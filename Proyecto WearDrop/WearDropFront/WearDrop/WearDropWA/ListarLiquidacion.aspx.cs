using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class ListarLiquidacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Prueba de DataTable para ver el formato en el GridView
            DataTable dt = new DataTable();
            dt.Columns.Add("IdDescuento");
            dt.Columns.Add("Nombre");
            dt.Columns.Add("Porcentaje Liquidacion");
            dt.Columns.Add("Condicion Stock Min");

            // Agrega filas de prueba para ver el formato
            dt.Rows.Add("1", "Descuento Por Polo", "50", "100");
            dt.Rows.Add("2", "Descuento Por  Jean", "80", "85");
            dt.Rows.Add("3", "Descuento Por  Falda", "100", "120");

            gvLiquidaciones.DataSource = dt;
            gvLiquidaciones.DataBind();
        }

        protected void lkFiltrar_Click(object sender, EventArgs e)
        {

        }
        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarLiquidacion.aspx");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarLiquidacion.aspx");
        }
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ModificarLiquidacion.aspx");
        }
        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarLiquidacion.aspx");
        }
    }
}