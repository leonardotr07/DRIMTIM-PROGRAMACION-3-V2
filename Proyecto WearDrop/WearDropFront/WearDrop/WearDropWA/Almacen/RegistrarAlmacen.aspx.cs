using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class RegistrarAlmacen : System.Web.UI.Page
    {
        private AlmacenWSClient boAlmacen;
        private almacen datAlmacen;
        protected void Page_Load(object sender, EventArgs e)
        {
            boAlmacen=new AlmacenWSClient();
            datAlmacen = new almacen();
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarAlmacenes.aspx");
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            datAlmacen.nombre=txtNombre.Text.Trim();
            datAlmacen.ubicacion=txtUbicacion.Text.Trim();
            datAlmacen.stock=int.Parse(txtStock.Text);
            datAlmacen.idTienda = 1; //Valor por defecto siempre.

            int resultado=boAlmacen.insertarAlmacen(datAlmacen);
            if (resultado > 0)
            {
                // Modificación exitosa
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Almacén registrado correctamente.'); window.location='ListarAlmacenes.aspx';", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('No se pudo registrar el almacén. Ocurrio un error.');", true);
            }
        }
        
    }
}