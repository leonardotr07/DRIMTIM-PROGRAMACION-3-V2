<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="InicioSesion.aspx.cs"
    Inherits="SoftProgWA.InicioSesion" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head runat="server">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Iniciar Sesión</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    :root{
      --bg:#f6f6f6; --card:#ffffff; --ink:#1f2d3a;
      --accent:#1f2d3a; --btn:#1f2d3a; --btn-hover:#15202c; --btn-text:#ffffff;
      --teal:#5faea6; --coral:#dc7a73; --mustard:#e6c85a; --navy:#22334a;
    }
    html,body{height:100%;background:var(--bg);color:var(--ink);
      font-family:system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif}
    .page-wrap{position:relative;min-height:100vh;overflow:hidden}

    /* -------- Burbujas más pequeñas y espaciadas -------- */
    .bubbles{position:absolute;inset:0;pointer-events:none}
    .bubble{position:absolute;border-radius:50%;opacity:.97;
      filter:drop-shadow(0 6px 12px rgba(0,0,0,.06))}
    .b-teal{background:var(--teal)} .b-coral{background:var(--coral)}
    .b-mustard{background:var(--mustard)} .b-navy{background:var(--navy)}

    /* izquierda inferior */
    .b1{width:110px;height:110px;left:70px;bottom:120px}
    .b2{width:22px;height:22px;left:24px;bottom:185px}
    .b3{width:44px;height:44px;left:210px;bottom:95px}
    .b4{width:24px;height:24px;left:320px;bottom:170px}

    /* derecha inferior (círculo grande reducido) */
    .b5{width:360px;height:360px;right:-100px;bottom:-80px}
    .b6{width:90px;height:90px;right:130px;bottom:85px}
    .b7{width:20px;height:20px;right:210px;bottom:220px}

    /* dispersas arriba */
    .b8{width:18px;height:18px;right:270px;top:300px}
    .b9{width:20px;height:20px;left:90px;top:340px}

    /* -------- Marca (logo sin letras + texto WearDrop) -------- */
    .brand{display:flex;align-items:center;justify-content:center;gap:12px;margin-bottom:8px}
    .brand img.logo{width:90px;height:90px;object-fit:contain;display:block}
    .brand .brand-title{font-size:40px;font-weight:700;color:var(--accent);letter-spacing:.2px}

    /* -------- Tarjeta de login más pequeña -------- */
    .login-card{
      width:100%;max-width:460px;background:var(--card);border-radius:16px;
      padding:22px 22px; box-shadow:0 16px 30px rgba(0,0,0,.07),0 2px 8px rgba(0,0,0,.05);
      border:1px solid rgba(0,0,0,.04); margin-inline:auto
    }
    .login-title{font-size:28px;text-align:center;margin:6px 0 14px;font-weight:700}
    .form-label{font-weight:600}
    .form-control{height:44px;border-radius:12px;border:1px solid #e7e7e7;background:#fff}
    .form-control:focus{border-color:#c9cfd6;box-shadow:0 0 0 .2rem rgba(31,45,58,.08)}

    .btn-login{
      height:46px;border-radius:12px;background:var(--btn);border-color:var(--btn);
      color:var(--btn-text)!important;font-weight:700;letter-spacing:.3px
    }
    .btn-login:hover{background:var(--btn-hover);border-color:var(--btn-hover);color:var(--btn-text)!important}
    .btn-login:disabled{background:var(--btn);border-color:var(--btn);color:var(--btn-text)!important;opacity:.85}

    .help-link{color:#4a6572;text-decoration:underline}.help-link:hover{color:#2e3f4e}

    @media (max-width:576px){
      .brand img.logo{width:72px;height:72px}
      .brand .brand-title{font-size:32px}
      .login-card{padding:18px 18px}
      .login-title{font-size:24px}
    }
  </style>
</head>
<body>
  <form id="formLogin" runat="server">
    <div class="page-wrap d-flex flex-column justify-content-center align-items-center">

      <!-- Marca: logo (sin letras en la imagen) + texto WearDrop -->
      <div class="brand">
        <img src="<%= ResolveUrl("~/images/logo.png") %>" alt="Logo WearDrop" class="logo" />
        <div class="brand-title">WearDrop</div>
      </div>

      <!-- Tarjeta de login más compacta -->
      <div class="login-card">
        <h1 class="login-title">Iniciar Sesión</h1>

        <div class="mb-3">
          <label for="txtUsername" class="form-label">Usuario:</label>
          <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Ingresa tu usuario" />
        </div>

        <div class="mb-3">
          <label for="txtPassword" class="form-label">Contraseña:</label>
          <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Ingresa tu contraseña" />
        </div>

        <asp:Label ID="lblMensaje" runat="server" CssClass="text-danger d-block text-center mb-2" EnableViewState="false"></asp:Label>

        <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="btn btn-login w-100" OnClick="btnLogin_Click" />

        <div class="text-center mt-3">
          <small>¿Olvidaste tu contraseña? <a href="#" class="help-link">Recupérala aquí</a></small>
        </div>
      </div>

      <!-- Burbujas pequeñas y espaciadas -->
      <div class="bubbles">
        <span class="bubble b-teal    b1"></span>
        <span class="bubble b-coral   b2"></span>
        <span class="bubble b-coral   b3"></span>
        <span class="bubble b-mustard b4"></span>

        <span class="bubble b-navy    b5"></span>
        <span class="bubble b-coral   b6"></span>
        <span class="bubble b-mustard b7"></span>

        <span class="bubble b-teal    b8"></span>
        <span class="bubble b-mustard b9"></span>
      </div>
    </div>
  </form>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

