<%@ Page Title="" Language="C#" MasterPageFile="~/WearDrop1.Master" AutoEventWireup="true" CodeBehind="GestionarPersonas.aspx.cs" Inherits="WearDropWA.GestionarPersonas" %>
<asp:Content ID="t" ContentPlaceHolderID="TitleContent" runat="server">
    Gestionar Cuentas
</asp:Content>

<asp:Content ID="h" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css" />

    <style>
        :root {
            /* dimensiones y espaciamiento */
            --container-width: 860px;
            --grid-gap: 22px;
            --card-height: 84px;
            --card-padding-y: 12px;
            --card-padding-x: 16px;
            --frame-radius: 14px;
            --card-radius: 5px;

            /* colores de marcos */
            --frame-green: #9DBD9B;
            --frame-blue:  #9FB6C8;
            --frame-pink:  #C99298;
            --frame-lilac: #B4A6D6;
            --frame-teal:  #9AC5BE;
            --frame-yellow:#EDE28A;
            --frame-light-pink: #C5A0B0;
        }

        .hdr {
            display: flex;
            align-items: stretch;
            height: 56px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, .1);
            margin-top: 10px;
        }

        .ttl {
            background: #fff;
            padding: 0 20px;
            display: flex;
            align-items: center;
            flex: 0 0 320px;
        }

        .ttl h2 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }

        .c1 { background: #C5D9C0; flex: 1.5; }
        .c2 { background: #95B88F; flex: 1.5; }

        .pill {
            max-width: var(--container-width);
            margin: 8px auto 12px;
            background: #fff;
            border: 1px solid #eee;
            border-radius: 10px;
            padding: 10px 14px;
            font-weight: 600;
        }

        .grid {
            max-width: var(--container-width);
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: var(--grid-gap);
            align-items: stretch;
        }

        @media (max-width: 700px) {
            .grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }
        }

        .frame {
            border-radius: var(--frame-radius);
            padding: 10px;
            display: flex;
        }

        .g { background: var(--frame-green); }
        .b { background: var(--frame-blue); }
        .p { background: var(--frame-pink); }
        .l { background: var(--frame-lilac); }
        .t { background: var(--frame-teal); }
        .y { background: var(--frame-yellow); }
        .lp { background: var(--frame-light-pink); }

        .card {
            display: block;
            flex: 1;
            text-decoration: none;
        }

        .chip {
            background: #fff;
            border-radius: var(--card-radius);
            padding: var(--card-padding-y) var(--card-padding-x);
            border: 1px solid #e8e8e8;
            box-shadow: 0 0 0 6px rgba(255, 255, 255, .8) inset;
            display: flex;
            align-items: center;
            gap: 12px;
            height: var(--card-height);
        }

        .card:hover .chip {
            box-shadow: 0 0 0 2px #e6efe6 inset;
        }

        .chip .ti {
            font-size: 24px;
            color: #0b2239;
        }

        .chip span {
            font-size: 22px;
            color: #122033;
            font-weight: 650;
        }
    </style>
</asp:Content>

<asp:Content ID="m" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container row">
        <div class="pill">Seleccionar una Persona a Gestionar:</div>

        <div class="grid">
            <div class="frame g">
                <asp:LinkButton runat="server" ID="btnEmpleados" CssClass="card" OnClick="btnEmpleados_Click">
                    <div class="chip"><i class="ti ti-user"></i><span>Empleados</span></div>
                </asp:LinkButton>
            </div>

            <div class="frame p">
                <asp:LinkButton runat="server" ID="btnClientes" CssClass="card" OnClick="btnClientes_Click">
                    <div class="chip"><i class="ti ti-shopping-cart"></i><span>Clientes</span></div>
                </asp:LinkButton>
            </div>

            <div class="frame b">
                <asp:LinkButton runat="server" ID="btnCuentas" CssClass="card" OnClick="btnCuentas_Click">
                    <div class="chip"><i class="ti ti-key"></i><span>Cuentas</span></div>
                </asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="s" ContentPlaceHolderID="ScriptsContent" runat="server">
</asp:Content>
