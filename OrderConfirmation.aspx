<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="QuickBites.OrderConfirmation" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .confirmation-container { max-width: 600px; margin: 0 auto; padding: 30px; text-align: center; }
        .confirmation-icon { font-size: 80px; color: #4CAF50; margin-bottom: 20px; }
        .order-number { font-size: 24px; margin: 20px 0; }
        .btn-continue { background: #6f42c1; color: white; padding: 10px 20px; border: none; border-radius: 4px; }
    </style>

    <div class="confirmation-container">
        <div class="confirmation-icon">✓</div>
        <h1>Order Confirmed!</h1>
        <p>Thank you for your order. We've received it and will prepare it soon.</p>
        
        <div class="order-number">
            Your order number: <strong><asp:Literal ID="litOrderId" runat="server"></asp:Literal></strong>
        </div>
        
        <p>We'll send you an email with the order details.</p>
        
        <asp:Button ID="btnContinue" runat="server" Text="Continue Shopping" 
            CssClass="btn-continue" OnClick="btnContinue_Click" />
    </div>
</asp:Content>