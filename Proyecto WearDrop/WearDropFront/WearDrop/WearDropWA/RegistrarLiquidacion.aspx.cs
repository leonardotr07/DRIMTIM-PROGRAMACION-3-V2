using System;
using System.Collections.Generic;
using System.Data;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServicePromocionCombo;
using WearDropWA.ServiciosDeDescuentoLiquidacion;
using WearDropWA.ServiciosDeDescuentoPorcentaje;

namespace WearDropWA
{
    public partial class RegistrarLiquidacion : System.Web.UI.Page
    {
        private DescuentoLiquidacionWSClient boDesc;
        private ServiciosDeDescuentoLiquidacion.descuentoLiquidacion datDesc;
        private ServiciosDeVigencia.vigencia vig; //* psue esto para q no haya ambiguedad pero puede ser cualquiera*//
        protected void Page_Load(object sender, EventArgs e)
        {
            datDesc = new ServiciosDeDescuentoLiquidacion.descuentoLiquidacion();
            vig = new ServiciosDeVigencia.vigencia();
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarLiquidacion.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            boDesc = new DescuentoLiquidacionWSClient();
            datDesc.nombre = txtNombre1.Text;
            datDesc.porcentajeLiquidacion = double.Parse(txtPorcentaje1.Text);
            datDesc.condicionStockMin = int.Parse(txtCondicion1.Text);
            int resultado =boDesc.insertarDescuento(datDesc);
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