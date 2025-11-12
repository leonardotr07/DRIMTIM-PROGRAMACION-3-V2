using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class RegistrarLiquidacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarLiquidacion.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {

            Response.Redirect("ListarLiquidacion.aspx");
        }
        protected void btnAnhadirPrenda_Click(object sender, EventArgs e)
        {

            Response.Redirect("SeleccionarPrendaLiquidacion.aspx");
        }
        protected void btnRegistrarVigencia_Click(object sender, EventArgs e)
        {

        }

    }
}