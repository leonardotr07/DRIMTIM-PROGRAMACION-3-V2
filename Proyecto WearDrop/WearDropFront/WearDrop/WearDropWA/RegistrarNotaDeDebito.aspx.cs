using System;
using System.Web.UI;
using WearDropWA.NotaDeDebitoService; // <-- Solo importas el servicio de Nota de Débito

namespace WearDropWA
{
    public partial class RegistrarNotaDeDebito : System.Web.UI.Page
    {
        private NotaDeDebitoWSClient boNotaDeDebito;

        protected void Page_Load(object sender, EventArgs e)
        {
            // (No se necesita lógica de paneles)
        }

        // --- MÉTODO EMITIR NOTA DE DÉBITO ---
        // (Copiado de tu RegistrarComprobantes.aspx.cs)
        protected void btnEmitirND_Click(object sender, EventArgs e)
        {
            boNotaDeDebito = new NotaDeDebitoWSClient();
            notaDeDebito nuevaND = new notaDeDebito();

            // --- 1. Validar y Leer Datos ---
            try
            {
                nuevaND.fecha = DateTime.Parse(txtFechaND.Text);
                nuevaND.fechaSpecified = true;
            }
            catch (Exception) { mostrarMensajeError("Debe elegir una fecha válida."); return; }

            try { nuevaND.total = double.Parse(txtTotalND.Text); }
            catch (Exception) { mostrarMensajeError("El 'Total (Original)' debe ser un número."); return; }

            try { nuevaND.IGV = double.Parse(txtIGVND.Text); }
            catch (Exception) { mostrarMensajeError("El 'IGV' debe ser un número."); return; }

            if (string.IsNullOrEmpty(txtMetodoPagoND.Text)) { mostrarMensajeError("Debe ingresar un Método de Pago."); return; }
            nuevaND.metodoDePago = txtMetodoPagoND.Text;

            if (string.IsNullOrEmpty(txtCorrelativoND.Text)) { mostrarMensajeError("Debe ingresar un Correlativo."); return; }
            nuevaND.correlativo = txtCorrelativoND.Text;

            if (string.IsNullOrEmpty(txtDetalleND.Text)) { mostrarMensajeError("Debe ingresar un Detalle."); return; }
            nuevaND.detalleModificacion = txtDetalleND.Text;

            if (string.IsNullOrEmpty(txtRUCND.Text)) { mostrarMensajeError("Debe ingresar un RUC."); return; }
            nuevaND.RUC = txtRUCND.Text;

            if (string.IsNullOrEmpty(txtRazonSocialND.Text)) { mostrarMensajeError("Debe ingresar Razón Social."); return; }
            nuevaND.razonSocial = txtRazonSocialND.Text;

            if (string.IsNullOrEmpty(txtMotivoND.Text)) { mostrarMensajeError("Debe ingresar un Motivo."); return; }
            nuevaND.motivoEspecifico = txtMotivoND.Text;

            try { nuevaND.nuevoMonto = double.Parse(txtNuevoMontoND.Text); }
            catch (Exception) { mostrarMensajeError("El 'Nuevo Monto' debe ser un número."); return; }

            try { nuevaND.valorAumentar = double.Parse(txtValorAumentarND.Text); }
            catch (Exception) { mostrarMensajeError("El 'Valor a aumentar' debe ser un número."); return; }

            try { nuevaND.idPrenda = int.Parse(txtIdPrenda.Text); }
            catch (Exception) { mostrarMensajeError("El 'ID Prenda' debe ser un número."); return; }

            // --- 2. Llamar al Servicio ---
            try
            {
                int resultado = boNotaDeDebito.insertarNotaDebito(nuevaND);
                if (resultado > 0) { MostrarModalExito(); }
                else { mostrarMensajeError("El servicio no pudo registrar la Nota de Débito."); }
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