using System;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public partial class ListarAlmacenes : System.Web.UI.Page
    {
        private AlmacenWSClient boAlmacen;
        private BindingList<almacen> listAlmacenes;

        protected void Page_Load(object sender, EventArgs e)
        {
            boAlmacen = new AlmacenWSClient();

            if (!IsPostBack)
            {
                // Limpiar la variable de sesión de la última página visitada al cargar ListarAlmacenes
                Session["UltimaPagina"] = null;
            }

            CargarAlmacenes();
        }

        private void CargarAlmacenes()
        {
            try
            {
                almacen[] almacenes = boAlmacen.listarAlmacenesActivos();
                listAlmacenes = new BindingList<almacen>(almacenes);
                gvAlmacenes.DataSource = listAlmacenes;
                gvAlmacenes.DataBind();
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al cargar almacenes: {ex.Message}');", true);
            }
        }

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarAlmacen.aspx");
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int idAlmacen = Int32.Parse(btn.CommandArgument);

                // Extraer de la lista de Almacenes el almacén seleccionado por el usuario
                almacen datAlmacen = listAlmacenes.SingleOrDefault(x => x.id == idAlmacen);

                if (datAlmacen != null)
                {
                    // Guardar el almacén seleccionado en la sesión
                    Session["almacenSeleccionado"] = datAlmacen;

                    // Redirigir a la página de modificación con el ID como parámetro
                    Response.Redirect($"ModificarAlmacen.aspx?id={idAlmacen}");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se encontró el almacén seleccionado.');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al modificar: {ex.Message}');", true);
            }
        }

        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton btn = (LinkButton)sender;
                int idAlmacen = Int32.Parse(btn.CommandArgument);

                // Extraer de la lista de Almacenes el almacén seleccionado por el usuario
                almacen datAlmacen = listAlmacenes.SingleOrDefault(x => x.id == idAlmacen);

                if (datAlmacen != null)
                {
                    // Guardar el almacén seleccionado en la sesión
                    Session["almacenSeleccionado"] = datAlmacen;

                    // Inicializar la variable de sesión de la última página en "Lotes" por defecto
                    Session["UltimaPagina"] = "Lotes";

                    // Redirigir a la página de visualización con el ID como parámetro
                    Response.Redirect($"MostrarAlmacen.aspx?id={idAlmacen}");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se encontró el almacén seleccionado.');", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al visualizar: {ex.Message}');", true);
            }
        }

        protected void btnConfirmarEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                int idAlmacen;

                if (string.IsNullOrEmpty(hfIdAlmacenEliminar.Value))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se ha seleccionado un almacén para eliminar.'); cerrarModal();", true);
                    return;
                }

                idAlmacen = int.Parse(hfIdAlmacenEliminar.Value);

                int resultado = boAlmacen.eliminarAlmacen(idAlmacen);

                if (resultado > 0)
                {
                    // Eliminación exitosa
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('Almacén eliminado correctamente.'); cerrarModal(); window.location='ListarAlmacenes.aspx';", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                        "alert('No se pudo eliminar el almacén. Ocurrió un error.'); cerrarModal();", true);
                }
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    $"alert('Error al eliminar: {ex.Message}'); cerrarModal();", true);
            }
        }
    }
}