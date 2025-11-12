<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="ListarAlmacenes.aspx.cs" Inherits="WearDropWA.ListarAlmacenes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Listar Almacenes
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
            flex: 1.5;
        }

        .bar-2 {
            flex: 1.5;
        }

        .top-accent {
            height: 4px;
            margin-top: 10px;
            border-radius: 4px;
        }

        /* ------- GridView Personalizado ------- */
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
            background: var(--c1);
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

        /* ------- Botones ------- */
        a, a:visited, a:hover, a:active, .btn-wd {
            text-decoration: none !important;
            color: inherit;
        }

        .btn-wd {
            background: var(--btn);
            color: #fff;
            border: none;
            padding: 8px 18px;
            border-radius: 8px;
            cursor: pointer;
            display: inline-block;
            transition: .15s;
            box-shadow: 0 1px 2px rgba(0,0,0,.08);
        }

        .btn-wd:hover {
            filter: brightness(.95);
        }

        .btn-wd:active {
            transform: translateY(1px);
        }

        /* ------- Tema de Almacenes ------- */
        .theme-almacenes {
            --tone-1: #C5D9C0;
            --tone-2: #95B88F;
            --tone-3: #73866D;
        }

        .theme-scope .bar-1 {
            background: var(--tone-1);
        }

        .theme-scope .bar-2 {
            background: var(--tone-2);
        }

        .theme-scope .custom-grid th {
            background: var(--tone-2) !important;
            color: #333;
        }

        .theme-scope .btn-wd {
            background: var(--tone-3);
            color: #fff;
        }

        .theme-scope .btn-wd:hover {
            filter: brightness(.95);
        }

        .theme-scope .top-accent {
            background: linear-gradient(90deg, var(--tone-1), var(--tone-2), var(--tone-3));
        }

        /* ------- Botones de Acción en GridView ------- */
        .action-btns i {
            font-size: 1.1em;
        }

        .btn-sm {
            padding: 4px 8px !important;
            margin-right: 4px;
        }

        /* ------- Modal de Confirmación ------- */
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
            border-color: #95B88F;
            color: #73866D;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-secondary-custom:active {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="theme-almacenes">
        <div class="theme-scope">
            <div class="container">
                <div class="top-accent"></div>

                <div class="container row">
                    <div class="row align-items-center">
                        <div class="col-md-6 p-0">
                            <div class="header-title">
                                <div class="title-section">
                                    <h2>Gestionar Almacenes</h2>
                                </div>
                                <div class="color-bar bar-1"></div>
                                <div class="color-bar bar-2"></div>
                            </div>
                        </div>
                        <div class="col text-end p-3">
                            <asp:LinkButton ID="lkRegistrar" CssClass="btn-wd" runat="server" OnClick="lkRegistrar_Click" Text="Registrar Almacén" />
                        </div>
                    </div>
                </div>

                <div class="container row mt-3">
                    <asp:GridView ID="gvAlmacenes" runat="server" 
                        AutoGenerateColumns="false" 
                        ShowHeaderWhenEmpty="True"
                        EmptyDataText="No hay almacenes disponibles"
                        CssClass="table table-hover table-striped custom-grid"
                        GridLines="None">
                        <Columns>
                            <asp:BoundField HeaderText="ID" DataField="Id" />
                            <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                            <asp:BoundField HeaderText="Ubicación" DataField="Ubicacion" />
                            <asp:BoundField HeaderText="Stock" DataField="Stock" />
                            
                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <div class="action-btns">
                                        <asp:LinkButton ID="btnVisualizar" runat="server"
                                            CssClass="btn btn-sm btn-outline-success"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClick="btnVisualizar_Click"
                                            ToolTip="Visualizar">
                                            <i class="fa fa-eye"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnModificar" runat="server"
                                            CssClass="btn btn-sm btn-outline-primary"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClick="btnModificar_Click"
                                            ToolTip="Editar">
                                            <i class="fa fa-pencil"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnEliminar" runat="server"
                                            CssClass="btn btn-sm btn-outline-danger"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClientClick='<%# "return mostrarModal(" + Eval("Id") + ", \"" + Eval("Nombre") + "\");" %>'
                                            ToolTip="Eliminar">
                                            <i class="fa fa-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de Confirmación de Eliminación -->
    <div id="modalEliminar" class="modal-overlay">
        <div class="modal-content">
            <h3 class="modal-title">¿Está seguro de eliminar este almacén?</h3>
            <div class="modal-body">
                <div class="info-field">
                    <div class="info-label">Nombre del Almacén:</div>
                    <div class="info-value" id="modalNombre"></div>
                </div>
            </div>
            <div class="modal-buttons">
                <asp:Button ID="btnConfirmarEliminar" runat="server" 
                    CssClass="btn-eliminar" 
                    Text="Eliminar" 
                    OnClick="btnConfirmarEliminar_Click" />
                <button type="button" class="btn btn-secondary-custom" onclick="cerrarModal()">Cancelar</button>
            </div>
            <asp:HiddenField ID="hfIdAlmacenEliminar" runat="server" />
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
        function mostrarModal(idAlmacen, nombre) {
            document.getElementById('modalNombre').innerText = nombre;
            document.getElementById('<%= hfIdAlmacenEliminar.ClientID %>').value = idAlmacen;
            document.getElementById('modalEliminar').style.display = 'flex';
            return false; // Evita postback hasta confirmar
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
