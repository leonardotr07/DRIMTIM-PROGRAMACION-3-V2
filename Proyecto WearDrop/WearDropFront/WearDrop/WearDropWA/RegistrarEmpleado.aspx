<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarEmpleado.aspx.cs" Inherits="WearDropWA.RegistrarEmpleado" %>
<asp:Content ID="t" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Empleado
</asp:Content>

<asp:Content ID="h" ContentPlaceHolderID="HeadContent" runat="server">
  <style>
    /* Header con barras verdes */
    .header-title{display:flex;align-items:stretch;height:60px;box-shadow:0 2px 4px rgba(0,0,0,.1);border-radius:10px;overflow:hidden;margin-top:6px}
    .title-section{background:#fff;padding:0 24px;display:flex;align-items:center;flex:0 0 340px}
    .title-section h2{margin:0;font-size:22px;font-weight:700;color:#333}
    .color-bar{height:100%}
    .bar-1{background:#C5D9C0;flex:1.5}
    .bar-2{background:#95B88F;flex:1.5}

    /* Campos sin card */
    .form-label{font-size:14px;color:#333;margin-bottom:6px;display:block}
    .form-control{
      width:100%;background:#fff;border:1px solid #E0E0E0;border-radius:10px;
      padding:12px 14px;font-size:15px
    }
    .input-compact{max-width:260px}
    .row-gap{row-gap:22px} /* espacio vertical entre filas */

    /* Radio género */
    .radio-wrap{
      background:#fff;border:1px solid #E0E0E0;border-radius:10px;
      padding:10px 14px;display:flex;align-items:center;gap:22px
    }
    .radio-wrap input[type=radio]{accent-color:#73866D;cursor:pointer;margin-right:6px}

    /* Botones */
    .btn-main{
      background:#73866D;color:#fff;border:none;padding:12px 28px;border-radius:14px;
      transition:.15s
    }
    .btn-main:hover{background:#5f6f5a}
    .btn-ghost{
      background:#E9F0E8;color:#3b4a3b;border:1px solid #C7D6C5;padding:12px 28px;border-radius:14px
    }
    .btn-ghost:hover{background:#dfe8de}
    .no-underline,.no-underline:hover,.no-underline:focus{text-decoration:none!important}
  </style>
</asp:Content>

<asp:Content ID="m" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">

    <!-- Encabezado -->
    <div class="row align-items-center mb-4">
      <div class="col-lg-10 p-0">
        <div class="header-title">
          <div class="title-section"><h2>Registrar Empleado</h2></div>
          <div class="color-bar bar-1"></div>
          <div class="color-bar bar-2"></div>
        </div>
      </div>
    </div>

    <!-- Formulario SIN card -->
    <div class="row row-gap col-lg-10">
      <!-- Fila 1 -->
      <div class="col-md-3">
        <asp:Label ID="lblID" runat="server" Text="ID" CssClass="form-label" />
        <asp:TextBox ID="txtID" runat="server" CssClass="form-control input-compact" ReadOnly="true" placeholder="Auto" />
      </div>
      <div class="col-md-9">
        <asp:Label ID="lblNombre" runat="server" Text="Nombre (*)" CssClass="form-label" />
        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Nombre completo" />
      </div>

      <!-- Fila 2 -->
      <div class="col-md-6">
        <asp:Label ID="lblApellidoPaterno" runat="server" Text="Primer Apellido" CssClass="form-label" />
        <asp:TextBox ID="txtApellidoPaterno" runat="server" CssClass="form-control" placeholder="Apellido paterno" />
      </div>
      <div class="col-md-6">
        <asp:Label ID="lblApellidoMaterno" runat="server" Text="Segundo Apellido" CssClass="form-label" />
        <asp:TextBox ID="txtApellidoMaterno" runat="server" CssClass="form-control" placeholder="Apellido materno" />
      </div>

      <!-- Fila 3 -->
      <div class="col-md-6">
        <asp:Label ID="lblDni" runat="server" Text="DNI" CssClass="form-label" />
        <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" MaxLength="8" placeholder="Documento Nacional de Identidad" />
      </div>
      <div class="col-md-6">
        <asp:Label ID="lblTelefono" runat="server" Text="Teléfono" CssClass="form-label" />
        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Número de teléfono" />
      </div>

      <!-- Fila 4 -->
      <div class="col-md-6">
        <asp:Label ID="lblGenero" runat="server" Text="Género" CssClass="form-label" />
        <div class="radio-wrap">
          <label class="mb-0"><input type="radio" name="genero" value="M" runat="server" id="rbMasculino" /> M</label>
          <label class="mb-0"><input type="radio" name="genero" value="F" runat="server" id="rbFemenino" /> F</label>
        </div>
      </div>
      <div class="col-md-6">
        <asp:Label ID="lblCargo" runat="server" Text="Cargo (*)" CssClass="form-label" />
        <asp:TextBox ID="txtCargo" runat="server" CssClass="form-control" placeholder="Cargo del empleado" />
      </div>

      <!-- Fila 5 -->
      <div class="col-md-6">
        <asp:Label ID="lblSueldo" runat="server" Text="Sueldo" CssClass="form-label" />
        <asp:TextBox ID="txtSueldo" runat="server" CssClass="form-control" placeholder="Monto de sueldo" />
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