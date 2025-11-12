<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="ListarCuentas.aspx.cs" Inherits="WearDropWA.ListarCuentas" %>
<asp:Content ID="ctTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Gestionar Cuentas
</asp:Content>

<asp:Content ID="ctHead" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* ------- layout base ------- */
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            margin-top: 14px;
            border-radius: 10px;
            overflow: hidden
        }

        .title-section {
            background: #fff;
            padding: 0 25px;
            display: flex;
            align-items: center;
            flex: 0 0 280px
        }

            .title-section h2 {
                margin: 0;
                font-size: 20px;
                font-weight: 600;
                color: #333;
                white-space: nowrap
            }

        .color-bar {
            height: 100%
        }

        /* 🎨 Colores AZULES (como Vestidos) */
        .bar-1 {
            background: #CFD9E4;
            flex: 1.5
        }
        /* azul claro de barra */
        .bar-2 {
            background: #8FA6B9;
            flex: 1.5
        }
        /* azul medio de barra */

        .custom-grid {
            border-collapse: collapse;
            width: 100%
        }

            .custom-grid th {
                background: #8FA6B9 !important;
                color: #333;
                font-weight: 500;
                padding: 15px 20px;
                text-align: left;
                border: none
            }

            .custom-grid td {
                padding: 12px 20px;
                border-bottom: 1px solid #E8E8E8
            }

            .custom-grid tr:nth-child(even) {
                background: #F5F5F5
            }

            .custom-grid tr:hover {
                background: #EAF0F5
            }
        /* hover azul muy claro */

        /* Botones superiores (tono acorde) */
        .btn-wd {
            background: #6F889E;
            color: #fff;
            border: none;
            padding: 8px 18px;
            border-radius: 8px;
            cursor: pointer;
            display: inline-block;
            transition: .15s;
            box-shadow: 0 1px 2px rgba(0,0,0,.08);
            text-decoration: none !important
        }

            .btn-wd:hover {
                filter: brightness(.95)
            }

            .btn-wd:active {
                transform: translateY(1px)
            }

        /* Botones de acción en la grilla */
        .action-btns i {
            font-size: 1.05em
        }

        .btn-sm {
            padding: 4px 8px !important;
            margin-right: 6px
        }

        .no-underline, .no-underline:hover, .no-underline:focus {
            text-decoration: none !important
        }
    </style>
</asp:Content>

<asp:Content ID="ctMain" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="container row">
            <div class="row align-items-center">
                <div class="col-md-6 p-0">
                    <div class="header-title">
                        <div class="title-section"><h2>Gestionar Cuentas</h2></div>
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

        <div class="container row mt-3">
            <asp:GridView ID="gvCuentas" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="True"
                CssClass="table table-hover table-striped custom-grid" GridLines="None">
                <Columns>
                    <asp:BoundField HeaderText="ID" DataField="IdCuenta" />
                    <asp:BoundField HeaderText="User Name" DataField="UserName" />
                    <asp:BoundField HeaderText="Email" DataField="Email" />
                    <asp:BoundField HeaderText="Empleado" DataField="Empleado" />

                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="action-btns">
                                <asp:LinkButton ID="btnModificar" runat="server"
                                    CssClass="btn btn-sm btn-outline-primary"
                                    CommandArgument='<%# Eval("IdCuenta") %>'
                                    OnClick="btnModificar_Click" ToolTip="Editar">
                                    <i class="fa fa-pencil"></i>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnEliminar" runat="server"
                                    CssClass="btn btn-sm btn-outline-danger"
                                    CommandArgument='<%# Eval("IdCuenta") %>'
                                    OnClientClick="return confirm('¿Está seguro de eliminar este registro?');"
                                     ToolTip="Eliminar">
                                    <i class="fa fa-trash"></i>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnVisualizar" runat="server"
                                    CssClass="btn btn-sm btn-outline-success"
                                    CommandArgument='<%# Eval("IdCuenta") %>'
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
