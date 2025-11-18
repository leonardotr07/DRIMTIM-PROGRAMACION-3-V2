using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.NotaDeDebitoService;

namespace WearDropWA
{
    public partial class ListarNotasDeDebito : System.Web.UI.Page
    {
        private NotaDeDebitoWSClient boNotaDeDebito;

        protected void Page_Load(object sender, EventArgs e)
        {
            boNotaDeDebito = new NotaDeDebitoWSClient();

            if (!IsPostBack)
            {
                CargarNotasDeDebito();
            }
        }

        private void CargarNotasDeDebito()
        {
            try
            {
                // Llama a tu servicio SOAP para listar notas de débito
                notaDeDebito[] listaNotas = boNotaDeDebito.listarTodasNotasDebito();
                gvNotasDeDebito.DataSource = listaNotas;
                gvNotasDeDebito.DataBind();
            }
            catch (Exception ex)
            {
                // Si el servicio falla, mostrar mensaje de error
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar notas de débito: {ex.Message}');", true);

                // Opcional: Datos de prueba para desarrollo
                var listaDePrueba = new List<object>();
                listaDePrueba.Add(new
                {
                    idComprobante = 1,
                    fecha = DateTime.Now,
                    Correlativo = "ND01-00001",
                    RUC = "20123456789",
                    razonSocial = "EMPRESA EJEMPLO S.A.C.",
                    motivoEspecifico = "Intereses por mora",
                    nuevoMonto = 150.00
                });
                listaDePrueba.Add(new
                {
                    idComprobante = 2,
                    fecha = DateTime.Now.AddDays(-5),
                    Correlativo = "ND01-00002",
                    RUC = "20987654321",
                    razonSocial = "COMERCIAL DEL SUR S.A.",
                    motivoEspecifico = "Recargo por servicio adicional",
                    nuevoMonto = 85.50
                });

                gvNotasDeDebito.DataSource = listaDePrueba;
                gvNotasDeDebito.DataBind();
            }
        }

        protected void gvNotasDeDebito_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvNotasDeDebito.PageIndex = e.NewPageIndex;
            CargarNotasDeDebito();
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int comprobanteID = Convert.ToInt32(btn.CommandArgument);

                // Redirigir a la página de modificación
                Response.Redirect("~/ModificarNotaDeDebito.aspx?id=" + comprobanteID);
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
                int idNotaDebito;

                // Validar que el HiddenField tenga un valor
                if (string.IsNullOrEmpty(hfIdNotaDebitoEliminar.Value))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se ha seleccionado una nota de débito para eliminar.'); cerrarModalEliminar();", true);
                    return;
                }

                idNotaDebito = int.Parse(hfIdNotaDebitoEliminar.Value);

                // Llamar al servicio para eliminar
                int resultado = boNotaDeDebito.eliminarNotaDebito(idNotaDebito);

                if (resultado > 0)
                {
                    // Eliminación exitosa
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Nota de débito eliminada correctamente.'); cerrarModalEliminar(); window.location='ListarNotasDeDebito.aspx';", true);
                }
                else
                {
                    // Error al eliminar
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se pudo eliminar la nota de débito. Ocurrió un error.'); cerrarModalEliminar();", true);
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