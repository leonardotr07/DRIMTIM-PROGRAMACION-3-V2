using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class RegistrarMovimiento : System.Web.UI.Page
    {
        private int idAlmacen;
        private MovimientoAlmacenWSClient boMovimiento;
        private AlmacenWSClient boAlmacen;

        protected void Page_Load(object sender, EventArgs e)
        {
            boMovimiento = new MovimientoAlmacenWSClient();
            boAlmacen = new AlmacenWSClient();

            if (!IsPostBack)
            {
                if (Request.QueryString["idAlmacen"] != null)
                {
                    idAlmacen = Convert.ToInt32(Request.QueryString["idAlmacen"]);
                    ViewState["IdAlmacen"] = idAlmacen;

                    // Cargar los almacenes en los dropdowns
                    CargarAlmacenes();
                }
                else
                {
                    Response.Redirect("~/Almacen/ListarAlmacenes.aspx");
                }
            }
            else
            {
                idAlmacen = (int)ViewState["IdAlmacen"];
            }
        }

        // Método para cargar almacenes en ambos dropdowns
        private void CargarAlmacenes()
        {
            try
            {
                // Obtener lista de almacenes del backend
                BindingList<almacen> listaAlmacenes = new BindingList<almacen>(boAlmacen.listarAlmacenesActivos());

                // Crear lista formateada para mostrar
                var almacenesFormateados = listaAlmacenes.Select(a => new
                {
                    IdAlmacen = a.id,
                    NombreCompleto = $"{a.nombre} - {a.ubicacion}"
                }).ToList();

                // 🔹 Cargar dropdown de Lugar de Destino
                ddlLugarDestino.DataSource = almacenesFormateados;
                ddlLugarDestino.DataTextField = "NombreCompleto";
                ddlLugarDestino.DataValueField = "IdAlmacen";
                ddlLugarDestino.DataBind();
                ddlLugarDestino.Items.Insert(0, new ListItem("-- Seleccione lugar de destino --", "0"));

                // 🔹 Cargar dropdown de Lugar de Origen
                ddlLugarOrigen.DataSource = almacenesFormateados;
                ddlLugarOrigen.DataTextField = "NombreCompleto";
                ddlLugarOrigen.DataValueField = "IdAlmacen";
                ddlLugarOrigen.DataBind();
                ddlLugarOrigen.Items.Insert(0, new ListItem("-- Seleccione lugar de origen --", "0"));
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar almacenes: {ex.Message}');", true);
            }
        }

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // 🔹 Validar que se hayan seleccionado los lugares
                    int idLugarDestino = Convert.ToInt32(ddlLugarDestino.SelectedValue);
                    int idLugarOrigen = Convert.ToInt32(ddlLugarOrigen.SelectedValue);

                    if (idLugarDestino == 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Debe seleccionar un lugar de destino');", true);
                        return;
                    }

                    if (idLugarOrigen == 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Debe seleccionar un lugar de origen');", true);
                        return;
                    }

                    // 🔹 Validar que no sean el mismo lugar
                    if (idLugarDestino == idLugarOrigen)
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
                    string lugarDestino = ddlLugarDestino.SelectedItem.Text;
                    string lugarOrigen = ddlLugarOrigen.SelectedItem.Text;

                    // 🔹 Crear el movimiento
                    movimientoAlmacen nuevoMovimiento = new movimientoAlmacen();
                    nuevoMovimiento.lugarDestino = lugarDestino;
                    nuevoMovimiento.lugarOrigen = lugarOrigen;
                    nuevoMovimiento.fecha = fechaTraslado;
                    nuevoMovimiento.fechaSpecified = true;

                    nuevoMovimiento.tipo = (tipoMovimiento)Enum.Parse(typeof(tipoMovimiento), tipo);
                    nuevoMovimiento.tipoSpecified = true;
                    // Asignar el almacén
                    nuevoMovimiento.datAlmacen = new almacen();
                    nuevoMovimiento.datAlmacen.id = idAlmacen;

                    // Llamar al servicio para insertar
                    int resultado = boMovimiento.insertarMovAlmacen(nuevoMovimiento);

                    if (resultado > 0)
                    {
                        // Éxito: redirigir con mensaje
                        Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}&msg=movimientoRegistrado");
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Error al registrar el movimiento. Intente nuevamente.');", true);
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
            Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}");
        }
    }
}
