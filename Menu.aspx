<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="QuickBites.Menu" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .menu-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .menu-title {
            text-align: center;
            color: #6f42c1;
            margin-bottom: 30px;
        }

        .category-filter {
            margin-bottom: 20px;
            max-width: 300px;
            margin: 0 auto 20px;
        }

        .menu-items {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .menu-item {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

            .menu-item:hover {
                transform: translateY(-5px);
            }
/*
        .item-image {
            height: 200px;
            overflow: hidden;
            background: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
        }

            .item-image img {
                max-width: 100%;
                max-height: 100%;
            }*/

        .item-details {
            padding: 15px;
        }

            .item-details h3 {
                margin: 0 0 10px 0;
                color: #333;
            }

        .description {
            color: #666;
            font-size: 14px;
            margin-bottom: 15px;
            min-height: 40px;
        }

        .item-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .price {
            font-weight: bold;
            color: #6f42c1;
            font-size: 18px;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
        }

        .qty-btn {
            width: 30px;
            height: 30px;
            border: 1px solid #ddd;
            background: #f5f5f5;
            cursor: pointer;
            font-weight: bold;
        }

        .qty-input {
            width: 40px;
            height: 30px;
            text-align: center;
            border: 1px solid #ddd;
            margin: 0 5px;
        }

        .add-to-cart {
            background: #6f42c1;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
        }

            .add-to-cart:hover {
                background: #E66000;
            }

        .floating-cart {
            position: fixed;
            top: 70px;
            right: 50px;
            z-index: 1000;
        }

        .cart-btn {
            background: #6f42c1;
            color: white;
            border: none;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            position: relative;
        }

        .cart-icon {
            font-size: 24px;
        }

        .cart-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #ff3333;
            color: white;
            width: 25px;
            height: 25px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
        }

        @media (max-width: 768px) {
            .menu-items {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="menu-container">
        <h1 class="menu-title">Hamro Menu</h1>
       <%-- <div class="floating-cart">
            <asp:LinkButton ID="btnViewCart" runat="server" CssClass="cart-btn" OnClick="btnViewCart_Click">
                <span class="cart-icon">🛒</span>
                <span class="cart-count" id="cartCount" runat="server">0</span>
            </asp:LinkButton>
        </div>--%>
        <div class="category-filter">
            <asp:DropDownList ID="ddlCategories" runat="server" AutoPostBack="true"
                OnSelectedIndexChanged="ddlCategories_SelectedIndexChanged" CssClass="form-control">
                <asp:ListItem Value="0" Text="All Categories"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="menu-items">
            <asp:Repeater ID="rptProducts" runat="server">
                <ItemTemplate>
                    <div class="menu-item">
                        <div class="item-details">
                            <h3><%# Eval("Name") %></h3>
                            <p class="description"><%# Eval("Description") %></p>
                            <div class="item-footer">
                                <span class="price">रु<%# Eval("Price", "{0:0.00}") %></span>
                                <div class="quantity-controls">
                                    <asp:Button ID="btnDecrease" runat="server" Text="-" CssClass="qty-btn"
                                        CommandArgument='<%# Eval("ProductId") %>' OnClick="btnDecrease_Click" />
                                    <asp:TextBox ID="txtQuantity" runat="server" Text="1" CssClass="qty-input" ReadOnly="true" />
                                    <asp:Button ID="btnIncrease" runat="server" Text="+" CssClass="qty-btn"
                                        CommandArgument='<%# Eval("ProductId") %>' OnClick="btnIncrease_Click" />
                                </div>
                                <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="add-to-cart"
                                    CommandArgument='<%# Eval("ProductId") %>' OnClick="btnAddToCart_Click" />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>


    </div>
</asp:Content>
