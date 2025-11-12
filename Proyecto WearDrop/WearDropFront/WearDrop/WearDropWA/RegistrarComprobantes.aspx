<%@ Page Title="Registrar Comprobante" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarComprobantes.aspx.cs" Inherits="WearDropWA.RegistrarComprobantes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Comprobante
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>

        /* ============================================================
            CSS COPIADO DE RegistrarProveedor.aspx
        ============================================================
        */

        /* -------------------- Caja del título -------------------- */
        .header-box {
            border: 1px solid #ddd;
            background-color: #f8f9fa;
            height: 75px;
            display: flex;
            justify-content: space-between;
            align-items: stretch;
            padding-left: 20px;
            border-radius: 10px;
        }
        .header-box h2 {
            margin: 0;
            color: #333;
            font-size: 1.5rem;
            display: flex;
            align-items: center;
            margin-right: 20px;
        }

        /* -------------------- Bloques de color -------------------- */
        .color-container { display: flex; align-items: stretch; gap: 0; }
        .color-block { width: 100px; flex: none; }
        .block-green-dark { background-color: #198754; }
        .block-green-light { background-color: #A4E6A4; }

        /* -------------------- Contenedor principal -------------------- */
        .section-container {
            margin-left: 0;
            display: flex;
            flex-direction: column;
            gap: 30px;
        }
        
        /* -------------------- TextBox -------------------- */
        .form-control {
            width: 100%; /* Modificado para que ocupe el 100% de su contenedor */
            text-align: left;
            display: block;
            padding: .375rem .75rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #ced4da;
            border-radius: .25rem;
            transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
        }


        /* ============================================================
            CSS DE ADAPTACIÓN PARA RegistrarComprobantes.aspx
        ============================================================
        */

        /* 1. Ajustar ancho y centrar los contenedores principales */
        .header-box {
            width: 80%;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: 30px;
        }
        .section-container {
            width: 80%;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: 50px; /* Espacio al final */
        }

        /* 2. Estilos para los TABS */
        .comprobante-tabs { 
            margin-bottom: -1px; 
            position: relative;
            z-index: 10;
        }
        .tab-link { 
            padding: 10px 20px; 
            text-decoration: none; 
            border: 1px solid #dee2e6; 
            background-color: #f8f9fa; 
            color: #333; 
            margin-right: 5px; 
            border-radius: 8px 8px 0 0; 
            font-weight: 500;
        }
        .tab-link.active { 
            background-color: #fff; 
            border-bottom-color: #fff; 
            font-weight: bold;
        }

        /* 3. ADAPTACIÓN DE .form-container */
        .form-container {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 35px 30px; /* Más padding */
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            width: 100%;
            border-top-left-radius: 0;
            display: flex;
            flex-direction: column;
            gap: 25px; /* Espacio entre filas */
        }
        
        /* 4. Fila de formulario */
        .form-row {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            gap: 60px; /* Espacio entre columnas */
            width: 100%;
        }

        /* 5. Adaptar .form-group (como .field-block) */
        .form-group {
            display: flex;
            flex-direction: column;
            flex: 1; /* Ocupa espacio disponible */
            min-width: 0; 
        }
        .form-group label {
            font-size: 1rem;
            font-weight: 500;
            color: #333;
            margin-bottom: 10px;
        }
        .form-group .form-control {
            width: 100%; /* Ocupa todo el .form-group */
        }
        
        /* 6. Modificador para campos de ancho completo */
        .form-group.full-width {
            flex-basis: 100%; /* Ocupa toda la fila */
        }

        /* 7. Adaptar .igv-container */
        .form-row.igv-row {
            justify-content: flex-end; /* Alinea el contenido a la derecha */
        }
        .igv-container { 
            text-align: right; 
            display: flex;
            align-items: center;
        }
        .igv-container label {
            font-size: 1rem;
            font-weight: 500;
            color: #333;
            margin-bottom: 0;
            margin-right: 10px;
        }
        .igv-textbox { 
            width: 80px; 
            display: inline-block; 
            text-align: left; 
        }

        /* 8. Resumen header */
        .resumen-header { 
            margin-top: 30px; 
            font-size: 1.2rem;
            font-weight: 500;
            color: #333;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        /* 9. Adaptar .footer-actions */
        .footer-actions {
            width: 100%;
            max-width: 100%;
            margin-top: 20px;
            padding-top: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .total-display { 
            font-size: 1.2em; 
            font-weight: bold; 
            color: #333; 
        }
        
        /* 10. Adaptar botones .btn-wd y .btn-secondary-custom */
        .btn-wd, .btn-secondary-custom {
            font-weight: 400;
            padding: 10px 25px;
            border-radius: 12px;
            border: none;
            color: white;
            transition: all 0.2s ease-in-out;
            text-decoration: none;
            display: inline-block;
        }
        .btn-wd {
            background-color: #198754;
            border: none;
        }
        .btn-wd:hover { background-color: #146c43; }
        .btn-secondary-custom {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary-custom:hover {
            background-color: #5a6268;
            color: white;
        }

    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="header-box">
        <h2 id="lblTitulo" runat="server">Registrar Comprobante</h2>
        <div class="color-container">
            <div class="color-block block-green-light"></div>
            <div class="color-block block-green-dark"></div>
        </div>
    </div>

    <div class="section-container">

        <asp:UpdatePanel ID="upRegistrar" runat="server">
            <ContentTemplate>
                
                <div class="comprobante-tabs">
                    <asp:LinkButton ID="btnTabBoleta" runat="server" CssClass="tab-link active" OnClick="btnTabBoleta_Click">Boleta</asp:LinkButton>
                    <asp:LinkButton ID="btnTabFactura" runat="server" CssClass="tab-link" OnClick="btnTabFactura_Click">Factura</asp:LinkButton>
                    <asp:LinkButton ID="btnTabNotaCredito" runat="server" CssClass="tab-link" OnClick="btnTabNotaCredito_Click">Nota de Crédito</asp:LinkButton>
                    <asp:LinkButton ID="btnTabNotaDebito" runat="server" CssClass="tab-link" OnClick="btnTabNotaDebito_Click">Nota de Débito</asp:LinkButton>
                </div>

                <%-- ======================= PANEL BOLETA ======================= --%>
                <asp:Panel ID="pnlBoleta" runat="server" Visible="true">
                    <div class="form-container">
                        <div class="form-row">
                            <div class="form-group">
                                <asp:Label ID="lblCorrelativo" runat="server" AssociatedControlID="txtCorrelativo">Correlativo</asp:Label>
                                <asp:TextBox ID="txtCorrelativo" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblFechaBoleta" runat="server" AssociatedControlID="txtFechaBoleta">Fecha</asp:Label>
                                <asp:TextBox ID="txtFechaBoleta" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <asp:Label ID="lblDNI" runat="server" AssociatedControlID="txtDNI">Documento Nacional de Identidad</asp:Label>
                                <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblNombres" runat="server" AssociatedControlID="txtNombres">Nombres y Apellidos</asp:Label>
                                <asp:TextBox ID="txtNombres" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group full-width">
                                <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail">Email</asp:Label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <asp:Label ID="lblMetodoPagoBoleta" runat="server" AssociatedControlID="txtMetodoPagoBoleta">Método de Pago</asp:Label>
                                <asp:TextBox ID="txtMetodoPagoBoleta" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblTotalBoletaInput" runat="server" AssociatedControlID="txtTotalBoleta">Total</asp:Label>
                                <asp:TextBox ID="txtTotalBoleta" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row igv-row">
                            <div class="igv-container">
                                <asp:Label ID="lblIGV" runat="server" AssociatedControlID="txtIGV">IGV (%):</asp:Label>
                                <asp:TextBox ID="txtIGV" runat="server" CssClass="form-control igv-textbox"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    
                    <h3 class="resumen-header">Resumen</h3>
                    <div class="footer-actions">
                        <div class="total-display"><strong>Total: S/. </strong><asp:Label ID="lblTotalBoleta" runat="server" Text="0.00"></asp:Label></div>
                        <div class="action-buttons">
                            <asp:HyperLink ID="hlCancelarBoleta" runat="server" NavigateUrl="~/GestionarComprobantes.aspx" CssClass="btn-secondary-custom" Style="margin-right: 10px;">Cancelar</asp:HyperLink>
                            <asp:Button ID="btnEmitirBoleta" runat="server" Text="Emitir" CssClass="btn-wd" OnClick="btnEmitirBoleta_Click" />
                        </div>
                    </div>
                </asp:Panel>

                <%-- ======================= PANEL FACTURA ======================= --%>
                <asp:Panel ID="pnlFactura" runat="server" Visible="false">
                    <div class="form-container">
                        <div class="form-row">
                            <div class="form-group">
                                <asp:Label ID="lblCorrelativoFactura" runat="server" AssociatedControlID="txtCorrelativoFactura">Correlativo</asp:Label>
                                <asp:TextBox ID="txtCorrelativoFactura" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblFechaFactura" runat="server" AssociatedControlID="txtFechaFactura">Fecha</asp:Label>
                                <asp:TextBox ID="txtFechaFactura" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <asp:Label ID="lblRUCFactura" runat="server" AssociatedControlID="txtRUCFactura">Registro Único de Contribuyentes</asp:Label>
                                <asp:TextBox ID="txtRUCFactura" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblRazonSocial" runat="server" AssociatedControlID="txtRazonSocial">Razón Social</asp:Label>
                                <asp:TextBox ID="txtRazonSocial" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                             <div class="form-group full-width">
                                <asp:Label ID="lblDireccion" runat="server" AssociatedControlID="txtDireccion">Dirección</asp:Label>
                                <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <asp:Label ID="lblNombresFactura" runat="server" AssociatedControlID="txtNombresFactura">Nombres y Apellidos (Contacto)</asp:Label>
                                <asp:TextBox ID="txtNombresFactura" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                             <div class="form-group">
                                <asp:Label ID="lblMetodoPago" runat="server" AssociatedControlID="txtMetodoPago">Método de Pago</asp:Label>
                                <asp:TextBox ID="txtMetodoPago" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <asp:Label ID="lblTotalFacturaInput" runat="server" AssociatedControlID="txtTotalFactura">Total</asp:Label>
                                <asp:TextBox ID="txtTotalFactura" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                </div>
                        </div>
                        <div class="form-row igv-row">
                            <div class="igv-container">
                                <asp:Label ID="lblIGVFactura" runat="server" AssociatedControlID="txtIGVFactura">IGV (%):</asp:Label>
                                <asp:TextBox ID="txtIGVFactura" runat="server" CssClass="form-control igv-textbox"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    
                    <h3 class="resumen-header">Resumen</h3>
                    <div class="footer-actions">
                        <div class="total-display"><strong>Total: S/. </strong><asp:Label ID="lblTotalFactura" runat="server" Text="0.00"></asp:Label></div>
                        <div class="action-buttons">
                            <asp:HyperLink ID="hlCancelarFactura" runat="server" NavigateUrl="~/GestionarComprobantes.aspx" CssClass="btn-secondary-custom" Style="margin-right: 10px;">Cancelar</asp:HyperLink>
                            <asp:Button ID="btnEmitirFactura" runat="server" Text="Emitir" CssClass="btn-wd" OnClick="btnEmitirFactura_Click" />
                        </div>
                    </div>
                </asp:Panel>

                <%-- ======================= PANEL NOTA DE CRÉDITO ======================= --%>
                <asp:Panel ID="pnlNotaCredito" runat="server" Visible="false">
                    <div class="form-container">
                        <div class="form-row">
                            <div class="form-group">
                                <asp:Label ID="lblCorrelativoNC" runat="server" AssociatedControlID="txtCorrelativoNC">Correlativo</asp:Label>
                                <asp:TextBox ID="txtCorrelativoNC" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblFechaNC" runat="server" AssociatedControlID="txtFechaNC">Fecha</asp:Label>
                                <asp:TextBox ID="txtFechaNC" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <asp:Label ID="lblDNINC" runat="server" AssociatedControlID="txtDNINC">Documento Nacional de Identidad</asp:Label>
                                <asp:TextBox ID="txtDNINC" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblRUCNC" runat="server" AssociatedControlID="txtRUCNC">Registro Único de Contribuyentes</asp:Label>
                                <asp:TextBox ID="txtRUCNC" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                         <div class="form-row">
                             <div class="form-group full-width">
                                <asp:Label ID="lblRazonSocialNC" runat="server" AssociatedControlID="txtRazonSocialNC">Razón Social</asp:Label>
                                <asp:TextBox ID="txtRazonSocialNC" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group full-width">
                                <asp:Label ID="lblMotivoNC" runat="server" AssociatedControlID="txtMotivoNC">Motivo Específico</asp:Label>
                                <asp:TextBox ID="txtMotivoNC" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group full-width">
                                <asp:Label ID="lblDetalleNC" runat="server" AssociatedControlID="txtDetalleNC">Detalle Modificación</asp:Label>
                                <asp:TextBox ID="txtDetalleNC" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <asp:Label ID="lblTotalNC" runat="server" AssociatedControlID="txtTotalNC">Total (Comprobante Original)</asp:Label>
                                <asp:TextBox ID="txtTotalNC" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblValorAumentarNC" runat="server" AssociatedControlID="txtValorAumentarNC">Valor a acreditar (Disminuir)</asp:Label>
                                <asp:TextBox ID="txtValorAumentarNC" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <asp:Label ID="lblNuevoMontoNC" runat="server" AssociatedControlID="txtNuevoMontoNC">Nuevo Monto</asp:Label>
                                <asp:TextBox ID="txtNuevoMontoNC" runat="server" CssClass="form-control" TextMode="Number" placeholder="0.00"></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="lblMetodoPagoNC" runat="server" AssociatedControlID="txtMetodoPagoNC">Método de Pago</asp:Label>
                                <asp:TextBox ID="txtMetodoPagoNC" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row igv-row">
                            <div class="igv-container">
                                <asp:Label ID="lblIGVNC" runat="server" AssociatedControlID="txtIGVNC">IGV (%):</asp:Label>
                                <asp:TextBox ID="txtIGVNC" runat="server" CssClass="form-control igv-textbox"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    
                    <h3 class="resumen-header">Resumen</h3>
                    <div class="footer-actions">
                        <div class="total-display"><strong>Nuevo Monto: S/. </strong><asp:Label ID="Label1" runat="server" Text="0.00"></asp:Label></div>
                        <div class="action-buttons">
                            <asp:HyperLink ID="hlCancelarNC" runat="server" NavigateUrl="~/GestionarComprobantes.aspx" CssClass="btn-secondary-custom" Style="margin-right: 10px;">Cancelar</asp:HyperLink>
                            <asp:Button ID="btnEmitirNC" runat="server" Text="Emitir" CssClass="btn-wd" OnClick="btnEmitirNC_Click" />
                        </div>
                    </div>
                </asp:Panel>

                <%-- ======================= PANEL NOTA DE DÉBITO ======================= --%>
                <asp:Panel ID="pnlNotaDebito" runat="server" Visible="false">
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
                                 </div>
                        </div>
                         <div class="form-row igv-row">
                            <div class="igv-container">
                                <asp:Label ID="lblIGVND" runat="server" AssociatedControlID="txtIGVND">IGV (%):</asp:Label>
                                <asp:TextBox ID="txtIGVND" runat="server" CssClass="form-control igv-textbox"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    
                    <h3 class="resumen-header">Resumen</h3>
                    <div class="footer-actions">
                        <div class="total-display"><strong>Nuevo Monto: S/. </strong><asp:Label ID="Label2" runat="server" Text="0.00"></asp:Label></div>
                        <div class="action-buttons">
                            <asp:HyperLink ID="hlCancelarND" runat="server" NavigateUrl="~/GestionarComprobantes.aspx" CssClass="btn-secondary-custom" Style="margin-right: 10px;">Cancelar</asp:HyperLink>
                            <asp:Button ID="btnEmitirND" runat="server" Text="Emitir" CssClass="btn-wd" OnClick="btnEmitirND_Click" />
                        </div>
                    </div>
                </asp:Panel>
                
            </ContentTemplate>
        </asp:UpdatePanel>
    </div> 

    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
    </div>
</asp:Content>