<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="QuickBites.OrderDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .order-details-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 25px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.05);
        }
        
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .order-title {
            color: #6f42c1;
            font-size: 24px;
            font-weight: 600;
        }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 14px;
            text-transform: capitalize;
        }
        
        .status-pending { background: #FFF3CD; color: #856404; }
        .status-processing { background: #CCE5FF; color: #004085; }
        .status-shipped { background: #E2E3E5; color: #383D41; }
        .status-delivered { background: #D4EDDA; color: #155724; }
        .status-cancelled { background: #F8D7DA; color: #721C24; }
        
        .order-info-section {
            background: #f9f9f9;
            border-radius: 6px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .section-title {
            color: #6f42c1;
            font-size: 18px;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .info-row {
            margin-bottom: 10px;
            display: flex;
        }
        
        .info-label {
            font-weight: 600;
            color: #555;
            width: 150px;
            flex-shrink: 0;
        }
        
        .info-value {
            color: #333;
        }
        
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        .items-table th {
            background: #6f42c1;
            color: white;
            padding: 12px 15px;
            text-align: left;
            font-weight: 500;
        }
        
        .items-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .total-row {
            text-align: right;
            font-size: 18px;
            font-weight: 600;
            margin: 20px 0;
        }
        
        .total-amount {
            color: #6f42c1;
            font-size: 22px;
        }
        
        .action-buttons {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-weight: 500;
        }
        
        .btn-back {
            background: #6c757d;
            color: white;
        }
        
        .btn-back:hover {
            background: #5a6268;
        }
        
        .btn-track {
            background: #17a2b8;
            color: white;
            margin-right: 10px;
        }
        
        .btn-track:hover {
            background: #138496;
        }
        
        .btn-cancel {
            background: #dc3545;
            color: white;
        }
        
        .btn-cancel:hover {
            background: #c82333;
        }
        
        
        .btn i {
            margin-right: 8px;
        }
    </style>

    <div class="order-details-container">
        <div class="order-header">
            <h1 class="order-title">Order #<asp:Literal ID="litOrderId" runat="server"></asp:Literal></h1>
            <div class="status-badge status-<asp:Literal ID="litStatusClass" runat="server"></asp:Literal>">
                <asp:Literal ID="litStatus" runat="server"></asp:Literal>
            </div>
        </div>

        <div class="order-info-section">
            <h3 class="section-title">Order Information</h3>
            <div class="info-row">
                <div class="info-label">Order Date:</div>
                <div class="info-value"><asp:Literal ID="litOrderDate" runat="server"></asp:Literal></div>
            </div>
            <div class="info-row">
                <div class="info-label">Delivery Address:</div>
                <div class="info-value"><asp:Literal ID="litDeliveryAddress" runat="server"></asp:Literal></div>
            </div>
            <div class="info-row">
                <div class="info-label">Payment Method:</div>
                <div class="info-value"><asp:Literal ID="litPaymentMethod" runat="server"></asp:Literal></div>
            </div>
        </div>

        <h3 class="section-title">Order Items</h3>
        <asp:GridView ID="gvOrderItems" runat="server" AutoGenerateColumns="false" CssClass="items-table"
            EmptyDataText="No items in this order" ShowHeaderWhenEmpty="true">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Item" />
                <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                <asp:BoundField DataField="UnitPrice" HeaderText="Price" DataFormatString="Rs.{0:0.00}" />
                <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="Rs.{0:0.00}" />
            </Columns>
        </asp:GridView>
        
        <div class="total-row">
            <strong>Total Amount: </strong>
            <span class="total-amount"><asp:Literal ID="litTotalAmount" runat="server"></asp:Literal></span>
        </div>

        <div class="action-buttons">
            <asp:Button ID="btnBack" runat="server" Text="Back to My Orders" 
                CssClass="btn btn-back" OnClick="btnBack_Click" />
            
            <div>
                <asp:HyperLink ID="hlTrack" runat="server" 
                    CssClass="btn btn-track" Visible="false">
                    <i class="fas fa-truck"></i> Track Package
                </asp:HyperLink>
                
                <asp:Button ID="btnCancel" runat="server" Text="Cancel Order" 
                    CssClass="btn btn-cancel" Visible="false" OnClick="btnCancel_Click" 
                    OnClientClick="return confirm('Are you sure you want to cancel this order?');" />
            </div>
        </div>
    </div>
</asp:Content>