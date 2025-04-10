<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="QuickBites.Cart" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .cart-container 
        { 
            max-width: 800px; 
            margin: 0 auto; 
            padding: 20px; 

        }
        .cart-title 
        { 
            text-align: center; 
            margin-bottom: 30px; 
            color: #6f42c1; 

        }
        .cart-table 
        { 
            width: 100%; 
            margin-bottom: 20px; 

        }
        .cart-table th 
        { 
            background: #f5f5f5; 
            padding: 10px; 
            text-align: left; 

        }
        .cart-table td 
        { 
            padding: 10px; 
            border-bottom: 1px solid #eee; 

        }
        .quantity-input 
        { 
            width: 50px; 
            text-align: center; 

        }
        .remove-btn 
        { 
            color: #ff3333; 
            cursor: pointer; 

        }
        .cart-summary { 
            text-align: right; 
            margin: 20px 0; 

        }
        .cart-actions { 
            display: flex; 
            justify-content: space-between; 

        }
        .btn 
        { 
            padding: 10px 20px; 
            border-radius: 4px; 
            cursor: pointer; 

        }
        .btn-continue { 
            background: #f5f5f5; 
            border: 1px solid #ddd; 

        }
        .btn-checkout { 
            background: #6f42c1; 
            color: white; 
            border: none; 

        }
        .empty-cart 
        { 
            text-align: center; 
            padding: 50px 0; 

        }
    </style>

    <div class="cart-container">
        <h1 class="cart-title">Your Shopping Cart</h1>
        
        <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="false" CssClass="cart-table"
            OnRowCommand="gvCart_RowCommand" EmptyDataText="Your cart is empty" ShowHeaderWhenEmpty="true">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Item" />
                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' 
                            CssClass="quantity-input" TextMode="Number" min="1" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="btnRemove" runat="server" CommandName="Remove" 
                            CommandArgument='<%# Eval("CartItemId") %>' CssClass="remove-btn" Text="Remove" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        
        <div class="cart-summary">
            <h3>Total: <asp:Label ID="lblTotal" runat="server" Text="Rs.0.00"></asp:Label></h3>
        </div>
        
        <div class="cart-actions">
            <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" 
                CssClass="btn btn-continue" OnClick="btnContinueShopping_Click" />
            <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" 
                CssClass="btn btn-checkout" OnClick="btnCheckout_Click" />
        </div>
    </div>
</asp:Content>