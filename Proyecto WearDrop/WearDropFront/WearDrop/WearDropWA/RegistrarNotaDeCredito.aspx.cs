using System;
using System.Web.UI;
using WearDropWA.NotaDeCreditoService; // <-- Solo importas el servicio de Nota de Crédito

namespace WearDropWA
{
    public partial class RegistrarNotaDeCredito : System.Web.UI.Page
    {
        private NotaDeCreditoWSClient boNotaDeCredito;

        protected void Page_Load(object sender, EventArgs e)
        {
            // (No se necesita lógica de paneles)
        }

        // --- MÉTODO EMITIR NOTA DE CRÉDITO ---
        // (Copiado de tu RegistrarComprobantes.aspx.cs)
        protected void btnEmitirNC_Click(object sender, EventArgs e)
        {
            boNotaDeCredito = new NotaDeCreditoWSClient();
            notaDeCredito nuevaNC = new notaDeCredito();

            // --- 1. Validar y Leer Datos ---
            try
            {
                nuevaNC.fecha = DateTime.Parse(txtFechaNC.Text);
                nuevaNC.fechaSpecified = true;
            }
            catch (Exception) { mostrarMensajeError("Debe elegir una fecha válida."); return; }

            try { nuevaNC.total = double.Parse(txtTotalNC.Text); }
            catch (Exception) { mostrarMensajeError("El 'Total (Original)' debe ser un número."); return; }

            try { nuevaNC.IGV = double.Parse(txtIGVNC.Text); }
            catch (Exception) { mostrarMensajeError("El 'IGV' debe ser un número."); return; }

            if (string.IsNullOrEmpty(txtMetodoPagoNC.Text)) { mostrarMensajeError("Debe ingresar un Método de Pago."); return; }
            nuevaNC.metodoDePago = txtMetodoPagoNC.Text;

            if (string.IsNullOrEmpty(txtCorrelativoNC.Text)) { mostrarMensajeError("Debe ingresar un Correlativo."); return; }
            nuevaNC.correlativo = txtCorrelativoNC.Text;

            if (string.IsNullOrEmpty(txtDetalleNC.Text)) { mostrarMensajeError("Debe ingresar un Detalle."); return; }
            nuevaNC.detalleModificacion = txtDetalleNC.Text;

            nuevaNC.RUC = txtRUCNC.Text; // (Opcional, puede ser vacío)
            nuevaNC.DNI = txtDNINC.Text; // (Opcional, puede ser vacío)

            if (string.IsNullOrEmpty(txtRazonSocialNC.Text)) { mostrarMensajeError("Debe ingresar Razón Social."); return; }
            nuevaNC.razonSocial = txtRazonSocialNC.Text;

            if (string.IsNullOrEmpty(txtMotivoNC.Text)) { mostrarMensajeError("Debe ingresar un Motivo."); return; }
            nuevaNC.motivoEspecifico = txtMotivoNC.Text;

            try { nuevaNC.nuevoMonto = double.Parse(txtNuevoMontoNC.Text); }
            catch (Exception) { mostrarMensajeError("El 'Nuevo Monto' debe ser un número."); return; }

            try { nuevaNC.valorAumentar = double.Parse(txtValorAumentarNC.Text); } // Este es el 'valor a acreditar'
            catch (Exception) { mostrarMensajeError("El 'Valor a acreditar' debe ser un número."); return; }

            // --- 2. Llamar al Servicio ---
            try
            {
                int resultado = boNotaDeCredito.insertarNotaCredito(nuevaNC);
                if (resultado > 0) { MostrarModalExito(); }
                else { mostrarMensajeError("El servicio no pudo registrar la Nota de Crédito."); }
            }
            catch (Exception ex) { mostrarMensajeError("Error de conexión al servicio: " + ex.Message); }
        }

        // --- MÉTODOS DE MODAL (Copiados) ---
        public void mostrarMensajeError(String mensaje)
        {
            string script = $"mostrarModalError('{Server.HtmlEncode(mensaje)}', '{lblMensajeError.ClientID}');";
            ScriptManager.RegisterStartupScript(this, GetType(), "modalError", script, true);
        }

        private void MostrarModalExito()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessModal", "showSuccessModal();", true);
        }
    }
}