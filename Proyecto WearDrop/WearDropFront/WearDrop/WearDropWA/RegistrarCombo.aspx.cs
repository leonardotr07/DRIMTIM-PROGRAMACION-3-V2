using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class RegistrarCombo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarCombo.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {

            Response.Redirect("ListarCombo.aspx");
        }
        protected void btnAñadirPrenda_Click(object sender, EventArgs e)
        {

            Response.Redirect("SeleccionarPrendaCombo.aspx");
        }
        protected void btnRegistrarVigencia_Click(object sender, EventArgs e)
        {

        }

    }
}