<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="QuickBites.Checkout" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .checkout-container { max-width: 800px; margin: 0 auto; padding: 20px; }
        .checkout-title { text-align: center; color: #6f42c1; margin-bottom: 30px; }
        .order-summary { background: #f9f9f9; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
        .address-form { margin-bottom: 30px; }
        .form-group { margin-bottom: 15px; }
        .form-label { display: block; margin-bottom: 5px; font-weight: 500; }
        .form-control { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .btn-place-order { background: #6f42c1; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; }
    </style>

    <div class="checkout-container">
        <h1 class="checkout-title">Checkout</h1>
        
        <!-- Order Summary -->
        <div class="order-summary">
            <h3>Order Summary</h3>
            <asp:GridView ID="gvOrderSummary" runat="server" AutoGenerateColumns="false" CssClass="cart-table" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Item" />
                    <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
                </Columns>
            </asp:GridView>
            <div class="text-right">
                <h4>Total: <asp:Label ID="lblTotal" runat="server" Text="₹0.00"></asp:Label></h4>
            </div>
        </div>

        <!-- Delivery Address -->
        <div class="address-form">
            <h3>Delivery Information</h3>
            <div class="form-group">
                <label class="form-label">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" required="true"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Phone Number</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" required="true" TextMode="Phone"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Delivery Address</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" required="true"></asp:TextBox>
            </div>
            <div class="form-group">
                <label class="form-label">Special Instructions</label>
                <asp:TextBox ID="txtInstructions" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
            </div>
        </div>

        <!-- Payment Method -->
        <div class="payment-method">
            <h3>Payment Method</h3>
            <asp:RadioButtonList ID="rblPaymentMethod" runat="server">
                <asp:ListItem Text="Cash on Delivery" Value="COD" Selected="True" />
                <asp:ListItem Text="Online Payment" Value="Online" />
            </asp:RadioButtonList>
        </div>

        <!-- Place Order Button -->
        <div class="text-center">
            <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" 
                CssClass="btn-place-order" OnClick="btnPlaceOrder_Click" />
        </div>
    </div>
</asp:Content>