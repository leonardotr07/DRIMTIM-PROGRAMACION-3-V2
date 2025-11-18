using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.FacturaService;

namespace WearDropWA
{
    public partial class ListarFacturas : System.Web.UI.Page
    {
        private FacturaWSClient boFactura;

        protected void Page_Load(object sender, EventArgs e)
        {
            boFactura = new FacturaWSClient();

            if (!IsPostBack)
            {
                CargarFacturas();
            }
        }

        private void CargarFacturas()
        {
            try
            {
                // Llama a tu servicio SOAP para listar facturas
                factura[] listaFacturas = boFactura.listarTodasFacturas();
                gvFacturas.DataSource = listaFacturas;
                gvFacturas.DataBind();
            }
            catch (Exception ex)
            {
                // Si el servicio falla, mostrar mensaje de error
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar facturas: {ex.Message}');", true);

                // Opcional: Datos de prueba para desarrollo
                var listaDePrueba = new List<object>();
                listaDePrueba.Add(new
                {
                    idComprobante = 1,
                    fecha = DateTime.Now,
                    Correlativo = "F001-00123",
                    RUC = "20123456789",
                    razonSocial = "EMPRESA EJEMPLO S.A.C.",
                    total = 1250.00
                });
                listaDePrueba.Add(new
                {
                    idComprobante = 2,
                    fecha = DateTime.Now.AddDays(-2),
                    Correlativo = "F001-00124",
                    RUC = "20987654321",
                    razonSocial = "DISTRIBUIDORA NORTE S.A.",
                    total = 3450.50
                });

                gvFacturas.DataSource = listaDePrueba;
                gvFacturas.DataBind();
            }
        }

        protected void gvFacturas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvFacturas.PageIndex = e.NewPageIndex;
            CargarFacturas();
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int comprobanteID = Convert.ToInt32(btn.CommandArgument);

                // Redirigir a la página de modificación
                Response.Redirect("~/ModificarFactura.aspx?id=" + comprobanteID);
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
                int idFactura;

                // Validar que el HiddenField tenga un valor
                if (string.IsNullOrEmpty(hfIdFacturaEliminar.Value))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se ha seleccionado una factura para eliminar.'); cerrarModalEliminar();", true);
                    return;
                }

                idFactura = int.Parse(hfIdFacturaEliminar.Value);

                // Llamar al servicio para eliminar
                int resultado = boFactura.eliminarFactura(idFactura);

                if (resultado > 0)
                {
                    // Eliminación exitosa
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Factura eliminada correctamente.'); cerrarModalEliminar(); window.location='ListarFacturas.aspx';", true);
                }
                else
                {
                    // Error al eliminar
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se pudo eliminar la factura. Ocurrió un error.'); cerrarModalEliminar();", true);
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