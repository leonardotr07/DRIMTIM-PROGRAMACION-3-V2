using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class ModificarMovimientoXLote : System.Web.UI.Page
    {
        // Clientes de servicios web
        private MovimientoAlmacenWSClient boMovimientoAlmacen;
        private LoteWSClient boLote;
        private MovimientoAlmacenXLoteWSClient boMovimientoAlmacenXLote;

        private int idRelacion;

        protected void Page_Load(object sender, EventArgs e)
        {
            boMovimientoAlmacen = new MovimientoAlmacenWSClient();
            boLote = new LoteWSClient();
            boMovimientoAlmacenXLote = new MovimientoAlmacenXLoteWSClient();

            if (!IsPostBack)
            {
                // 🔹 Obtener el ID de la relación y el almacén desde el query string
                if (Request.QueryString["id"] != null && Request.QueryString["idAlmacen"] != null)
                {
                    idRelacion = Convert.ToInt32(Request.QueryString["id"]);
                    ViewState["IdRelacion"] = idRelacion;
                    ViewState["IdAlmacen"] = Request.QueryString["idAlmacen"];

                    // Cargar los datos de la relación existente
                    CargarDatosRelacion();
                }
                else
                {
                    Response.Redirect("../ListarAlmacenes.aspx");
                }
            }
            else
            {
                idRelacion = (int)ViewState["IdRelacion"];
            }
        }

        // 🔹 Cargar los datos de la relación existente (solo al inicio)
        private void CargarDatosRelacion()
        {
            try
            {
                // Obtener la relación existente del servicio
                movimientoAlmacenXLote relacionActual = boMovimientoAlmacenXLote.obtenerMovXLotePorID(idRelacion);

                if (relacionActual != null)
                {
                    // 🔹 Cargar datos del Movimiento
                    if (relacionActual.datMov != null)
                    {
                        txtIdMovimiento.Text = relacionActual.datMov.idMovimiento.ToString();
                        CargarDatosMovimiento(relacionActual.datMov.idMovimiento);
                    }

                    // 🔹 Cargar datos del Lote
                    if (relacionActual.datLote != null)
                    {
                        txtIdLote.Text = relacionActual.datLote.idLote.ToString();
                        CargarDatosLote(relacionActual.datLote.idLote);
                    }

                    // 🔹 Guardar la relación completa en ViewState
                    ViewState["RelacionActual"] = relacionActual;
                }
                else
                {
                    MostrarMensaje("No se encontró la relación especificada");
                    Response.Redirect(ObtenerUrlRedireccion());
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al cargar la relación: {ex.Message}");
                Response.Redirect(ObtenerUrlRedireccion());
            }
        }

        // 🔹 🔹 🔹 AÑADIDO: Evento cuando cambia el ID del Movimiento
        protected void txtIdMovimiento_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtIdMovimiento.Text))
            {
                try
                {
                    int idMovimiento = Convert.ToInt32(txtIdMovimiento.Text.Trim());
                    CargarDatosMovimiento(idMovimiento);
                }
                catch (FormatException)
                {
                    LimpiarCamposMovimiento();
                    MostrarMensaje("Por favor, ingrese un ID de movimiento válido (número entero)");
                }
                catch (Exception ex)
                {
                    LimpiarCamposMovimiento();
                    MostrarMensaje($"Error al cargar el movimiento: {ex.Message}");
                }
            }
            else
            {
                LimpiarCamposMovimiento();
            }
        }

        // 🔹 Cargar datos del movimiento
        private void CargarDatosMovimiento(int idMovimiento)
        {
            try
            {
                movimientoAlmacen movimiento = boMovimientoAlmacen.obtenerMovimientoPorId(idMovimiento);

                if (movimiento != null && movimiento.idMovimiento > 0)
                {
                    txtLugarOrigen.Text = movimiento.lugarOrigen ?? "";
                    txtLugarDestino.Text = movimiento.lugarDestino ?? "";

                    if (movimiento.fechaSpecified && movimiento.fecha != DateTime.MinValue)
                    {
                        txtFecha.Text = movimiento.fecha.ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        txtFecha.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    }

                    if (movimiento.tipo != null)
                    {
                        txtTipo.Text = movimiento.tipo.ToString();
                    }
                    else
                    {
                        txtTipo.Text = "";
                    }

                    ViewState["MovimientoActual"] = movimiento;
                }
                else
                {
                    LimpiarCamposMovimiento();
                    MostrarMensaje($"No se encontró ningún movimiento con el ID {idMovimiento}");
                }
            }
            catch (System.ServiceModel.FaultException faultEx)
            {
                LimpiarCamposMovimiento();
                MostrarMensaje($"Error del servicio web: {faultEx.Message}");
            }
            catch (System.ServiceModel.CommunicationException commEx)
            {
                LimpiarCamposMovimiento();
                MostrarMensaje($"Error de comunicación con el servicio: {commEx.Message}");
            }
            catch (Exception ex)
            {
                LimpiarCamposMovimiento();
                MostrarMensaje($"Error inesperado al cargar el movimiento: {ex.Message}");
            }
        }

        private void LimpiarCamposMovimiento()
        {
            txtLugarOrigen.Text = string.Empty;
            txtLugarDestino.Text = string.Empty;
            txtFecha.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtTipo.Text = string.Empty;
            ViewState["MovimientoActual"] = null;
        }

        protected void txtIdLote_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtIdLote.Text))
            {
                try
                {
                    int idLote = Convert.ToInt32(txtIdLote.Text.Trim());
                    CargarDatosLote(idLote);
                }
                catch (FormatException)
                {
                    LimpiarCamposLote();
                    // 🔹 NO redirigir, solo mostrar mensaje
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Por favor, ingrese un ID de lote válido (número entero)');", true);
                }
                catch (Exception ex)
                {
                    LimpiarCamposLote();
                    // 🔹 NO redirigir, solo mostrar mensaje
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        $"alert('Error al cargar el lote: {ex.Message}');", true);
                }
            }
            else
            {
                LimpiarCamposLote();
            }
        }

        // 🔹 Cargar datos del lote
        private void CargarDatosLote(int idLote)
        {
            try
            {
                lote lote = boLote.obtenerLotePorID(idLote);

                if (lote != null && lote.idLote > 0)
                {
                    // 🔹 Mostrar la descripción del lote
                    txtDescripcion.Text = lote.descripcion ?? "";
                    ViewState["LoteActual"] = lote;
                }
                else
                {
                    LimpiarCamposLote();
                    // 🔹 NO redirigir, solo mostrar mensaje
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        $"alert('No se encontró ningún lote con el ID {idLote}');", true);
                }
            }
            catch (System.ServiceModel.FaultException faultEx)
            {
                LimpiarCamposLote();
                // 🔹 NO redirigir, solo mostrar mensaje
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error del servicio web: {faultEx.Message}');", true);
            }
            catch (System.ServiceModel.CommunicationException commEx)
            {
                LimpiarCamposLote();
                // 🔹 NO redirigir, solo mostrar mensaje
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error de comunicación con el servicio: {commEx.Message}');", true);
            }
            catch (Exception ex)
            {
                LimpiarCamposLote();
                // 🔹 NO redirigir, solo mostrar mensaje
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error inesperado al cargar el lote: {ex.Message}');", true);
            }
        }

        private void LimpiarCamposLote()
        {
            txtDescripcion.Text = string.Empty;
            ViewState["LoteActual"] = null;
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                // Validar campos obligatorios
                if (string.IsNullOrWhiteSpace(txtIdMovimiento.Text))
                {
                    MostrarMensaje("Por favor, ingrese el ID del Movimiento");
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtIdLote.Text))
                {
                    MostrarMensaje("Por favor, ingrese el ID del Lote");
                    return;
                }

                // Validar que los datos estén cargados
                if (ViewState["MovimientoActual"] == null)
                {
                    MostrarMensaje("Los datos del movimiento no están cargados. Verifique el ID del Movimiento.");
                    return;
                }

                if (ViewState["LoteActual"] == null)
                {
                    MostrarMensaje("Los datos del lote no están cargados. Verifique el ID del Lote.");
                    return;
                }

                // Validación adicional: verificar que los campos estén completos
                if (string.IsNullOrWhiteSpace(txtLugarOrigen.Text) ||
                    string.IsNullOrWhiteSpace(txtLugarDestino.Text))
                {
                    MostrarMensaje("Los datos del movimiento están incompletos. Verifique el ID.");
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtDescripcion.Text))
                {
                    MostrarMensaje("Los datos del lote están incompletos. Verifique el ID.");
                    return;
                }

                // 🔹 Obtener el ID del almacén
                string idAlmacenStr = ViewState["IdAlmacen"]?.ToString();
                if (string.IsNullOrEmpty(idAlmacenStr))
                {
                    MostrarMensaje("No se pudo determinar el almacén. Por favor, acceda a esta página desde un almacén específico.");
                    return;
                }

                int idAlmacen = Convert.ToInt32(idAlmacenStr);
                int idMovimiento = Convert.ToInt32(txtIdMovimiento.Text.Trim());
                int idLote = Convert.ToInt32(txtIdLote.Text.Trim());

                // 🔹 VALIDAR QUE EL MOVIMIENTO PERTENEZCA AL ALMACÉN
                bool movimientoExisteEnAlmacen = ValidarMovimientoEnAlmacen(idMovimiento, idAlmacen);

                if (!movimientoExisteEnAlmacen)
                {
                    MostrarMensaje($"El movimiento con ID {idMovimiento} no pertenece a este almacén. Verifique que el movimiento esté asociado al almacén seleccionado.");
                    return;
                }

                // 🔹 VALIDAR QUE EL LOTE PERTENEZCA AL ALMACÉN
                bool loteExisteEnAlmacen = ValidarLoteEnAlmacen(idLote, idAlmacen);

                if (!loteExisteEnAlmacen)
                {
                    MostrarMensaje($"El lote con ID {idLote} no se encuentra en este almacén. Verifique que el lote pertenezca al almacén seleccionado.");
                    return;
                }

                // 🔹 Recuperar la relación existente o crear una nueva
                movimientoAlmacenXLote movXLote = ViewState["RelacionActual"] as movimientoAlmacenXLote;

                if (movXLote == null)
                {
                    movXLote = new movimientoAlmacenXLote();
                }

                // Asignar el ID de la relación
                movXLote.idMov_X_Lote = idRelacion;

                // Asignar los objetos completos recuperados del ViewState
                movXLote.datMov = (movimientoAlmacen)ViewState["MovimientoActual"];
                movXLote.datLote = (lote)ViewState["LoteActual"];

                // Llamar al servicio web para modificar la relación
                int resultado = boMovimientoAlmacenXLote.modificarMovXLote(movXLote);

                if (resultado > 0)
                {
                    MostrarMensajeYRedirigir(
                        "Relación modificada exitosamente",
                        ObtenerUrlRedireccion()
                    );
                }
                else
                {
                    MostrarMensaje("Error al modificar la relación. El servicio retornó 0. Por favor, intente nuevamente.");
                }
            }
            catch (FormatException)
            {
                MostrarMensaje("Por favor, ingrese valores numéricos válidos para los IDs");
            }
            catch (System.ServiceModel.FaultException faultEx)
            {
                MostrarMensaje($"Error del servicio web al modificar: {faultEx.Message}");
            }
            catch (Exception ex)
            {
                MostrarMensaje($"Error al modificar la relación: {ex.Message}");
            }
        }

        private bool ValidarMovimientoEnAlmacen(int idMovimiento, int idAlmacen)
        {
            try
            {
                BindingList<movimientoAlmacen> movimientosDelAlmacen = new BindingList<movimientoAlmacen>(
                    boMovimientoAlmacen.listarMovimientosPorAlmacen(idAlmacen)
                );

                bool existe = movimientosDelAlmacen.Any(m => m.idMovimiento == idMovimiento);
                return existe;
            }
            catch (System.ServiceModel.FaultException faultEx)
            {
                System.Diagnostics.Debug.WriteLine($"Error al validar movimiento: {faultEx.Message}");
                return false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error inesperado al validar movimiento: {ex.Message}");
                return false;
            }
        }

        private bool ValidarLoteEnAlmacen(int idLote, int idAlmacen)
        {
            try
            {
                BindingList<lote> lotesDelAlmacen = new BindingList<lote>(
                    boLote.listarLotesActivosPorAlmacen(idAlmacen)
                );

                bool existe = lotesDelAlmacen.Any(l => l.idLote == idLote);
                return existe;
            }
            catch (System.ServiceModel.FaultException faultEx)
            {
                System.Diagnostics.Debug.WriteLine($"Error al validar lote: {faultEx.Message}");
                return false;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error inesperado al validar lote: {ex.Message}");
                return false;
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect(ObtenerUrlRedireccion());
        }

        private string ObtenerUrlRedireccion()
        {
            string idAlmacen = ViewState["IdAlmacen"]?.ToString();

            if (!string.IsNullOrEmpty(idAlmacen))
            {
                return $"../MostrarAlmacen.aspx?id={idAlmacen}";
            }
            else
            {
                return "../ListarAlmacenes.aspx";
            }
        }

        private void MostrarMensaje(string mensaje)
        {
            string script = $"<script type='text/javascript'>alert('{EscaparComillas(mensaje)}');</script>";
            Response.Write(script);
        }

        private void MostrarMensajeYRedirigir(string mensaje, string url)
        {
            string script = $"<script type='text/javascript'>alert('{EscaparComillas(mensaje)}'); window.location='{url}';</script>";
            Response.Write(script);
        }

        private string EscaparComillas(string texto)
        {
            return texto.Replace("'", "\\'").Replace("\"", "\\\"").Replace("\n", "\\n").Replace("\r", "");
        }
    }
}
