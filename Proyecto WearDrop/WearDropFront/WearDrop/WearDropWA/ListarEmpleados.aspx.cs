using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class ListarEmpleados : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Prueba de DataTable para ver el formato en el GridView
            DataTable dt = new DataTable();
            dt.Columns.Add("IdEmpleado");
            dt.Columns.Add("Nombre");
            dt.Columns.Add("Apellidos");
            dt.Columns.Add("Dni");
            dt.Columns.Add("Sueldo");

            // Agrega filas de prueba para ver el formato
            dt.Rows.Add("1", "Pedro", "Sanchez", "73024207", "1770.00");
            dt.Rows.Add("2", "Leonardo", "Valeria", "73024207", "1000.00");
            dt.Rows.Add("3", "Matias", "Jafeth", "73024207", "100.00");

            gvEmpleados.DataSource = dt;
            gvEmpleados.DataBind();
        }

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarEmpleado.aspx");
        }

        protected void lkFiltrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarEmpleados.aspx");
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarEmpleado.aspx");
        }

        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            Response.Redirect("VerEmpleado.aspx");
        }
    }
}