<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master"
    AutoEventWireup="true" CodeBehind="ListarPrendas.aspx.cs"
    Inherits="WearDropWA.ListarPrendas" %>

<asp:Content ID="ctTitle" ContentPlaceHolderID="TitleContent" runat="server">
    <asp:Literal ID="litTitulo" runat="server" />
</asp:Content>

<asp:Content ID="ctHead" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* (tus estilos tal cual) */
        .header-title { display:flex; align-items:stretch; height:60px; box-shadow:0 2px 4px rgba(0,0,0,.1); margin-top:14px; border-radius:10px; overflow:hidden }
        .title-section { background:#fff; padding:0 25px; display:flex; align-items:center; flex:0 0 280px }
        .title-section h2 { margin:0; font-size:20px; font-weight:600; color:#333; white-space:nowrap }
        .color-bar { height:100% }
        .bar-1 { flex:1.5 }
        .bar-2 { flex:1.5 }
        .top-accent { height:4px; margin-top:10px; border-radius:4px }
        .custom-grid { border-collapse:collapse; width:100% }
        .custom-grid th { color:#333; font-weight:500; padding:15px 20px; text-align:left; border:none; background:var(--c1) }
        .custom-grid td { padding:12px 20px; border-bottom:1px solid #E8E8E8 }
        .custom-grid tr:nth-child(even) { background:#F5F5F5 }
        .custom-grid tr:hover { background:#E8F4E5 }
        a, a:visited, a:hover, a:active, .btn-wd { text-decoration:none !important; color:inherit }
        .btn-wd { background:var(--btn); color:#fff; border:none; padding:8px 18px; border-radius:8px; cursor:pointer; display:inline-block; transition:.15s; box-shadow:0 1px 2px rgba(0,0,0,.08) }
        .btn-wd:hover { filter:brightness(.95) }
        .btn-wd:active { transform:translateY(1px) }
        .theme-polos { --tone-1:#C6D8C4; --tone-2:#9DBD9B; --tone-3:#7FA07E; }
        .theme-vestidos { --tone-1:#C7D6E2; --tone-2:#9FB6C8; --tone-3:#7C98AD; }
        .theme-gorros { --tone-1:#E0B6BC; --tone-2:#C99298; --tone-3:#A86E75; }
        .theme-pantalones { --tone-1:#D3CBEB; --tone-2:#B4A6D6; --tone-3:#8E83BE; }
        .theme-casacas { --tone-1:#C4DDD8; --tone-2:#9AC5BE; --tone-3:#77AAA2; }
        .theme-blusas { --tone-1:#F3EEB9; --tone-2:#EDE28A; --tone-3:#C7BC5F; }
        .theme-faldas { --tone-1:#DFC2CE; --tone-2:#C5A0B0; --tone-3:#A77A8D; }
        .theme-scope .bar-1 { background:var(--tone-1); }
        .theme-scope .bar-2 { background:var(--tone-2); }
        .theme-scope .custom-grid th { background:var(--tone-2) !important; color:#333; }
        .theme-scope .btn-wd { background:var(--tone-3); color:#fff; }
        .theme-scope .btn-wd:hover { filter:brightness(.95); }
        .theme-scope .top-accent { background:linear-gradient(90deg,var(--tone-1),var(--tone-2),var(--tone-3)); }
        .action-btns i { font-size:1.1em; }
        .btn-sm { padding:4px 8px !important; margin-right:4px; }
    </style>
</asp:Content>

<asp:Content ID="ctMain" ContentPlaceHolderID="MainContent" runat="server">
    <div id="themeWrap" runat="server" class="theme-polos">
        <div class="theme-scope">
            <div class="container">
                <div class="top-accent"></div>

                <div class="container row">
                    <div class="row align-items-center">
                        <div class="col-md-6 p-0">
                            <div class="header-title">
                                <div class="title-section">
                                    <h2><asp:Literal ID="litHeader" runat="server" /></h2>
                                </div>
                                <div class="color-bar bar-1"></div>
                                <div class="color-bar bar-2"></div>
                            </div>
                        </div>
                        <div class="col text-end p-3">
                            <asp:LinkButton ID="lkRegistrar" CssClass="btn-wd" runat="server" OnClick="lkRegistrar_Click" Text="Registrar" />
                            &nbsp;
                            <asp:LinkButton ID="lkFiltrar" CssClass="btn-wd" runat="server" OnClick="lkFiltrar_Click" Text="Filtrar" />
                        </div>
                    </div>
                </div>

                <div class="container row mt-3">
                    <asp:GridView ID="gvPrendas" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="True"
                        CssClass="table table-hover table-striped custom-grid" GridLines="None">
                        <Columns>
                            <asp:BoundField HeaderText="ID" DataField="IdPrenda" />
                            <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                            <asp:BoundField HeaderText="Color" DataField="Color" />
                            <asp:BoundField HeaderText="Material" DataField="Material" />
                            <asp:BoundField HeaderText="P/U" DataField="PrecioUnidad" DataFormatString="{0:C}" />

                            <asp:BoundField HeaderText="P/M" DataField="PrecioMayor" DataFormatString="{0:C}" />
                            <asp:BoundField HeaderText="P/D" DataField="PrecioDocena" DataFormatString="{0:C}" />

                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <div class="action-btns">
                                        <asp:LinkButton ID="btnVisualizar" runat="server"
                                            CssClass="btn btn-sm btn-outline-success"
                                            CommandArgument='<%# Eval("IdPrenda") %>'
                                            OnClick="btnVisualizar_Click" ToolTip="Visualizar">
                                            <i class="fa fa-eye"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnModificar" runat="server"
                                            CssClass="btn btn-sm btn-outline-primary"
                                            CommandArgument='<%# Eval("IdPrenda") %>'
                                            OnClick="btnModificar_Click" ToolTip="Editar">
                                            <i class="fa fa-pencil"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnEliminar" runat="server"
                                            CssClass="btn btn-sm btn-outline-danger"
                                            CommandArgument='<%# Eval("IdPrenda") %>'
                                            OnClick="lkEliminar_Click"
                                            CausesValidation="false"
                                            OnClientClick="return confirm('¿Seguro que deseas eliminar esta prenda?');">
                                            <i class="fa fa-trash"></i>
                                        </asp:LinkButton>

                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    </asp:Content>
