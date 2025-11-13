<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="ListarClientes.aspx.cs" Inherits="WearDropWA.ListarClientes" %>
<asp:Content ID="ctTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Gestionar Clientes
</asp:Content>

<asp:Content ID="ctHead" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* ===== Header con dos barras (rojas) ===== */
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, .1);
            margin-top: 14px;
            border-radius: 10px;
            overflow: hidden;
        }

        .title-section {
            background: #fff;
            padding: 0 25px;
            display: flex;
            align-items: center;
            flex: 0 0 280px;
        }

        .title-section h2 {
            margin: 0;
            font-size: 20px;
            font-weight: 600;
            color: #333;
            white-space: nowrap;
        }

        .color-bar {
            height: 100%;
        }

        /* 🎨 Paleta ROJA */
        .bar-1 {
            background: #E4CFCF;
            flex: 1.5;
        }

        .bar-2 {
            background: #B98F8F;
            flex: 1.5;
        }

        /* ===== Grilla ===== */
        .custom-grid {
            border-collapse: collapse;
            width: 100%;
        }

        .custom-grid th {
            background: #B98F8F !important; /* cabecera roja */
            color: #333;
            font-weight: 500;
            padding: 15px 20px;
            text-align: left;
            border: none;
        }

        .custom-grid td {
            padding: 12px 20px;
            border-bottom: 1px solid #E8E8E8;
        }

        .custom-grid tr:nth-child(even) {
            background: #F5F5F5;
        }

        .custom-grid tr:hover {
            background: #F8ECEC; /* hover rojo claro */
        }

        .action-btns i {
            font-size: 1.05em;
        }

        .btn-sm {
            padding: 4px 8px !important;
            margin-right: 6px;
        }

        /* ===== Botones superiores (Registrar/Filtrar) ===== */
        .btn-wd {
            background: #A67B7B; /* botón rojo sólido */
            color: #fff;
            border: none;
            padding: 8px 18px;
            border-radius: 8px;
            cursor: pointer;
            display: inline-block;
            transition: .15s;
            box-shadow: 0 1px 2px rgba(0, 0, 0, .08);
            text-decoration: none !important;
        }

        .btn-wd:hover {
            filter: brightness(.95);
        }

        .btn-wd:active {
            transform: translateY(1px);
        }

        .no-underline,
        .no-underline:hover,
        .no-underline:focus {
            text-decoration: none !important;
        }
    </style>
</asp:Content>

<asp:Content ID="ctMain" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <!-- Encabezado + botones -->
        <div class="container row">
            <div class="row align-items-center">
                <div class="col-md-6 p-0">
                    <div class="header-title">
                        <div class="title-section">
                            <h2>Gestionar Clientes</h2>
                        </div>
                        <div class="color-bar bar-1"></div>
                        <div class="color-bar bar-2"></div>
                    </div>
                </div>
                <div class="col text-end p-3">
                    <asp:LinkButton ID="lkRegistrar" runat="server" CssClass="btn-wd no-underline" OnClick="lkRegistrar_Click">Registrar</asp:LinkButton>
                    &nbsp;
                    <asp:LinkButton ID="lkFiltrar" runat="server" CssClass="btn-wd no-underline" OnClick="lkFiltrar_Click">Filtrar</asp:LinkButton>
                </div>
            </div>
        </div>

        <!-- Grilla -->
        <div class="container row mt-3">
            <asp:GridView ID="gvClientes" runat="server"
                CssClass="table table-hover table-striped custom-grid"
                AutoGenerateColumns="False" ShowHeaderWhenEmpty="True"
                GridLines="None"
                AllowPaging="true" PageSize="8" OnPageIndexChanging="gvClientes_PageIndexChanging">
                <Columns>
                    <asp:BoundField HeaderText="ID" DataField="idCliente" />
                    <asp:BoundField HeaderText="Nombre" DataField="nombre" />
                    <asp:BoundField HeaderText="Apellido" DataField="primerApellido" />
                    <asp:BoundField HeaderText="DNI" DataField="dni" />
                    <asp:BoundField HeaderText="Tipo de Cliente" DataField="tipo.descripcion" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="action-btns">
                                <asp:LinkButton ID="btnModificar" runat="server"
                                    CssClass="btn btn-sm btn-outline-primary"
                                    CommandArgument='<%# Eval("IdCliente") %>'
                                    OnClick="btnModificar_Click" ToolTip="Editar">
                                    <i class="fa fa-pencil"></i>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnEliminar" runat="server"
                                    CssClass="btn btn-sm btn-outline-danger"
                                    CommandArgument='<%# Eval("IdCliente") %>'
                                    OnClientClick="return confirm('¿Está seguro de eliminar este registro?');"
                                    ToolTip="Eliminar">
                                    <i class="fa fa-trash"></i>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnVisualizar" runat="server"
                                    CssClass="btn btn-sm btn-outline-success"
                                    CommandArgument='<%# Eval("IdCliente") %>'
                                    OnClick="btnVisualizar_Click" ToolTip="Ver">
                                    <i class="fa fa-eye"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

<asp:Content ID="ctScripts" ContentPlaceHolderID="ScriptsContent" runat="server" />