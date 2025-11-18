<%@ Page Title="Registrar Boleta" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarBoleta.aspx.cs" Inherits="WearDropWA.RegistrarBoleta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Boleta
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* ... (Estilos de .header-box, .form-container, .form-row, etc. que ya tenías) ... */
        .header-box { border: 1px solid #ddd; background-color: #f8f9fa; height: 75px; display: flex; justify-content: space-between; align-items: stretch; padding-left: 20px; border-radius: 10px; }
        .header-box h2 { margin: 0; color: #333; font-size: 1.5rem; display: flex; align-items: center; margin-right: 20px; }
        .color-container { display: flex; align-items: stretch; gap: 0; }
        .color-block { width: 100px; flex: none; }
        .block-green-dark { background-color: #198754; }
        .block-green-light { background-color: #A4E6A4; }
        .section-container { margin-left: 0; display: flex; flex-direction: column; gap: 30px; }
        .form-control { width: 100%; text-align: left; display: block; padding: .375rem .75rem; font-size: 1rem; font-weight: 400; line-height: 1.5; color: #212529; background-color: #fff; background-clip: padding-box; border: 1px solid #ced4da; border-radius: .25rem; transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out; }
        .header-box { width: 80%; margin-left: auto; margin-right: auto; margin-bottom: 30px; }
        .section-container { width: 80%; margin-left: auto; margin-right: auto; margin-bottom: 50px; }
        .form-container { background-color: #fff; border: 1px solid #dee2e6; border-radius: 8px; padding: 35px 30px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); width: 100%; display: flex; flex-direction: column; gap: 25px; }
        .form-row { display: flex; flex-direction: row; justify-content: space-between; gap: 60px; width: 100%; }
        .form-group { display: flex; flex-direction: column; flex: 1; min-width: 0; }
        .form-group label { font-size: 1rem; font-weight: 500; color: #333; margin-bottom: 10px; }
        .form-group .form-control { width: 100%; }
        .form-group.full-width { flex-basis: 100%; }
        .form-row.igv-row { justify-content: flex-end; }
        .igv-container { text-align: right; display: flex; align-items: center; }
        .igv-container label { font-size: 1rem; font-weight: 500; color: #333; margin-bottom: 0; margin-right: 10px; }
        .igv-textbox { width: 80px; display: inline-block; text-align: left; }
        .resumen-header { margin-top: 30px; font-size: 1.2rem; font-weight: 500; color: #333; padding-bottom: 10px; border-bottom: 1px solid #eee; }
        .footer-actions { width: 100%; max-width: 100%; margin-top: 20px; padding-top: 15px; display: flex; justify-content: space-between; align-items: center; }
        .total-display { font-size: 1.2em; font-weight: bold; color: #333; }
        .btn-wd, .btn-secondary-custom { font-weight: 400; padding: 10px 25px; border-radius: 12px; border: none; color: white; transition: all 0.2s ease-in-out; text-decoration: none; display: inline-block; }
        .btn-wd { background-color: #198754; border: none; }
        .btn-wd:hover { background-color: #146c43; }
        .btn-secondary-custom { background-color: #6c757d; color: white; }
        .btn-secondary-custom:hover { background-color: #5a6268; color: white; }

        /* --- ¡NUEVO! ESTILO PARA VALIDACIÓN --- */
        .text-danger {
            color: #dc3545;
            font-size: 12px;
            margin-top: 3px;
            display: block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="header-box">
        <asp:HyperLink ID="hlVolver" runat="server" 
            NavigateUrl="~/ListarBoletas.aspx"
            CssClass="text-secondary" 
            Style="text-decoration: none; margin-right: 15px; font-size: 1.5rem; display: flex; align-items: center;">
            <i class="fa-solid fa-arrow-left fa-fw"></i>
        </asp:HyperLink>
        <h2 id="lblTitulo" runat="server" style="flex-grow: 1;">Registrar Boleta</h2>
        <div class="color-container">
            <div class="color-block block-green-light"></div>
            <div class="color-block block-green-dark"></div>
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
                    <h5 class="modal-title" id="successModalLabel">Registro Exitoso</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="redirectToManager()"></button>
                </div>
                <div class="modal-body">
                    El comprobante se registró correctamente.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="redirectToManager()">Aceptar</button>
                </div>
            </div>
        </div>
    </div>


    <div class="section-container">
        <asp:UpdatePanel ID="upRegistrarBoleta" runat="server">
            <ContentTemplate>
                
                <div class="form-container">
                    <div class="form-row">
                        <div class="form-group">
                            <asp:Label ID="lblCorrelativo" runat="server" AssociatedControlID="txtCorrelativo">Correlativo <span class="text-danger">(*)</span></asp:Label>
                            <asp:TextBox ID="txtCorrelativo" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCorrelativo" runat="server" 
                                ControlToValidate="txtCorrelativo" ErrorMessage="El correlativo es obligatorio" 
                                CssClass="text-danger" Display="Dynamic" ValidationGroup="vgBoleta" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblFechaBoleta" runat="server" AssociatedControlID="txtFechaBoleta">Fecha <span class="text-danger">(*)</span></asp:Label>
                            <asp:TextBox ID="txtFechaBoleta" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFechaBoleta" runat="server" 
                                ControlToValidate="txtFechaBoleta" ErrorMessage="La fecha es obligatoria" 
                                CssClass="text-danger" Display="Dynamic" ValidationGroup="vgBoleta" />
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group full-width">
                            <asp:Label ID="lblDNI" runat="server" AssociatedControlID="txtDNI">Documento Nacional de Identidad <span class="text-danger">(*)</span></asp:Label>
                            <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDNI" runat="server" 
                                ControlToValidate="txtDNI" ErrorMessage="El DNI es obligatorio" 
                                CssClass="text-danger" Display="Dynamic" ValidationGroup="vgBoleta" />
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <asp:Label ID="lblMetodoPagoBoleta" runat="server" AssociatedControlID="txtMetodoPagoBoleta">Método de Pago <span class="text-danger">(*)</span></asp:Label>
                            <asp:TextBox ID="txtMetodoPagoBoleta" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvMetodoPago" runat="server" 
                                ControlToValidate="txtMetodoPagoBoleta" ErrorMessage="El método de pago es obligatorio" 
                                CssClass="text-danger" Display="Dynamic" ValidationGroup="vgBoleta" />
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblTotalBoletaInput" runat="server" AssociatedControlID="txtTotalBoleta">Total <span class="text-danger">(*)</span></asp:Label>
                            <asp:TextBox ID="txtTotalBoleta" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTotal" runat="server" 
                                ControlToValidate="txtTotalBoleta" ErrorMessage="El total es obligatorio" 
                                CssClass="text-danger" Display="Dynamic" ValidationGroup="vgBoleta" />
                            <asp:RangeValidator ID="rvTotal" runat="server"
                                ControlToValidate="txtTotalBoleta" Type="Double" MinimumValue="0.01" MaximumValue="9999999"
                                ErrorMessage="El total debe ser un número mayor a 0." CssClass="text-danger" Display="Dynamic" ValidationGroup="vgBoleta" />
                        </div>
                    </div>
                    
                    <div class="form-row igv-row">
                        <div class="igv-container">
                            <asp:Label ID="lblIGV" runat="server" AssociatedControlID="txtIGV">IGV (%): <span class="text-danger">(*)</span></asp:Label>
                            <asp:TextBox ID="txtIGV" runat="server" CssClass="form-control igv-textbox"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvIGV" runat="server" 
                                ControlToValidate="txtIGV" ErrorMessage="IGV obl." 
                                CssClass="text-danger" Display="Dynamic" ValidationGroup="vgBoleta" />
                        </div>
                    </div>
                </div>
                
                <h3 class="resumen-header">Resumen</h3>
                <div class="footer-actions">
                    <div class="total-display"><strong>Total: S/. </strong><asp:Label ID="lblTotalBoleta" runat="server" Text="0.00"></asp:Label></div>
                    <div class="action-buttons">
                        <asp:HyperLink ID="hlCancelarBoleta" runat="server" 
                            NavigateUrl="~/ListarBoletas.aspx" 
                            CssClass="btn-secondary-custom" Style="margin-right: 10px;">Cancelar</asp:HyperLink>
                        
                        <asp:Button ID="btnEmitirBoleta" runat="server" Text="Emitir" 
                            CssClass="btn-wd" OnClick="btnEmitirBoleta_Click" 
                            ValidationGroup="vgBoleta" />
                    </div>
                </div>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div> 
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
        function showSuccessModal() {
            var myModal = new bootstrap.Modal(document.getElementById('successModal'));
            myModal.show();
        }

        function redirectToManager() {
            window.location.href = "ListarBoletas.aspx";
        }

        function mostrarModalError(mensaje, labelId) {
            document.getElementById(labelId).innerText = mensaje;
            var modalError = new bootstrap.Modal(document.getElementById('errorModal'));
            modalError.show();
        }
    </script>
</asp:Content>