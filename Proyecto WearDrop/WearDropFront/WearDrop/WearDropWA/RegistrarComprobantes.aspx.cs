using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WearDropWA
{
    public partial class RegistrarComprobantes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // (Tu lógica de Page_Load si tienes)
            if (!IsPostBack)
            {
                // Asegura que el panel de Boleta sea el inicial
                MostrarPanel("boleta");
            }
        }

        // --- MÉTODOS PARA CAMBIAR PESTAÑAS ---
        // (Estos ya los tenías)

        protected void btnTabBoleta_Click(object sender, EventArgs e)
        {
            MostrarPanel("boleta");
        }

        protected void btnTabFactura_Click(object sender, EventArgs e)
        {
            MostrarPanel("factura");
        }

        protected void btnTabNotaCredito_Click(object sender, EventArgs e)
        {
            MostrarPanel("notacredito");
        }

        protected void btnTabNotaDebito_Click(object sender, EventArgs e)
        {
            MostrarPanel("notadebito");
        }

        // Este método centraliza la lógica, ¡muy bien!
        private void MostrarPanel(string panelActivo)
        {
            pnlBoleta.Visible = false;
            pnlFactura.Visible = false;
            pnlNotaCredito.Visible = false;
            pnlNotaDebito.Visible = false;

            btnTabBoleta.CssClass = "tab-link";
            btnTabFactura.CssClass = "tab-link";
            btnTabNotaCredito.CssClass = "tab-link";
            btnTabNotaDebito.CssClass = "tab-link";

            switch (panelActivo)
            {
                case "boleta": pnlBoleta.Visible = true; btnTabBoleta.CssClass = "tab-link active"; break;
                case "factura": pnlFactura.Visible = true; btnTabFactura.CssClass = "tab-link active"; break;
                case "notacredito": pnlNotaCredito.Visible = true; btnTabNotaCredito.CssClass = "tab-link active"; break;
                case "notadebito": pnlNotaDebito.Visible = true; btnTabNotaDebito.CssClass = "tab-link active"; break;
            }
        }

        // --- MÉTODOS PARA REGISTRAR (BOTONES EMITIR) ---

        protected void btnEmitirBoleta_Click(object sender, EventArgs e)
        {
            // 1. (Aquí va tu lógica para GUARDAR la boleta en la BD)
            // ej: Boleta boleta = new Boleta();
            //     boleta.DNI = txtDNI.Text;
            //     ...
            //     BoletaBO.Registrar(boleta);

            // 2. Si todo sale bien, llamas al JavaScript para mostrar el modal
            MostrarModalExito();
        }

        protected void btnEmitirFactura_Click(object sender, EventArgs e)
        {
            // 1. (Lógica para GUARDAR Factura)
            // ...

            // 2. Mostrar modal
            MostrarModalExito();
        }

        protected void btnEmitirNC_Click(object sender, EventArgs e)
        {
            // 1. (Lógica para GUARDAR Nota de Crédito)
            // ...

            // 2. Mostrar modal
            MostrarModalExito();
        }


        protected void btnEmitirND_Click(object sender, EventArgs e)
        {
            // 1. (Lógica para GUARDAR Nota de Débito)
            // ...

            // 2. Mostrar modal
            MostrarModalExito();
        }

        // --- FUNCIÓN PARA LLAMAR AL JAVASCRIPT ---

        private void MostrarModalExito()
        {
            // Esta línea le dice al ScriptManager (en el .Master o en esta página)
            // que ejecute la función JavaScript "showSuccessModal()"
            // cuando la página termine de cargarse.
            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessModal", "showSuccessModal();", true);
        }

        // (Aquí estaban los métodos duplicados, que ya he borrado)
    }
}