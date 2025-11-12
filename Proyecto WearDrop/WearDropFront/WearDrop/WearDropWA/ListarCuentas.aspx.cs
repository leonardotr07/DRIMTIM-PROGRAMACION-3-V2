using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class ListarCuentas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Prueba de DataTable para ver el formato en el GridView
            DataTable dt = new DataTable();
            dt.Columns.Add("IdCuenta");
            dt.Columns.Add("UserName");
            dt.Columns.Add("Email");
            dt.Columns.Add("Empleado");

            // Agrega filas de prueba para ver el formato
            dt.Rows.Add("1", "Hercule123", "hercules@gmail.com", "Luis");
            dt.Rows.Add("2", "Zeus123", "hercules@gmail.com", "Luisa");
            dt.Rows.Add("3", "Hades123", "hercules@gmail.com", "Luisardo");

            gvCuentas.DataSource = dt;
            gvCuentas.DataBind();
        }

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarCuentas.aspx");
        }

        protected void lkFiltrar_Click(object sender, EventArgs e) {
            Response.Redirect("ListarCuentas.aspx");
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarCuentas.aspx");
        }

        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarCuentas.aspx");
        }
    }
}