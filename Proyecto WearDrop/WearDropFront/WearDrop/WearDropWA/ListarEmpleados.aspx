<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="ListarEmpleados.aspx.cs" Inherits="WearDropWA.ListarEmpleados" %>
<asp:Content ID="ctTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Gestionar Empleados
</asp:Content>

<asp:Content ID="ctHead" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* ------- layout base ------- */
        .header-title { display:flex; align-items:stretch; height:60px; box-shadow:0 2px 4px rgba(0,0,0,.1); margin-top:14px; border-radius:10px; overflow:hidden }
        .title-section { background:#fff; padding:0 25px; display:flex; align-items:center; flex:0 0 280px }
        .title-section h2 { margin:0; font-size:20px; font-weight:600; color:#333; white-space:nowrap }
        .color-bar { height:100% }

        /* Colores fijos (como en la captura) */
        .bar-1 { background:#C6D8C4; flex:1.5 }
        .bar-2 { background:#9DBD9B; flex:1.5 }

        .custom-grid { border-collapse:collapse; width:100% }
        .custom-grid th { background:#9DBD9B !important; color:#333; font-weight:500; padding:15px 20px; text-align:left; border:none }
        .custom-grid td { padding:12px 20px; border-bottom:1px solid #E8E8E8 }
        .custom-grid tr:nth-child(even) { background:#F5F5F5 }
        .custom-grid tr:hover { background:#E8F4E5 }

        /* 🔹 Quita subrayado de todos los LinkButton */
        a, a:visited, a:hover, a:active,
        .btn-wd, .btn-wd:hover, .btn-wd:focus, .btn-wd:active {
            text-decoration: none !important;
        }

        .btn-wd {
            background:#73866D; 
            color:#fff; 
            border:none; 
            padding:8px 18px; 
            border-radius:8px; 
            cursor:pointer; 
            display:inline-block; 
            transition:.15s; 
            box-shadow:0 1px 2px rgba(0,0,0,.08)
        }
        .btn-wd:hover { filter:brightness(.95) }
        .btn-wd:active { transform:translateY(1px) }

        /* Botones de acción en la grilla */
        .action-btns i { font-size:1.05em }
        .btn-sm { padding:4px 8px !important; margin-right:6px }
    </style>
</asp:Content>

<asp:Content ID="ctMain" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">

        <div class="container row">
            <div class="row align-items-center">
                <div class="col-md-6 p-0">
                    <div class="header-title">
                        <div class="title-section">
                            <h2>Gestionar Empleados</h2>
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
            <asp:GridView ID="gvEmpleados" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="True"
                CssClass="table table-hover table-striped custom-grid" GridLines="None">
                <Columns>
                    <asp:BoundField HeaderText="ID" DataField="IdEmpleado" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="Apellidos" DataField="Apellidos" />
                    <asp:BoundField HeaderText="DNI" DataField="Dni" />
                    <asp:BoundField HeaderText="Sueldo" DataField="Sueldo" DataFormatString="{0:N2}" />

                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="action-btns">

                                <asp:LinkButton ID="btnVisualizar" runat="server"
                                    CssClass="btn btn-sm btn-outline-success"
                                    CommandArgument='<%# Eval("IdEmpleado") %>'
                                    OnClick="btnVisualizar_Click"
                                    ToolTip="Ver"> 
                                    <i class="fa fa-eye"></i>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnModificar" runat="server"
                                    CssClass="btn btn-sm btn-outline-primary"
                                    CommandArgument='<%# Eval("IdEmpleado") %>'
                                    OnClick="btnModificar_Click"
                                    ToolTip="Editar">
                                    <i class="fa fa-pencil"></i>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnEliminar" runat="server"
                                    CssClass="btn btn-sm btn-outline-danger"
                                    CommandArgument='<%# Eval("IdEmpleado") %>'
                                    OnClientClick="return confirm('¿Está seguro de eliminar este registro?');"
                                    ToolTip="Eliminar">
                                    <i class="fa fa-trash"></i>
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