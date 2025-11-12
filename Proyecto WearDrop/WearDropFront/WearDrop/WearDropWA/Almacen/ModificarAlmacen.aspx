<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="ModificarAlmacen.aspx.cs" Inherits="WearDropWA.ModificarAlmacen" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Modificar Almacén
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* ------- Layout Base (Estilo de ListarAlmacenes) ------- */
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
            gap: 20px;
        }

        /* ------- Subsecciones generales ------- */
        .subsection {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 18px 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
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

        /* 🔹 TextBox (ANCHO COMPLETO) */
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

        /* 🔹 Campo de Stock REDUCIDO al 35% */
        .form-control-small {
            width: 100%;
            max-width: 35%;
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

        .form-control:focus,
        .form-control-small:focus {
            outline: none;
            border-color: var(--tone-2);
            box-shadow: 0 0 0 3px rgba(149, 184, 143, 0.1);
        }

        .form-control::placeholder,
        .form-control-small::placeholder {
            color: #999;
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

                <!-- Header con Título (Estilo ListarAlmacenes) -->
                <div class="container row">
                    <div class="col-md-6 p-0">
                        <div class="header-title">
                            <div class="title-section">
                                <h2>Modificar Almacén</h2>
                            </div>
                            <div class="color-bar bar-1"></div>
                            <div class="color-bar bar-2"></div>
                        </div>
                    </div>
                </div>

                <!-- Contenedor Principal (Estructura de subsecciones) -->
                <div class="section-container">

                    <!-- 🔹 FILA 1: Nombre -->
                    <div class="subsection">
                        <div class="one-column">
                            <div class="field-block">
                                <h3>Nombre <span class="required">(*)</span></h3>
                                <asp:TextBox ID="txtNombre" runat="server" 
                                    CssClass="form-control"
                                    placeholder="Ingrese el nombre del almacén"
                                    MaxLength="100">
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                                    ControlToValidate="txtNombre"
                                    ErrorMessage="El nombre es obligatorio"
                                    CssClass="text-danger"
                                    Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>

                    <!-- 🔹 FILA 2: Ubicación -->
                    <div class="subsection">
                        <div class="one-column">
                            <div class="field-block">
                                <h3>Ubicación <span class="required">(*)</span></h3>
                                <asp:TextBox ID="txtUbicacion" runat="server"
                                    CssClass="form-control"
                                    placeholder="Ingrese la ubicación"
                                    MaxLength="200">
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvUbicacion" runat="server"
                                    ControlToValidate="txtUbicacion"
                                    ErrorMessage="La ubicación es obligatoria"
                                    CssClass="text-danger"
                                    Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>

                    <!-- 🔹 FILA 3: Stock (REDUCIDO AL 35%) -->
                    <div class="subsection">
                        <div class="one-column">
                            <div class="field-block">
                                <h3>Stock <span class="required">(*)</span></h3>
                                <asp:TextBox ID="txtStock" runat="server"
                                    CssClass="form-control-small"
                                    placeholder="Ingrese el stock"
                                    TextMode="Number">
                                </asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvStock" runat="server"
                                    ControlToValidate="txtStock"
                                    ErrorMessage="El stock es obligatorio"
                                    CssClass="text-danger"
                                    Display="Dynamic">
                                </asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="rvStock" runat="server"
                                    ControlToValidate="txtStock"
                                    Type="Integer"
                                    MinimumValue="0"
                                    MaximumValue="99999"
                                    ErrorMessage="El stock debe ser un número entre 0 y 99999"
                                    CssClass="text-danger"
                                    Display="Dynamic">
                                </asp:RangeValidator>
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

                    <asp:Button ID="btnModificar" runat="server"
                        Text="Modificar"
                        CssClass="btn-wd"
                        OnClick="btnModificar_Click" />
                </div>

            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
    <script type="text/javascript">
        // Validación adicional del lado del cliente
        function validarFormulario() {
            var nombre = document.getElementById('<%= txtNombre.ClientID %>').value.trim();
            var ubicacion = document.getElementById('<%= txtUbicacion.ClientID %>').value.trim();
            var stock = document.getElementById('<%= txtStock.ClientID %>').value.trim();

            if (nombre === '' || ubicacion === '' || stock === '') {
                alert('Por favor, complete todos los campos obligatorios');
                return false;
            }

            if (isNaN(stock) || parseInt(stock) < 0) {
                alert('El stock debe ser un número válido mayor o igual a 0');
                return false;
            }

            return confirm('¿Está seguro de modificar este almacén?');
        }
    </script>
</asp:Content>
