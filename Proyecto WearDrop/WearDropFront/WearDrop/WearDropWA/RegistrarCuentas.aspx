<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarCuentas.aspx.cs" Inherits="WearDropWA.RegistrarCuentas" %>
<asp:Content ID="ctTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Cuenta
</asp:Content>

<asp:Content ID="ctHead" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* ===== Header (paleta azul) ===== */
        .header-title{display:flex;align-items:stretch;height:60px;box-shadow:0 2px 4px rgba(0,0,0,.1);border-radius:10px;overflow:hidden}
        .title-section{background:#fff;padding:0 25px;display:flex;align-items:center;flex:0 0 320px}
        .title-section h2{margin:0;font-size:22px;font-weight:700;color:#333;white-space:nowrap}
        .color-bar{height:100%}
        .bar-1{background:#CFD9E4;flex:1.5}   /* azul claro */
        .bar-2{background:#8FA6B9;flex:1.5}   /* azul medio */

        /* ===== Card y layout ===== */
        .form-card{background:#fff;border:1px solid #dee2e6;border-radius:10px;box-shadow:0 2px 8px rgba(0,0,0,.06);padding:22px 24px}
        .form-label{font-size:14px;color:#333;margin-bottom:6px;display:block}
        .form-control, .form-select{
            width:100%;background:#FFFFFF;border:1px solid #E0E0E0;border-radius:8px;
            padding:10px 14px;font-size:14px;
        }
        .input-compact{max-width:240px}

        /* ===== Botones (azules) ===== */
        .btn-main{
            background:#6F889E;color:#fff;border:none;padding:10px 26px;border-radius:12px;
            transition:.15s;
        }
        .btn-main:hover{filter:brightness(.95)}
        .btn-ghost{
            background:#E9EEF4;color:#364B5C;border:1px solid #BDCAD6;padding:10px 26px;border-radius:12px;
            transition:.15s;
        }
        .btn-ghost:hover{background:#DFE8F0}
        .no-underline,.no-underline:hover,.no-underline:focus{ text-decoration:none !important; }
    </style>
</asp:Content>

<asp:Content ID="ctMain" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <!-- Header -->
        <div class="row align-items-center mb-4">
            <div class="col-md-10 p-0">
                <div class="header-title">
                    <div class="title-section"><h2>Registrar Cuenta</h2></div>
                    <div class="color-bar bar-1"></div>
                    <div class="color-bar bar-2"></div>
                </div>
            </div>
        </div>

        <!-- Card única del formulario -->
        <div class="row">
            <div class="col-md-10">
                <div class="form-card">
                    <div class="row g-4">
                        <!-- Fila 1: ID / UserName -->
                        <div class="col-md-3">
                            <asp:Label ID="lblID" runat="server" Text="ID" CssClass="form-label" />
                            <asp:TextBox ID="txtID" runat="server" CssClass="form-control input-compact" ReadOnly="true" placeholder="X" />
                        </div>
                        <div class="col-md-9">
                            <asp:Label ID="lblUser" runat="server" Text="User Name (*)" CssClass="form-label" />
                            <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="Ingresar usuario" />
                        </div>

                        <!-- Fila 2: Contraseña / Email -->
                        <div class="col-md-6">
                            <asp:Label ID="lblPass" runat="server" Text="Contraseña (*)" CssClass="form-label" />
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Contraseña" />
                        </div>
                        <div class="col-md-6">
                            <asp:Label ID="lblEmail" runat="server" Text="Email (*)" CssClass="form-label" />
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="correo@dominio.com" />
                        </div>

                        <!-- Fila 3: TipoCuenta -->
                        <div class="col-md-12">
                            <asp:Label ID="lblTipo" runat="server" Text="TipoCuenta (*)" CssClass="form-label" />
                            <asp:DropDownList ID="ddlTipoCuenta" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Seleccionar" Value="" />
                                <asp:ListItem Text="Administrador" Value="ADMIN" />
                                <asp:ListItem Text="Empleado" Value="EMP" />
                                <asp:ListItem Text="Cliente" Value="CLI" />
                            </asp:DropDownList>
                        </div>
                    </div>

                    <!-- Botones -->
                    <div class="mt-4 d-flex justify-content-between">
                        <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-ghost no-underline" OnClick="btnCancelar_Click">
                            Cancelar
                        </asp:LinkButton>
                        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn-main" OnClick="btnRegistrar_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="ctScripts" ContentPlaceHolderID="ScriptsContent" runat="server" />
