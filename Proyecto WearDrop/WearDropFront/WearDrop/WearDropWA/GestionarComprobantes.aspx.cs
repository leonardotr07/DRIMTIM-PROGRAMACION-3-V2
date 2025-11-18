using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class GestionarComprobantes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Esta página ya no carga datos
        }

        // --- MÉTODOS DE NAVEGACIÓN ---

        protected void btnBoleta_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ListarBoletas.aspx");
        }

        protected void btnFactura_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ListarFacturas.aspx");
        }

        protected void btnNotaCredito_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ListarNotasDeCredito.aspx");
        }

        protected void btnNotaDebito_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ListarNotasDeDebito.aspx");
        }
    }
}