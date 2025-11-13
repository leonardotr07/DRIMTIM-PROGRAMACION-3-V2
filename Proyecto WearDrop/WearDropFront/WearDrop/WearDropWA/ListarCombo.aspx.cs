using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServicePromocionCombo;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class ListarCombo : System.Web.UI.Page
    {
        private PromocionComboWSClient boProm;
        private BindingList<promocionCombo> listaProm;
        protected void Page_Load(object sender, EventArgs e)
        {
            //Prueba de DataTable para ver el formato en el GridView
            //DataTable dt = new DataTable();
            //dt.Columns.Add("IdPromocion");
            //dt.Columns.Add("Nombre");
            //dt.Columns.Add("Cantidad Gratis");
            //dt.Columns.Add("Cantidad Requerida");
            //// Agrega filas de prueba para ver el formato
            //dt.Rows.Add("1", "Promocion Por Polo", "50", "100");
            //dt.Rows.Add("2", "Promocion Por  Jean", "80", "103");
            //dt.Rows.Add("3", "Promocion Por  Falda", "100", "203");

            //gvMonto.DataSource = dt;
            //gvMonto.DataBind();
            boProm = new PromocionComboWSClient();
            if (!IsPostBack)
            {
                // Limpiar la variable de sesión de la última página visitada al cargar ListarAlmacenes
                Session["UltimaPagina"] = null;
            }

            CargarPromociones();
        }
        private void CargarPromociones()
        {
            try
            {
                promocionCombo[] promociones = boProm.mostrar_promocionesActivas();
                listaProm = new BindingList<promocionCombo>(promociones);
                gvMonto.DataSource = listaProm;
                gvMonto.DataBind();
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar las promociones: {ex.Message}');", true);
            }
        }
        protected void lkFiltrar_Click(object sender, EventArgs e)
        {

        }
        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarCombo.aspx");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            int idProm = Int32.Parse(((LinkButton)sender).CommandArgument);

            try
            {


                boProm = new PromocionComboWSClient();
                boProm.eliminarPromocionCombo(idProm);
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al eliminar: {ex.Message}'); cerrarModal();", true);
            }
            Response.Redirect("ListarCombo.aspx");
        }
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ModificarCombo.aspx");
        }
        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarCombo.aspx");
        }
    }
}