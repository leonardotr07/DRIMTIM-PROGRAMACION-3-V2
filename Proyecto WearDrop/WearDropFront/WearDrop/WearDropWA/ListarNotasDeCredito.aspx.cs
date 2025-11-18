using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.NotaDeCreditoService;

namespace WearDropWA
{
    public partial class ListarNotasDeCredito : System.Web.UI.Page
    {
        private NotaDeCreditoWSClient boNotaDeCredito;

        protected void Page_Load(object sender, EventArgs e)
        {
            boNotaDeCredito = new NotaDeCreditoWSClient();

            if (!IsPostBack)
            {
                CargarNotasDeCredito();
            }
        }

        private void CargarNotasDeCredito()
        {
            try
            {
                // Llama a tu servicio SOAP para listar notas de crédito
                notaDeCredito[] listaNotas = boNotaDeCredito.listarTodasNotasCredito();
                gvNotasDeCredito.DataSource = listaNotas;
                gvNotasDeCredito.DataBind();
            }
            catch (Exception ex)
            {
                // Si el servicio falla, mostrar mensaje de error
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar notas de crédito: {ex.Message}');", true);

                // Opcional: Datos de prueba para desarrollo
                var listaDePrueba = new List<object>();
                listaDePrueba.Add(new
                {
                    idComprobante = 1,
                    fecha = DateTime.Now,
                    Correlativo = "NC01-00001",
                    RUC = "20123456789",
                    razonSocial = "EMPRESA EJEMPLO S.A.C.",
                    motivoEspecifico = "Devolución de producto",
                    nuevoMonto = -500.00
                });
                listaDePrueba.Add(new
                {
                    idComprobante = 2,
                    fecha = DateTime.Now.AddDays(-3),
                    Correlativo = "NC01-00002",
                    RUC = "12345678",
                    razonSocial = "Juan Pérez García",
                    motivoEspecifico = "Error en facturación",
                    nuevoMonto = -250.50
                });

                gvNotasDeCredito.DataSource = listaDePrueba;
                gvNotasDeCredito.DataBind();
            }
        }

        protected void gvNotasDeCredito_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvNotasDeCredito.PageIndex = e.NewPageIndex;
            CargarNotasDeCredito();
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int comprobanteID = Convert.ToInt32(btn.CommandArgument);

                // Redirigir a la página de modificación
                Response.Redirect("~/ModificarNotaDeCredito.aspx?id=" + comprobanteID);
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
                int idNotaCredito;

                // Validar que el HiddenField tenga un valor
                if (string.IsNullOrEmpty(hfIdNotaCreditoEliminar.Value))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se ha seleccionado una nota de crédito para eliminar.'); cerrarModalEliminar();", true);
                    return;
                }

                idNotaCredito = int.Parse(hfIdNotaCreditoEliminar.Value);

                // Llamar al servicio para eliminar
                int resultado = boNotaDeCredito.eliminarNotaCredito(idNotaCredito);

                if (resultado > 0)
                {
                    // Eliminación exitosa
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Nota de crédito eliminada correctamente.'); cerrarModalEliminar(); window.location='ListarNotasDeCredito.aspx';", true);
                }
                else
                {
                    // Error al eliminar
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se pudo eliminar la nota de crédito. Ocurrió un error.'); cerrarModalEliminar();", true);
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