<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarMovimiento.aspx.cs" Inherits="WearDropWA.RegistrarMovimiento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Movimiento
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    
    <style>
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-top: 14px;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .title-section {
            background-color: #FFFFFF;
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

        .bar-1 {
            background-color: #C5D9C0;
            flex: 1.5;
        }

        .bar-2 {
            background-color: #95B88F;
            flex: 1.5;
        }

        .top-accent {
            height: 4px;
            margin-top: 10px;
            border-radius: 4px;
            background: linear-gradient(90deg, #C5D9C0, #95B88F, #73866D);
        }

        /* Formulario */
        .form-container {
            background-color: #FFFFFF;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-top: 20px;
        }

        .form-label {
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
            font-size: 14px;
            display: block;
        }

        .required {
            color: #dc3545;
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            color: #333;
            background-color: #fff;
            transition: border-color 0.3s ease;
        }

        .form-control-short {
            max-width: 250px;
        }

        .form-control:focus {
            outline: none;
            border-color: #95B88F;
            box-shadow: 0 0 0 3px rgba(149, 184, 143, 0.1);
        }

        .text-danger {
            color: #dc3545;
            font-size: 13px;
            margin-top: 4px;
            display: block;
        }

        /* Botones */
        .btn-custom {
            background-color: #73866D;
            color: #FFFFFF;
            border: none;
            padding: 10px 30px;
            border-radius: 8px;
            font-weight: 500;
            transition: .15s;
            box-shadow: 0 1px 2px rgba(0,0,0,.08);
            text-decoration: none;
            display: inline-block;
        }

        .btn-custom:hover {
            filter: brightness(.95);
            color: #FFFFFF;
        }

        .btn-custom:active {
            transform: translateY(1px);
        }

        .btn-secondary-custom {
            background-color: #FFFFFF;
            color: #333;
            border: 2px solid #ddd;
            padding: 10px 30px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 1px 2px rgba(0,0,0,.08);
            text-decoration: none;
            display: inline-block;
        }

        .btn-secondary-custom:hover {
            background-color: #f8f9fa;
            border-color: #95B88F;
            color: #73866D;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-secondary-custom:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .button-group {
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #E8E8E8;
        }

        /* 🔹 ------- PERSONALIZACIÓN DE SELECT2 ------- */
        
        /* Contenedor principal de Select2 */
        .select2-container--default .select2-selection--single {
            height: 42px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #fff;
            transition: border-color 0.3s ease;
        }

        .select2-container--default .select2-selection--single:focus,
        .select2-container--default.select2-container--open .select2-selection--single {
            border-color: #95B88F;
            box-shadow: 0 0 0 0.2rem rgba(149, 184, 143, 0.25);
            outline: none;
        }

        /* Texto seleccionado */
        .select2-container--default .select2-selection--single .select2-selection__rendered {
            line-height: 40px;
            padding-left: 12px;
            color: #333;
            font-size: 14px;
        }

        /* Flecha del dropdown */
        .select2-container--default .select2-selection--single .select2-selection__arrow {
            height: 40px;
            right: 8px;
        }

        .select2-container--default .select2-selection--single .select2-selection__arrow b {
            border-color: #666 transparent transparent transparent;
        }

        /* Placeholder */
        .select2-container--default .select2-selection--single .select2-selection__placeholder {
            color: #999;
        }

        /* Dropdown desplegado */
        .select2-dropdown {
            border: 1px solid #95B88F;
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        /* 🔹 ALTURA MÁXIMA Y SCROLL (4-5 opciones visibles) */
        .select2-results__options {
            max-height: 200px !important;
            overflow-y: auto;
        }

        /* Opciones individuales */
        .select2-container--default .select2-results__option {
            padding: 10px 12px;
            font-size: 14px;
        }

        /* Opción en hover */
        .select2-container--default .select2-results__option--highlighted[aria-selected] {
            background-color: #E8F4E5 !important;
            color: #333;
        }

        /* Opción seleccionada */
        .select2-container--default .select2-results__option[aria-selected="true"] {
            background-color: #95B88F !important;
            color: #fff;
        }

        /* Scrollbar personalizado */
        .select2-results__options::-webkit-scrollbar {
            width: 10px;
        }

        .select2-results__options::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 4px;
        }

        .select2-results__options::-webkit-scrollbar-thumb {
            background: #95B88F;
            border-radius: 4px;
        }

        .select2-results__options::-webkit-scrollbar-thumb:hover {
            background: #73866D;
        }

        /* Ancho del select2 */
        .select2-container {
            width: 100% !important;
        }

        /* ========================================
           🔹 ESTILOS DE PAGINACIÓN (SI SE AGREGAN GRIDVIEWS)
           ======================================== */
        
        /* Si agregas un GridView con paginación, descomenta estos estilos: */
        
        /*
        .custom-grid tr.pager-row td {
            padding: 20px 0;
            text-align: left;
            background-color: transparent !important;
            border: none !important;
        }

        .custom-grid .pager-row table {
            margin: 0;
            border-spacing: 5px;
            background-color: transparent !important;
        }

        .custom-grid .pager-row td a,
        .custom-grid .pager-row td span {
            display: inline-block;
            padding: 12px 16px;
            margin: 0 3px;
            border: 2px solid #95B88F;
            border-radius: 6px;
            background-color: #fff;
            color: #73866D;
            font-weight: 500;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.3s ease;
            width: 50px;
            height: 46px;
            text-align: center;
            box-sizing: border-box;
            line-height: 22px;
        }

        .custom-grid .pager-row td a:hover {
            background-color: #fff !important;
            color: #73866D;
            border-color: #73866D;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(115, 134, 109, 0.3);
        }

        .custom-grid .pager-row td span {
            background-color: #73866D !important;
            color: #fff !important;
            border-color: #73866D;
            font-weight: 600;
            box-shadow: 0 2px 6px rgba(115, 134, 109, 0.4);
        }

        .custom-grid .pager-row td a:first-child,
        .custom-grid .pager-row td a:last-child {
            background-color: #fff !important;
            color: #73866D;
            border-color: #95B88F;
            font-weight: 600;
            width: 80px;
            height: 46px;
            padding: 12px 10px;
        }

        .custom-grid .pager-row td a:first-child:hover,
        .custom-grid .pager-row td a:last-child:hover {
            background-color: #fff !important;
            color: #73866D;
            border-color: #73866D;
            box-shadow: 0 4px 8px rgba(115, 134, 109, 0.3);
        }

        .custom-grid .pager-row td a:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(115, 134, 109, 0.2);
        }

        .custom-grid .pager-row td a:first-child::before,
        .custom-grid .pager-row td a:last-child::after {
            content: "";
        }

        .custom-grid tr.pager-row {
            background-color: transparent !important;
        }

        .custom-grid tr.pager-row:hover {
            background-color: transparent !important;
        }
        */
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="top-accent"></div>

        <!-- Header con título -->
        <div class="row">
            <div class="col-md-6 p-0">
                <div class="header-title">
                    <div class="title-section">
                        <h2>Registrar Movimiento</h2>
                    </div>
                    <div class="color-bar bar-1"></div>
                    <div class="color-bar bar-2"></div>
                </div>
            </div>
        </div>

        <!-- Formulario -->
        <div class="row">
            <div class="col-md-12">
                <div class="form-container">
                    <!-- Fila 1: Lugar Destino y Lugar Origen -->
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <label class="form-label">
                                Lugar de Destino <span class="required">(*)</span>
                            </label>
                            <asp:DropDownList ID="ddlLugarDestino" runat="server" CssClass="form-select">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvLugarDestino" runat="server"
                                ControlToValidate="ddlLugarDestino"
                                InitialValue="0"
                                ErrorMessage="El lugar de destino es obligatorio"
                                CssClass="text-danger"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">
                                Lugar de Origen <span class="required">(*)</span>
                            </label>
                            <asp:DropDownList ID="ddlLugarOrigen" runat="server" CssClass="form-select">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvLugarOrigen" runat="server"
                                ControlToValidate="ddlLugarOrigen"
                                InitialValue="0"
                                ErrorMessage="El lugar de origen es obligatorio"
                                CssClass="text-danger"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <!-- Fila 2: Fecha del Traslado y Tipo -->
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <label class="form-label">
                                Fecha del Traslado <span class="required">(*)</span>
                            </label>
                            <asp:TextBox ID="txtFechaTraslado" runat="server"
                                CssClass="form-control form-control-short"
                                TextMode="Date">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFechaTraslado" runat="server"
                                ControlToValidate="txtFechaTraslado"
                                ErrorMessage="La fecha es obligatoria"
                                CssClass="text-danger"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">
                                Tipo <span class="required">(*)</span>
                            </label>
                            <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-select-tipo">
                                <asp:ListItem Value="0">-- Seleccione un tipo --</asp:ListItem>
                                <asp:ListItem Value="Entrada">Entrada</asp:ListItem>
                                <asp:ListItem Value="Salida">Salida</asp:ListItem>
                                <asp:ListItem Value="Mov.Interno">Mov. Interno</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvTipo" runat="server"
                                ControlToValidate="ddlTipo"
                                InitialValue="0"
                                ErrorMessage="Debe seleccionar un tipo"
                                CssClass="text-danger"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <!-- Botones -->
                    <div class="row button-group">
                        <div class="col-md-6">
                            <asp:LinkButton ID="lkCancelar" runat="server"
                                CssClass="btn-secondary-custom"
                                OnClick="lkCancelar_Click"
                                CausesValidation="false"
                                Text="Cancelar">
                            </asp:LinkButton>
                        </div>
                        <div class="col-md-6 text-end">
                            <asp:LinkButton ID="lkRegistrar" runat="server"
                                CssClass="btn-custom"
                                OnClick="lkRegistrar_Click"
                                Text="Registrar">
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <!-- jQuery (requerido por Select2) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Select2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            // Inicializar Select2 en Lugar de Destino
            $('#<%= ddlLugarDestino.ClientID %>').select2({
                placeholder: "-- Seleccione lugar de destino --",
                allowClear: false,
                width: '100%',
                language: {
                    noResults: function () {
                        return "No se encontraron resultados";
                    }
                }
            });

            // Inicializar Select2 en Lugar de Origen
            $('#<%= ddlLugarOrigen.ClientID %>').select2({
                placeholder: "-- Seleccione lugar de origen --",
                allowClear: false,
                width: '100%',
                language: {
                    noResults: function() {
                        return "No se encontraron resultados";
                    }
                }
            });

            // Inicializar Select2 en Tipo (también con scroll)
            $('#<%= ddlTipo.ClientID %>').select2({
                placeholder: "-- Seleccione un tipo --",
                allowClear: false,
                width: '100%',
                minimumResultsForSearch: Infinity, // Deshabilitar búsqueda para pocos elementos
                language: {
                    noResults: function () {
                        return "No se encontraron resultados";
                    }
                }
            });
        });
    </script>
</asp:Content>
