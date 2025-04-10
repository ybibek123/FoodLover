<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="QuickBites.MyOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .orders-container { max-width: 1000px; margin: 0 auto; padding: 20px; }
        .orders-title { text-align: center; color: #6f42c1; margin-bottom: 30px; }
        .orders-table { width: 100%; border-collapse: collapse; }
        .orders-table th { background: #f5f5f5; padding: 12px; text-align: left; }
        .orders-table td { padding: 12px; border-bottom: 1px solid #eee; }
        .order-status { padding: 5px 10px; border-radius: 4px; font-weight: 500; }
        .status-pending { background: #FFF3CD; color: #856404; }
        .status-processing { background: #CCE5FF; color: #004085; }
        .status-delivered { background: #D4EDDA; color: #155724; }
        .btn-view { background: #6f42c1; color: white; padding: 5px 10px; border: none; border-radius: 4px; }
    </style>

    <div class="orders-container">
        <h1 class="orders-title">My Orders</h1>
        
        <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="false" CssClass="orders-table"
            EmptyDataText="You haven't placed any orders yet.">
            <Columns>
                <asp:BoundField DataField="OrderId" HeaderText="Order #" />
                <asp:BoundField DataField="OrderDate" HeaderText="Date" DataFormatString="{0:g}" />
                <asp:BoundField DataField="TotalAmount" HeaderText="Total" DataFormatString="{0:C}" />
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <span class='order-status status-<%# Eval("Status").ToString().ToLower() %>'>
                            <%# Eval("Status") %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HyperLink ID="lnkView" runat="server" 
                            NavigateUrl='<%# "~/OrderDetails.aspx?orderId=" + Eval("OrderId") %>'
                            CssClass="btn-view" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>