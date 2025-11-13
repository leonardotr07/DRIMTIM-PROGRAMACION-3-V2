using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class RegistrarClientes : System.Web.UI.Page
    {
        private ClienteWSClient boCliente;
        private cliente cliente;
        private String estado;
        protected void Page_Load(object sender, EventArgs e)
        {
            String accion = Request.QueryString["accion"];
            if (accion == null)
            {
                cliente = new cliente();
                lblTitulo.Text = "Registrar Cliente";
                estado = "nuevo";
            }
            else if (accion == "modificar")
            {
                lblTitulo.Text = "Modificar Cliente";
                estado = "modificar";
                cliente = (cliente)Session["cliente"];
                //if (!IsPostBack)
                    //AsignarValores();
                //txtID.Enabled = false;
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {

        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {

        }
    }
}