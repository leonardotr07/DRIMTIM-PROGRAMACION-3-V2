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
    public partial class ListarEmpleados : System.Web.UI.Page
    {
        private EmpleadoWSClient boEmpleado;
        private BindingList<empleado1> empleados;


        protected void Page_Load(object sender, EventArgs e)
        {
            boEmpleado = new EmpleadoWSClient();
            empleados = new BindingList<empleado1>(boEmpleado.listarEmpleados());
            gvEmpleados.DataSource = empleados;
            gvEmpleados.DataBind();

        }

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarEmpleado.aspx");
        }

        protected void lkFiltrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarEmpleados.aspx");
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            int idEmpleado = Int32.Parse(((LinkButton)sender).CommandArgument);
            empleado1 empSelect = empleados.Single(x=>x.idPersona == idEmpleado);
            Session["empleado"] = empSelect;
            Response.Redirect("RegistrarEmpleado.aspx?accion=modificar");

        }

        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            int idEmpleado = Int32.Parse(((LinkButton)sender).CommandArgument);
            empleado1 empSelect = empleados.Single(x => x.idPersona == idEmpleado);
            Session["empleado"] = empSelect;
            Response.Redirect("VerEmpleado.aspx");
        }

        protected void gvEmpleados_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvEmpleados.PageIndex = e.NewPageIndex;
            gvEmpleados.DataBind();
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            int idEmpleado = Int32.Parse(((LinkButton)sender).CommandArgument);
            boEmpleado.eliminarEmpleado(idEmpleado);
            Response.Redirect("ListarEmpleados.aspx");
        }
    }
}