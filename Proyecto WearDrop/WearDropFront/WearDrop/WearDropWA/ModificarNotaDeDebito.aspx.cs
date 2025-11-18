using System;
using System.Web.UI;
using WearDropWA.NotaDeDebitoService; // Asegúrate de importar tu servicio

namespace WearDropWA
{
    public partial class ModificarNotaDeDebito : System.Web.UI.Page
    {
        private NotaDeDebitoWSClient boNotaDeDebito;

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
                    Response.Redirect("~/ListarNotasDeDebito.aspx");
                }
            }
        }

        private void CargarDatos(int id)
        {
            boNotaDeDebito = new NotaDeDebitoWSClient();
            try
            {
                // Asumo que tu servicio tiene un método 'buscarNotaDeDebito'
                notaDeDebito ndEncontrada = boNotaDeDebito.obtenerNotaDebitoPorId(id);

                if (ndEncontrada != null)
                {
                    txtID.Text = ndEncontrada.idComprobante.ToString();
                    txtCorrelativo.Text = ndEncontrada.correlativo;
                    txtNDFecha.Text = ndEncontrada.fecha.ToString("yyyy-MM-dd");
                    txtNDTotal.Text = ndEncontrada.total.ToString("F2");
                    txtNDIGV.Text = ndEncontrada.IGV.ToString("F2");
                    txtNDMetodoPago.Text = ndEncontrada.metodoDePago;
                    txtNDDetalle.Text = ndEncontrada.detalleModificacion;
                    txtNDRUC.Text = ndEncontrada.RUC;
                    txtNDRazonSocial.Text = ndEncontrada.razonSocial;
                    txtNDMotivo.Text = ndEncontrada.motivoEspecifico;
                    txtNDNuevoMonto.Text = ndEncontrada.nuevoMonto.ToString("F2");
                    txtNDValorAumentar.Text = ndEncontrada.valorAumentar.ToString("F2");
                    txtNDIdPrenda.Text = ndEncontrada.idPrenda.ToString();
                }
                else
                {
                    mostrarMensajeError("No se encontró la nota de débito con el ID " + id);
                }
            }
            catch (Exception ex)
            {
                mostrarMensajeError("Error al cargar datos: " + ex.Message);
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // 1. Comprueba los validadores del grupo "vgModND"
            if (!Page.IsValid) return;

            boNotaDeDebito = new NotaDeDebitoWSClient();
            notaDeDebito ndModificada = new notaDeDebito();

            // 2. Validar y Leer Datos (solo conversiones)
            try
            {
                ndModificada.idComprobante = Convert.ToInt32(txtID.Text);
                ndModificada.fecha = DateTime.Parse(txtNDFecha.Text);
                ndModificada.fechaSpecified = true;
                ndModificada.total = double.Parse(txtNDTotal.Text);
                ndModificada.IGV = double.Parse(txtNDIGV.Text);
                ndModificada.nuevoMonto = double.Parse(txtNDNuevoMonto.Text);
                ndModificada.valorAumentar = double.Parse(txtNDValorAumentar.Text);
                ndModificada.idPrenda = int.Parse(txtNDIdPrenda.Text);
            }
            catch (Exception) { mostrarMensajeError("La fecha, total, IGV, montos o ID Prenda tienen un formato incorrecto."); return; }

            // Campos de texto (ya validados)
            ndModificada.correlativo = txtCorrelativo.Text;
            ndModificada.metodoDePago = txtNDMetodoPago.Text;
            ndModificada.detalleModificacion = txtNDDetalle.Text;
            ndModificada.RUC = txtNDRUC.Text;
            ndModificada.razonSocial = txtNDRazonSocial.Text;
            ndModificada.motivoEspecifico = txtNDMotivo.Text;

            // --- 3. Llamar al Servicio de MODIFICAR ---
            try
            {
                // Llamamos al método que me pasaste
                int resultado = boNotaDeDebito.modificarNotaDebito(ndModificada);

                if (resultado > 0)
                {
                    MostrarModalExito();
                }
                else
                {
                    mostrarMensajeError("El servicio no pudo modificar la nota de débito (Resultado: 0).");
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
            // (Asegúrate de que tu JS 'redirectToManager' apunte a ListarNotasDeDebito.aspx)
            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessModal", "showSuccessModal();", true);
        }
    }
}