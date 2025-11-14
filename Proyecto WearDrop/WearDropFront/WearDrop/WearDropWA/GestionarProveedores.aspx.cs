using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ProveedorWS;

namespace WearDropWA
{
    public partial class GestionarProveedores : Page
    {
        // Mantén la lista en ViewState para no reconsultar en cada postback (opcional)
        private BindingList<proveedor> Proveedores
        {
            get => ViewState["Proveedores"] as BindingList<proveedor>;
            set => ViewState["Proveedores"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                CargarYBindear();
        }

        private void CargarYBindear()
        {
            using (var boProveedor = new ProveedorWSClient())
            {
                // Convierte a List<T> antes de crear la BindingList
                var arr = boProveedor.listarTodosLosProveedores();   // normalmente proveedor[]
                var lista = (arr ?? Array.Empty<proveedor>()).ToList();
                Proveedores = new BindingList<proveedor>(lista);
            }

            dgvProveedores.DataSource = Proveedores;
            dgvProveedores.DataBind();
        }

        protected void dgvProveedores_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvProveedores.PageIndex = e.NewPageIndex;
            // Reasigna el DataSource (o vuelve a consultar, como prefieras)
            if (Proveedores == null) CargarYBindear();
            else
            {
                dgvProveedores.DataSource = Proveedores;
                dgvProveedores.DataBind();
            }
        }

        protected void btnRegistrarProveedor_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/RegistrarProveedor.aspx");
        }

        protected void btnModificarProveedor_Click(object sender, EventArgs e)
        {
            int id = int.Parse(((LinkButton)sender).CommandArgument);

            // Si necesitas el objeto completo, búscalo en memoria;
            // si prefieres exactitud, llama al WS por ID (si existe ese método).
            var prov = (Proveedores ?? new BindingList<proveedor>()).FirstOrDefault(p => p.idProveedor == id);
            Session["proveedorSelect"] = prov;

            Response.Redirect("~/RegistrarProveedor.aspx?accion=modificar");
        }

        protected void btnVerProveedor_Click(object sender, EventArgs e)
        {
            int id = int.Parse(((LinkButton)sender).CommandArgument);
            var prov = (Proveedores ?? new BindingList<proveedor>()).FirstOrDefault(p => p.idProveedor == id);
            Session["proveedorSelect"] = prov;

            Response.Redirect("~/RegistrarProveedor.aspx?accion=ver");
        }

        protected void btnEliminarProveedor_Click(object sender, EventArgs e)
        {
            int id = int.Parse(((LinkButton)sender).CommandArgument);

            using (var boProveedor = new ProveedorWSClient())
            {
                boProveedor.eliminarProveedor(id);
            }

            // refresca dataset
            CargarYBindear();
        }
    }
}