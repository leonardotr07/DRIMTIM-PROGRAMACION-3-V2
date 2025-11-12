using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class GestionarPersonas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEmpleados_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarEmpleados.aspx");
        }

        protected void btnClientes_Click(object sender, EventArgs e)
        {
            //Response.Redirect("ListarClientes.aspx");
        }

        protected void btnCuentas_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarCuentas.aspx");
        }
    }
}