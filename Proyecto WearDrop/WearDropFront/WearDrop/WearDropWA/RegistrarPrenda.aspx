<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarPrenda.aspx.cs" Inherits="WearDropWA.RegistrarPrenda" %>

<asp:Content ID="cTitle" ContentPlaceHolderID="TitleContent" runat="server">
    <asp:Literal ID="litTitulo" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="cHead" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,.08);
            margin-top: 14px;
            border-radius: 10px;
            overflow: hidden
        }

        .title-section {
            background: #fff;
            padding: 0 22px;
            display: flex;
            align-items: center
        }

            .title-section h2 {
                margin: 0;
                font-size: 20px;
                font-weight: 600;
                color: #333
            }

        .color-bar {
            height: 100%
        }

        .bar-1 {
            flex: 1.2
        }

        .bar-2 {
            flex: 1
        }

        .theme-polos .bar-1 {
            background: #CFE1CC
        }

        .theme-polos .bar-2 {
            background: #9DBD9B
        }

        .theme-vestidos .bar-1 {
            background: #CCD8E1
        }

        .theme-vestidos .bar-2 {
            background: #9FB6C8
        }

        .theme-faldas .bar-1 {
            background: #E4C3CC
        }

        .theme-faldas .bar-2 {
            background: #C5A0B0
        }

        .theme-gorros .bar-1 {
            background: #E4B9BD
        }

        .theme-gorros .bar-2 {
            background: #C99298
        }

        .theme-pantalones .bar-1 {
            background: #D8D1EC
        }

        .theme-pantalones .bar-2 {
            background: #B4A6D6
        }

        .theme-casacas .bar-1 {
            background: #CFE6E1
        }

        .theme-casacas .bar-2 {
            background: #9AC5BE
        }

        .theme-blusas .bar-1 {
            background: #F6F1B8
        }

        .theme-blusas .bar-2 {
            background: #EDE28A
        }

        .card-white {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0,0,0,.06);
            padding: 22px;
            margin: 14px 0
        }

        .card-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 14px
        }

        .form-label {
            font-size: 14px;
            color: #333;
            margin-bottom: 8px;
            display: block
        }

        .form-control {
            background: #fff;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 10px 14px;
            width: 100%
        }

        .form-note {
            color: #9aa1a9;
            font-size: 12px
        }

        .btn {
            color: #fff;
            border: none;
            padding: 10px 24px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            background: #73866D
        }

            .btn:hover {
                filter: brightness(.95)
            }

        .btn-outline {
            background: #fff;
            border: 1px solid #d6d8dc;
            color: #333;
            border-radius: 8px;
            padding: 10px 24px
        }

            .btn-outline:hover {
                background: #f6f7f8
            }
    </style>
</asp:Content>

<asp:Content ID="cMain" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" id="themeWrap" runat="server">
        <div class="row">
            <div class="col-md-8 p-0">
                <div class="header-title">
                    <div class="title-section">
                        <h2>
                            <asp:Literal ID="litHeader" runat="server"></asp:Literal></h2>
                    </div>
                    <div class="color-bar bar-1"></div>
                    <div class="color-bar bar-2"></div>
                </div>
            </div>
        </div>

        <!-- Datos básicos -->
        <div class="card-white">
            <div class="card-title">Datos básicos</div>
            <div class="row g-3">
                <asp:Panel ID="divId" runat="server" CssClass="col-md-2" Visible="false">
                    <label class="form-label" for="txtId">ID</label>
                    <asp:TextBox ID="txtId" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    <div class="form-note">Solo visible en edición</div>
                </asp:Panel>

                <div class="col-md-6">
                    <label class="form-label" for="txtNombre">Nombre <span id="spanReq" runat="server">(*)</span></label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Nombre de la prenda"></asp:TextBox>
                </div>

                <!-- (TALLA eliminado) -->

                <div class="col-md-3">
                    <label class="form-label" for="ddlMaterial">Material <span id="spanReqMaterial" runat="server">(*)</span></label>
                    <asp:DropDownList ID="ddlMaterial" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>

                <div class="col-md-3">
                    <label class="form-label" for="txtColor">Color <span id="spanReqColor" runat="server">(*)</span></label>
                    <asp:TextBox ID="txtColor" runat="server" CssClass="form-control" placeholder="Ej: Blanco"></asp:TextBox>
                </div>

                <div class="col-md-3">
                    <label class="form-label" for="txtStock">Stock <span id="spanReqStock" runat="server">(*)</span></label>
                    <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" placeholder="0"></asp:TextBox>
                </div>
            </div>
        </div>

        <!-- Precios -->
        <div class="card-white">
            <div class="card-title">Precios</div>
            <div class="row g-3">
                <div class="col-md-3">
                    <label class="form-label" for="txtPU">Precio Unidad <span id="spanReqPU" runat="server">(*)</span></label>
                    <asp:TextBox ID="txtPU" runat="server" CssClass="form-control" placeholder="0.00"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label class="form-label" for="txtPM">Precio Mayor <span id="spanReqPM" runat="server">(*)</span></label>
                    <asp:TextBox ID="txtPM" runat="server" CssClass="form-control" placeholder="0.00"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label class="form-label" for="txtPD">Precio Docena <span id="spanReqPD" runat="server">(*)</span></label>
                    <asp:TextBox ID="txtPD" runat="server" CssClass="form-control" placeholder="0.00"></asp:TextBox>
                </div>
            </div>
        </div>

        <!-- Card: Campos específicos por tipo -->
        <div class="card-white">
            <div class="card-title">Características específicas</div>

            <!-- PANEL POLO -->
            <asp:Panel ID="pnlPOLO" runat="server" Visible="false">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label" for="ddlTipoManga">Tipo de Manga <span id="spanReqManga" runat="server">(*)</span></label>
                        <asp:DropDownList ID="ddlTipoManga" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label" for="txtEstampado">Estampado</label>
                        <asp:TextBox ID="txtEstampado" runat="server" CssClass="form-control" placeholder="Descripción del estampado (opcional)"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label" for="ddlTipoCuello">Tipo de Cuello <span id="spanReqCuello" runat="server">(*)</span></label>
                        <asp:DropDownList ID="ddlTipoCuello" runat="server" CssClass="form-control"></asp:DropDownList>
                        
                    </div>

                </div>

            </asp:Panel>

            <!-- PANEL BLUSA -->
            <asp:Panel ID="pnlBLUSA" runat="server" Visible="false">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label" for="ddlTipoBlusa">Tipo de Blusa <span id="spanReqTipoBlusa" runat="server">(*)</span></label>
                        <asp:DropDownList ID="ddlTipoBlusa" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="ddlTipoMangaB">Tipo de Manga <span id="spanReqMangaB" runat="server">(*)</span></label>
                        <asp:DropDownList ID="ddlTipoMangaB" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                </div>
            </asp:Panel>

            <!-- PANEL VESTIDO -->
            <asp:Panel ID="pnlVESTIDO" runat="server" Visible="false">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label" for="ddlTipoVestido">
                            Tipo de Vestido <span id="spanReqTipoVestido" runat="server">(*)</span>
                        </label>
                        <asp:DropDownList ID="ddlTipoVestido" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label" for="ddlTipoMangaV">
                            Tipo de Manga <span id="spanReqMangaV" runat="server">(*)</span>
                        </label>
                        <asp:DropDownList ID="ddlTipoMangaV" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label" for="txtLargoVestido">
                            Largo (cm) <span id="spanReqLargoVestido" runat="server">(*)</span>
                        </label>
                        <asp:TextBox ID="txtLargoVestido" runat="server" CssClass="form-control" placeholder="Ej: 90"></asp:TextBox>
                    </div>
                </div>
            </asp:Panel>


            <!-- PANEL FALDA -->
            <asp:Panel ID="pnlFALDA" runat="server" Visible="false">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label" for="ddlTipoFalda">Tipo de Falda <span id="spanReqTipoFalda" runat="server">(*)</span></label>
                        <asp:DropDownList ID="ddlTipoFalda" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label" for="txtLargoFalda">Largo (cm) <span id="spanReqLargoFalda" runat="server">(*)</span></label>
                        <asp:TextBox ID="txtLargoFalda" runat="server" CssClass="form-control" placeholder="Ej: 60"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label" for="ddlConVolantes">Con Volantes <span id="spanReqVolantes" runat="server">(*)</span></label>
                        <asp:DropDownList ID="ddlConVolantes" runat="server" CssClass="form-control">
                            <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                            <asp:ListItem Value="1">Sí</asp:ListItem>
                            <asp:ListItem Value="0">No</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </asp:Panel>

            <!-- PANEL PANTALÓN -->
            <asp:Panel ID="pnlPANTALON" runat="server" Visible="false">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label" for="ddlTipoPantalon">
                            Tipo de Pantalón <span id="spanReqTipoPantalon" runat="server">(*)</span>
                        </label>
                        <asp:DropDownList ID="ddlTipoPantalon" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label" for="txtLargoPierna">
                            Largo pierna (cm) <span id="spanReqLargoPierna" runat="server">(*)</span>
                        </label>
                        <asp:TextBox ID="txtLargoPierna" runat="server" CssClass="form-control" placeholder="Ej: 100"></asp:TextBox>
                    </div>

                    <!-- NUEVO: Cintura (cm) -->
                    <div class="col-md-4">
                        <label class="form-label" for="txtCintura">
                            Cintura (cm) <span id="spanReqCintura" runat="server">(*)</span>
                        </label>
                        <asp:TextBox ID="txtCintura" runat="server" CssClass="form-control" placeholder="Ej: 78"></asp:TextBox>
                    </div>
                </div>
            </asp:Panel>

            <!-- PANEL CASACA -->
            <asp:Panel ID="pnlCASACA" runat="server" Visible="false">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label" for="ddlTipoCasaca">Tipo de Casaca <span id="spanReqTipoCasaca" runat="server">(*)</span></label>
                        <asp:DropDownList ID="ddlTipoCasaca" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label" for="ddlConCapucha">Con Capucha <span id="spanReqCapucha" runat="server">(*)</span></label>
                        <asp:DropDownList ID="ddlConCapucha" runat="server" CssClass="form-control">
                            <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                            <asp:ListItem Value="1">Sí</asp:ListItem>
                            <asp:ListItem Value="0">No</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </asp:Panel>

            <!-- PANEL GORRO -->
            <asp:Panel ID="pnlGORRO" runat="server" Visible="false">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label" for="ddlTipoGorra">Tipo de Gorro <span id="spanReqTipoGorra" runat="server">(*)</span></label>
                        <asp:DropDownList ID="ddlTipoGorra" runat="server" CssClass="form-control"></asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label" for="ddlTallaAjustable">Talla Ajustable <span id="spanReqTallaAjustable" runat="server">(*)</span></label>
                        <asp:DropDownList ID="ddlTallaAjustable" runat="server" CssClass="form-control">
                            <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                            <asp:ListItem Value="1">Sí</asp:ListItem>
                            <asp:ListItem Value="0">No</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label" for="ddlImpermeable">Impermeable <span id="spanReqImpermeable" runat="server">(*)</span></label>
                        <asp:DropDownList ID="ddlImpermeable" runat="server" CssClass="form-control">
                            <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                            <asp:ListItem Value="1">Sí</asp:ListItem>
                            <asp:ListItem Value="0">No</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </asp:Panel>
        </div>
        <div class="card-white" style="display: flex; justify-content: space-between; align-items: center">
            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn-outline" OnClick="btnCancelar_Click" />
            <asp:Button ID="btnGuardar" runat="server" CssClass="btn" OnClick="btnGuardar_Click" />
        </div>
    </div>
</asp:Content>

<asp:Content ID="cScripts" ContentPlaceHolderID="ScriptsContent" runat="server" />
