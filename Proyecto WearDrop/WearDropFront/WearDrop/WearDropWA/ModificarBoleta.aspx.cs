using System;
using System.Web.UI;
using WearDropWA.BoletaService; // Asegúrate de importar tu servicio

namespace WearDropWA
{
    public partial class ModificarBoleta : System.Web.UI.Page
    {
        private BoletaWSClient boBoleta;

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
                    Response.Redirect("~/ListarBoletas.aspx");
                }
            }
        }

        private void CargarDatos(int id)
        {
            boBoleta = new BoletaWSClient();
            try
            {
                // Asumo que tu servicio tiene un método 'buscarBoleta'
                boleta boletaEncontrada = boBoleta.obtenerBoletaPorId(id);

                if (boletaEncontrada != null)
                {
                    txtID.Text = boletaEncontrada.idComprobante.ToString();
                    txtCorrelativo.Text = boletaEncontrada.correlativo;
                    txtBoletaDNI.Text = boletaEncontrada.DNI;
                    txtBoletaMetodoPago.Text = boletaEncontrada.metodoDePago;
                    txtBoletaFecha.Text = boletaEncontrada.fecha.ToString("yyyy-MM-dd");
                    txtBoletaTotal.Text = boletaEncontrada.total.ToString("F2"); // "F2" para 2 decimales
                    txtBoletaIGV.Text = boletaEncontrada.IGV.ToString("F2");
                }
                else
                {
                    mostrarMensajeError("No se encontró la boleta con el ID " + id);
                }
            }
            catch (Exception ex)
            {
                mostrarMensajeError("Error al cargar datos: " + ex.Message);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // 1. Comprueba los validadores del grupo "vgModBoleta"
            if (!Page.IsValid) return;

            boBoleta = new BoletaWSClient();
            boleta boletaModificada = new boleta();

            // 2. Validar y Leer Datos (solo conversiones)
            try
            {
                boletaModificada.idComprobante = Convert.ToInt32(txtID.Text);
                boletaModificada.fecha = DateTime.Parse(txtBoletaFecha.Text);
                boletaModificada.fechaSpecified = true;
                boletaModificada.total = double.Parse(txtBoletaTotal.Text);
                boletaModificada.IGV = double.Parse(txtBoletaIGV.Text);
            }
            catch (Exception) { mostrarMensajeError("La fecha, total o IGV tienen un formato incorrecto."); return; }

            // Campos de texto (ya validados por RequiredFieldValidator)
            boletaModificada.correlativo = txtCorrelativo.Text;
            boletaModificada.metodoDePago = txtBoletaMetodoPago.Text;
            boletaModificada.DNI = txtBoletaDNI.Text;

            // --- 3. Llamar al Servicio de MODIFICAR ---
            try
            {
                // Llamamos al método que me pasaste
                int resultado = boBoleta.modificarBoleta(boletaModificada);

                if (resultado > 0)
                {
                    MostrarModalExito();
                }
                else
                {
                    mostrarMensajeError("El servicio no pudo modificar la boleta (Resultado: 0).");
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
            // (Asegúrate de que tu JS 'redirectToManager' apunte a ListarBoletas.aspx)
            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessModal", "showSuccessModal();", true);
        }
    }
}