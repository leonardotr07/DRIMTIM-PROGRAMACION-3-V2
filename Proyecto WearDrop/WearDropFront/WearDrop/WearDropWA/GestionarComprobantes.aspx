<%@ Page Title="Gestionar Comprobantes" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="GestionarComprobantes.aspx.cs" Inherits="WearDropWA.GestionarComprobantes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Seleccionar Tipo de Comprobante a Gestionar
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .header-title {
            display: flex;
            align-items: stretch;
            height: 60px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-top: 14px; /* Añadido del estándar */
            border-radius: 10px; /* Añadido del estándar */
            overflow: hidden; /* Añadido del estándar */
        }
        .title-section {
            background-color: #FFFFFF;
            padding: 0 25px;
            display: flex;
            align-items: center;
            flex: 0 0 280px; /* Ajustado */
        }
        .title-section h2 {
            margin: 0;
            font-size: 20px;
            font-weight: 600; /* Coincide con el estándar */
            color: #333;
            white-space: nowrap;
        }
        .color-bar { height: 100%; }
        /* Usamos el tema de color azul para comprobantes */
        .bar-1 { background-color: #C7D6E2; flex: 1.5; } 
        .bar-2 { background-color: #9FB6C8; flex: 1.5; }

        .promo-button, .promo-button:hover {
            text-decoration: none; 
        }

        .promo-button {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px 40px;
            font-size: 1.5rem;
            border-radius: 12px;
            border: 2px solid transparent;
            cursor: pointer;
            width: 300px; /* Ancho ajustado para 4 botones */
            font-weight: bold;
            transition: transform 0.3s, box-shadow 0.3s ease-in-out;
            text-align: center;
        }
        .promo-button i { margin-right: 10px; }
        .promo-button .inner {
            background-color: white;
            padding: 12px 30px;
            border-radius: 10px;
            color: #333;
            width: 100%; /* Para que el texto interno no se rompa */
        }
        .promo-button:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        /* Colores para los 4 botones */
        .green { background-color: #9DBD9B; border-color: #9DBD9B; }
        .blue { background-color: #9FB6C8; border-color: #9FB6C8; }
        .soft-red { background-color: #C99298; border-color: #C99298; }
        .lilac { background-color: #B4A6D6; border-color: #B4A6D6; } /* Color nuevo */

        .button-container {
            display: grid; /* Usamos Grid para un 2x2 */
            grid-template-columns: repeat(2, 1fr); /* 2 columnas */
            gap: 30px;
            justify-items: center;
            margin-top: 50px;
            margin-bottom: 50px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="container row">
            <div class="row align-items-center">
                <!-- Título de la página con barras decorativas -->
                <div class="col-md-7 p-0"> <!-- Ajustado a col-md-7 -->
                    <div class="header-title">
                        <div class="title-section">
                            <h2>Seleccionar Tipo de Comprobante</h2>
                        </div>
                        <div class="color-bar bar-1"></div>
                        <div class="color-bar bar-2"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contenedor de los 4 botones -->
        <div class="container row mt-4">
            <div class="button-container">
                
                <!-- Usamos LinkButton para usar OnClick en C# -->
                <asp:LinkButton ID="btnBoleta" runat="server" OnClick="btnBoleta_Click" CssClass="promo-button green">
                    <div class="inner"><i class="fa-solid fa-receipt"></i><span>BOLETAS</span></div>
                </asp:LinkButton>
                
                <asp:LinkButton ID="btnFactura" runat="server" OnClick="btnFactura_Click" CssClass="promo-button blue">
                    <div class="inner"><i class="fa-solid fa-file-invoice-dollar"></i><span>FACTURAS</span></div>
                </asp:LinkButton>

                <asp:LinkButton ID="btnNotaCredito" runat="server" OnClick="btnNotaCredito_Click" CssClass="promo-button soft-red">
                    <div class="inner"><i class="fa-solid fa-file-circle-minus"></i><span>NOTAS DE CRÉDITO</span></div>
                </asp:LinkButton>

                <asp:LinkButton ID="btnNotaDebito" runat="server" OnClick="btnNotaDebito_Click" CssClass="promo-button lilac">
                    <div class="inner"><i class="fa-solid fa-file-circle-plus"></i><span>NOTAS DE DÉBITO</span></div>
                </asp:LinkButton>

            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>