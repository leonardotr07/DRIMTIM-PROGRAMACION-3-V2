using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class RegistrarLote : System.Web.UI.Page
    {
        private int idAlmacen;
        private MovimientoAlmacenWSClient boMov;
        private LoteWSClient boLote;
        private MovimientoAlmacenXLoteWSClient boMovXLote;
        private AlmacenWSClient boAlmacen;

        // 🔹 Propiedad para acceder a la lista desde ViewState
        private BindingList<movimientoAlmacen> ListaMovimientos
        {
            get
            {
                if (ViewState["ListaMovimientos"] == null)
                    return new BindingList<movimientoAlmacen>();
                return (BindingList<movimientoAlmacen>)ViewState["ListaMovimientos"];
            }
            set
            {
                ViewState["ListaMovimientos"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            boMov = new MovimientoAlmacenWSClient();
            boLote = new LoteWSClient();
            boMovXLote = new MovimientoAlmacenXLoteWSClient();
            boAlmacen = new AlmacenWSClient(); // ✅ INICIALIZAR SERVICIO DE ALMACÉN

            if (!IsPostBack)
            {
                if (Request.QueryString["idAlmacen"] != null)
                {
                    idAlmacen = Convert.ToInt32(Request.QueryString["idAlmacen"]);
                    ViewState["IdAlmacen"] = idAlmacen;

                    CargarDatosContexto(); // ✅ MODIFICADO: Ahora carga desde el servicio
                    CargarMovimientos();

                    if (Request.QueryString["idMovimiento"] != null)
                    {
                        int idMovimiento = Convert.ToInt32(Request.QueryString["idMovimiento"]);
                        ddlIdMovimiento.SelectedValue = idMovimiento.ToString();
                        ActualizarDatosMovimiento(idMovimiento);
                    }

                    CargarPrendas();
                }
                else
                {
                    Response.Redirect("~/ListarAlmacenes.aspx");
                }
            }
            else
            {
                idAlmacen = (int)ViewState["IdAlmacen"];
            }
        }

        private void CargarDatosContexto()
        {
            try
            {
                almacen datAlmacen = boAlmacen.obtenerPorId(idAlmacen);

                if (datAlmacen != null)
                {
                    lblNombreAlmacen.Text = datAlmacen.nombre ?? "Almacén no encontrado";
                }
                else
                {
                    lblNombreAlmacen.Text = "Almacén no encontrado";
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar datos del almacén: {ex.Message}');", true);
                lblNombreAlmacen.Text = "Error al cargar";
            }
        }

        private void CargarMovimientos()
        {
            try
            {
                // 🔹 Obtener lista de movimientos del backend y guardarla en ViewState
                ListaMovimientos = new BindingList<movimientoAlmacen>(boMov.listarMovimientosPorAlmacen(idAlmacen));

                // Crear lista con formato personalizado para el DropDownList
                var movimientosFormateados = ListaMovimientos.Select(m => new
                {
                    IdMovimiento = m.idMovimiento,
                    DescripcionCompleta = $"Mov {m.idMovimiento} - {m.tipo} - {m.lugarOrigen} a {m.lugarDestino}"
                }).ToList();

                // Vincular al DropDownList
                ddlIdMovimiento.DataSource = movimientosFormateados;
                ddlIdMovimiento.DataTextField = "DescripcionCompleta";
                ddlIdMovimiento.DataValueField = "IdMovimiento";
                ddlIdMovimiento.DataBind();

                // Agregar opción por defecto
                ddlIdMovimiento.Items.Insert(0, new ListItem("--Seleccione un movimiento--", "0"));
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar movimientos: {ex.Message}');", true);
            }
        }

        protected void ddlIdMovimiento_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idMovimiento = Convert.ToInt32(ddlIdMovimiento.SelectedValue);

            if (idMovimiento > 0)
            {
                ActualizarDatosMovimiento(idMovimiento);
            }
            else
            {
                lblLugarOrigen.Text = "-";
                lblLugarDestino.Text = "-";
            }
        }

        private void ActualizarDatosMovimiento(int idMovimiento)
        {
            try
            {
                // Obtener el movimiento seleccionado del backend
                movimientoAlmacen movimientoSeleccionado = boMov.obtenerMovimientoPorId(idMovimiento);

                if (movimientoSeleccionado != null)
                {
                    lblLugarOrigen.Text = movimientoSeleccionado.lugarOrigen ?? "-";
                    lblLugarDestino.Text = movimientoSeleccionado.lugarDestino ?? "-";
                }
                else
                {
                    lblLugarOrigen.Text = "-";
                    lblLugarDestino.Text = "-";
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al cargar datos del movimiento: {ex.Message}');", true);
                lblLugarOrigen.Text = "-";
                lblLugarDestino.Text = "-";
            }
        }

        private void CargarPrendas()
        {
            var prendasTest = new List<dynamic>
            {
                new { IdPrenda = 1, NombrePrenda = "Camiseta Básica", Color = "Blanco", Material = "Algodón", Stock = 50, Talla = "M" },
                new { IdPrenda = 2, NombrePrenda = "Pantalón Jean", Color = "Azul", Material = "Mezclilla", Stock = 30, Talla = "32" },
                new { IdPrenda = 3, NombrePrenda = "Zapatilla Deportiva", Color = "Negro", Material = "Sintético", Stock = 25, Talla = "42" },
                new { IdPrenda = 4, NombrePrenda = "Chaqueta", Color = "Gris", Material = "Poliéster", Stock = 15, Talla = "L" },
                new { IdPrenda = 5, NombrePrenda = "Gorra", Color = "Rojo", Material = "Algodón", Stock = 40, Talla = "Única" },
                new { IdPrenda = 6, NombrePrenda = "Bufanda", Color = "Beige", Material = "Lana", Stock = 20, Talla = "Única" }
            };

            gvPrendas.DataSource = prendasTest;
            gvPrendas.DataBind();
        }

        protected void gvPrendas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPrendas.PageIndex = e.NewPageIndex;
            CargarPrendas();
        }

        protected void btnAniadirPrenda_Click(object sender, EventArgs e)
        {
            // Implementar lógica
        }

        protected void btnFiltroPrenda_Click(object sender, EventArgs e)
        {
            // Implementar lógica
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idPrenda = int.Parse(btn.CommandArgument);
            // Lógica para agregar prenda
        }

        protected void btnQuitar_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idPrenda = int.Parse(btn.CommandArgument);
            // Lógica para quitar prenda
        }

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                // Validar que se haya seleccionado un movimiento
                int idMovimiento = Convert.ToInt32(ddlIdMovimiento.SelectedValue);

                if (idMovimiento == 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Debe seleccionar un movimiento');", true);
                    return;
                }

                // Validar que se haya ingresado una descripción
                string descripcion = txtDescripcionLote.Text.Trim();

                if (string.IsNullOrEmpty(descripcion))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Debe ingresar una descripción para el lote');", true);
                    return;
                }

                // 🔹 Crear el lote
                lote nuevoLote = new lote();
                nuevoLote.datAlmacen = new almacen();
                nuevoLote.datAlmacen.id = idAlmacen;
                nuevoLote.descripcion = descripcion;

                // 🔹 Buscar el movimiento seleccionado en la lista guardada en ViewState
                movimientoAlmacen movimientoSeleccionado = ListaMovimientos
                    .FirstOrDefault(m => m.idMovimiento == idMovimiento);

                // 🔹 Validar que se encontró el movimiento
                if (movimientoSeleccionado == null)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Error: No se pudo obtener el movimiento seleccionado');", true);
                    return;
                }

                // 🔹 Crear la relación MovimientoXLote
                movimientoAlmacenXLote nuevaRelacionMovXLote = new movimientoAlmacenXLote();
                nuevaRelacionMovXLote.datMov = movimientoSeleccionado;
                nuevaRelacionMovXLote.datLote = nuevoLote;

                // 🔹 Llamar a los servicios
                int resultadoLote = boLote.insertarLote(nuevoLote);
                nuevaRelacionMovXLote.datLote.idLote = resultadoLote; //Asignamos el Id necesario para la inserción.
                int resultadoRelacion = boMovXLote.insertarMovXLote(nuevaRelacionMovXLote);

                if (resultadoLote > 0 && resultadoRelacion > 0)
                {
                    // Éxito: redirigir con mensaje
                    Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}&msg=Lote y relación Movimiento X Lote registrados.");
                }
                else
                {
                    if (resultadoLote <= 0)
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Error al registrar el lote. Intente nuevamente.');", true);
                    if (resultadoRelacion <= 0)
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Error al registrar la relación. Intente nuevamente.');", true);
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error: {ex.Message}');", true);
            }
        }

        protected void lkCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Almacen/MostrarAlmacen.aspx?id={idAlmacen}");
        }
    }
}
