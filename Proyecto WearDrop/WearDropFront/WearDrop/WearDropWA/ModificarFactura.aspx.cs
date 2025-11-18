using System;
using System.Web.UI;
using WearDropWA.FacturaService; // Asegúrate de importar tu servicio

namespace WearDropWA
{
    public partial class ModificarFactura : System.Web.UI.Page
    {
        private FacturaWSClient boFactura;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int idParaEditar = Convert.ToInt32(Request.QueryString["id"]);
                    CargarDatos(idParaEditar);
                }
                else
                {
                    // Si no hay ID, redirigimos de vuelta a la lista
                    Response.Redirect("~/ListarFacturas.aspx");
                }
            }
        }

        private void CargarDatos(int id)
        {
            boFactura = new FacturaWSClient();
            try
            {
                // Asumo que tu servicio tiene un método 'buscarFactura'
                factura facturaEncontrada = boFactura.obtenerFacturaPorId(id);

                if (facturaEncontrada != null)
                {
                    txtID.Text = facturaEncontrada.idComprobante.ToString();
                    txtCorrelativo.Text = facturaEncontrada.correlativo;
                    txtFacturaRUC.Text = facturaEncontrada.RUC;
                    txtFacturaRazonSocial.Text = facturaEncontrada.razonSocial;
                    txtFacturaMetodoPago.Text = facturaEncontrada.metodoDePago;
                    txtFacturaFecha.Text = facturaEncontrada.fecha.ToString("yyyy-MM-dd");
                    txtFacturaTotal.Text = facturaEncontrada.total.ToString("F2");
                    txtFacturaIGV.Text = facturaEncontrada.IGV.ToString("F2");
                }
                else
                {
                    mostrarMensajeError("No se encontró la factura con el ID " + id);
                }
            }
            catch (Exception ex)
            {
                mostrarMensajeError("Error al cargar datos: " + ex.Message);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // 1. Comprueba los validadores del grupo "vgModFactura"
            if (!Page.IsValid) return;

            boFactura = new FacturaWSClient();
            factura facturaModificada = new factura();

            // 2. Validar y Leer Datos (solo conversiones)
            try
            {
                facturaModificada.idComprobante = Convert.ToInt32(txtID.Text);
                facturaModificada.fecha = DateTime.Parse(txtFacturaFecha.Text);
                facturaModificada.fechaSpecified = true;
                facturaModificada.total = double.Parse(txtFacturaTotal.Text);
                facturaModificada.IGV = double.Parse(txtFacturaIGV.Text);
            }
            catch (Exception) { mostrarMensajeError("La fecha, total o IGV tienen un formato incorrecto."); return; }

            // Campos de texto (ya validados)
            facturaModificada.correlativo = txtCorrelativo.Text;
            facturaModificada.metodoDePago = txtFacturaMetodoPago.Text;
            facturaModificada.RUC = txtFacturaRUC.Text;
            facturaModificada.razonSocial = txtFacturaRazonSocial.Text;

            // --- 3. Llamar al Servicio de MODIFICAR ---
            try
            {
                // Llamamos al método que me pasaste
                int resultado = boFactura.modificarFactura(facturaModificada);

                if (resultado > 0)
                {
                    MostrarModalExito();
                }
                else
                {
                    mostrarMensajeError("El servicio no pudo modificar la factura (Resultado: 0).");
                }
            }
            catch (Exception ex)
            {
                mostrarMensajeError("Error de conexión al servicio: " + ex.Message);
            }
        }

        // --- MÉTODOS DE MODAL ---
        public void mostrarMensajeError(String mensaje)
        {
            // (Asegúrate de que 'lblMensajeError' exista en tu ASPX)
            string script = $"mostrarModalError('{Server.HtmlEncode(mensaje)}', '{lblMensajeError.ClientID}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "modalError", script, true);
        }

        private void MostrarModalExito()
        {
            // (Asegúrate de que tu JS 'redirectToManager' apunte a ListarFacturas.aspx)
            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessModal", "showSuccessModal();", true);
        }
    }
}