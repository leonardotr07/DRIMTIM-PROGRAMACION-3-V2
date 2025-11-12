<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarRelacionMovimientoLote.aspx.cs" Inherits="WearDropWA.RegistrarRelacionMovimientoLote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Movimiento X Lote
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
            margin-bottom: 40px;
            border-radius: 10px;
            overflow: hidden;
        }

        .title-section {
            background: #fff;
            padding: 0 25px;
            display: flex;
            align-items: center;
            flex: 0 0 380px;
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
            margin-bottom: 30px;
            border-radius: 4px;
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

        .theme-scope .top-accent {
            background: linear-gradient(90deg, var(--tone-1), var(--tone-2), var(--tone-3));
        }

        /* ------- Contenedor Principal ------- */
        .section-container {
            width: 100%;
            margin-left: 0;
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        /* ------- Sección Principal (Movimiento / Lote) ------- */
        .main-section {
            background-color: #fff;
            border: 2px solid #dee2e6;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 3px 6px rgba(0,0,0,0.08);
        }

        /* ------- Título de Sección ------- */
        .section-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--tone-3);
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 2px solid var(--tone-2);
        }

        /* ------- Subsecciones internas ------- */
        .subsection {
            background-color: #fafafa;
            border: 1px solid #e8e8e8;
            border-radius: 6px;
            padding: 18px 20px;
            margin-bottom: 15px;
        }

        .subsection:last-child {
            margin-bottom: 0;
        }

        /* 🔹 Filas con dos columnas */
        .two-columns {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 30px;
            width: 100%;
        }

        /* 🔹 Una sola columna */
        .one-column {
            display: flex;
            flex-direction: column;
            width: 100%;
        }

        .field-block {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .field-block h3 {
            font-size: 0.95rem;
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }

        .required {
            color: #dc3545;
        }

        /* 🔹 TextBox */
        .form-control {
            width: 100%;
            max-width: 100%;
            text-align: left;
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            color: #333;
            background-color: #fff;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }

        .form-control-readonly {
            background-color: #F0F0F0;
            cursor: not-allowed;
            color: #666;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--tone-2);
            box-shadow: 0 0 0 3px rgba(149, 184, 143, 0.1);
        }

        .form-control::placeholder {
            color: #999;
        }

        /* 🔹 TextArea */
        .form-textarea {
            width: 100%;
            max-width: 100%;
            text-align: left;
            padding: 10px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            color: #333;
            background-color: #fff;
            resize: vertical;
            min-height: 100px;
            font-family: inherit;
            box-sizing: border-box;
        }

        .form-textarea:focus {
            outline: none;
            border-color: var(--tone-2);
            box-shadow: 0 0 0 3px rgba(149, 184, 143, 0.1);
        }

        /* ------- Botones inferiores ------- */
        .buttons-bottom-container {
            width: 100%;
            max-width: 100%;
            border: 1px #dee2e6;
            border-radius: 6px;
            margin-top: 25px;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .theme-scope .btn-wd {
            background: var(--tone-3);
            color: #fff;
            border: none;
            padding: 9px 28px;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            display: inline-block;
            transition: .15s;
            box-shadow: 0 1px 2px rgba(0,0,0,.08);
            text-decoration: none;
        }

        .theme-scope .btn-wd:hover {
            filter: brightness(.95);
            color: #fff;
        }

        .theme-scope .btn-wd:active {
            transform: translateY(1px);
        }

        .btn-secondary-custom {
            background-color: #FFFFFF;
            color: #333;
            border: 2px solid #ddd;
            padding: 9px 28px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-secondary-custom:hover {
            background-color: #f8f9fa;
            border-color: var(--tone-2);
            color: var(--tone-3);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-secondary-custom:active {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* ------- Validadores ------- */
        .text-danger {
            color: #dc3545;
            font-size: 12px;
            margin-top: 3px;
            display: block;
        }

        a, a:visited, a:hover, a:active {
            text-decoration: none !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="theme-almacenes">
        <div class="theme-scope">
            <div class="container">
                <div class="top-accent"></div>

                <!-- Header con Título -->
                <div class="container row">
                    <div class="col-md-8 p-0">
                        <div class="header-title">
                            <div class="title-section">
                                <h2>Registrar Relación Movimiento X Lote</h2>
                            </div>
                            <div class="color-bar bar-1"></div>
                            <div class="color-bar bar-2"></div>
                        </div>
                    </div>
                </div>

                <!-- Contenedor Principal -->
                <div class="section-container">

                    <!-- 🔹 SECCIÓN 1: MOVIMIENTO -->
                    <div class="main-section">
                        <h2 class="section-title">Movimiento</h2>

                        <!-- ID del Movimiento -->
                        <div class="subsection">
                            <div class="one-column">
                                <div class="field-block">
                                    <h3>ID del Movimiento <span class="required">(*)</span></h3>
                                    <asp:TextBox ID="txtIdMovimiento" runat="server" 
                                        CssClass="form-control"
                                        placeholder="Ingrese el ID del movimiento"
                                        AutoPostBack="true"
                                        OnTextChanged="txtIdMovimiento_TextChanged">
                                    </asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvIdMovimiento" runat="server"
                                        ControlToValidate="txtIdMovimiento"
                                        ErrorMessage="El ID del movimiento es obligatorio"
                                        CssClass="text-danger"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <!-- Lugar Origen y Lugar Destino -->
                        <div class="subsection">
                            <div class="two-columns">
                                <div class="field-block">
                                    <h3>Lugar Origen <span class="required">(*)</span></h3>
                                    <asp:TextBox ID="txtLugarOrigen" runat="server"
                                        CssClass="form-control form-control-readonly"
                                        placeholder="Se cargará automáticamente"
                                        ReadOnly="true">
                                    </asp:TextBox>
                                </div>
                                <div class="field-block">
                                    <h3>Lugar Destino <span class="required">(*)</span></h3>
                                    <asp:TextBox ID="txtLugarDestino" runat="server"
                                        CssClass="form-control form-control-readonly"
                                        placeholder="Se cargará automáticamente"
                                        ReadOnly="true">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <!-- Fecha y Tipo -->
                        <div class="subsection">
                            <div class="two-columns">
                                <div class="field-block">
                                    <h3>Fecha <span class="required">(*)</span></h3>
                                    <asp:TextBox ID="txtFecha" runat="server"
                                        TextMode="Date"
                                        CssClass="form-control form-control-readonly"
                                        ReadOnly="true">
                                    </asp:TextBox>
                                </div>
                                <div class="field-block">
                                    <h3>Tipo <span class="required">(*)</span></h3>
                                    <asp:TextBox ID="txtTipo" runat="server"
                                        CssClass="form-control form-control-readonly"
                                        placeholder="Se cargará automáticamente"
                                        ReadOnly="true">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 🔹 SECCIÓN 2: LOTE -->
                    <div class="main-section">
                        <h2 class="section-title">Lote</h2>

                        <!-- ID del Lote -->
                        <div class="subsection">
                            <div class="one-column">
                                <div class="field-block">
                                    <h3>ID del Lote <span class="required">(*)</span></h3>
                                    <asp:TextBox ID="txtIdLote" runat="server"
                                        CssClass="form-control"
                                        placeholder="Ingrese el ID del lote"
                                        AutoPostBack="true"
                                        OnTextChanged="txtIdLote_TextChanged">
                                    </asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvIdLote" runat="server"
                                        ControlToValidate="txtIdLote"
                                        ErrorMessage="El ID del lote es obligatorio"
                                        CssClass="text-danger"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>

                        <!-- Descripción -->
                        <div class="subsection">
                            <div class="one-column">
                                <div class="field-block">
                                    <h3>Descripción <span class="required">(*)</span></h3>
                                    <asp:TextBox ID="txtDescripcion" runat="server"
                                        TextMode="MultiLine"
                                        CssClass="form-textarea form-control-readonly"
                                        placeholder="Se cargará automáticamente"
                                        ReadOnly="true">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Botones Inferiores -->
                <div class="container buttons-bottom-container">
                    <asp:Button ID="btnCancelar" runat="server"
                        Text="Cancelar"
                        CssClass="btn-secondary-custom"
                        OnClick="btnCancelar_Click"
                        CausesValidation="false" />

                    <asp:Button ID="btnRegistrarRelacion" runat="server"
                        Text="Registrar Relación"
                        CssClass="btn-wd"
                        OnClick="btnRegistrarRelacion_Click"
                        OnClientClick="return validarFormulario();" />
                </div>

            </div>
        </div>
    </div>

    <%--<!-- ScriptManager necesario para AutoPostBack -->
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />--%>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
        // Validación del formulario antes de enviar
        function validarFormulario() {
            var idMovimiento = document.getElementById('<%= txtIdMovimiento.ClientID %>').value.trim();
            var idLote = document.getElementById('<%= txtIdLote.ClientID %>').value.trim();
            var lugarOrigen = document.getElementById('<%= txtLugarOrigen.ClientID %>').value.trim();
            var lugarDestino = document.getElementById('<%= txtLugarDestino.ClientID %>').value.trim();
            var descripcion = document.getElementById('<%= txtDescripcion.ClientID %>').value.trim();

            if (idMovimiento === '') {
                alert('Por favor, ingrese el ID del Movimiento');
                document.getElementById('<%= txtIdMovimiento.ClientID %>').focus();
                return false;
            }

            if (idLote === '') {
                alert('Por favor, ingrese el ID del Lote');
                document.getElementById('<%= txtIdLote.ClientID %>').focus();
                return false;
            }

            if (lugarOrigen === '' || lugarDestino === '') {
                alert('Los datos del movimiento no se han cargado correctamente. Verifique el ID del Movimiento.');
                document.getElementById('<%= txtIdMovimiento.ClientID %>').focus();
                return false;
            }

            if (descripcion === '') {
                alert('Los datos del lote no se han cargado correctamente. Verifique el ID del Lote.');
                document.getElementById('<%= txtIdLote.ClientID %>').focus();
                return false;
            }

            // Confirmación final
            return confirm('¿Está seguro de registrar esta relación entre el movimiento ' + idMovimiento + ' y el lote ' + idLote + '?');
        }

        // Prevenir envío del formulario con Enter en los campos de ID
        document.addEventListener('DOMContentLoaded', function() {
            var txtIdMov = document.getElementById('<%= txtIdMovimiento.ClientID %>');
            var txtIdLot = document.getElementById('<%= txtIdLote.ClientID %>');

            if (txtIdMov) {
                txtIdMov.addEventListener('keypress', function (e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        this.blur(); // Dispara el AutoPostBack
                    }
                });
            }

            if (txtIdLot) {
                txtIdLot.addEventListener('keypress', function (e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        this.blur(); // Dispara el AutoPostBack
                    }
                });
            }
        });
    </script>
</asp:Content>
