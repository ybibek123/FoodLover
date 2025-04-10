<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="QuickBites.Login" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .login-container {
            max-width: 500px;
            margin: 3rem auto;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            background: white;
        }
        
        .login-header h2 {
            color: #6f42c1;
            font-weight: 600;
            text-align: center;
            margin-bottom: 1.5rem;
        }
        
        .btn-login {
            background-color: #6f42c1;
            border: none;
            padding: 0.75rem;
            font-weight: 500;
            width: 100%;
            border-radius: 8px;
            transition: all 0.3s;
        }
        
        .btn-login:hover {
            background-color: #E05E00;
        }
        
        .forgot-password {
            text-align: right;
            margin-top: -10px;
            margin-bottom: 1rem;
        }
    </style>

    <div class="login-container">
        <div class="login-header">
            <h2>Welcome Back</h2>
            <p class="text-muted text-center">Sign in to your FoodLover account</p>
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Email</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" 
                TextMode="Email" placeholder="your@email.com" required></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                CssClass="text-danger" ErrorMessage="Email is required" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Password</label>
            <div class="position-relative">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" 
                    TextMode="Password" placeholder="Your password" required></asp:TextBox>
                <span class="field-icon" onclick="togglePassword('<%= txtPassword.ClientID %>')">
                    <i class="far fa-eye"></i>
                </span>
            </div>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
                CssClass="text-danger" ErrorMessage="Password is required" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        
        <div class="mb-3 form-check">
            <asp:CheckBox ID="cbRememberMe" runat="server" CssClass="form-check-input" />
            <label class="form-check-label">Remember me</label>
        </div>
        
        <div class="forgot-password">
            <a href="/ForgotPassword" style="color:#6f42c1">Forgot password?</a>
        </div>
        
        <asp:Button ID="btnLogin" runat="server" Text="Sign In" 
            CssClass="btn btn-login" OnClick="btnLogin_Click" />
        
        <div class="text-center mt-3">
            <p>Don't have an account? <a href="/Register" style="color:#6f42c1">Sign up</a></p>
        </div>
    </div>

    <script>
        function togglePassword(textboxId) {
            const textbox = document.getElementById(textboxId);
            const icon = textbox.nextElementSibling.querySelector('i');
            
            if (textbox.type === "password") {
                textbox.type = "text";
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                textbox.type = "password";
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        }
    </script>
</asp:Content>