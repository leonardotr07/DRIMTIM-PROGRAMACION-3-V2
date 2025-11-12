using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.Design;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class MostrarAlmacen : System.Web.UI.Page
    {
        private MovimientoAlmacenWSClient boMovimientoAlmacen;
        private LoteWSClient boLote;
        private MovimientoAlmacenXLoteWSClient boMovimientoAlmacenXLote;
        private almacen datAlmacen;

        private BindingList<lote> listaLotes;
        private BindingList<movimientoAlmacen> listaMovimientoAlmacen;
        private BindingList<movimientoAlmacenXLote> listaMovimientoAlmacenXLote;

        protected void Page_Load(object sender, EventArgs e)
        {
            boMovimientoAlmacen = new MovimientoAlmacenWSClient();
            boLote = new LoteWSClient();
            boMovimientoAlmacenXLote = new MovimientoAlmacenXLoteWSClient();

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    // Obtener el almacén de la sesión
                    datAlmacen = (almacen)Session["almacenSeleccionado"];

                    if (datAlmacen == null)
                    {
                        Response.Redirect("ListarAlmacenes.aspx");
                        return;
                    }

                    // Guardar todo el objeto almacén en ViewState
                    ViewState["AlmacenCompleto"] = datAlmacen;

                    // Recuperar la última pestaña visitada de la sesión o usar "Lotes" por defecto
                    string tabActiva = Session["UltimaPagina"]?.ToString() ?? "Lotes";
                    ViewState["TabActiva"] = tabActiva;

                    CargarDatosAlmacen();

                    // Cargar la pestaña correspondiente basada en la sesión
                    CargarPestanaActiva(tabActiva);
                }
                else
                {
                    Response.Redirect("ListarAlmacenes.aspx");
                }
            }
            else
            {
                // Recuperar el almacén completo del ViewState en postback
                datAlmacen = (almacen)ViewState["AlmacenCompleto"];

                if (datAlmacen == null)
                {
                    // Si por alguna razón se perdió el ViewState, intentar recuperar de Session
                    datAlmacen = (almacen)Session["almacenSeleccionado"];

                    if (datAlmacen == null)
                    {
                        Response.Redirect("ListarAlmacenes.aspx");
                        return;
                    }
                }
            }
        }

        private void CargarDatosAlmacen()
        {
            txtId.Text = datAlmacen.id.ToString();
            txtNombre.Text = datAlmacen.nombre;
            txtUbicacion.Text = datAlmacen.ubicacion;
        }

        private void CargarPestanaActiva(string tabActiva)
        {
            switch (tabActiva)
            {
                case "Movimientos":
                    MostrarPanel(panelMovimientos);
                    ActualizarEstiloTab(tabMovimientos);
                    CargarMovimientos();
                    break;
                case "MovimientosXLote":
                    MostrarPanel(panelMovimientosXLotes);
                    ActualizarEstiloTab(tabMovimientosXLotes);
                    CargarMovimientosXLotes();
                    break;
                default: // "Lotes"
                    MostrarPanel(panelLotes);
                    ActualizarEstiloTab(tabLotes);
                    CargarLotes();
                    break;
            }
        }

        #region Manejo de Pestañas

        protected void tabLotes_Click(object sender, EventArgs e)
        {
            MostrarPanel(panelLotes);
            ActualizarEstiloTab(tabLotes);
            
            Session["UltimaPagina"] = "Lotes";
            ViewState["TabActiva"] = "Lotes";
            CargarLotes();
        }

        protected void tabMovimientos_Click(object sender, EventArgs e)
        {
            MostrarPanel(panelMovimientos);
            ActualizarEstiloTab(tabMovimientos);
            Session["UltimaPagina"] = "Movimientos";
            ViewState["TabActiva"] = "Movimientos";
            CargarMovimientos();
        }

        protected void tabMovimientosXLotes_Click(object sender, EventArgs e)
        {
            MostrarPanel(panelMovimientosXLotes);
            ActualizarEstiloTab(tabMovimientosXLotes);
            Session["UltimaPagina"] = "MovimientosXLote";
            ViewState["TabActiva"] = "MovimientosXLote";
            CargarMovimientosXLotes();
        }

        private void MostrarPanel(Panel panelActivo)
        {
            panelLotes.Visible = false;
            panelMovimientos.Visible = false;
            panelMovimientosXLotes.Visible = false;
            panelActivo.Visible = true;
        }

        private void ActualizarEstiloTab(LinkButton tabActivo)
        {
            tabLotes.CssClass = "nav-link";
            tabMovimientos.CssClass = "nav-link";
            tabMovimientosXLotes.CssClass = "nav-link";
            tabActivo.CssClass = "nav-link active";
        }

        #endregion

        #region Carga de Datos

        private void CargarLotes()
        {
            try
            {
                listaLotes = new BindingList<lote>(boLote.listarLotesActivosPorAlmacen(datAlmacen.id));
                gvLotes.DataSource = listaLotes;
                gvLotes.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar lotes: {ex.Message}');", true);
            }
        }

        private void CargarMovimientos()
        {
            try
            {
                listaMovimientoAlmacen = new BindingList<movimientoAlmacen>(
                    boMovimientoAlmacen.listarMovimientosPorAlmacen(datAlmacen.id)
                );

                gvMovimientos.DataSource = listaMovimientoAlmacen;
                gvMovimientos.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar movimientos: {ex.Message}');", true);
            }
        }

        private void CargarMovimientosXLotes()
        {
            try
            {
                listaMovimientoAlmacenXLote = new BindingList<movimientoAlmacenXLote>(
                    boMovimientoAlmacenXLote.listarMovXLoteActivosPorAlmacen(datAlmacen.id)
                );

                gvMovimientosXLotes.DataSource = listaMovimientoAlmacenXLote;
                
                gvMovimientosXLotes.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar movimientos por lote: {ex.Message}');", true);
            }
        }

        #endregion

        #region Paginación

        protected void gvLotes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvLotes.PageIndex = e.NewPageIndex;
            CargarLotes();
        }

        protected void gvMovimientos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMovimientos.PageIndex = e.NewPageIndex;
            CargarMovimientos();
        }

        protected void gvMovimientosXLotes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMovimientosXLotes.PageIndex = e.NewPageIndex;
            CargarMovimientosXLotes();
        }

        #endregion

        #region Acciones de Lotes

        protected void btnModificarLote_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idLote = int.Parse(btn.CommandArgument);
            Response.Redirect($"Lote/ModificarLote.aspx?id={idLote}&idAlmacen={datAlmacen.id}");
        }

        #endregion

        #region Acciones de Movimientos

        protected void btnModificarMovimiento_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idMovimiento = int.Parse(btn.CommandArgument);
            Response.Redirect($"Movimiento/ModificarMovimiento.aspx?id={idMovimiento}&idAlmacen={datAlmacen.id}");
        }

        #endregion

        #region Acciones de Movimientos x Lotes

        protected void btnModificarMovimientoXLote_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int idMovimiento = int.Parse(btn.CommandArgument);
            Response.Redirect($"MovimientoXLote/ModificarMovimientoXLote.aspx?id={idMovimiento}&idAlmacen={datAlmacen.id}");
        }

        #endregion

        #region Eliminación con Modal

        protected void btnConfirmarEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                int idEliminar = int.Parse(hfIdEliminar.Value);
                string tipoEliminar = hfTipoEliminar.Value;

                switch (tipoEliminar)
                {
                    case "Lote":
                        int resultadoLote = boLote.eliminarLote(idEliminar);
                        if (resultadoLote > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"alert('Lote eliminado correctamente'); cerrarModal();", true);
                            CargarLotes();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"alert('No se pudo eliminar el lote'); cerrarModal();", true);
                        }
                        break;

                    case "Movimiento":
                        int resultadoMovimiento = boMovimientoAlmacen.eliminarMovimientoAlmacen(idEliminar);
                        if (resultadoMovimiento > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"alert('Movimiento eliminado correctamente'); cerrarModal();", true);
                            CargarMovimientos();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"alert('No se pudo eliminar el movimiento'); cerrarModal();", true);
                        }
                        break;

                    case "MovimientoXLote":
                        int resultadoMovXLote = boMovimientoAlmacenXLote.eliminarMovXLote(idEliminar);
                        if (resultadoMovXLote > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"alert('Movimiento por Lote eliminado correctamente'); cerrarModal();", true);
                            CargarMovimientosXLotes();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                                $"alert('No se pudo eliminar el movimiento por lote'); cerrarModal();", true);
                        }
                        break;

                    default:
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            "alert('Tipo de eliminación no reconocido'); cerrarModal();", true);
                        break;
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al eliminar: {ex.Message}'); cerrarModal();", true);
            }
        }

        #endregion

        #region Botones de Navegación

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            string tabActiva = ViewState["TabActiva"]?.ToString() ?? "Lotes";

            switch (tabActiva)
            {
                case "Lotes":
                    Response.Redirect($"Lote/RegistrarLote.aspx?idAlmacen={datAlmacen.id}");
                    break;
                case "Movimientos":
                    Response.Redirect($"Movimiento/RegistrarMovimiento.aspx?idAlmacen={datAlmacen.id}");
                    break;
                case "MovimientosXLote":
                    Response.Redirect($"MovimientoXLote/RegistrarMovimientoXLote.aspx?idAlmacen={datAlmacen.id}");
                    break;
            }
        }

        protected void lkFiltrar_Click(object sender, EventArgs e)
        {
            // Implementar lógica de filtrado según la pestaña activa
            string tabActiva = ViewState["TabActiva"]?.ToString() ?? "Lotes";

            switch (tabActiva)
            {
                case "Lotes":
                    // Redirigir a página de filtrado de lotes
                    Response.Redirect($"Lote/FiltrarLotes.aspx?idAlmacen={datAlmacen.id}");
                    break;
                case "Movimientos":
                    // Redirigir a página de filtrado de movimientos
                    Response.Redirect($"Movimiento/FiltrarMovimientos.aspx?idAlmacen={datAlmacen.id}");
                    break;
                case "MovimientosXLote":
                    // Redirigir a página de filtrado de movimientos x lote
                    Response.Redirect($"MovimientoXLote/FiltrarMovimientosXLote.aspx?idAlmacen={datAlmacen.id}");
                    break;
            }
        }

        protected void lkRetroceder_Click(object sender, EventArgs e)
        {
            // Limpiar la variable de sesión de la pestaña activa al retroceder
            Session["UltimaPagina"] = null;
            Response.Redirect("ListarAlmacenes.aspx");
        }

        #endregion

    }
}