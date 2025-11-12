using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class ModificarComprobantes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int idParaEditar = Convert.ToInt32(Request.QueryString["id"]);
                    CargarDatosDelComprobante(idParaEditar);
                }
                else
                {
                    Response.Redirect("~/GestionarComprobantes.aspx");
                }
            }
        }

        // Pega esto dentro de tu clase ModificarComprobantes
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // 1. Averigua qué panel está activo
            string tipoActivo = ddlTipoComprobante.SelectedValue;
            int id = Convert.ToInt32(txtID.Text);

            // 2. Llama al método de guardado correspondiente
            //    (Aquí irá tu lógica de negocio)
            switch (tipoActivo)
            {
                case "Boleta":
                    // GuardarBoleta(id, txtBoletaDNI.Text, ...);
                    break;
                case "Factura":
                    // GuardarFactura(id, txtFacturaRUC.Text, ...);
                    break;
                case "Nota de Crédito":
                    // GuardarNotaCredito(id, txtNCMotivo.Text, ...);
                    break;
                case "Nota de Débito":
                    // GuardarNotaDebito(id, txtNDMotivo.Text, ...);
                    break;
            }

            // 3. Redirige de vuelta a la lista
            Response.Redirect("~/GestionarComprobantes.aspx");
        }

        private void CargarDatosDelComprobante(int id)
        {
            // --- 1. OBTENER DATOS (EJEMPLO) ---
            // (Reemplaza esto con tu llamada real a la Base de Datos)
            // ComprobanteBO boComprobante = new ComprobanteBO();
            // Comprobante comp = boComprobante.ObtenerPorID(id);

            // --- DATOS DE PRUEBA (BORRAR LUEGO) ---
            var comp = new { ID = id, Tipo = "Boleta", Correlativo = "B001-456", MetodoPago = "Yape", DNI = "12345678", Fecha = DateTime.Now, Total = 4000.00 };
            // --- FIN DE DATOS DE PRUEBA ---

            // --- 2. LLENAR CAMPOS COMUNES ---
            txtID.Text = comp.ID.ToString();
            txtCorrelativo.Text = comp.Correlativo;

            // --- 3. SELECCIONAR EL TIPO EN EL DROPDOWN ---
            // Esto "selecciona" la opción "Boleta" en el dropdown
            ddlTipoComprobante.SelectedValue = comp.Tipo;

            // --- 4. CARGAR LOS DATOS EN EL PANEL CORRECTO ---
            // (Basado en el tipo de comprobante encontrado)
            if (comp.Tipo == "Boleta")
            {
                txtBoletaMetodoPago.Text = comp.MetodoPago;
                txtBoletaDNI.Text = comp.DNI;
                txtBoletaFecha.Text = comp.Fecha.ToString("yyyy-MM-dd");
                txtBoletaTotal.Text = comp.Total.ToString("F2");
            }
            // else if (comp.Tipo == "Factura")
            // {
            //    // (llenar campos de factura)
            // }
            // ... etc.

            // --- 5. MOSTRAR EL PANEL INICIAL ---
            MostrarPanel(comp.Tipo);
        }

        // --- ESTE MÉTODO SE LLAMA CUANDO CAMBIAS EL DROPDOWN ---
        protected void ddlTipoComprobante_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Llama a la función para mostrar el panel correspondiente
            string tipoSeleccionado = ddlTipoComprobante.SelectedValue;
            MostrarPanel(tipoSeleccionado);
        }
        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            // Simplemente redirige de vuelta a la lista
            Response.Redirect("~/GestionarComprobantes.aspx");
        }

        // --- ESTA FUNCIÓN OCULTA/MUESTRA LOS PANELES ---
        private void MostrarPanel(string tipo)
        {
            // 1. Oculta todos los paneles
            pnlBoleta.Visible = false;
            pnlFactura.Visible = false;
            pnlNotaCredito.Visible = false;
            pnlNotaDebito.Visible = false;

            // 2. Muestra solo el panel correcto
            switch (tipo)
            {
                case "Boleta":
                    pnlBoleta.Visible = true;
                    break;
                case "Factura":
                    pnlFactura.Visible = true;
                    break;
                case "Nota de Crédito":
                    pnlNotaCredito.Visible = true;
                    break;
                case "Nota de Débito":
                    pnlNotaDebito.Visible = true;
                    break;
            }
        }
    }
}