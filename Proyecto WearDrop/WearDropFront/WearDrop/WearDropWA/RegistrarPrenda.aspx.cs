using System;
using System.Web.UI;
using System.Web.UI.WebControls;

// Aliases que apuntan al namespace generado real (uno solo)
using RefPolo   = global::WearDropWA.ServiciosBackEnd;
using RefBlusa  = global::WearDropWA.ServiciosBackEnd;
using RefVest   = global::WearDropWA.ServiciosBackEnd;
using RefFalda  = global::WearDropWA.ServiciosBackEnd;
using RefPant   = global::WearDropWA.ServiciosBackEnd;
using RefCasaca = global::WearDropWA.ServiciosBackEnd;
using RefGorro  = global::WearDropWA.ServiciosBackEnd;

namespace WearDropWA
{
    public enum Estado { Nuevo, Modificar, Ver }

    public partial class RegistrarPrenda : System.Web.UI.Page
    {
        private Estado estado;
        private string Tipo => (Request["tipo"] ?? "Polos").Trim();
        private string IdQS => (Request["id"] ?? "").Trim();
        private int Id => int.TryParse(IdQS, out var n) ? n : 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            string accion = (Request.QueryString["accion"] ?? "").Trim().ToLower();

            // --- REGLA DE ESTADO ---
            if (accion == "ver") estado = Estado.Ver;
            else if (accion == "modificar") estado = Estado.Modificar;
            else estado = Estado.Nuevo;

            if (IsPostBack) return;

            ConfigurarCabecera();
            MostrarPanelPorTipo();

            CargarCombosGenerales();
            CargarCombosEspecificosPorTipo();

            if (estado == Estado.Modificar || estado == Estado.Ver)
            {
                AsignarValores();
                txtId.Enabled = false;
            }
            if (estado == Estado.Ver) BloquearEdicion();
        }

        // ========= UI helpers =========
        private void SetVisible(Control c, bool visible) { if (c != null) c.Visible = visible; }

        private void SetSelected(DropDownList ddl, string value)
        {
            if (ddl == null) return;
            var v = (value ?? "").Trim();
            var item = ddl.Items.FindByValue(v);
            if (item != null) ddl.SelectedValue = v;
        }

        private void ConfigurarCabecera()
        {
            string singular = ObtenerNombreSingular();
            string titulo = estado == Estado.Nuevo ? "Registrar" :
                            estado == Estado.Modificar ? "Modificar" : "Ver";

            litTitulo.Text = $"{titulo} {singular}";
            litHeader.Text = $"{titulo} {singular}";
            themeWrap.Attributes["class"] = "container theme-" + Tipo.ToLower();

            btnGuardar.Text = estado == Estado.Nuevo ? "Registrar" :
                              estado == Estado.Modificar ? "Guardar" : "Aceptar";

            SetVisible(divId, estado != Estado.Nuevo);
            if (estado != Estado.Nuevo && txtId != null) txtId.Text = IdQS;

            OcultarAsteriscos(estado != Estado.Nuevo);
        }

        private void OcultarAsteriscos(bool ocultar)
        {
            SetVisible(spanReq, !ocultar);
            SetVisible(spanReqMaterial, !ocultar);
            SetVisible(spanReqColor, !ocultar);
            SetVisible(spanReqStock, !ocultar);
            SetVisible(spanReqPU, !ocultar);
            SetVisible(spanReqPM, !ocultar);
            SetVisible(spanReqPD, !ocultar);
            SetVisible(spanReqManga, !ocultar);
            SetVisible(spanReqCuello, !ocultar);
            SetVisible(spanReqTipoBlusa, !ocultar);
            SetVisible(spanReqMangaB, !ocultar);
            SetVisible(spanReqTipoVestido, !ocultar);
            SetVisible(spanReqLargoVestido, !ocultar);
            SetVisible(spanReqTipoFalda, !ocultar);
            SetVisible(spanReqLargoFalda, !ocultar);
            SetVisible(spanReqVolantes, !ocultar);
            SetVisible(spanReqTipoPantalon, !ocultar);
            SetVisible(spanReqLargoPierna, !ocultar);
            SetVisible(spanReqTipoCasaca, !ocultar);
            SetVisible(spanReqCapucha, !ocultar);
            SetVisible(spanReqTipoGorra, !ocultar);
            SetVisible(spanReqTallaAjustable, !ocultar);
            SetVisible(spanReqImpermeable, !ocultar);
            SetVisible(spanReqMangaV, !ocultar);  // <--- nuevo
            SetVisible(spanReqCintura, !ocultar);

        }

        private void MostrarPanelPorTipo()
        {
            pnlPOLO.Visible = pnlBLUSA.Visible = pnlVESTIDO.Visible =
            pnlFALDA.Visible = pnlPANTALON.Visible = pnlCASACA.Visible =
            pnlGORRO.Visible = false;

            switch (Tipo.ToLower())
            {
                case "polo":
                case "polos": pnlPOLO.Visible = true; break;
                case "blusa":
                case "blusas": pnlBLUSA.Visible = true; break;
                case "vestido":
                case "vestidos": pnlVESTIDO.Visible = true; break;
                case "falda":
                case "faldas": pnlFALDA.Visible = true; break;
                case "pantalon":
                case "pantalones": pnlPANTALON.Visible = true; break;
                case "casaca":
                case "casacas": pnlCASACA.Visible = true; break;
                case "gorro":
                case "gorros": pnlGORRO.Visible = true; break;
            }
        }

        private void BloquearEdicion()
        {
            txtNombre.Enabled = false;
            ddlMaterial.Enabled = false;
            txtColor.Enabled = false;
            txtStock.Enabled = false;
            txtPU.Enabled = false;
            txtPM.Enabled = false;
            txtPD.Enabled = false;

            ddlTipoManga.Enabled = false;
            ddlTipoCuello.Enabled = false;
            txtEstampado.Enabled = false;

            ddlTipoBlusa.Enabled = false;
            ddlTipoMangaB.Enabled = false;

            ddlTipoVestido.Enabled = false;
            txtLargoVestido.Enabled = false;
            ddlTipoMangaV.Enabled = false;

            ddlTipoFalda.Enabled = false;
            txtLargoFalda.Enabled = false;
            ddlConVolantes.Enabled = false;

            ddlTipoPantalon.Enabled = false;
            txtLargoPierna.Enabled = false;
            txtCintura.Enabled = false;
            ddlTipoCasaca.Enabled = false;
            ddlConCapucha.Enabled = false;

            ddlTipoGorra.Enabled = false;
            ddlTallaAjustable.Enabled = false;
            ddlImpermeable.Enabled = false;

            btnGuardar.Visible = false;
        }

        // ========= COMBOS =========
        private void CargarCombosGenerales()
        {
            ddlMaterial.Items.Clear();
            ddlMaterial.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (RefPolo.material it in Enum.GetValues(typeof(RefPolo.material)))
            {
                string name = Enum.GetName(typeof(RefPolo.material), it);
                ddlMaterial.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }
        }

        private void CargarCombosEspecificosPorTipo()
        {
            // Polo
            ddlTipoManga.Items.Clear();
            ddlTipoManga.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (RefPolo.tipoManga it in Enum.GetValues(typeof(RefPolo.tipoManga)))
            {
                string name = Enum.GetName(typeof(RefPolo.tipoManga), it);
                ddlTipoManga.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            ddlTipoCuello.Items.Clear();
            ddlTipoCuello.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (RefPolo.tipoCuello it in Enum.GetValues(typeof(RefPolo.tipoCuello)))
            {
                string name = Enum.GetName(typeof(RefPolo.tipoCuello), it);
                ddlTipoCuello.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            // Blusa
            ddlTipoBlusa.Items.Clear();
            ddlTipoBlusa.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (RefBlusa.tipoBlusa it in Enum.GetValues(typeof(RefBlusa.tipoBlusa)))
            {
                string name = Enum.GetName(typeof(RefBlusa.tipoBlusa), it);
                ddlTipoBlusa.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            ddlTipoMangaB.Items.Clear();
            ddlTipoMangaB.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (RefBlusa.tipoManga it in Enum.GetValues(typeof(RefBlusa.tipoManga)))
            {
                string name = Enum.GetName(typeof(RefBlusa.tipoManga), it);
                ddlTipoMangaB.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            // Vestido
            ddlTipoVestido.Items.Clear();
            ddlTipoVestido.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (RefVest.tipoVestido it in Enum.GetValues(typeof(RefVest.tipoVestido)))
            {
                string name = Enum.GetName(typeof(RefVest.tipoVestido), it);
                ddlTipoVestido.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            ddlTipoMangaV.Items.Clear();
            ddlTipoMangaV.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (RefVest.tipoManga it in Enum.GetValues(typeof(RefVest.tipoManga)))
            {
                string name = Enum.GetName(typeof(RefVest.tipoManga), it);
                ddlTipoMangaV.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            // Falda
            ddlTipoFalda.Items.Clear();
            ddlTipoFalda.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (RefFalda.tipoFalda it in Enum.GetValues(typeof(RefFalda.tipoFalda)))
            {
                string name = Enum.GetName(typeof(RefFalda.tipoFalda), it);
                ddlTipoFalda.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            ddlConVolantes.Items.Clear();
            ddlConVolantes.Items.Add(new ListItem("-- Seleccione --", ""));
            ddlConVolantes.Items.Add(new ListItem("No", "0"));
            ddlConVolantes.Items.Add(new ListItem("Sí", "1"));

            // Pantalón
            ddlTipoPantalon.Items.Clear();
            ddlTipoPantalon.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (RefPant.tipoPantalon it in Enum.GetValues(typeof(RefPant.tipoPantalon)))
            {
                string name = Enum.GetName(typeof(RefPant.tipoPantalon), it);
                ddlTipoPantalon.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            // Casaca
            ddlTipoCasaca.Items.Clear();
            ddlTipoCasaca.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (RefCasaca.tipoCasaca it in Enum.GetValues(typeof(RefCasaca.tipoCasaca)))
            {
                string name = Enum.GetName(typeof(RefCasaca.tipoCasaca), it);
                ddlTipoCasaca.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            ddlConCapucha.Items.Clear();
            ddlConCapucha.Items.Add(new ListItem("-- Seleccione --", ""));
            ddlConCapucha.Items.Add(new ListItem("No", "0"));
            ddlConCapucha.Items.Add(new ListItem("Sí", "1"));

            // Gorro
            ddlTipoGorra.Items.Clear();
            ddlTipoGorra.Items.Add(new ListItem("-- Seleccione --", ""));
            foreach (RefGorro.tipoGorra it in Enum.GetValues(typeof(RefGorro.tipoGorra)))
            {
                string name = Enum.GetName(typeof(RefGorro.tipoGorra), it);
                ddlTipoGorra.Items.Add(new ListItem(name.Replace('_', ' '), name));
            }

            ddlTallaAjustable.Items.Clear();
            ddlTallaAjustable.Items.Add(new ListItem("-- Seleccione --", ""));
            ddlTallaAjustable.Items.Add(new ListItem("No", "0"));
            ddlTallaAjustable.Items.Add(new ListItem("Sí", "1"));

            ddlImpermeable.Items.Clear();
            ddlImpermeable.Items.Add(new ListItem("-- Seleccione --", ""));
            ddlImpermeable.Items.Add(new ListItem("No", "0"));
            ddlImpermeable.Items.Add(new ListItem("Sí", "1"));
        }

        // ========= CARGA PARA MODIFICAR/VER =========
        private void AsignarValores()
        {
            if (Id <= 0) { MostrarError("Id inválido."); return; }

            switch (Tipo.ToLower())
            {
                case "polo":
                case "polos":
                    {
                        var ws = new RefPolo.PoloWSClient();
                        var p = ws.obtenerPoloPorId(Id);
                        if (p == null) throw new Exception("No se encontró el Polo.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoManga, p.tipoManga.ToString());
                        SetSelected(ddlTipoCuello, p.tipoCuello.ToString());
                        txtEstampado.Text = p.estampado;
                        break;
                    }
                case "blusa":
                case "blusas":
                    {
                        var ws = new RefBlusa.BlusaWSClient();
                        var p = ws.obtenerBlusaPorId(Id);
                        if (p == null) throw new Exception("No se encontró la Blusa.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoBlusa, p.tipoBlusa.ToString());
                        SetSelected(ddlTipoMangaB, p.tipoManga.ToString());
                        break;
                    }
                case "vestido":
                case "vestidos":
                    {
                        var ws = new RefVest.VestidoWSClient();
                        var p = ws.obtenerVestidoPorId(Id);
                        if (p == null) throw new Exception("No se encontró el Vestido.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlTipoMangaV, p.tipoManga.ToString());
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoVestido, p.tipoVestido.ToString());
                        txtLargoVestido.Text = p.largo.ToString("0.##");
                        break;
                    }
                case "falda":
                case "faldas":
                    {
                        var ws = new RefFalda.FaldaWSClient();
                        var p = ws.obtenerFaldaPorId(Id);
                        if (p == null) throw new Exception("No se encontró la Falda.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoFalda, p.tipoFalda.ToString());
                        txtLargoFalda.Text = p.largo.ToString("0.##");
                        SetSelected(ddlConVolantes, BoolTo10(p.conVolantes));
                        break;
                    }
                case "pantalon":
                case "pantalones":
                    {
                        var ws = new RefPant.PantalonWSClient();
                        var p = ws.obtenerPantalonPorId(Id);
                        if (p == null) throw new Exception("No se encontró el Pantalón.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoPantalon, p.tipoPantalon.ToString());
                        txtLargoPierna.Text = p.largoPierna.ToString("0.##");
                        txtCintura.Text = p.cintura.ToString("0.##");
                        break;
                    }
                case "casaca":
                case "casacas":
                    {
                        var ws = new RefCasaca.CasacaWSClient();
                        var p = ws.obtenerCasacaPorId(Id);
                        if (p == null) throw new Exception("No se encontró la Casaca.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoCasaca, p.tipoCasaca.ToString());
                        SetSelected(ddlConCapucha, BoolTo10(p.conCapucha));
                        break;
                    }
                case "gorro":
                case "gorros":
                    {
                        var ws = new RefGorro.GorroWSClient();
                        var p = ws.obtenerGorroPorId(Id);
                        if (p == null) throw new Exception("No se encontró el Gorro.");
                        MapGeneralFromEntity(p.nombre, p.color, p.alertaMinStock, p.precioUnidad, p.precioMayor, p.precioDocena);
                        SetSelected(ddlMaterial, p.material.ToString());
                        SetSelected(ddlTipoGorra, p.tipoGorra.ToString());
                        SetSelected(ddlTallaAjustable, BoolTo10(p.tallaAjustable));
                        SetSelected(ddlImpermeable, BoolTo10(p.impermeable));
                        break;
                    }
            }
        }

        private void MapGeneralFromEntity(string nombre, string color, int alertaMinStock,
                                          double pu, double pm, double pd)
        {
            txtNombre.Text = nombre;
            txtColor.Text = color;
            txtStock.Text = alertaMinStock.ToString();
            txtPU.Text = pu.ToString("0.##");
            txtPM.Text = pm.ToString("0.##");
            txtPD.Text = pd.ToString("0.##");
        }

        // ========= GUARDAR =========
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                switch (Tipo.ToLower())
                {
                    case "polo":
                    case "polos": GuardarPolo(); break;
                    case "blusa":
                    case "blusas": GuardarBlusa(); break;
                    case "vestido":
                    case "vestidos": GuardarVestido(); break;
                    case "falda":
                    case "faldas": GuardarFalda(); break;
                    case "pantalon":
                    case "pantalones": GuardarPantalon(); break;
                    case "casaca":
                    case "casacas": GuardarCasaca(); break;
                    case "gorro":
                    case "gorros": GuardarGorro(); break;
                }
            }
            catch (Exception ex)
            {
                MostrarError(ex.Message);
                return;
            }

            Response.Redirect($"ListarPrendas.aspx?tipo={Tipo}");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect($"ListarPrendas.aspx?tipo={Tipo}");
        }

        // ========= GUARDAR POR TIPO =========
        private void GuardarPolo()
        {
            var ws = new RefPolo.PoloWSClient();
            var p = new RefPolo.polo
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (RefPolo.material)Enum.Parse(typeof(RefPolo.material), ddlMaterial.SelectedValue, true),
                materialSpecified = true,
                tipoManga = (RefPolo.tipoManga)Enum.Parse(typeof(RefPolo.tipoManga), ddlTipoManga.SelectedValue, true),
                tipoMangaSpecified = true,
                tipoCuello = (RefPolo.tipoCuello)Enum.Parse(typeof(RefPolo.tipoCuello), ddlTipoCuello.SelectedValue, true),
                tipoCuelloSpecified = true,
                estampado = txtEstampado.Text
            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarPolo(p); }
            else ws.insertarPolo(p);
        }

        private void GuardarBlusa()
        {
            var ws = new RefBlusa.BlusaWSClient();
            var p = new RefBlusa.blusa
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (RefBlusa.material)Enum.Parse(typeof(RefBlusa.material), ddlMaterial.SelectedValue, true),
                materialSpecified = true,
                tipoBlusa = (RefBlusa.tipoBlusa)Enum.Parse(typeof(RefBlusa.tipoBlusa), ddlTipoBlusa.SelectedValue, true),
                tipoBlusaSpecified = true,
                tipoManga = (RefBlusa.tipoManga)Enum.Parse(typeof(RefBlusa.tipoManga), ddlTipoMangaB.SelectedValue, true),
                tipoMangaSpecified = true
            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarBlusa(p); }
            else ws.insertarBlusa(p);
        }

        private void GuardarVestido()
        {
            var ws = new RefVest.VestidoWSClient();
            var p = new RefVest.vestido
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (RefVest.material)Enum.Parse(typeof(RefVest.material), ddlMaterial.SelectedValue, true),
                materialSpecified = true,
                tipoVestido = (RefVest.tipoVestido)Enum.Parse(typeof(RefVest.tipoVestido), ddlTipoVestido.SelectedValue, true),
                tipoVestidoSpecified = true,
                tipoManga = (RefVest.tipoManga)Enum.Parse(typeof(RefVest.tipoManga), ddlTipoMangaV.SelectedValue, true),
                tipoMangaSpecified = true,
                // CORREGIDO: largo es double -> ParseDouble
                largo = ParseInt(txtLargoVestido.Text, "Largo (cm)")


            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarVestido(p); }
            else ws.insertarVestido(p);
        }

        private void GuardarFalda()
        {
            var ws = new RefFalda.FaldaWSClient();
            var p = new RefFalda.falda
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (RefFalda.material)Enum.Parse(typeof(RefFalda.material), ddlMaterial.SelectedValue, true),
                materialSpecified = true,
                tipoFalda = (RefFalda.tipoFalda)Enum.Parse(typeof(RefFalda.tipoFalda), ddlTipoFalda.SelectedValue, true),
                tipoFaldaSpecified = true,
                largo = ParseDouble(txtLargoFalda.Text, "Largo (cm)"),
                conVolantes = IsTrue10(ddlConVolantes.SelectedValue)
            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarFalda(p); }
            else ws.insertarFalda(p);
        }

        private void GuardarPantalon()
        {
            var ws = new RefPant.PantalonWSClient();
            var p = new RefPant.pantalon
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (RefPant.material)Enum.Parse(typeof(RefPant.material), ddlMaterial.SelectedValue, true),
                materialSpecified = true,
                tipoPantalon = (RefPant.tipoPantalon)Enum.Parse(typeof(RefPant.tipoPantalon), ddlTipoPantalon.SelectedValue, true),
                tipoPantalonSpecified = true,
                largoPierna = ParseDouble(txtLargoPierna.Text, "Largo pierna (cm)"),
                cintura = ParseDouble(txtCintura.Text, "Cintura (cm)")
            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarPantalon(p); }
            else ws.insertarPantalon(p);
        }

        private void GuardarCasaca()
        {
            var ws = new RefCasaca.CasacaWSClient();
            var p = new RefCasaca.casaca
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (RefCasaca.material)Enum.Parse(typeof(RefCasaca.material), ddlMaterial.SelectedValue, true),
                materialSpecified = true,
                tipoCasaca = (RefCasaca.tipoCasaca)Enum.Parse(typeof(RefCasaca.tipoCasaca), ddlTipoCasaca.SelectedValue, true),
                tipoCasacaSpecified = true,
                conCapucha = IsTrue10(ddlConCapucha.SelectedValue)
            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarCasaca(p); }
            else ws.insertarCasaca(p);
        }

        private void GuardarGorro()
        {
            var ws = new RefGorro.GorroWSClient();
            var p = new RefGorro.gorro
            {
                nombre = txtNombre.Text,
                color = txtColor.Text,
                alertaMinStock = ParseInt(txtStock.Text, "Stock"),
                precioUnidad = ParseDouble(txtPU.Text, "Precio Unidad"),
                precioMayor = ParseDouble(txtPM.Text, "Precio Mayor"),
                precioDocena = ParseDouble(txtPD.Text, "Precio Docena"),
                material = (RefGorro.material)Enum.Parse(typeof(RefGorro.material), ddlMaterial.SelectedValue, true),
                materialSpecified = true,
                tipoGorra = (RefGorro.tipoGorra)Enum.Parse(typeof(RefGorro.tipoGorra), ddlTipoGorra.SelectedValue, true),
                tipoGorraSpecified = true,
                tallaAjustable = IsTrue10(ddlTallaAjustable.SelectedValue),
                impermeable = IsTrue10(ddlImpermeable.SelectedValue)
            };

            if (estado == Estado.Modificar) { p.idPrenda = Id; ws.modificarGorro(p); }
            else ws.insertarGorro(p);
        }

        // ========= HELPERS =========
        private static string BoolTo10(bool b) => b ? "1" : "0";
        private static bool IsTrue10(string v) => (v ?? "").Trim() == "1";

        private static int ParseInt(string txt, string campo)
        {
            if (!int.TryParse((txt ?? "").Trim(), out var n))
                throw new ArgumentException($"Valor inválido para {campo}.");
            return n;
        }

        private static double ParseDouble(string txt, string campo)
        {
            if (!double.TryParse((txt ?? "").Trim(), out var d))
                throw new ArgumentException($"Valor inválido para {campo}.");
            return d;
        }

        private string ObtenerNombreSingular()
        {
            switch (Tipo.ToLower())
            {
                case "polo":
                case "polos": return "Polo";
                case "blusa":
                case "blusas": return "Blusa";
                case "vestido":
                case "vestidos": return "Vestido";
                case "falda":
                case "faldas": return "Falda";
                case "pantalon":
                case "pantalones": return "Pantalón";
                case "casaca":
                case "casacas": return "Casaca";
                case "gorro":
                case "gorros": return "Gorro";
                default: return Tipo;
            }
        }

        private void MostrarError(string mensaje)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "error", $"alert('{mensaje}');", true);
        }
    }
}