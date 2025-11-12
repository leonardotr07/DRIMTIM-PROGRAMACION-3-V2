using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class GestionarPrendas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnPolos_Click(object sender, EventArgs e)
            => Response.Redirect("~/ListarPrendas.aspx?tipo=Polos");

        protected void btnVestidos_Click(object sender, EventArgs e)
            => Response.Redirect("~/ListarPrendas.aspx?tipo=Vestidos");

        protected void btnFaldas_Click(object sender, EventArgs e)
            => Response.Redirect("~/ListarPrendas.aspx?tipo=Faldas");

        protected void btnGorros_Click(object sender, EventArgs e)
            => Response.Redirect("~/ListarPrendas.aspx?tipo=Gorros");

        protected void btnPantalones_Click(object sender, EventArgs e)
            => Response.Redirect("~/ListarPrendas.aspx?tipo=Pantalones");

        protected void btnCasacas_Click(object sender, EventArgs e)
            => Response.Redirect("~/ListarPrendas.aspx?tipo=Casacas");

        protected void btnBlusas_Click(object sender, EventArgs e)
            => Response.Redirect("~/ListarPrendas.aspx?tipo=Blusas");

        
    }
}
