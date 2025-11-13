<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarClientes.aspx.cs" Inherits="WearDropWA.RegistrarClientes" %>
<asp:Content ID="t" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Cliente
</asp:Content>

<asp:Content ID="h" ContentPlaceHolderID="HeadContent" runat="server">
  <style>
    /* ===== Header con barras rojas ===== */
    .header-title{
      display:flex;align-items:stretch;height:60px;
      box-shadow:0 2px 4px rgba(0,0,0,.1);
      border-radius:10px;overflow:hidden;margin-top:6px
    }
    .title-section{
      background:#fff;padding:0 24px;
      display:flex;align-items:center;flex:0 0 340px
    }
    .title-section h2{
      margin:0;font-size:22px;font-weight:700;color:#333
    }
    .color-bar{height:100%}
    .bar-1{background:#E4CFCF;flex:1.5} /* rojo claro */
    .bar-2{background:#B98F8F;flex:1.5} /* rojo medio */

    /* ===== Campos del formulario ===== */
    .form-label{
      font-size:14px;color:#333;margin-bottom:6px;display:block
    }
    .form-label .req{color:#B33B3B;font-weight:600;margin-left:2px}
    .form-control,.form-select{
      width:100%;background:#fff;border:1px solid #E0E0E0;
      border-radius:10px;padding:12px 14px;font-size:15px
    }
    .input-compact{max-width:260px}
    .row-gap{row-gap:22px}

    /* ===== Radio Género ===== */
    .radio-wrap{
      background:#fff;border:1px solid #E0E0E0;
      border-radius:10px;padding:10px 14px;
      display:flex;align-items:center;gap:22px
    }
    .radio-wrap input[type=radio]{
      accent-color:#A67B7B;cursor:pointer;margin-right:6px
    }

    /* ===== Botones ===== */
    .btn-main{
      background:#A67B7B;color:#fff;border:none;
      padding:12px 28px;border-radius:14px;transition:.15s
    }
    .btn-main:hover{background:#946A6A}
    .btn-ghost{
      background:#F3EAEA;color:#3b2f2f;border:1px solid #D8C1C1;
      padding:12px 28px;border-radius:14px
    }
    .btn-ghost:hover{background:#EBDDDD}
    .no-underline,.no-underline:hover,.no-underline:focus{text-decoration:none!important}
  </style>
</asp:Content>

<asp:Content ID="m" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">

    <!-- Encabezado -->
    <div class="row align-items-center mb-4">
      <div class="col-lg-10 p-0">
        <div class="header-title">
          <div class="title-section">
              <h2>
                  <asp:Label ID="lblTitulo" runat="server" Text="Registrar Cliente"></asp:Label>
              </h2>
          </div>
            <div class="color-bar bar-1"></div>
            <div class="color-bar bar-2"></div>
        </div>
      </div>
    </div>

    <!-- Formulario sin card -->
    <div class="row row-gap col-lg-10">

      <!-- ID / Nombre -->
      <div class="col-md-3">
        <asp:Label ID="lblID" runat="server" Text="ID" CssClass="form-label" />
        <asp:TextBox ID="txtID" runat="server" CssClass="form-control input-compact" ReadOnly="true" placeholder="X" />
      </div>
      <div class="col-md-9">
        <label class="form-label">Nombre<span class="req">*</span></label>
        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Nombre completo" />
      </div>

      <!-- Apellidos -->
      <div class="col-md-6">
        <label class="form-label">Primer Apellido<span class="req">*</span></label>
        <asp:TextBox ID="txtApellidoPaterno" runat="server" CssClass="form-control" placeholder="Apellido paterno" />
      </div>
      <div class="col-md-6">
        <label class="form-label">Segundo Apellido<span class="req">*</span></label>
        <asp:TextBox ID="txtApellidoMaterno" runat="server" CssClass="form-control" placeholder="Apellido materno" />
      </div>

      <!-- DNI / Género -->
      <div class="col-md-6">
        <label class="form-label">DNI<span class="req">*</span></label>
        <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" MaxLength="8" placeholder="Documento Nacional de Identidad" />
      </div>
      <div class="col-md-6">
        <label class="form-label">Género<span class="req">*</span></label>
        <div class="radio-wrap">
          <label class="mb-0"><input type="radio" name="genero" value="M" runat="server" id="rbMasculino" /> M</label>
          <label class="mb-0"><input type="radio" name="genero" value="F" runat="server" id="rbFemenino" /> F</label>
        </div>
      </div>

      <!-- Teléfono / Tipo Cliente -->
      <div class="col-md-6">
        <label class="form-label">Teléfono<span class="req">*</span></label>
        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Número de teléfono" />
      </div>
      <div class="col-md-6">
        <label class="form-label">Tipo de Cliente<span class="req">*</span></label>
        <asp:DropDownList ID="ddlTipoCliente" runat="server" CssClass="form-select">
          <asp:ListItem Text="Seleccionar" Value="" />
          <asp:ListItem Text="Minorista" Value="MIN" />
          <asp:ListItem Text="Mayorista" Value="MAY" />
        </asp:DropDownList>
      </div>
    </div>

    <!-- Botones -->
    <div class="row mt-4 col-lg-10">
      <div class="col-12 d-flex justify-content-between">
        <asp:LinkButton ID="btnCancelar" runat="server" CssClass="btn-ghost no-underline" OnClick="btnCancelar_Click">Cancelar</asp:LinkButton>
        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn-main" OnClick="btnRegistrar_Click" />
      </div>
    </div>

  </div>
</asp:Content>

<asp:Content ID="s" ContentPlaceHolderID="ScriptsContent" runat="server" />
