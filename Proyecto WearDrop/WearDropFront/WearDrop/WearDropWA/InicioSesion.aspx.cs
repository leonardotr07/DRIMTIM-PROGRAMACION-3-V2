using System;
using System.Web.UI;

namespace SoftProgWA
{
    public partial class InicioSesion : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Si necesitas lógica al cargar la página
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Demo de manejo (reemplaza con tu autenticación real)
            if (string.IsNullOrWhiteSpace(txtUsername.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblMensaje.Text = "Completa usuario y contraseña.";
                return;
            }

            // TODO: validar credenciales
            lblMensaje.Text = ""; // limpiar mensaje
            // Response.Redirect("~/Default.aspx");
        }
    }
}
