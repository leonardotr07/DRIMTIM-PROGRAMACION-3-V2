using System;
using System.Web.UI;
using WearDropWA.FacturaService; // Solo importas el servicio de Factura

namespace WearDropWA
{
    public partial class RegistrarFactura : System.Web.UI.Page
    {
        private FacturaWSClient boFactura;

        protected void Page_Load(object sender, EventArgs e)
        {
            // (No se necesita lógica de paneles)
        }

        // --- MÉTODO EMITIR FACTURA ---
        protected void btnEmitirFactura_Click(object sender, EventArgs e)
        {
            boFactura = new FacturaWSClient();
            factura nuevaFactura = new factura();

            // --- 1. Validar y Leer Datos ---
            try
            {
                nuevaFactura.fecha = DateTime.Parse(txtFechaFactura.Text);
                nuevaFactura.fechaSpecified = true;
            }
            catch (Exception) { mostrarMensajeError("Debe elegir una fecha válida."); return; }

            try { nuevaFactura.total = double.Parse(txtTotalFactura.Text); }
            catch (Exception) { mostrarMensajeError("El campo 'Total' debe ser un número válido."); return; }

            try { nuevaFactura.IGV = double.Parse(txtIGVFactura.Text); }
            catch (Exception) { mostrarMensajeError("El campo 'IGV' debe ser un número válido."); return; }

            if (string.IsNullOrEmpty(txtMetodoPago.Text)) { mostrarMensajeError("Debe ingresar un Método de Pago."); return; }
            nuevaFactura.metodoDePago = txtMetodoPago.Text;

            if (string.IsNullOrEmpty(txtCorrelativoFactura.Text)) { mostrarMensajeError("Debe ingresar un Correlativo."); return; }
            nuevaFactura.correlativo = txtCorrelativoFactura.Text;

            if (string.IsNullOrEmpty(txtRUCFactura.Text)) { mostrarMensajeError("Debe ingresar un RUC."); return; }
            nuevaFactura.RUC = txtRUCFactura.Text;

            if (string.IsNullOrEmpty(txtRazonSocial.Text)) { mostrarMensajeError("Debe ingresar una Razón Social."); return; }
            nuevaFactura.razonSocial = txtRazonSocial.Text;

            // (Campo 'NombresFactura' (contacto) - ajústalo si tu servicio lo requiere)
            // nuevaFactura.contacto = txtNombresFactura.Text; 


            // --- 2. Llamar al Servicio ---
            try
            {
                int resultado = boFactura.insertarFactura(nuevaFactura);
                if (resultado > 0) { MostrarModalExito(); }
                else { mostrarMensajeError("El servicio no pudo registrar la factura (Resultado: 0)."); }
            }
            catch (Exception ex) { mostrarMensajeError("Error de conexión al servicio: " + ex.Message); }
        }

        // --- MÉTODOS DE MODAL (Copiados) ---
        public void mostrarMensajeError(String mensaje)
        {
            // Le pasamos el mensaje Y el ID del label a JavaScript
            string script = $"mostrarModalError('{Server.HtmlEncode(mensaje)}', '{lblMensajeError.ClientID}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "modalError", script, true);
        }

        private void MostrarModalExito()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessModal", "showSuccessModal();", true);
        }
    }
}