using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class ModificarMovimiento : System.Web.UI.Page
    {
        private int idAlmacen;
        private int idMovimiento;
        private MovimientoAlmacenWSClient boMovimiento;
        private AlmacenWSClient boAlmacen;
        private movimientoAlmacen datMov;

        protected void Page_Load(object sender, EventArgs e)
        {
            boMovimiento = new MovimientoAlmacenWSClient();
            boAlmacen = new AlmacenWSClient();

            if (!IsPostBack)
            {
                if (Request.QueryString["idAlmacen"] != null && Request.QueryString["id"] != null)
                {
                    idAlmacen = Convert.ToInt32(Request.QueryString["idAlmacen"]);
                    idMovimiento = Convert.ToInt32(Request.QueryString["id"]);

                    ViewState["IdAlmacen"] = idAlmacen;
                    ViewState["IdMovimiento"] = idMovimiento;

                    // 🔹 Cargar almacenes primero
                    CargarAlmacenes();

                    // 🔹 Luego cargar los datos del movimiento
                    CargarDatosMovimiento();
                }
                else
                {
                    Response.Redirect("~/Almacen/ListarAlmacenes.aspx");
                }
            }
            else
            {
                idAlmacen = (int)ViewState["IdAlmacen"];
                idMovimiento = (int)ViewState["IdMovimiento"];
            }
        }

        // 🔹 Método para cargar almacenes en ambos dropdowns
        private void CargarAlmacenes()
        {
            try
            {
                // Obtener lista de almacenes del backend
                BindingList<almacen> listaAlmacenes = new BindingList<almacen>(boAlmacen.listarAlmacenesActivos());

                // Crear lista formateada
                var almacenesFormateados = listaAlmacenes.Select(a => new
                {
                    IdAlmacen = a.id,
                    NombreCompleto = $"{a.nombre} - {a.ubicacion}"
                }).ToList();

                // 🔹 Cargar dropdown de Lugar de Origen
                ddlLugarOrigen.DataSource = almacenesFormateados;
                ddlLugarOrigen.DataTextField = "NombreCompleto";
                ddlLugarOrigen.DataValueField = "IdAlmacen";
                ddlLugarOrigen.DataBind();
                ddlLugarOrigen.Items.Insert(0, new ListItem("-- Seleccione lugar de origen --", "0"));

                // 🔹 Cargar dropdown de Lugar de Destino
                ddlLugarDestino.DataSource = almacenesFormateados;
                ddlLugarDestino.DataTextField = "NombreCompleto";
                ddlLugarDestino.DataValueField = "IdAlmacen";
                ddlLugarDestino.DataBind();
                ddlLugarDestino.Items.Insert(0, new ListItem("-- Seleccione lugar de destino --", "0"));
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar almacenes: {ex.Message}');", true);
            }
        }

        // Método para cargar los datos del movimiento existente
        private void CargarDatosMovimiento()
        {
            /*OJO: aqui también va a listar a los proveedores... como opciones, por ahora solo estarán los movimientos
             entre almacenes, pero después estarán también los proveedores. También se tendría que verificar que por lo menos en uno
            de los parámetros sea el del almacén en donde se encuentra (Por cuestiones de tiempo ya no lo pude implementar)*/
            try
            {
                datMov = boMovimiento.obtenerMovimientoPorId(idMovimiento);

                if (datMov != null)
                {
                    // Cargar la fecha
                    txtFechaTraslado.Text = datMov.fecha.ToString("yyyy-MM-dd");

                    // Seleccionar el tipo
                    ddlTipo.SelectedValue = datMov.tipo.ToString();

                    // BUSCAR Y SELECCIONAR LUGAR DE ORIGEN
                    string idOrigenSeleccionado = "0";
                    foreach (ListItem item in ddlLugarOrigen.Items)
                    {
                        if (item.Text.Contains(datMov.lugarOrigen))
                        {
                            idOrigenSeleccionado = item.Value;
                            ddlLugarOrigen.SelectedValue = item.Value;
                            break;
                        }
                    }

                    // BUSCAR Y SELECCIONAR LUGAR DE DESTINO
                    string idDestinoSeleccionado = "0";
                    foreach (ListItem item in ddlLugarDestino.Items)
                    {
                        if (item.Text.Contains(datMov.lugarDestino))
                        {
                            idDestinoSeleccionado = item.Value;
                            ddlLugarDestino.SelectedValue = item.Value;
                            break;
                        }
                    }
                    string script = $@"
                <script type='text/javascript'>
                    $(document).ready(function() {{
                        // Esperar a que Select2 esté inicializado y luego establecer valores
                        setTimeout(function() {{
                            $('#{ddlLugarOrigen.ClientID}').val('{idOrigenSeleccionado}').trigger('change');
                            $('#{ddlLugarDestino.ClientID}').val('{idDestinoSeleccionado}').trigger('change');
                        }}, 100);
                    }});
                </script>
            ";
                    ClientScript.RegisterStartupScript(this.GetType(), "setSelect2Values", script);

                    // Guardar el movimiento completo en ViewState
                    ViewState["DatMovimiento"] = datMov;
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Movimiento no encontrado');", true);
                    Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}&tab=Movimientos");
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar datos del movimiento: {ex.Message}');", true);
            }
        }


        protected void lkModificar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // 🔹 Validar que se hayan seleccionado los lugares
                    int idLugarOrigen = Convert.ToInt32(ddlLugarOrigen.SelectedValue);
                    int idLugarDestino = Convert.ToInt32(ddlLugarDestino.SelectedValue);

                    if (idLugarOrigen == 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Debe seleccionar un lugar de origen');", true);
                        return;
                    }

                    if (idLugarDestino == 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Debe seleccionar un lugar de destino');", true);
                        return;
                    }

                    // 🔹 Validar que no sean el mismo lugar
                    if (idLugarOrigen == idLugarDestino)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('El lugar de origen y destino no pueden ser el mismo');", true);
                        return;
                    }

                    // 🔹 Validar tipo
                    string tipo = ddlTipo.SelectedValue;
                    if (tipo == "0")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Debe seleccionar un tipo de movimiento');", true);
                        return;
                    }

                    // 🔹 Validar fecha
                    if (string.IsNullOrEmpty(txtFechaTraslado.Text))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Debe seleccionar una fecha de traslado');", true);
                        return;
                    }

                    DateTime fechaTraslado = Convert.ToDateTime(txtFechaTraslado.Text);

                    // 🔹 Obtener los textos seleccionados (nombres de los almacenes)
                    string lugarOrigen = ddlLugarOrigen.SelectedItem.Text;
                    string lugarDestino = ddlLugarDestino.SelectedItem.Text;

                    // 🔹 Recuperar el movimiento desde ViewState
                    datMov = (movimientoAlmacen)ViewState["DatMovimiento"];

                    // 🔹 Si no existe en ViewState, crear uno nuevo (aunque no debería pasar)
                    if (datMov == null)
                    {
                        datMov = new movimientoAlmacen();
                        datMov.datAlmacen = new almacen { id = idAlmacen };
                    }

                    // 🔹 Actualizar los campos modificables
                    datMov.idMovimiento = idMovimiento;
                    datMov.lugarOrigen = lugarOrigen;
                    datMov.lugarDestino = lugarDestino;

                    datMov.fecha = fechaTraslado;
                    datMov.fechaSpecified = true;

                    datMov.tipo = (tipoMovimiento)Enum.Parse(typeof(tipoMovimiento), tipo);
                    datMov.tipoSpecified = true;

                    // 🔹 Llamar al servicio para modificar
                    int resultado = boMovimiento.modificarMovimientoAlmacen(datMov);

                    if (resultado > 0)
                    {
                        Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}&msg=movimientoModificado&tab=Movimientos");
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Error al modificar el movimiento. Intente nuevamente.');", true);
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        $"alert('Error: {ex.Message}');", true);
                }
            }
        }

        protected void lkCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}&tab=Movimientos");
        }
    }
}
