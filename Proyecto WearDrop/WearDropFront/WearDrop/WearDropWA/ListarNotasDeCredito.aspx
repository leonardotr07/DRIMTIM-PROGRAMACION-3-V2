<%@ Page Title="Listar Notas de Crédito" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="ListarNotasDeCredito.aspx.cs" Inherits="WearDropWA.ListarNotasDeCredito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Listar Notas de Crédito
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .header-title { display:flex; align-items:stretch; height:60px; box-shadow:0 2px 4px rgba(0,0,0,.1); margin-top:14px; border-radius:10px; overflow:hidden }
        .title-section { background:#fff; padding:0 25px; display:flex; align-items:center; flex:0 0 auto; }
        .title-section h2 { margin:0; font-size:20px; font-weight:600; color:#333; white-space:nowrap }
        .color-bar { height:100% } .bar-1 { flex:1.5 } .bar-2 { flex:1.5 }
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
        
        /* Tema de Comprobantes (Rojo Suave para Crédito) */
        .theme-comprobantes { --tone-1:#E0B6BC; --tone-2:#C99298; --tone-3:#A86E75; }

        .theme-scope .bar-1 { background:var(--tone-1); }
        .theme-scope .bar-2 { background:var(--tone-2); }
        .theme-scope .custom-grid th { background:var(--tone-2) !important; color:#333; }
        .theme-scope .btn-wd { background:var(--tone-3); color:#fff; }
        .theme-scope .top-accent { background:linear-gradient(90deg,var(--tone-1),var(--tone-2),var(--tone-3)); }
        
        .action-btns i { font-size:1.1em; }
        .btn-sm { padding:4px 8px !important; margin-right:4px; }
        .pagination-container { text-align: right; margin-top: 15px; }

        /* Modal personalizado */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content-custom {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            max-width: 500px;
            width: 90%;
        }

        .modal-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }

        .modal-body {
            margin-bottom: 25px;
        }

        .info-field {
            margin-bottom: 15px;
        }

        .info-label {
            font-weight: 500;
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .info-value {
            background-color: #f0f0f0;
            padding: 10px;
            border-radius: 4px;
            color: #333;
        }

        .modal-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .btn-eliminar {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 30px;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-eliminar:hover {
            background-color: #c82333;
        }

        .btn-secondary-custom {
            background-color: #FFFFFF;
            color: #333;
            border: 2px solid #ddd;
            padding: 10px 30px;
            border-radius: 4px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-secondary-custom:hover {
            background-color: #f8f9fa;
            border-color: #C99298;
            color: #A86E75;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
                                    <asp:HyperLink ID="hlVolver" runat="server" 
                                        NavigateUrl="~/GestionarComprobantes.aspx"
                                        CssClass="text-secondary" 
                                        Style="text-decoration: none; margin-right: 15px; font-size: 20px; font-weight: 600;">
                                        <i class="fa-solid fa-arrow-left fa-fw"></i>
                                    </asp:HyperLink>
                                    <h2>Gestionar Notas de Crédito</h2>
                                </div>
                                <div class="color-bar bar-1"></div>
                                <div class="color-bar bar-2"></div>
                            </div>
                        </div>
                        <div class="col text-end p-3">
                            <asp:HyperLink ID="btnIrARegistrar" CssClass="btn-wd" 
                                runat="server" 
                                NavigateUrl="~/RegistrarNotaDeCredito.aspx" 
                                Text="Registrar Nota de Crédito" />
                        </div>
                    </div>
                </div>

                <div class="container row mt-3">
                    <asp:GridView ID="gvNotasDeCredito" runat="server" 
                        AutoGenerateColumns="False" 
                        ShowHeaderWhenEmpty="True"
                        EmptyDataText="No hay notas de crédito disponibles"
                        CssClass="table table-hover table-striped custom-grid" 
                        AllowPaging="True" 
                        PageSize="10"
                        OnPageIndexChanging="gvNotasDeCredito_PageIndexChanging"
                        GridLines="None">
                        
                        <Columns>
                            <asp:BoundField DataField="idComprobante" HeaderText="ID" />
                            <asp:BoundField DataField="fecha" HeaderText="Fecha" DataFormatString="{0:d}" />
                            <asp:BoundField DataField="Correlativo" HeaderText="Correlativo" />
                            <asp:BoundField DataField="RUC" HeaderText="RUC / DNI" />
                            <asp:BoundField DataField="razonSocial" HeaderText="Razón Social" />
                            <asp:BoundField DataField="motivoEspecifico" HeaderText="Motivo" />
                            <asp:BoundField DataField="nuevoMonto" HeaderText="Nuevo Monto" DataFormatString="{0:C}" />
                            
                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <div class="action-btns">
                                        <asp:LinkButton ID="btnEditar" runat="server" 
                                            CssClass="btn btn-sm btn-outline-primary" 
                                            CommandArgument='<%# Eval("idComprobante") %>'
                                            OnClick="btnEditar_Click"
                                            ToolTip="Editar">
                                            <i class="fa fa-pencil"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnEliminar" runat="server" 
                                            CssClass="btn btn-sm btn-outline-danger" 
                                            CommandArgument='<%# Eval("idComprobante") %>'
                                            OnClientClick='<%# "return mostrarModalEliminar(" + Eval("idComprobante") + ", \"" + Eval("Correlativo") + "\", \"" + Eval("motivoEspecifico") + "\");" %>'
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

    <!-- Modal de Confirmación de Eliminación -->
    <div id="modalEliminarNotaCredito" class="modal-overlay">
        <div class="modal-content-custom">
            <h3 class="modal-title">¿Está seguro de eliminar esta nota de crédito?</h3>
            <div class="modal-body">
                <div class="info-field">
                    <div class="info-label">Correlativo:</div>
                    <div class="info-value" id="modalCorrelativo"></div>
                </div>
                <div class="info-field">
                    <div class="info-label">Motivo:</div>
                    <div class="info-value" id="modalMotivo"></div>
                </div>
                <p style="color: #666; font-size: 14px; text-align: center;">Esta acción no se puede deshacer.</p>
            </div>
            <div class="modal-buttons">
                <asp:Button ID="btnConfirmarEliminar" runat="server" 
                    CssClass="btn-eliminar" 
                    Text="Eliminar" 
                    OnClick="btnConfirmarEliminar_Click" />
                <button type="button" class="btn-secondary-custom" onclick="cerrarModalEliminar()">Cancelar</button>
            </div>
            <asp:HiddenField ID="hfIdNotaCreditoEliminar" runat="server" />
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
        function mostrarModalEliminar(idNotaCredito, correlativo, motivo) {
            document.getElementById('modalCorrelativo').innerText = correlativo;
            document.getElementById('modalMotivo').innerText = motivo;
            document.getElementById('<%= hfIdNotaCreditoEliminar.ClientID %>').value = idNotaCredito;
            document.getElementById('modalEliminarNotaCredito').style.display = 'flex';
            return false; // Evita postback hasta confirmar
        }

        function cerrarModalEliminar() {
            document.getElementById('modalEliminarNotaCredito').style.display = 'none';
        }

        // Cerrar modal si se hace clic fuera de él
        window.onclick = function (event) {
            var modal = document.getElementById('modalEliminarNotaCredito');
            if (event.target == modal) {
                cerrarModalEliminar();
            }
        }
    </script>
</asp:Content>