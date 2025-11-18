using System;
using System.Web.UI;
using WearDropWA.BoletaService;

namespace WearDropWA
{
    // ¡Asegúrate de que el nombre de la clase sea RegistrarBoleta!
    public partial class RegistrarBoleta : System.Web.UI.Page
    {
        private BoletaWSClient boBoleta;

        protected void Page_Load(object sender, EventArgs e)
        {
            // (Ya no se necesita lógica de paneles aquí)
        }

        protected void btnEmitirBoleta_Click(object sender, EventArgs e)
        {
            // 1. ¡NUEVA VALIDACIÓN!
            // Esto comprueba todos los validadores de "vgBoleta"
            // Si alguno falla, el código se detiene aquí y muestra
            // los mensajes en rojo automáticamente.
            if (!Page.IsValid) return;

            boBoleta = new BoletaWSClient();
            boleta nuevaBoleta = new boleta();

            // 2. Validar y Leer Datos (SOLO conversiones)
            // (Ya no necesitamos 'if string.IsNullOrEmpty')
            try
            {
                nuevaBoleta.fecha = DateTime.Parse(txtFechaBoleta.Text);
                nuevaBoleta.fechaSpecified = true;
            }
            catch (Exception)
            {
                // Si la fecha es inválida (ej. "30/02/2025"), el validador no lo detecta.
                // Para esto usamos el modal de error.
                mostrarMensajeError("La fecha ingresada no es válida.");
                return;
            }

            try { nuevaBoleta.total = double.Parse(txtTotalBoleta.Text); }
            catch (Exception) { mostrarMensajeError("El campo 'Total' debe ser un número válido."); return; }

            try { nuevaBoleta.IGV = double.Parse(txtIGV.Text); }
            catch (Exception) { mostrarMensajeError("El campo 'IGV' debe ser un número válido."); return; }

            // Los campos de texto van directo
            nuevaBoleta.metodoDePago = txtMetodoPagoBoleta.Text;
            nuevaBoleta.correlativo = txtCorrelativo.Text;
            nuevaBoleta.DNI = txtDNI.Text;

            // --- 3. Llamar al Servicio ---
            try
            {
                int resultado = boBoleta.insertarBoleta(nuevaBoleta);
                if (resultado > 0)
                {
                    MostrarModalExito();
                }
                else
                {
                    mostrarMensajeError("El servicio no pudo registrar la boleta (Resultado: 0).");
                }
            }
            catch (Exception ex)
            {
                mostrarMensajeError("Error de conexión al servicio: " + ex.Message);
            }
        }

        // --- MÉTODOS DE MODAL (Estilo del Profesor) ---
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