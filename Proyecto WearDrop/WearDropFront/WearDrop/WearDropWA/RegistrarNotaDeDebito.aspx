<%@ Page Title="Registrar Nota de Débito" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarNotaDeDebito.aspx.cs" Inherits="WearDropWA.RegistrarNotaDeDebito" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Nota de Débito
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <!-- Estilos (copiados de RegistrarComprobantes) -->
    <style>
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
        
        .btn-wd, .btn-secondary-custom {
            font-weight: 400; padding: 10px 25px; border-radius: 12px; border: none;
            color: white; transition: all 0.2s ease-in-out; text-decoration: none; display: inline-block;
        }
        .btn-wd { background-color: #198754; border: none; }
        .btn-wd:hover { background-color: #146c43; }
        .btn-secondary-custom { background-color: #6c757d; color: white; }
        .btn-secondary-custom:hover { background-color: #5a6268; color: white; }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="header-box">
        <!-- Flecha para volver a la lista de Notas de Débito -->
        <asp:HyperLink ID="hlVolver" runat="server" 
            NavigateUrl="~/ListarNotasDeDebito.aspx"
            CssClass="text-secondary" 
            Style="text-decoration: none; margin-right: 15px; font-size: 1.5rem; display: flex; align-items: center;">
            <i class="fa-solid fa-arrow-left fa-fw"></i>
        </asp:HyperLink>
        <h2 id="lblTitulo" runat="server" style="flex-grow: 1;">Registrar Nota de Débito</h2>
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

    <div class="section-container">
        <asp:UpdatePanel ID="upRegistrarNotaDebito" runat="server">
            <ContentTemplate>
                <!-- 
                  Este es el contenido de tu antiguo 'pnlNotaDebito'
                -->
                <div class="form-container">
                    <div class="form-row">
                        <div class="form-group">
                            <asp:Label ID="lblCorrelativoND" runat="server" AssociatedControlID="txtCorrelativoND">Correlativo</asp:Label>
                            <asp:TextBox ID="txtCorrelativoND" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblFechaND" runat="server" AssociatedControlID="txtFechaND">Fecha</asp:Label>
                            <asp:TextBox ID="txtFechaND" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <asp:Label ID="lblRUCND" runat="server" AssociatedControlID="txtRUCND">Registro Único de Contribuyentes</asp:Label>
                            <asp:TextBox ID="txtRUCND" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblRazonSocialND" runat="server" AssociatedControlID="txtRazonSocialND">Razón Social</asp:Label>
                            <asp:TextBox ID="txtRazonSocialND" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group full-width">
                            <asp:Label ID="lblMotivoND" runat="server" AssociatedControlID="txtMotivoND">Motivo específico</asp:Label>
                            <asp:TextBox ID="txtMotivoND" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group full-width">
                            <asp:Label ID="lblDetalleND" runat="server" AssociatedControlID="txtDetalleND">Detalle Modificación</asp:Label>
                            <asp:TextBox ID="txtDetalleND" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <asp:Label ID="lblTotalND" runat="server" AssociatedControlID="txtTotalND">Total (Comprobante Original)</asp:Label>
                            <asp:TextBox ID="txtTotalND" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblValorAumentarND" runat="server" AssociatedControlID="txtValorAumentarND">Valor a aumentar</asp:Label>
                            <asp:TextBox ID="txtValorAumentarND" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                        </div>
                    </div>
                     <div class="form-row">
                        <div class="form-group">
                            <asp:Label ID="lblNuevoMontoND" runat="server" AssociatedControlID="txtNuevoMontoND">Nuevo Monto</asp:Label>
                            <asp:TextBox ID="txtNuevoMontoND" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="lblMetodoPagoND" runat="server" AssociatedControlID="txtMetodoPagoND">Método de Pago</asp:Label>
                            <asp:TextBox ID="txtMetodoPagoND" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <asp:Label ID="lblIdPrenda" runat="server" AssociatedControlID="txtIdPrenda">ID Prenda Relacionada</asp:Label>
                            <asp:TextBox ID="txtIdPrenda" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                         <div class="form-group">
                            <!-- Espacio vacío -->
                         </div>
                    </div>
                     <div class="form-row igv-row">
                        <div class="igv-container">
                            <asp:Label ID="lblIGVND" runat="server" AssociatedControlID="txtIGVND">IGV (%):</aspI:Label>
                            <asp:TextBox ID="txtIGVND" runat="server" CssClass="form-control igv-textbox"></asp:TextBox>
                        </div>
                    </div>
                </div>
                
                <h3 class="resumen-header">Resumen</h3>
                <div class="footer-actions">
                    <div class="total-display"><strong>Nuevo Monto: S/. </strong><asp:Label ID="lblNuevoMontoDisplay" runat="server" Text="0.00"></asp:Label></div>
                    <div class="action-buttons">
                        <!-- Botón Cancelar ahora va a ListarNotasDeDebito.aspx -->
                        <asp:HyperLink ID="hlCancelarND" runat="server" 
                            NavigateUrl="~/ListarNotasDeDebito.aspx" 
                            CssClass="btn-secondary-custom" Style="margin-right: 10px;">Cancelar</asp:HyperLink>
                        
                        <asp:Button ID="btnEmitirND" runat="server" Text="Emitir" 
                            CssClass="btn-wd" OnClick="btnEmitirND_Click" />
                    </div>
                </div>

            </ContentTemplate>
        </asp:UpdatePanel>
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
                    La nota de débito se registró correctamente.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="redirectToManager()">Aceptar</button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
        // Función para MOSTRAR el modal de éxito
        function showSuccessModal() {
            var myModal = new bootstrap.Modal(document.getElementById('successModal'));
            myModal.show();
        }

        // Función para REDIRIGIR después de cerrar el modal
        function redirectToManager() {
            window.location.href = "ListarNotasDeDebito.aspx";
        }

        // Función para MOSTRAR el modal de error
        function mostrarModalError(mensaje, labelId) {
            document.getElementById(labelId).innerText = mensaje;
            var modalError = new bootstrap.Modal(document.getElementById('errorModal'));
            modalError.show();
        }
    </script>
</asp:Content>