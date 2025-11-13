using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class RegistrarEmpleado : System.Web.UI.Page
    {
        private EmpleadoWSClient boEmpleado;
        private empleado1 empleado;
        private String estado;
        protected void Page_Load(object sender, EventArgs e)
        {
            String accion = Request.QueryString["accion"];
            if (accion == null)
            {
                empleado = new empleado1();
                lblTitulo.Text = "Registrar Empleado";
                estado = "nuevo";
            }
            else if(accion == "modificar")
            {
                lblTitulo.Text = "Modificar Empleado";
                estado = "modificar";
                empleado = (empleado1)Session["empleado"];
                if (!IsPostBack)
                    AsignarValores();
                txtID.Enabled = false;
            }

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
            if(empleado.genero.Equals('M')) rbMasculino.Checked = true;
            else rbFemenino.Checked = true;
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarEmpleados.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            boEmpleado = new EmpleadoWSClient();
            empleado.dni = Int32.Parse(txtDni.Text);
            empleado.segundoApellido = txtApellidoMaterno.Text;
            empleado.primerApellido = txtApellidoPaterno.Text;
            empleado.telefono = Int32.Parse(txtTelefono.Text);
            empleado.nombre = txtNombre.Text;

            cargo cargo = new cargo();
            cargo.idCargo = 1;
            empleado.cargoAsignado = cargo;

            if(!rbFemenino.Checked && !rbMasculino.Checked)
            {
                string script = "mostrarModalError();";
                ScriptManager.RegisterStartupScript(
                    this, GetType(), "modalError", script, true);
                return;
            }
            if (rbMasculino.Checked) empleado.genero = 'M';
            else if (rbFemenino.Checked) empleado.genero = 'F';
            
            try
            {
                empleado.sueldo = Double.Parse(txtSueldo.Text);
            }
            catch (Exception ex)
            {
                string script = "mostrarModalError();";
                ScriptManager.RegisterStartupScript(
                    this, GetType(), "modalError", script, true);
                return;
            }

            //Realizar CRUD
            try
            {
                if (estado == "nuevo")
                    boEmpleado.insertarEmpleado(empleado);
                else if (estado == "modificar")
                    boEmpleado.modificarEmpleado(empleado);
            }
            catch (Exception ex)
            {
                string script = "mostrarModalError();";
                ScriptManager.RegisterStartupScript(
                    this, GetType(), "modalError", script, true);
            }

             Response.Redirect("ListarEmpleados.aspx");
        }
    }
}