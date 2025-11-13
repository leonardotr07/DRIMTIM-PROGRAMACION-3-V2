using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class VerEmpleado : System.Web.UI.Page
    {
        private EmpleadoWSClient boEmpleado;
        private empleado1 empleado;
        private String estado;
        protected void Page_Load(object sender, EventArgs e)
        {
            empleado = (empleado1)Session["empleado"];
            if (!IsPostBack)
                AsignarValores();
            txtID.Enabled = false;
            txtApellidoMaterno.Enabled = false;
            txtApellidoPaterno.Enabled = false;
            txtCargo.Enabled = false;
            txtDni.Enabled = false;
            txtID.Enabled = false;
            txtNombre.Enabled = false;
            txtSueldo.Enabled = false;
            txtTelefono.Enabled = false;
            rbFemenino.Disabled = true;
            rbMasculino.Disabled = true;
        }

        void AsignarValores()
        {
            txtApellidoMaterno.Text = empleado.segundoApellido;
            txtApellidoPaterno.Text = empleado.primerApellido;
            txtCargo.Text = "Auxiliar";
            txtDni.Text = empleado.dni.ToString();
            txtID.Text = empleado.idPersona.ToString();
            txtNombre.Text = empleado.nombre;
            txtSueldo.Text = empleado.sueldo.ToString();
            txtTelefono.Text = empleado.telefono.ToString();
            if (empleado.genero.Equals('M')) rbMasculino.Checked = true;
            else rbFemenino.Checked = true;
        }
        protected void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarEmpleados.aspx");
        }

        protected void btnVerVentas_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarEmpleadoXVentas.aspx");
        }
    }
}