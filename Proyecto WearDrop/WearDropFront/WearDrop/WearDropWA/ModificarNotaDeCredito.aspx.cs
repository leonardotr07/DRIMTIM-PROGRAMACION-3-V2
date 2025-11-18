using System;
using System.Web.UI;
using WearDropWA.NotaDeCreditoService; // Asegúrate de importar tu servicio

namespace WearDropWA
{
    public partial class ModificarNotaDeCredito : System.Web.UI.Page
    {
        private NotaDeCreditoWSClient boNotaDeCredito;

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
                    Response.Redirect("~/ListarNotasDeCredito.aspx");
                }
            }
        }

        private void CargarDatos(int id)
        {
            boNotaDeCredito = new NotaDeCreditoWSClient();
            try
            {
                // Asumo que tu servicio tiene un método 'buscarNotaDeCredito'
                notaDeCredito ncEncontrada = boNotaDeCredito.obtenerNotaCreditoPorId(id);

                if (ncEncontrada != null)
                {
                    txtID.Text = ncEncontrada.idComprobante.ToString();
                    txtCorrelativo.Text = ncEncontrada.correlativo;
                    txtNCFecha.Text = ncEncontrada.fecha.ToString("yyyy-MM-dd");
                    txtNCTotal.Text = ncEncontrada.total.ToString("F2");
                    txtNCIGV.Text = ncEncontrada.IGV.ToString("F2");
                    txtNCMetodoPago.Text = ncEncontrada.metodoDePago;
                    txtNCDetalle.Text = ncEncontrada.detalleModificacion;
                    txtNCRUC.Text = ncEncontrada.RUC;
                    txtNCRazonSocial.Text = ncEncontrada.razonSocial;
                    txtNCDNI.Text = ncEncontrada.DNI;
                    txtNCMotivo.Text = ncEncontrada.motivoEspecifico;
                    txtNCNuevoMonto.Text = ncEncontrada.nuevoMonto.ToString("F2");
                    txtNCValorAumentar.Text = ncEncontrada.valorAumentar.ToString("F2");
                }
                else
                {
                    mostrarMensajeError("No se encontró la nota de crédito con el ID " + id);
                }
            }
            catch (Exception ex)
            {
                mostrarMensajeError("Error al cargar datos: " + ex.Message);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // 1. Comprueba los validadores del grupo "vgModNC"
            if (!Page.IsValid) return;

            boNotaDeCredito = new NotaDeCreditoWSClient();
            notaDeCredito ncModificada = new notaDeCredito();

            // 2. Validar y Leer Datos (solo conversiones)
            try
            {
                ncModificada.idComprobante = Convert.ToInt32(txtID.Text);
                ncModificada.fecha = DateTime.Parse(txtNCFecha.Text);
                ncModificada.fechaSpecified = true;
                ncModificada.total = double.Parse(txtNCTotal.Text);
                ncModificada.IGV = double.Parse(txtNCIGV.Text);
                ncModificada.nuevoMonto = double.Parse(txtNCNuevoMonto.Text);
                ncModificada.valorAumentar = double.Parse(txtNCValorAumentar.Text); // 'valorAumentar' en tu DAO
            }
            catch (Exception) { mostrarMensajeError("La fecha, total, IGV o montos tienen un formato incorrecto."); return; }

            // Campos de texto (ya validados)
            ncModificada.correlativo = txtCorrelativo.Text;
            ncModificada.metodoDePago = txtNCMetodoPago.Text;
            ncModificada.detalleModificacion = txtNCDetalle.Text;
            ncModificada.RUC = txtNCRUC.Text;
            ncModificada.razonSocial = txtNCRazonSocial.Text;
            ncModificada.DNI = txtNCDNI.Text;
            ncModificada.motivoEspecifico = txtNCMotivo.Text;

            // --- 3. Llamar al Servicio de MODIFICAR ---
            try
            {
                // Llamamos al método que me pasaste
                int resultado = boNotaDeCredito.modificarNotaCredito(ncModificada);

                if (resultado > 0)
                {
                    MostrarModalExito();
                }
                else
                {
                    mostrarMensajeError("El servicio no pudo modificar la nota de crédito (Resultado: 0).");
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
            // (Asegúrate de que tu JS 'redirectToManager' apunte a ListarNotasDeCredito.aspx)
            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessModal", "showSuccessModal();", true);
        }
    }
}