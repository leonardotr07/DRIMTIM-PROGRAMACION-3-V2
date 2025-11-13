using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class ListarClientes : System.Web.UI.Page
    {
        private ClienteWSClient boCliente;
        private BindingList<cliente> clientes;
        protected void Page_Load(object sender, EventArgs e)
        {
            boCliente = new ClienteWSClient();
            clientes = new BindingList<cliente>(boCliente.listarClientes());
            gvClientes.DataSource = clientes;
            gvClientes.DataBind();
        }

        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            Response.Redirect("VerCliente.aspx");
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {

        }

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarClientes.aspx");
        }

        protected void lkFiltrar_Click(object sender, EventArgs e)
        {

        }

        protected void gvClientes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvClientes.PageIndex = e.NewPageIndex;
            gvClientes.DataBind();
        }
    }
}