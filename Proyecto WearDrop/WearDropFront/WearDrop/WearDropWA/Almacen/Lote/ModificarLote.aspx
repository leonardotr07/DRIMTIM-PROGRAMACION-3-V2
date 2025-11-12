<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="ModificarLote.aspx.cs" Inherits="WearDropWA.ModificarLote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Modificar Lote
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
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

        /* ------- Form Controls ------- */
        .form-control {
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            width: 100%;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #95B88F;
            box-shadow: 0 0 0 3px rgba(149, 184, 143, 0.1);
            outline: none;
        }

        .form-control::placeholder {
            color: #999;
        }

        .form-control-desc {
            resize: vertical;
            min-height: 80px;
            max-height: 200px;
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
                        <h2>Modificar Lote</h2>
                    </div>
                    <div class="color-bar bar-1"></div>
                    <div class="color-bar bar-2"></div>
                </div>
            </div>
        </div>

        <!-- Información del contexto -->
        <div class="row mt-3">
            <div class="col-md-3">
                <div class="info-section">
                    <div class="info-label">Nombre del Almacén</div>
                    <div class="info-value">
                        <asp:Label ID="lblNombreAlmacen" runat="server" Text="-"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <div class="info-section">
                    <div class="info-label">Descripción del Lote</div>
                    <div class="info-value">
                        <asp:TextBox ID="txtDescripcionLote" runat="server"
                            CssClass="form-control form-control-desc"
                            TextMode="MultiLine"
                            Rows="3"
                            placeholder="Ingrese la descripción del lote"
                            MaxLength="500">
                        </asp:TextBox>
                    </div>
                </div>
            </div>
        </div>

        <!-- Botones de filtro -->
        <div class="row mb-3">
            <div class="col-md-12">
                <asp:Button ID="btnAñadirPrenda" runat="server"
                    CssClass="btn-wd"
                    Text="Añadir Prenda"
                    OnClick="btnAñadirPrenda_Click" />
                <asp:Button ID="btnFiltrarPrenda" runat="server"
                    CssClass="btn-wd"
                    Text="Filtrar Prenda"
                    OnClick="btnFiltrarPrenda_Click" />
            </div>
        </div>

        <!-- GridView de Prendas -->
        <div class="row">
            <div class="col-md-12">
                <asp:GridView ID="gvPrendas" runat="server"
                    AutoGenerateColumns="false"
                    ShowHeaderWhenEmpty="True"
                    EmptyDataText="No hay prendas en este lote"
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
                                    <asp:LinkButton ID="btnModificar" runat="server"
                                        CssClass="btn btn-sm btn-outline-primary"
                                        CommandArgument='<%# Eval("IdPrenda") %>'
                                        OnClick="btnModificar_Click"
                                        ToolTip="Modificar">
                                        <i class="fa fa-pencil"></i>
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnEliminar" runat="server"
                                        CssClass="btn btn-sm btn-outline-danger"
                                        CommandArgument='<%# Eval("IdPrenda") %>'
                                        OnClick="btnEliminar_Click"
                                        OnClientClick="return confirm('¿Está seguro de eliminar esta prenda del lote?');"
                                        ToolTip="Eliminar">
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
                <asp:LinkButton ID="lkGuardar" runat="server"
                    CssClass="btn-custom"
                    OnClick="lkGuardar_Click"
                    Text="Guardar">
                </asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
        // Validación del formulario
        function validarFormulario() {
            var descripcion = document.getElementById('<%= txtDescripcionLote.ClientID %>').value.trim();

            if (descripcion === '') {
                alert('Por favor, ingrese una descripción para el lote');
                return false;
            }

            return true;
        }
    </script>
</asp:Content>
