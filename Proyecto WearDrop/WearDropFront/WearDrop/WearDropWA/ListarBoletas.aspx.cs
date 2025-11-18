using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.BoletaService;

namespace WearDropWA
{
    public partial class ListarBoletas : System.Web.UI.Page
    {
        private BoletaWSClient boBoleta;

        protected void Page_Load(object sender, EventArgs e)
        {
            boBoleta = new BoletaWSClient();

            if (!IsPostBack)
            {
                CargarBoletas();
            }
        }

        private void CargarBoletas()
        {
            try
            {
                // Llama a tu servicio SOAP para listar boletas
                gvBoletas.DataSource = boBoleta.listarTodasBoletas();
                gvBoletas.DataBind();
            }
            catch (Exception ex)
            {
                // Si el servicio falla, mostrar mensaje de error
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar boletas: {ex.Message}');", true);

                // Opcional: Datos de prueba para desarrollo
                var listaDePrueba = new List<object>();
                listaDePrueba.Add(new
                {
                    idComprobante = 1,
                    fecha = DateTime.Now,
                    Correlativo = "B001-00456",
                    DNI = "12345678",
                    metodoDePago = "Yape",
                    IGV = 18.00,
                    total = 150.00
                });
                listaDePrueba.Add(new
                {
                    idComprobante = 2,
                    fecha = DateTime.Now.AddDays(-1),
                    Correlativo = "B001-00457",
                    DNI = "87654321",
                    metodoDePago = "Plin",
                    IGV = 18.00,
                    total = 320.50
                });

                gvBoletas.DataSource = listaDePrueba;
                gvBoletas.DataBind();
            }
        }

        protected void gvBoletas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvBoletas.PageIndex = e.NewPageIndex;
            CargarBoletas();
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int comprobanteID = Convert.ToInt32(btn.CommandArgument);

                // Redirigir a la página de modificación
                Response.Redirect("~/ModificarBoleta.aspx?id=" + comprobanteID);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al editar: {ex.Message}');", true);
            }
        }

        protected void btnConfirmarEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                int idBoleta;

                // Validar que el HiddenField tenga un valor
                if (string.IsNullOrEmpty(hfIdBoletaEliminar.Value))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se ha seleccionado una boleta para eliminar.'); cerrarModalEliminar();", true);
                    return;
                }

                idBoleta = int.Parse(hfIdBoletaEliminar.Value);

                // Llamar al servicio para eliminar
                int resultado = boBoleta.eliminarBoleta(idBoleta);

                if (resultado > 0)
                {
                    // Eliminación exitosa
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Boleta eliminada correctamente.'); cerrarModalEliminar(); window.location='ListarBoletas.aspx';", true);
                }
                else
                {
                    // Error al eliminar
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se pudo eliminar la boleta. Ocurrió un error.'); cerrarModalEliminar();", true);
                }
            }
            catch (Exception ex)
            {
                // Manejo de excepciones
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al eliminar: {ex.Message}'); cerrarModalEliminar();", true);
            }
        }
    }
}