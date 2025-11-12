<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="MostrarAlmacen.aspx.cs" Inherits="WearDropWA.MostrarAlmacen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Mostrar Almacén
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

        /* ------- Info del Almacén ------- */
        .info-section {
            margin-bottom: 20px;
        }

        .info-label {
            font-weight: 500;
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
            display: block;
        }

        .info-input {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 15px;
            color: #333;
            background-color: #f8f9fa;
            cursor: default;
        }

        .info-input:focus {
            outline: none;
            border-color: #95B88F;
            background-color: #fff;
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

        /* ------- Pestañas ------- */
        .nav-tabs {
            border-bottom: 2px solid #95B88F;
            margin-bottom: 20px;
            margin-top: 20px;
        }

        .nav-link {
            color: #73866D;
            border: none;
            padding: 10px 20px;
            margin-right: 5px;
            background-color: transparent;
            text-decoration: none;
            cursor: pointer;
            display: inline-block;
            transition: .15s;
        }

        .nav-link:hover {
            color: #73866D;
            background-color: #f8f9fa;
        }

        .nav-link.active {
            color: #333;
            background-color: #95B88F;
            border-radius: 4px 4px 0 0;
            font-weight: 500;
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

        /* Asegurar que las celdas de acciones tengan altura uniforme */
        .custom-grid td {
            padding: 12px 20px;
            border-bottom: 1px solid #E8E8E8;
            vertical-align: middle;
        }

        /* ------- 🔹 PAGINACIÓN MEJORADA 🔹 ------- */
        .custom-grid tr.pager-row td {
            padding: 20px 0;
            text-align: left;
            background-color: transparent !important;
            border: none !important;
        }

        /* Contenedor de paginación alineado a la izquierda */
        .custom-grid .pager-row table {
            margin: 0;
            border-spacing: 5px;
            background-color: transparent !important;
        }

        /* Estilo general de los enlaces de paginación - MISMO TAMAÑO PARA TODOS */
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
            width: 50px; /* ✅ Mismo ancho para todos */
            height: 46px; /* ✅ Misma altura para todos */
            text-align: center;
            box-sizing: border-box;
            line-height: 22px;
        }

            /* Hover en enlaces de paginación */
            .custom-grid .pager-row td a:hover {
                background-color: #fff !important;
                color: #73866D;
                border-color: #73866D;
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(115, 134, 109, 0.3);
            }

        /* Página actual (activa) */
        .custom-grid .pager-row td span {
            background-color: #73866D !important;
            color: #fff !important;
            border-color: #73866D;
            font-weight: 600;
            box-shadow: 0 2px 6px rgba(115, 134, 109, 0.4);
        }

        /* Botones "Primera" y "Última" - MISMO TAMAÑO Y SIN FLECHAS */
        .custom-grid .pager-row td a:first-child,
        .custom-grid .pager-row td a:last-child {
            background-color: #fff !important;
            color: #73866D;
            border-color: #95B88F;
            font-weight: 600;
            width: 80px; /* ✅ Ancho ligeramente mayor para el texto */
            height: 46px; /* ✅ Misma altura */
            padding: 12px 10px;
        }

            .custom-grid .pager-row td a:first-child:hover,
            .custom-grid .pager-row td a:last-child:hover {
                background-color: #fff !important;
                color: #73866D;
                border-color: #73866D;
                box-shadow: 0 4px 8px rgba(115, 134, 109, 0.3);
            }

        /* Efecto active (al hacer clic) */
        .custom-grid .pager-row td a:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(115, 134, 109, 0.2);
        }

        /* 🔹 ELIMINAR LAS FLECHAS « » DE "Primera" Y "Última" 🔹 */
        .custom-grid .pager-row td a:first-child::before,
        .custom-grid .pager-row td a:last-child::after {
            content: ""; /* ✅ Sin contenido = sin flechas */
        }

        /* 🔹 ELIMINAR FONDO VERDE DE LA FILA DE PAGINACIÓN 🔹 */
        .custom-grid tr.pager-row {
            background-color: transparent !important;
        }

            .custom-grid tr.pager-row:hover {
                background-color: transparent !important;
            }


        /* ------- Modal ------- */
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

        .modal-content {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            max-width: 600px;
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

        .info-row {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
        }

        .info-field {
            flex: 1;
        }

        .info-field-full {
            width: 100%;
            margin-bottom: 15px;
        }

        .modal-body .info-label {
            font-weight: 500;
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .modal-body .info-value {
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
            border-color: #95B88F;
            color: #73866D;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-secondary-custom:active {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* ------- Botón Retroceder ------- */
        .btn-retroceder {
            background-color: #FFFFFF;
            color: #333;
            border: 2px solid #ddd;
            padding: 10px 30px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            box-shadow: 0 1px 2px rgba(0,0,0,.08);
        }

        .btn-retroceder:hover {
            background-color: #f8f9fa;
            border-color: #95B88F;
            color: #73866D;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-decoration: none;
        }

        .btn-retroceder:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .btn-retroceder:focus {
            text-decoration: none;
        }

        .button-retroceder-container {
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
                        <h2>Gestionar Almacenes</h2>
                    </div>
                    <div class="color-bar bar-1"></div>
                    <div class="color-bar bar-2"></div>
                </div>
            </div>
        </div>

        <!-- Información del Almacén -->
        <div class="row mb-2 mt-3">
            <div class="col-md-2">
                <div class="info-section">
                    <label class="info-label">ID</label>
                    <asp:TextBox ID="txtId" runat="server" CssClass="info-input" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-5">
                <div class="info-section">
                    <label class="info-label">Nombre</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="info-input" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-5">
                <div class="info-section">
                    <label class="info-label">Ubicación</label>
                    <asp:TextBox ID="txtUbicacion" runat="server" CssClass="info-input" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
        </div>

        <!-- Botones de acción -->
        <div class="row">
            <div class="col-md-12">
                <asp:LinkButton ID="lkRegistrar" runat="server" CssClass="btn-wd" OnClick="lkRegistrar_Click" Text="Registrar" />
                <asp:LinkButton ID="lkFiltrar" runat="server" CssClass="btn-wd" OnClick="lkFiltrar_Click" Text="Filtrar" />
            </div>
        </div>

        <!-- Pestañas de navegación -->
        <ul class="nav nav-tabs">
            <li class="nav-item">
                <asp:LinkButton ID="tabLotes" runat="server" CssClass="nav-link active" OnClick="tabLotes_Click" Text="Lotes" />
            </li>
            <li class="nav-item">
                <asp:LinkButton ID="tabMovimientos" runat="server" CssClass="nav-link" OnClick="tabMovimientos_Click" Text="Movimientos" />
            </li>
            <li class="nav-item">
                <asp:LinkButton ID="tabMovimientosXLotes" runat="server" CssClass="nav-link" OnClick="tabMovimientosXLotes_Click" Text="Movimientos X Lotes" />
            </li>
        </ul>

        <!-- Panel de Lotes -->
        <asp:Panel ID="panelLotes" runat="server" Visible="true">
            <asp:GridView ID="gvLotes" runat="server"
                AutoGenerateColumns="false"
                ShowHeaderWhenEmpty="True"
                EmptyDataText="No hay lotes disponibles"
                CssClass="table table-hover custom-grid"
                AllowPaging="true"
                PageSize="5"
                OnPageIndexChanging="gvLotes_PageIndexChanging"
                GridLines="None">
                <Columns>
                    <asp:BoundField HeaderText="ID Lote" DataField="IdLote" />
                    <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="action-btns">
                                <asp:LinkButton ID="btnModificarLote" runat="server"
                                    CssClass="btn btn-sm btn-outline-primary"
                                    CommandArgument='<%# Eval("IdLote") %>'
                                    OnClick="btnModificarLote_Click"
                                    ToolTip="Editar">
                                    <i class="fa fa-pencil"></i>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnEliminarLote" runat="server"
                                    CssClass="btn btn-sm btn-outline-danger"
                                    CommandArgument='<%# Eval("IdLote") %>'
                                    OnClientClick='<%# "return mostrarModalLote(" + Eval("IdLote") + ", \"" + Eval("Descripcion") + "\");" %>'
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
        </asp:Panel>

        <!-- Panel de Movimientos -->
        <asp:Panel ID="panelMovimientos" runat="server" Visible="false">
            <asp:GridView ID="gvMovimientos" runat="server"
                AutoGenerateColumns="false"
                ShowHeaderWhenEmpty="True"
                EmptyDataText="No hay movimientos disponibles"
                CssClass="table table-hover custom-grid"
                AllowPaging="true"
                PageSize="5"
                OnPageIndexChanging="gvMovimientos_PageIndexChanging"
                GridLines="None">
                <Columns>
                    <asp:BoundField HeaderText="ID" DataField="IdMovimiento" />
                    <asp:BoundField HeaderText="Tipo" DataField="Tipo" />
                    <asp:BoundField HeaderText="Origen" DataField="LugarOrigen" />
                    <asp:BoundField HeaderText="Destino" DataField="LugarDestino" />
                    <asp:BoundField HeaderText="Fecha" DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="action-btns">
                                <asp:LinkButton ID="btnModificarMovimiento" runat="server"
                                    CssClass="btn btn-sm btn-outline-primary"
                                    CommandArgument='<%# Eval("IdMovimiento") %>'
                                    OnClick="btnModificarMovimiento_Click"
                                    ToolTip="Editar">
                                    <i class="fa fa-pencil"></i>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnEliminarMovimiento" runat="server"
                                    CssClass="btn btn-sm btn-outline-danger"
                                    CommandArgument='<%# Eval("IdMovimiento") %>'
                                    OnClientClick='<%# "return mostrarModalMovimiento(" + Eval("IdMovimiento") + ", \"" + Eval("LugarOrigen") + "\", \"" + Eval("LugarDestino") + "\", \"" + Eval("Tipo") + "\", \"" + Eval("Fecha", "{0:dd/MM/yyyy}") + "\");" %>'
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
        </asp:Panel>

        <!-- Panel de Movimientos X Lotes -->
        <asp:Panel ID="panelMovimientosXLotes" runat="server" Visible="false">
            <asp:GridView ID="gvMovimientosXLotes" runat="server"
                AutoGenerateColumns="false"
                ShowHeaderWhenEmpty="True"
                EmptyDataText="No hay movimientos por lotes disponibles"
                CssClass="table table-hover custom-grid"
                AllowPaging="true"
                PageSize="5"
                OnPageIndexChanging="gvMovimientosXLotes_PageIndexChanging"
                GridLines="None">
                <Columns>
                    <asp:BoundField HeaderText="ID Mov" DataField="datMov.IdMovimiento" />
                    <asp:BoundField HeaderText="Tipo" DataField="datMov.Tipo" />
                    <asp:BoundField HeaderText="Origen" DataField="datMov.LugarOrigen" />
                    <asp:BoundField HeaderText="Destino" DataField="datMov.LugarDestino" />
                    <asp:BoundField HeaderText="ID Lote" DataField="datLote.IdLote" />
                    <asp:BoundField HeaderText="Descripción Lote" DataField="datLote.Descripcion" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <div class="action-btns">
                                <asp:LinkButton ID="btnModificarMovimientoXLote" runat="server"
                                    CssClass="btn btn-sm btn-outline-primary"
                                    CommandArgument='<%# Eval("idMov_X_Lote") %>'
                                    OnClick="btnModificarMovimientoXLote_Click"
                                    ToolTip="Editar">
                                    <i class="fa fa-pencil"></i>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnEliminarMovimientoXLote" runat="server"
                                    CssClass="btn btn-sm btn-outline-danger"
                                    CommandArgument='<%# Eval("idMov_X_Lote") %>'
                                    OnClientClick='<%# "return mostrarModalMovimientoXLote(" + Eval("datMov.IdMovimiento") + ", \"" + Eval("datMov.LugarOrigen") + "\", \"" + Eval("datMov.LugarDestino") + "\", \"" + Eval("datMov.Tipo") + "\", \"Fecha\", \"" + Eval("datLote.Descripcion") + "\");" %>'
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
        </asp:Panel>

        <!-- Botón Retroceder -->
        <div class="row button-retroceder-container">
            <div class="col-md-12">
                <asp:LinkButton ID="lkRetroceder" runat="server"
                    CssClass="btn-retroceder"
                    OnClick="lkRetroceder_Click"
                    Text="← Retroceder">
                </asp:LinkButton>
            </div>
        </div>
    </div>

    <!-- Modal de Confirmación de Eliminación -->
    <div id="modalEliminar" class="modal-overlay">
        <div class="modal-content">
            <h3 class="modal-title">¿Está seguro de eliminar este registro?</h3>
            <div class="modal-body" id="modalBodyContent">
                <!-- El contenido se generará dinámicamente según la pestaña -->
            </div>
            <div class="modal-buttons">
                <asp:Button ID="btnConfirmarEliminar" runat="server"
                    CssClass="btn-eliminar"
                    Text="Eliminar"
                    OnClick="btnConfirmarEliminar_Click" />
                <button type="button" class="btn btn-secondary-custom" onclick="cerrarModal()">Cancelar</button>
            </div>
            <asp:HiddenField ID="hfIdEliminar" runat="server" />
            <asp:HiddenField ID="hfTipoEliminar" runat="server" />
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
        function mostrarModalLote(idLote, descripcion) {
            var modalBody = document.getElementById('modalBodyContent');
            modalBody.innerHTML = `
                <div class="info-field-full">
                    <div class="info-label">Descripción:</div>
                    <div class="info-value">${descripcion}</div>
                </div>
            `;

            document.getElementById('<%= hfIdEliminar.ClientID %>').value = idLote;
            document.getElementById('<%= hfTipoEliminar.ClientID %>').value = 'Lote';
            document.getElementById('modalEliminar').style.display = 'flex';
            return false;
        }

        function mostrarModalMovimiento(idMovimiento, lugarOrigen, lugarDestino, tipo, fecha) {
            var modalBody = document.getElementById('modalBodyContent');
            modalBody.innerHTML = `
                <div class="info-row">
                    <div class="info-field">
                        <div class="info-label">Lugar Origen:</div>
                        <div class="info-value">${lugarOrigen}</div>
                    </div>
                    <div class="info-field">
                        <div class="info-label">Tipo:</div>
                        <div class="info-value">${tipo}</div>
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-field">
                        <div class="info-label">Lugar Destino:</div>
                        <div class="info-value">${lugarDestino}</div>
                    </div>
                    <div class="info-field">
                        <div class="info-label">Fecha:</div>
                        <div class="info-value">${fecha}</div>
                    </div>
                </div>
            `;

            document.getElementById('<%= hfIdEliminar.ClientID %>').value = idMovimiento;
            document.getElementById('<%= hfTipoEliminar.ClientID %>').value = 'Movimiento';
            document.getElementById('modalEliminar').style.display = 'flex';
            return false;
        }

        function mostrarModalMovimientoXLote(idMovimiento, lugarOrigen, lugarDestino, tipo, fecha, descripcionLote) {
            var modalBody = document.getElementById('modalBodyContent');
            modalBody.innerHTML = `
                <div class="info-row">
                    <div class="info-field">
                        <div class="info-label">Lugar Origen:</div>
                        <div class="info-value">${lugarOrigen}</div>
                    </div>
                    <div class="info-field">
                        <div class="info-label">Lugar Destino:</div>
                        <div class="info-value">${lugarDestino}</div>
                    </div>
                </div>
                <div class="info-row">
                    <div class="info-field">
                        <div class="info-label">Fecha:</div>
                        <div class="info-value">${fecha}</div>
                    </div>
                    <div class="info-field">
                        <div class="info-label">Tipo:</div>
                        <div class="info-value">${tipo}</div>
                    </div>
                </div>
                <div class="info-field-full">
                    <div class="info-label">Descripción del Lote:</div>
                    <div class="info-value">${descripcionLote}</div>
                </div>
            `;

            document.getElementById('<%= hfIdEliminar.ClientID %>').value = idMovimiento;
            document.getElementById('<%= hfTipoEliminar.ClientID %>').value = 'MovimientoXLote';
            document.getElementById('modalEliminar').style.display = 'flex';
            return false;
        }

        function cerrarModal() {
            document.getElementById('modalEliminar').style.display = 'none';
        }

        // Cerrar modal si se hace clic fuera de él
        window.onclick = function (event) {
            var modal = document.getElementById('modalEliminar');
            if (event.target == modal) {
                cerrarModal();
            }
        }
    </script>
</asp:Content>
