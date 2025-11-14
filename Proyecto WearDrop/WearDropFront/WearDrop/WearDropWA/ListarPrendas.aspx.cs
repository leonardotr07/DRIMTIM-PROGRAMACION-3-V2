using System;
using System.ComponentModel; // BindingList
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace WearDropWA
{
    public partial class ListarPrendas : System.Web.UI.Page
    {
        private BindingList<object> prendas;

        string Tipo => (Request["tipo"] ?? "Polos").Trim();
        string TipoLower => (Request["tipo"] ?? "Polos").Trim().ToLowerInvariant();

        protected void Page_Load(object sender, EventArgs e)
        {
            litTitulo.Text = "Gestionar " + Tipo;
            litHeader.Text = "Gestionar " + Tipo;
            themeWrap.Attributes["class"] = "theme-" + TipoLower;

            switch (TipoLower)
            {
                case "blusas":
                    {
                        var cli = new global::WearDropWA.BlusaWS.BlusaWSClient();
                        var data = cli.listarBlusas() ?? Array.Empty<global::WearDropWA.BlusaWS.blusa>();
                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                case "polos":
                    {
                        var cli = new global::WearDropWA.PoloWS.PoloWSClient();
                        var data = cli.listarPolos() ?? Array.Empty<global::WearDropWA.PoloWS.polo>();
                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                case "vestidos":
                    {
                        var cli = new global::WearDropWA.VestidoWS.VestidoWSClient();
                        var data = cli.listarVestidos() ?? Array.Empty<global::WearDropWA.VestidoWS.vestido>();
                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                case "pantalones":
                    {
                        var cli = new global::WearDropWA.PantalonWS.PantalonWSClient();
                        var data = cli.listarPantalones() ?? Array.Empty<global::WearDropWA.PantalonWS.pantalon>();
                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                case "casacas":
                    {
                        var cli = new global::WearDropWA.CasacaWS.CasacaWSClient();
                        var data = cli.listarCasacas() ?? Array.Empty<global::WearDropWA.CasacaWS.casaca>();
                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                case "gorros":
                    {
                        var cli = new global::WearDropWA.GorroWS.GorroWSClient();
                        var data = cli.listarGorros() ?? Array.Empty<global::WearDropWA.GorroWS.gorro>();
                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                case "faldas":
                    {
                        var cli = new global::WearDropWA.FaldaWS.FaldaWSClient();
                        var data = cli.listarFaldas() ?? Array.Empty<global::WearDropWA.FaldaWS.falda>();
                        prendas = new BindingList<object>(data.Cast<object>().ToList());
                        break;
                    }
                default:
                    prendas = new BindingList<object>();
                    break;
            }

            gvPrendas.DataSource = prendas;
            gvPrendas.DataBind();
        }

        protected void gvPrendas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            string id = "";
            try { id = DataBinder.Eval(e.Row.DataItem, "IdPrenda").ToString(); }
            catch { try { id = DataBinder.Eval(e.Row.DataItem, "idPrenda").ToString(); } catch { } }
            e.Row.Cells[0].Text = id;

            string nombre = "";
            try { nombre = DataBinder.Eval(e.Row.DataItem, "Nombre").ToString(); }
            catch { try { nombre = DataBinder.Eval(e.Row.DataItem, "nombre").ToString(); } catch { } }
            e.Row.Cells[1].Text = nombre;

            string color = "";
            try { color = DataBinder.Eval(e.Row.DataItem, "Color").ToString(); }
            catch { try { color = DataBinder.Eval(e.Row.DataItem, "color").ToString(); } catch { } }
            e.Row.Cells[2].Text = color;

            string material = "";
            try { material = DataBinder.Eval(e.Row.DataItem, "Material").ToString(); }
            catch { try { material = DataBinder.Eval(e.Row.DataItem, "material").ToString(); } catch { } }
            e.Row.Cells[3].Text = material;

            string pu = "0";
            try { pu = DataBinder.Eval(e.Row.DataItem, "PrecioUnidad").ToString(); }
            catch { try { pu = DataBinder.Eval(e.Row.DataItem, "precioUnidad").ToString(); } catch { } }
            e.Row.Cells[4].Text = pu;

            string pm = "0";
            try { pm = DataBinder.Eval(e.Row.DataItem, "PrecioMayor").ToString(); }
            catch { try { pm = DataBinder.Eval(e.Row.DataItem, "precioMayor").ToString(); } catch { } }
            e.Row.Cells[5].Text = pm;

            string pd = "0";
            try { pd = DataBinder.Eval(e.Row.DataItem, "PrecioDocena").ToString(); }
            catch { try { pd = DataBinder.Eval(e.Row.DataItem, "precioDocena").ToString(); } catch { } }
            e.Row.Cells[6].Text = pd;
        }

        protected void gvPrendas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvPrendas.PageIndex = e.NewPageIndex;
            gvPrendas.DataSource = prendas;
            gvPrendas.DataBind();
        }

        protected void lkRegistrar_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegistrarPrenda.aspx?tipo=" + Tipo);
        }

        protected void lkFiltrar_Click(object sender, EventArgs e) { }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            int id = Int32.Parse(((LinkButton)sender).CommandArgument);
            Response.Redirect($"RegistrarPrenda.aspx?tipo={Tipo}&id={id}&accion=modificar");
        }

        protected void lkEliminar_Click(object sender, EventArgs e)
        {
            int id = Int32.Parse(((LinkButton)sender).CommandArgument);
            string tipo = (Request["tipo"] ?? "Polos").Trim().ToLowerInvariant();

            try
            {
                switch (tipo)
                {
                    case "polos":
                    case "polo":
                        new global::WearDropWA.PoloWS.PoloWSClient().eliminarPolo(id);
                        break;
                    case "blusas":
                    case "blusa":
                        new global::WearDropWA.BlusaWS.BlusaWSClient().eliminarBlusa(id);
                        break;
                    case "vestidos":
                    case "vestido":
                        new global::WearDropWA.VestidoWS.VestidoWSClient().eliminarVestido(id);
                        break;
                    case "pantalones":
                    case "pantalon":
                        new global::WearDropWA.PantalonWS.PantalonWSClient().eliminarPantalon(id);
                        break;
                    case "casacas":
                    case "casaca":
                        new global::WearDropWA.CasacaWS.CasacaWSClient().eliminarCasaca(id);
                        break;
                    case "gorros":
                    case "gorro":
                        new global::WearDropWA.GorroWS.GorroWSClient().eliminarGorro(id);
                        break;
                    case "faldas":
                    case "falda":
                        new global::WearDropWA.FaldaWS.FaldaWSClient().eliminarFalda(id);
                        break;
                    default:
                        throw new InvalidOperationException("Tipo no reconocido.");
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(
                    this, GetType(), "errDel",
                    $"alert('Error al eliminar: {ex.Message.Replace("'", "\\'")}');",
                    true
                );
            }

            Response.Redirect($"ListarPrendas.aspx?tipo={(Request["tipo"] ?? "Polos")}");
        }

        protected void btnVisualizar_Click(object sender, EventArgs e)
        {
            int id = Int32.Parse(((LinkButton)sender).CommandArgument);
            Response.Redirect($"RegistrarPrenda.aspx?tipo={Tipo}&id={id}&accion=ver");
        }
    }
}