<%@ Page Title="Modificar Nota de Crédito" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="ModificarNotaDeCredito.aspx.cs" Inherits="WearDropWA.ModificarNotaDeCredito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Modificar Nota de Crédito
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <!-- Estilos de RegistrarAlmacen (tu estándar) -->
    <style>
        .header-title { display:flex; align-items:stretch; height:60px; box-shadow:0 2px 4px rgba(0,0,0,.1); margin-top:14px; margin-bottom: 40px; border-radius:10px; overflow:hidden }
        .title-section { background:#fff; padding:0 25px; display:flex; align-items:center; flex:0 0 280px }
        .title-section h2 { margin:0; font-size:20px; font-weight:600; color:#333; white-space:nowrap }
        .color-bar { height:100% } .bar-1 { flex:1.5 } .bar-2 { flex:1.5 }
        .top-accent { height:4px; margin-top:10px; margin-bottom: 30px; border-radius:4px }
        /* Tema de Comprobantes (Rojo Suave) */
        .theme-comprobantes { --tone-1:#E0B6BC; --tone-2:#C99298; --tone-3:#A86E75; }
        .theme-scope .bar-1 { background:var(--tone-1); }
        .theme-scope .bar-2 { background:var(--tone-2); }
        .theme-scope .top-accent { background:linear-gradient(90deg,var(--tone-1),var(--tone-2),var(--tone-3)); }
        .section-container { width: 100%; margin-left: 0; display: flex; flex-direction: column; gap: 20px; }
        .subsection { background-color: #fff; border: 1px solid #dee2e6; border-radius: 8px; padding: 18px 25px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); width: 100%; }
        .two-columns { display: flex; justify-content: space-between; align-items: flex-start; gap: 60px; width: 100%; }
        .one-column { display: flex; flex-direction: column; width: 100%; }
        .field-block { display: flex; flex-direction: column; flex: 1; }
        .field-block h3 { font-size: 0.95rem; font-weight: 500; color: #333; margin-bottom: 8px; }
        .required { color: #dc3545; }
        .form-control { width: 100%; max-width: 100%; text-align: left; padding: 8px 12px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; color: #333; background-color: #fff; transition: border-color 0.3s ease; box-sizing: border-box; }
        .form-control[disabled], .form-control[readonly] { background-color: #e9ecef; opacity: 1; }
        .form-control:focus { outline: none; border-color: var(--tone-2); box-shadow: 0 0 0 3px rgba(149, 184, 143, 0.1); }
        .form-control::placeholder { color: #999; }
        .buttons-bottom-container { width: 100%; max-width: 100%; border-top: 1px solid #eee; margin-top: 25px; padding: 20px 0 10px 0; display: flex; justify-content: space-between; align-items: center; }
        .theme-scope .btn-wd { background: var(--tone-3); color: #fff; border: none; padding: 9px 28px; border-radius: 8px; font-weight: 500; cursor: pointer; display: inline-block; transition: .15s; box-shadow: 0 1px 2px rgba(0,0,0,.08); text-decoration: none; }
        .theme-scope .btn-wd:hover { filter: brightness(.95); color: #fff; }
        .btn-secondary-custom { background-color: #FFFFFF; color: #333; border: 2px solid #ddd; padding: 9px 28px; border-radius: 8px; font-weight: 500; transition: all 0.3s ease; text-decoration: none; display: inline-block; }
        .btn-secondary-custom:hover { background-color: #f8f9fa; border-color: var(--tone-2); color: var(--tone-3); box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); }
        .text-danger { color: #dc3545; font-size: 12px; margin-top: 3px; display: block; }
        a, a:visited, a:hover, a:active { text-decoration: none !important; }
        .igv-container { text-align: right; display: flex; align-items: center; justify-content: flex-end; }
        .igv-container h3 { margin-bottom: 0; margin-right: 10px; }
        .igv-textbox { width: 100px; text-align: left; }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div id="themeWrap" runat="server" class="theme-comprobantes">
        <div class="theme-scope">
            <div class="container">
                <div class="top-accent"></div>

                <!-- Header con Título -->
                <div class="container row">
                    <div class="col-md-7 p-0">
                        <div class="header-title">
                            <div class="title-section">
                                <asp:HyperLink ID="hlVolver" runat="server" 
                                    NavigateUrl="~/ListarNotasDeCredito.aspx"
                                    CssClass="text-secondary" 
                                    Style="text-decoration: none; margin-right: 15px; font-size: 20px; font-weight: 600;">
                                    <i class="fa-solid fa-arrow-left fa-fw"></i>
                                </asp:HyperLink>
                                <h2>Modificar Nota de Crédito</h2>
                            </div>
                            <div class="color-bar bar-1"></div>
                            <div class="color-bar bar-2"></div>
                        </div>
                    </div>
                </div>

                <!-- Modal de Error -->
                <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header" style="background-color: #dc3545; color: white;">
                                <h5 class="modal-title" id="errorModalLabel">¡Ha ocurrido un error!</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Por favor, corrige el siguiente problema:</p>
                                <asp:Label ID="lblMensajeError" runat="server" Text="" Style="font-weight: bold; color: #dc3545;"></asp:Label>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal de Éxito -->
                <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="successModalLabel">Modificación Exitosa</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="redirectToManager()"></button>
                            </div>
                            <div class="modal-body">
                                La nota de crédito se modificó correctamente.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="redirectToManager()">Aceptar</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Contenedor Principal (Formulario) -->
                <div class="section-container">
                    <asp:UpdatePanel ID="upModificarNC" runat="server">
                        <ContentTemplate>
                            
                            <div class="subsection">
                                <div class="two-columns">
                                    <div class="field-block">
                                        <h3>ID</h3>
                                        <asp:TextBox ID="txtID" runat="server" CssClass="form-control" Enabled="false" ToolTip="No se puede modificar"></asp:TextBox>
                                    </div>
                                    <div class="field-block">
                                        <h3>Correlativo <span class="required">(*)</span></h3>
                                        <asp:TextBox ID="txtCorrelativo" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCorrelativo" runat="server" 
                                            ControlToValidate="txtCorrelativo" ErrorMessage="El correlativo es obligatorio" 
                                            CssClass="text-danger" Display="Dynamic" ValidationGroup="vgModNC" />
                                    </div>
                                </div>
                            </div>

                            <div class="subsection">
                                <div class="two-columns">
                                    <div class="field-block">
                                        <h3>DNI</h3>
                                        <asp:TextBox ID="txtNCDNI" runat="server" CssClass="form-control" MaxLength="8"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revDNI" runat="server"
                                            ControlToValidate="txtNCDNI" ValidationExpression="^\d{8}$"
                                            ErrorMessage="El DNI debe contener 8 dígitos (o estar vacío)."
                                            CssClass="text-danger" Display="Dynamic" ValidationGroup="vgModNC" />
                                    </div>
                                    <div class="field-block">
                                        <h3>RUC</h3>
                                        <asp:TextBox ID="txtNCRUC" runat="server" CssClass="form-control" MaxLength="11"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="revRUC" runat="server"
                                            ControlToValidate="txtNCRUC" ValidationExpression="^\d{11}$"
                                            ErrorMessage="El RUC debe contener 11 dígitos (o estar vacío)."
                                            CssClass="text-danger" Display="Dynamic" ValidationGroup="vgModNC" />
                                    </div>
                                </div>
                            </div>
                            
                            <div class="subsection">
                                <div class="one-column">
                                    <div class="field-block">
                                        <h3>Razón Social <span class="required">(*)</span></h3>
                                        <asp:TextBox ID="txtNCRazonSocial" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvRazonSocial" runat="server" 
                                            ControlToValidate="txtNCRazonSocial" ErrorMessage="La razón social es obligatoria" 
                                            CssClass="text-danger" Display="Dynamic" ValidationGroup="vgModNC" />
                                    </div>
                                </div>
                            </div>

                            <div class="subsection">
                                <div class="two-columns">
                                    <div class="field-block">
                                        <h3>Motivo Específico <span class="required">(*)</span></h3>
                                        <asp:TextBox ID="txtNCMotivo" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvMotivo" runat="server" 
                                            ControlToValidate="txtNCMotivo" ErrorMessage="El motivo es obligatorio" 
                                            CssClass="text-danger" Display="Dynamic" ValidationGroup="vgModNC" />
                                    </div>
                                    <div class="field-block">
                                        <h3>Detalle Modificación <span class="required">(*)</span></h3>
                                        <asp:TextBox ID="txtNCDetalle" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDetalle" runat="server" 
                                            ControlToValidate="txtNCDetalle" ErrorMessage="El detalle es obligatorio" 
                                            CssClass="text-danger" Display="Dynamic" ValidationGroup="vgModNC" />
                                    </div>
                                </div>
                            </div>

                            <div class="subsection">
                                <div class="two-columns">
                                    <div class="field-block">
                                        <h3>Total (Comprobante Original) <span class="required">(*)</span></h3>
                                        <asp:TextBox ID="txtNCTotal" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvTotal" runat="server" 
                                            ControlToValidate="txtNCTotal" ErrorMessage="El total original es obligatorio" 
                                            CssClass="text-danger" Display="Dynamic" ValidationGroup="vgModNC" />
                                    </div>
                                    <div class="field-block">
                                        <h3>Valor a Acreditar (Disminuir) <span class="required">(*)</span></h3>
                                        <asp:TextBox ID="txtNCValorAumentar" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvValor" runat="server" 
                                            ControlToValidate="txtNCValorAumentar" ErrorMessage="El valor es obligatorio" 
                                            CssClass="text-danger" Display="Dynamic" ValidationGroup="vgModNC" />
                                    </div>
                                </div>
                            </div>

                            <div class="subsection">
                                <div class="two-columns">
                                    <div class="field-block">
                                        <h3>Nuevo Monto <span class="required">(*)</span></h3>
                                        <asp:TextBox ID="txtNCNuevoMonto" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvNuevoMonto" runat="server" 
                                            ControlToValidate="txtNCNuevoMonto" ErrorMessage="El nuevo monto es obligatorio" 
                                            CssClass="text-danger" Display="Dynamic" ValidationGroup="vgModNC" />
                                    </div>
                                    <div class="field-block">
                                        <h3>Método de Pago <span class="required">(*)</span></h3>
                                        <asp:TextBox ID="txtNCMetodoPago" runat="server" CssClass="form-control"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvMetodoPago" runat="server" 
                                            ControlToValidate="txtNCMetodoPago" ErrorMessage="El método de pago es obligatorio" 
                                            CssClass="text-danger" Display="Dynamic" ValidationGroup="vgModNC" />
                                    </div>
                                </div>
                            </div>
                            
                            <div class="subsection">
                                <div class="two-columns">
                                    <div class="field-block">
                                        <h3>Fecha <span class="required">(*)</span></h3>
                                        <asp:TextBox ID="txtNCFecha" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvFecha" runat="server" 
                                            ControlToValidate="txtNCFecha" ErrorMessage="La fecha es obligatoria" 
                                            CssClass="text-danger" Display="Dynamic" ValidationGroup="vgModNC" />
                                    </div>
                                    <div class="field-block">
                                        <div class="igv-container">
                                            <h3>IGV (%): <span class="required">(*)</span></h3>
                                            <asp:TextBox ID="txtNCIGV" runat="server" CssClass="form-control igv-textbox"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvIGV" runat="server" 
                                                ControlToValidate="txtNCIGV" ErrorMessage="IGV obl." 
                                                CssClass="text-danger" Display="Dynamic" ValidationGroup="vgModNC" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

                <!-- Botones Inferiores -->
                <div class="container buttons-bottom-container">
                    <asp:HyperLink ID="hlCancelar" runat="server"
                        Text="Cancelar"
                        CssClass="btn-secondary-custom"
                        NavigateUrl="~/ListarNotasDeCredito.aspx" />
                    
                    <asp:Button ID="btnGuardar" runat="server"
                        Text="Guardar Cambios"
                        CssClass="btn-wd"
                        ValidationGroup="vgModNC"
                        OnClick="btnGuardar_Click" />
                </div>

            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
        function showSuccessModal() {
            var myModal = new bootstrap.Modal(document.getElementById('successModal'));
            myModal.show();
        }
        function redirectToManager() {
            // Regresa a la lista de notas de crédito
            window.location.href = "ListarNotasDeCredito.aspx";
        }
        function mostrarModalError(mensaje, labelId) {
            document.getElementById(labelId).innerText = mensaje;
            var modalError = new bootstrap.Modal(document.getElementById('errorModal'));
            modalError.show();
        }
    </script>
</asp:Content>