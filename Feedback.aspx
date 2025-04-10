<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="QuickBites.Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <h2 class="text-center text-purple mb-4">We Value Your Feedback</h2>
        <asp:Label ID="lblMessage" runat="server" CssClass="text-success"></asp:Label>

        <div class="mb-3">
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name" required></asp:TextBox>
        </div>
        <div class="mb-3">
            <asp:TextBox ID="txtComment" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Your feedback" required></asp:TextBox>
        </div>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit Feedback" CssClass="btn btn-primary-custom" OnClick="btnSubmit_Click" />
    </div>
</asp:Content>