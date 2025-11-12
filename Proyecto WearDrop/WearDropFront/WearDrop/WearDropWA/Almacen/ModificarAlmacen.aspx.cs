using System;
using System.Web.UI;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class ModificarAlmacen : System.Web.UI.Page
    {
        private AlmacenWSClient boAlmacen;
        private almacen datAlmacen;

        protected void Page_Load(object sender, EventArgs e)
        {
            boAlmacen=new AlmacenWSClient();
            if (!IsPostBack)
            {
                // Obtener el almacén de la sesión
                datAlmacen = (almacen)Session["almacenSeleccionado"];

                if (datAlmacen != null)
                {
                    // Cargar los datos en los controles
                    txtNombre.Text = datAlmacen.nombre;
                    txtUbicacion.Text = datAlmacen.ubicacion;
                    txtStock.Text = datAlmacen.stock.ToString();
                }
                else
                {
                    // Si no hay almacén en sesión, redirigir a listar
                    Response.Redirect("ListarAlmacenes.aspx");
                }
            }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtener el almacén de la sesión
                datAlmacen = (almacen)Session["almacenSeleccionado"];

                if (datAlmacen != null)
                {
                    // Actualizar los datos del almacén con los valores del formulario
                    datAlmacen.nombre = txtNombre.Text.Trim();
                    datAlmacen.ubicacion = txtUbicacion.Text.Trim();
                    datAlmacen.stock = int.Parse(txtStock.Text);


                    // Llamar al método modificar del servicio
                    int resultado = boAlmacen.modificarAlmacen(datAlmacen);

                    if (resultado > 0)
                    {
                        // Modificación exitosa
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Almacén modificado correctamente.'); window.location='ListarAlmacenes.aspx';", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('No se pudo modificar el almacén.');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error al modificar: {ex.Message}');", true);
            }
            finally
            {
                if (boAlmacen != null)
                {
                    boAlmacen.Close();
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListarAlmacenes.aspx");
        }
    }
}