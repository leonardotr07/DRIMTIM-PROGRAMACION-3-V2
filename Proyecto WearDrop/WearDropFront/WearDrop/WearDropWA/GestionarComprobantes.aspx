<%@ Page Title="Gestionar Comprobantes" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="GestionarComprobantes.aspx.cs" Inherits="WearDropWA.GestionarComprobantes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Gestionar Comprobantes
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* ------- layout base ------- */
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

        .btn-wd {
            background:var(--btn); color:#fff; border:none; padding:8px 18px;
            border-radius:8px; cursor:pointer; display:inline-block; transition:.15s;
            box-shadow:0 1px 2px rgba(0,0,0,.08)
        }
        .btn-wd:hover { filter:brightness(.95) }
        .btn-wd:active { transform:translateY(1px) }

        /* ===== Tonos ===== */
        .theme-polos { --tone-1:#C6D8C4; --tone-2:#9DBD9B; --tone-3:#7FA07E; }
        .theme-vestidos { --tone-1:#C7D6E2; --tone-2:#9FB6C8; --tone-3:#7C98AD; }
        .theme-gorros { --tone-1:#E0B6BC; --tone-2:#C99298; --tone-3:#A86E75; }
        .theme-pantalones { --tone-1:#D3CBEB; --tone-2:#B4A6D6; --tone-3:#8E83BE; }
        .theme-casacas { --tone-1:#C4DDD8; --tone-2:#9AC5BE; --tone-3:#77AAA2; }
        .theme-blusas { --tone-1:#F3EEB9; --tone-2:#EDE28A; --tone-3:#C7BC5F; }
        .theme-faldas { --tone-1:#DFC2CE; --tone-2:#C5A0B0; --tone-3:#A77A8D; }
        /* Tema para Comprobantes (ej. azul) */
        .theme-comprobantes { --tone-1:#C7D6E2; --tone-2:#9FB6C8; --tone-3:#7C98AD; }


        .theme-scope .bar-1 { background:var(--tone-1); }
        .theme-scope .bar-2 { background:var(--tone-2); }
        .theme-scope .custom-grid th { background:var(--tone-2) !important; color:#333; }
        .theme-scope .btn-wd { background:var(--tone-3); color:#fff; }
        .theme-scope .btn-wd:hover { filter:brightness(.95); }
        .theme-scope .top-accent { background:linear-gradient(90deg,var(--tone-1),var(--tone-2),var(--tone-3)); }

        /* ===== Botones de acción estilo Bootstrap ===== */
        .action-btns i { font-size:1.1em; }
        .btn-sm { padding:4px 8px !important; margin-right:4px; }
        
        /* Estilos de tu GridView anterior (Paginación) */
        .pagination-container {
            text-align: right;
            margin-top: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="themeWrap" runat="server" class="theme-comprobantes">
        <div class="theme-scope">
            <div class="container">
                <div class="top-accent"></div>

                <div class="container row">
                    <div class="row align-items-center">
                        <div class="col-md-6 p-0">
                            <div class="header-title">
                                <div class="title-section">
                                    <h2>Gestionar Comprobantes</h2>
                                </div>
                                <div class="color-bar bar-1"></div>
                                <div class="color-bar bar-2"></div>
                            </div>
                        </div>
                        <div class="col text-end p-3">
                            <asp:LinkButton ID="btnIrARegistrar" CssClass="btn-wd" 
                                runat="server" 
                                OnClick="btnIrARegistrar_Click" 
                                Text="Registrar" />
                        </div>
                    </div>
                </div>

                <div class="container row mt-3">
                    <asp:GridView ID="gvComprobantes" 
                        runat="server" 
                        AutoGenerateColumns="False" 
                        ShowHeaderWhenEmpty="True"
                        CssClass="table table-hover table-striped custom-grid" 
                        AllowPaging="True" 
                        PageSize="10"
                        OnPageIndexChanging="gvComprobantes_PageIndexChanging"
                        OnRowCommand="gvComprobantes_RowCommand">
                        
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" />
                            <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:d}" />
                            <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
                            <asp:BoundField DataField="Correlativo" HeaderText="Correlativo" />
                            <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C}" />
            
                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <div class="action-btns">
                                        <asp:LinkButton ID="btnEditar" runat="server" 
                                            CssClass="btn btn-sm btn-outline-primary" 
                                            CommandArgument='<%# Eval("ID") %>'
                                            CommandName="Editar"
                                            ToolTip="Editar">
                                            <i class="fa fa-pencil"></i>
                                        </asp:LinkButton>
                                        
                                        <asp:LinkButton ID="btnEliminar" runat="server" 
                                            CssClass="btn btn-sm btn-outline-danger" 
                                            CommandArgument='<%# Eval("ID") %>'
                                            CommandName="Eliminar"
                                            OnClientClick="return showConfirm(this);"
                                            ToolTip="Eliminar">
                                            <i class="fa fa-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        
                        <PagerStyle CssClass="pagination-container" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalLabel">Confirmar Eliminación</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ¿Estás seguro de borrar este comprobante? Esta acción no se puede deshacer.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-secondary-custom" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" id="btnConfirmDelete" class="btn btn-danger" onclick="executeDelete()">Eliminar</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
        var _deleteButtonToClick;

        function showConfirm(btn) {
            _deleteButtonToClick = btn;
            var myModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
            myModal.show();
            return false;
        }

        function executeDelete() {
            _deleteButtonToClick.click();
        }
    </script>
</asp:Content>