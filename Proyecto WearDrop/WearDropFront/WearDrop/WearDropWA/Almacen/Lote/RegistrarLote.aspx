<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarLote.aspx.cs" Inherits="WearDropWA.RegistrarLote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Lote
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <!-- 🔹 Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    
    <style>
        /* ------- Layout Base ------- */
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            margin-top: 14px;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 20px;
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

        /* ------- Info Section ------- */
        .info-section {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .info-label {
            font-weight: 500;
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
            display: block;
        }

        .info-value {
            color: #333;
            font-size: 15px;
        }

        /* 🔹 Sección de Descripción del Lote */
        .description-section {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            margin-bottom: 25px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        .description-label {
            font-weight: 600;
            color: #333;
            font-size: 15px;
            margin-bottom: 10px;
            display: block;
        }

        .required {
            color: #dc3545;
        }

        .form-control-desc {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            color: #333;
            background-color: #fff;
            resize: vertical;
            min-height: 90px;
            max-height: 180px;
            font-family: inherit;
            transition: border-color 0.3s ease;
        }

        .form-control-desc:focus {
            border-color: #95B88F;
            box-shadow: 0 0 0 3px rgba(149, 184, 143, 0.1);
            outline: none;
        }

        .form-control-desc::placeholder {
            color: #999;
            font-style: italic;
        }

        .text-danger {
            color: #dc3545;
            font-size: 13px;
            margin-top: 5px;
            display: block;
        }

        /* ------- Botones ------- */
        a, a:visited, a:hover, a:active, .btn-wd {
            text-decoration: none !important;
            color: inherit;
        }

        .btn-wd {
            background: #73866D;
            color: #fff;
            border: none;
            padding: 8px 18px;
            border-radius: 8px;
            cursor: pointer;
            display: inline-block;
            transition: .15s;
            box-shadow: 0 1px 2px rgba(0,0,0,.08);
            margin-right: 10px;
        }

        .btn-wd:hover {
            filter: brightness(.95);
        }

        .btn-wd:active {
            transform: translateY(1px);
        }

        /* ------- GridView ------- */
        .custom-grid {
            border-collapse: collapse;
            width: 100%;
        }

        .custom-grid th {
            color: #333;
            font-weight: 500;
            padding: 15px 20px;
            text-align: left;
            border: none;
            background: #95B88F !important;
        }

        .custom-grid td {
            padding: 12px 20px;
            border-bottom: 1px solid #E8E8E8;
            vertical-align: middle;
        }

        .custom-grid tr:nth-child(even) {
            background: #F5F5F5;
        }

        .custom-grid tr:hover {
            background: #E8F4E5;
        }

        /* ------- Botones de Acción en GridView ------- */
        .action-btns {
            display: flex;
            gap: 8px;
            align-items: center;
            justify-content: flex-start;
        }

        .action-btns i {
            font-size: 1.1em;
        }

        .btn-sm {
            padding: 4px 8px !important;
            margin: 0 !important;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 32px;
            min-height: 32px;
        }

        /* ------- 🔹 PAGINACIÓN MEJORADA 🔹 ------- */
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

        /* ------- Dropdown Container ------- */
        .dropdown-container {
            position: relative;
            width: 100%;
        }

        /* ------- Botones Principales ------- */
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
            margin-top: 30px;
            margin-bottom: 30px;
        }

        /* 🔹 ------- PERSONALIZACIÓN DE SELECT2 ------- */
        
        .select2-container--default .select2-selection--single {
            height: 38px;
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

        .select2-container--default .select2-selection--single .select2-selection__rendered {
            line-height: 36px;
            padding-left: 12px;
            color: #333;
            font-size: 14px;
        }

        .select2-container--default .select2-selection--single .select2-selection__arrow {
            height: 36px;
            right: 8px;
        }

        .select2-container--default .select2-selection--single .select2-selection__arrow b {
            border-color: #666 transparent transparent transparent;
        }

        .select2-container--default .select2-selection--single .select2-selection__placeholder {
            color: #999;
        }

        .select2-dropdown {
            border: 1px solid #95B88F;
            border-radius: 4px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .select2-results__options {
            max-height: 200px !important;
            overflow-y: auto;
        }

        .select2-container--default .select2-results__option {
            padding: 10px 12px;
            font-size: 14px;
        }

        .select2-container--default .select2-results__option--highlighted[aria-selected] {
            background-color: #E8F4E5 !important;
            color: #333;
        }

        .select2-container--default .select2-results__option[aria-selected="true"] {
            background-color: #95B88F !important;
            color: #fff;
        }

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

        .select2-search--dropdown .select2-search__field {
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 6px 10px;
            font-size: 14px;
        }

        .select2-search--dropdown .select2-search__field:focus {
            border-color: #95B88F;
            outline: none;
        }

        .select2-container {
            max-width: 600px;
        }
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
                        <h2>Registrar Lote</h2>
                    </div>
                    <div class="color-bar bar-1"></div>
                    <div class="color-bar bar-2"></div>
                </div>
            </div>
        </div>

        <!-- Información del contexto -->
        <div class="row mb-3 mt-3">
            <div class="col-md-2">
                <div class="info-section">
                    <div class="info-label">Almacén</div>
                    <div class="info-value">
                        <asp:Label ID="lblNombreAlmacen" runat="server" Text=""></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="info-section">
                    <div class="info-label">ID Movimiento</div>
                    <div class="info-value">
                        <div class="dropdown-container">
                            <asp:DropDownList ID="ddlIdMovimiento" runat="server"
                                CssClass="form-select"
                                AutoPostBack="true"
                                OnSelectedIndexChanged="ddlIdMovimiento_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="info-section">
                    <div class="info-label">Lugar Origen</div>
                    <div class="info-value">
                        <asp:Label ID="lblLugarOrigen" runat="server" Text="-"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="info-section">
                    <div class="info-label">Lugar Destino</div>
                    <div class="info-value">
                        <asp:Label ID="lblLugarDestino" runat="server" Text="-"></asp:Label>
                    </div>
                </div>
            </div>
        </div>

        <!-- Descripción del Lote (Obligatoria) -->
        <div class="row">
            <div class="col-md-12">
                <div class="description-section">
                    <label class="description-label">
                        <i class="fa fa-file-text-o" style="margin-right: 8px;"></i>
                        Descripción del Lote <span class="required">(*)</span>
                    </label>
                    <asp:TextBox ID="txtDescripcionLote" runat="server"
                        CssClass="form-control-desc"
                        TextMode="MultiLine"
                        placeholder="Ingrese una descripción detallada del lote..."
                        MaxLength="500">
                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDescripcionLote" runat="server"
                        ControlToValidate="txtDescripcionLote"
                        ErrorMessage="La descripción del lote es obligatoria"
                        CssClass="text-danger"
                        Display="Dynamic">
                    </asp:RequiredFieldValidator>
                </div>
            </div>
        </div>

        <!-- Botones de filtro -->
        <div class="row mb-3">
            <div class="col-md-12">
                <asp:Button ID="btnAñadirPrenda" runat="server"
                    CssClass="btn-wd"
                    Text="Añadir Prenda"
                    OnClick="btnAniadirPrenda_Click" />
                <asp:Button ID="btnFiltroPrenda" runat="server"
                    CssClass="btn-wd"
                    Text="Filtro Prenda"
                    OnClick="btnFiltroPrenda_Click" />
            </div>
        </div>

        <!-- GridView de Prendas -->
        <div class="row">
            <div class="col-md-12">
                <asp:GridView ID="gvPrendas" runat="server"
                    AutoGenerateColumns="false"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="No hay prendas disponibles"
                    CssClass="table table-hover custom-grid"
                    AllowPaging="true"
                    PageSize="5"
                    OnPageIndexChanging="gvPrendas_PageIndexChanging"
                    GridLines="None">
                    <Columns>
                        <asp:BoundField HeaderText="ID" DataField="IdPrenda" />
                        <asp:BoundField HeaderText="Nombre" DataField="NombrePrenda" />
                        <asp:BoundField HeaderText="Color" DataField="Color" />
                        <asp:BoundField HeaderText="Material" DataField="Material" />
                        <asp:BoundField HeaderText="Stock" DataField="Stock" />
                        <asp:BoundField HeaderText="Talla" DataField="Talla" />
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <div class="action-btns">
                                    <asp:LinkButton ID="btnAgregar" runat="server"
                                        CssClass="btn btn-sm btn-outline-success"
                                        CommandArgument='<%# Eval("IdPrenda") %>'
                                        OnClick="btnAgregar_Click"
                                        ToolTip="Agregar">
                                        <i class="fa fa-plus"></i>
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnQuitar" runat="server"
                                        CssClass="btn btn-sm btn-outline-danger"
                                        CommandArgument='<%# Eval("IdPrenda") %>'
                                        OnClick="btnQuitar_Click"
                                        ToolTip="Quitar">
                                        <i class="fa fa-trash"></i>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerSettings Mode="NumericFirstLast" FirstPageText="Primera" LastPageText="Última" />
                    <PagerStyle CssClass="pager-row" HorizontalAlign="Center" />
                </asp:GridView>
            </div>
        </div>

        <!-- Botones principales -->
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
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <!-- jQuery (requerido por Select2) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Select2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            // Inicializar Select2 en el dropdown
            $('#<%= ddlIdMovimiento.ClientID %>').select2({
                placeholder: "--Seleccione un movimiento--",
                allowClear: false,
                width: '100%',
                language: {
                    noResults: function() {
                        return "No se encontraron resultados";
                    }
                }
            });
            
            // Mantener el AutoPostBack funcionando
            $('#<%= ddlIdMovimiento.ClientID %>').on('select2:select', function (e) {
                __doPostBack('<%= ddlIdMovimiento.UniqueID %>', '');
            });
        });
    </script>
</asp:Content>
