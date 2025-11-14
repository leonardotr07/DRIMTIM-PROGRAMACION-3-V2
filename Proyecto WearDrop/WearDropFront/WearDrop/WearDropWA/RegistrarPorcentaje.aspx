<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="RegistrarPorcentaje.aspx.cs" Inherits="WearDropWA.RegistrarLiquidacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Registrar Descuento Liquidacion
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        /* Estilos generales */
        .header-title {
            display: flex; 
            align-items: stretch; height: 60px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); 

        } 
        .title-section {
            background-color: #FFFFFF; padding: 0 25px; display: flex; align-items: center; flex: 0 0 150px; 

        } 
        .title-section h2 {
            margin: 0; font-size: 20px; font-weight: 500; color: #333; white-space: nowrap;

        } 
        .color-bar { 
            height: 100%; 

        } 
        .bar-1 { 
              background-color: #C0D2E2; flex: 1.5; max-width: 150px;

          }
        .bar-2 {
            background-color: #A0B4C5; 
            flex: 1.5; 
            max-width: 150px;
        }

        /* Estilos para el formulario "Registrar Vigencia Previa" */
        .vigencia-previa-container {
            margin-top: 30px;
            padding: 20px;
            border: 1px solid #E0E0E0;
            border-radius: 8px;
            background-color: #FFFFFF;
            width: 70%;
        }

        .vigencia-previa-container h3 {
            margin-bottom: 20px;
            color: #333;
        }

        .form-field {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .form-field label {
            font-size: 14px;
            color: #333;
            width: 150px;
        }

        .form-field input {
            background-color: #F5F5F5;
            border: 1px solid #E0E0E0;
            border-radius: 4px;
            padding: 10px;
            font-size: 14px;
            width: calc(100% - 160px); /* Para que ocupe el espacio restante */
        }

        .form-button-container {
            display: flex;
            justify-content: flex-end;
            gap: 20px;
            margin-top: 20px;
        }
        
        .form-button-container-prenda {
            display: flex;
            justify-content: flex-start;
            gap: 20px;
            margin-top: 20px;
        }

        .btn-cancelar, .btn-registrar {
            background-color: #A0B4C5;
            color: white;
            padding: 10px 30px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

         .btn-registrar-vigencia {
    background-color: #A0B4C5;
    color: white;
    padding: 10px 30px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
}
        .btn-cancelar:hover, .btn-registrar:hover {
            background-color: #8698a8;
        }

        /* Estilos para "Añadir Prenda" */
        .btn-anadir-prenda {
             background-color: #A0B4C5;
  color: white;
  padding: 10px 30px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
        }

        .btn-anadir-prenda:hover {
            background-color: #8698a8;
        }

        /* Estilos para el formulario "Registrar Descuento Porcentaje" */
        .descuento-container {
            margin-top: 30px;
            padding: 20px;
            border: 1px solid #E0E0E0;
            border-radius: 8px;
            background-color: #FFFFFF;
            width: 70%;
        }

        .descuento-container .form-field {
            margin-bottom: 15px;
        }

    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <!-- Título y barras -->
        <div class="header-title">
            <div class="title-section">
                <h2>Registrar Descuento Porcentaje</h2>
            </div>
            <div class="color-bar bar-1"></div>
            <div class="color-bar bar-2"></div>
        </div>

        <!-- Sección para "Registrar Vigencia Previa" -->
        <div class="vigencia-previa-container">
            <h3>Registrar Vigencia Previa</h3>

            <!-- Campo Fecha Inicio -->
            <div class="form-field">
                <label for="fechaInicio">Fecha Inicio (*)</label>
                <input type="date" id="fechaInicio" placeholder="dd/mm/aaaa" />
            </div>

            <!-- Campo Fecha Fin -->
            <div class="form-field">
                <label for="fechaFin">Fecha Fin (*)</label>
                <input type="date" id="fechaFin" placeholder="dd/mm/aaaa" />
            </div>

            <!-- Botón Registrar Vigencia -->
            <div class="form-button-container">
                <asp:Button ID="btnRegistrarVigencia" runat="server" Text="Registrar" CssClass="btn-registrar-vigencia" OnClick="btnRegistrarVigencia_Click" OnClientClick="return confirm('Vigencia Registrada Correctamente.');"/>
            </div>
        </div>

        <!-- Sección para "Registrar Descuento Porcentaje" -->
        <div class="descuento-container">

            <!-- Campo Nombre del Descuento -->
            <div class="form-field">
                <label for="nombreDescuento">Nombre (*)</label>
                <input type="text" id="nombreDescuento" placeholder="Nombre del descuento" />
            </div>

            <!-- Campo Porcentaje -->
            <div class="form-field">
                <label for="porcentajeDescuento">Porcentaje (*)</label>
                <input type="text" id="porcentajeDescuento" placeholder="Porcentaje del descuento" />
            </div>

            <!-- Botón Añadir Prenda -->
            <div class="form-button-container-prenda
                ">
                <asp:Button ID="btnAñadirPrenda" runat="server" Text="Añadir Prenda" CssClass="btn-anadir-prenda" OnClick="btnAñadirPrenda_Click"/>
            </div>

            <!-- Botón Registrar -->
            <div class="form-button-container">
                 <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn-cancelar" OnClick="btnCancelar_Click"/>
                 <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn-registrar" OnClick="btnRegistrar_Click" OnClientClick="return confirm('Descuento Registrado Correctamente.');"/>
               <%-- <button class="btn-cancelar">Cancelar</button>
                <button class="btn-registrar">Registrar</button>--%>
            </div>
        </div>
    </div>
</asp:Content>
