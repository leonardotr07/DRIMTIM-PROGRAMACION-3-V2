using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServicePromocionCombo;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class RegistrarCombo : System.Web.UI.Page
    {
        private PromocionComboWSClient boProm;
        private promocionCombo datProm;
        private vigencia vig;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            datProm = new promocionCombo();
            vig=new vigencia();

        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarCombo.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            boProm = new PromocionComboWSClient();
            datProm.nombre=txtNombre.Text;
            datProm.cantidadGratis=int.Parse(txtCantidadGratis.Text);
            datProm.cantidadRequerida = int.Parse(txtCantidadRequerida.Text);
            int resultado=boProm.insertarPromocion(datProm);
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