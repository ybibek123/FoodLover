<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="QuickBites.Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Custom CSS (scoped to this page) -->
    <style>
        .register-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            background: white;
        }

        .register-header h2 {
            color: #6f42c1;
            font-weight: 600;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 500;
        }

        .form-control {
            padding: 0.75rem 1rem;
            border-radius: 8px;
            border: 1px solid #ddd;
        }

            .form-control:focus {
                border-color: #6f42c1;
                box-shadow: 0 0 0 0.25rem rgba(255, 107, 0, 0.15);
            }

        .btn-register {
            background-color: #6f42c1;
            border: none;
            padding: 0.75rem;
            font-weight: 500;
            width: 100%;
            border-radius: 8px;
        }

            .btn-register:hover {
                background-color: #E05E00;
            }

        .field-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #777;
        }

        .validation-error {
            color: #dc3545;
            font-size: 0.875rem;
        }
    </style>

    <div class="register-container">
        <div class="register-header">
            <h2>Create Your Account</h2>
            <p class="text-muted text-center">Start ordering your favorite meals in minutes</p>
        </div>

        <!-- Registration Form -->
        <div class="row g-3">
            <!-- Full Name -->
            <div class="col-md-12">
                <label class="form-label">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="John Doe" required></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFullName"
                    CssClass="validation-error" ErrorMessage="Required"></asp:RequiredFieldValidator>
            </div>

            <!-- Email -->
            <div class="col-md-6">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="your@email.com" required></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                    CssClass="validation-error" ErrorMessage="Required"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail"
                    ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                    CssClass="validation-error" ErrorMessage="Invalid email"></asp:RegularExpressionValidator>
            </div>

            <!-- Phone -->
            <div class="col-md-6">
                <label class="form-label">Phone</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+1234567890" required></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone"
                    CssClass="validation-error" ErrorMessage="Required"></asp:RequiredFieldValidator>
            </div>

            <!-- Street Address -->
            <div class="col-md-8">
                <label class="form-label">Street Address</label>
                <asp:TextBox ID="txtStreet" runat="server" CssClass="form-control" placeholder="123 Main St" required></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStreet"
                    CssClass="validation-error" ErrorMessage="Required"></asp:RequiredFieldValidator>
            </div>

            <!-- City -->
            <div class="col-md-4">
                <label class="form-label">City</label>
                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="New York" required></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity"
                    CssClass="validation-error" ErrorMessage="Required"></asp:RequiredFieldValidator>
            </div>

            <!-- Password -->
            <div class="col-md-6">
                <label class="form-label">Password</label>
                <div class="position-relative">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" required></asp:TextBox>
                    <span class="field-icon" onclick="togglePassword('<%= txtPassword.ClientID %>')">
                        <i class="far fa-eye"></i>
                    </span>
                </div>
                <asp:RequiredFieldValidator ID="cvPassword" runat="server" ControlToValidate="txtPassword"
                    CssClass="validation-error" ErrorMessage="Required"></asp:RequiredFieldValidator>
            </div>

            <!-- Confirm Password -->
            <div class="col-md-6">
                <label class="form-label">Confirm Password</label>
                <div class="position-relative">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" required></asp:TextBox>
                    <span class="field-icon" onclick="togglePassword('<%= txtConfirmPassword.ClientID %>')">
                        <i class="far fa-eye"></i>
                    </span>
                </div>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmPassword"
                    CssClass="validation-error" ErrorMessage="Required"></asp:RequiredFieldValidator>
                <asp:CompareValidator runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword"
                    CssClass="validation-error" ErrorMessage="Passwords don't match"></asp:CompareValidator>
            </div>

            <!-- Terms Checkbox -->
            <div class="col-12">
                <div class="form-check">
                    <asp:CheckBox ID="cbTerms" runat="server" CssClass="form-check-input" />
                    <label class="form-check-label">
                        I agree to the <a href="/terms" style="color: #6f42c1">Terms</a> and <a href="/privacy" style="color: #6f42c1">Privacy Policy</a>
                    </label>
                    <asp:CustomValidator ID="cvTerms" runat="server"
                        ClientValidationFunction="validateTerms"
                        CssClass="validation-error d-block"
                        ErrorMessage="You must accept the terms"
                        OnServerValidate="cvTerms_ServerValidate">
                    </asp:CustomValidator>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="col-12">
                <asp:Button ID="btnRegister" runat="server" Text="Create Account"
                    CssClass="btn btn-register" OnClick="btnRegister_Click" />
            </div>

            <!-- Login Link -->
            <div class="col-12 text-center mt-3">
                <p>Already have an account? <a href="/Login" style="color: #6f42c1">Sign in</a></p>
            </div>
        </div>
    </div>

    <!-- JavaScript for Password Toggle -->
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

        function validateTerms(source, args) {
            args.IsValid = document.getElementById('<%= cbTerms.ClientID %>').checked;
        }
    </script>
</asp:Content>
