<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Credit_Card_Validation_System.aspx.cs" Inherits="Web_Based.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Credit Card Validation</title>
    <style>
        body {
            background-color: #C0DEFF; /* Sayfa arka planını mavi yapar */
            padding: 20px; /* İçerikle kenar arasındaki boşluğu ayarlar */
        }
        .content-container {
            margin-top: 150px;
            height: 634px;
            width: 607px;
            border-radius: 10px; /* Kenarları yuvarlar */
            padding: 20px; /* İçerikle kenar arasındaki boşluğu ayarlar */
        }
        .auto-style1 {
            margin-top: 50px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
            background-color: #fff; /* İçerik alanını beyaz yapar */
            padding: 20px;
            height: 430px;
            width: 564px;
        }
        .input-label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .input-field {
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ccc; /* Gri çizgi rengi */
        }
        .input-field:focus {
            border-color: #0056b3; /* Tıklanınca çizgi rengi değişecek */
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            text-align: center;
            cursor: pointer;
            border: none;
            border-radius: 15px;
            background-color: #6499E9;
            color: #fff;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #0056b3;
        }
        .row {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .column {
            margin: 0 10px;
        }
        .lbl_error {
            display: block;
            margin: auto;
            text-align: center;
            color: white;
        }

    </style>
</head>
<body style="display: flex; justify-content: center; align-items: flex-start; height: 125px;">    
    <form id="form1" runat="server">
        <div class="content-container" runat="server">
            <p class="auto-style1">
                <asp:Label ID="lbl_owner" CssClass="input-label" runat="server" Text="Owner" ForeColor="#6499E9" Font-Size="Larger"></asp:Label>
                <asp:TextBox ID="tb_owner" CssClass="input-field" runat="server" style="text-align: center" Width="316px" Height="35px" BorderColor="#CCCCCC" ForeColor="Gray" OnTextChanged="tb_owner_TextChanged" TabIndex="1" ></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="lbl_card_number" CssClass="input-label" runat="server" Text="Card Number" ForeColor="#6499E9" Font-Bold="True" Font-Size="Larger"></asp:Label>
                <asp:TextBox ID="tb_card_number" CssClass="input-field" runat="server" Style="text-align: center" Width="316px" Height="35px" BorderColor="#CCCCCC" ForeColor="Gray" OnTextChanged="tb_card_number_TextChanged"  AutoPostBack="true" MaxLength="16" TabIndex="2"></asp:TextBox>
                <br />
                <br />
                &nbsp;
                <asp:Label ID="lbl_ccv" CssClass="input-label" runat="server" Text="CCV" ForeColor="#6499E9" Width="75px" Font-Size="Larger"></asp:Label>
                &emsp;&ensp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Lbl_expiration_date" CssClass="input-label" runat="server" Text="Expiration Date" ForeColor="#6499E9" Width="166px" Font-Size="Larger"></asp:Label>
                <br />
                <asp:TextBox ID="tb_ccv" CssClass="input-field" runat="server" style="text-align: center; margin-left: 0px;" Width="80px" Height="30px" BorderColor="#CCCCCC" ForeColor="Gray" OnTextChanged="tb_ccv_TextChanged" OnFocus="clearCCVText()" AutoPostBack="true" TabIndex="3">***</asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &ensp;
                <asp:DropDownList ID="ddl_month" CssClass="input-field" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" Width="80px" Height="34px" ForeColor="Gray" TabIndex="4">
                    <asp:ListItem Selected="True">January</asp:ListItem>
                    <asp:ListItem>February</asp:ListItem>
                    <asp:ListItem>March</asp:ListItem>
                    <asp:ListItem>April</asp:ListItem>
                    <asp:ListItem>May</asp:ListItem>
                    <asp:ListItem>June</asp:ListItem>
                    <asp:ListItem>July</asp:ListItem>
                    <asp:ListItem>August</asp:ListItem>
                    <asp:ListItem>September</asp:ListItem>
                    <asp:ListItem>October</asp:ListItem>
                    <asp:ListItem>November</asp:ListItem>
                    <asp:ListItem>December</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddl_year" CssClass="input-field" runat="server" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" Width="80px" Height="34px" ForeColor="Gray" TabIndex="5">
                    <asp:ListItem>2024</asp:ListItem>
                    <asp:ListItem>2025</asp:ListItem>
                    <asp:ListItem>2026</asp:ListItem>
                    <asp:ListItem>2027</asp:ListItem>
                    <asp:ListItem>2028</asp:ListItem>
                </asp:DropDownList>
                <br />
                <br />
                <br />
                <asp:Image ID="img_visa" runat="server" ImageUrl="~/images/visa.png" Width="65px" BorderColor="White" BorderStyle="Solid" ForeColor="#CCCCCC" />
                <asp:Image ID="img_mastercard" runat="server" Height="40px" ImageUrl="~/images/mastercard.png" Width="65px" BorderColor="White" BorderStyle="Solid" />
                <asp:Image ID="img_amex" runat="server" Height="40px" ImageUrl="~/images/amex.png" Width="65px" BorderColor="White" BorderStyle="Solid" />
                <br />
                <br />
                <asp:Button ID="btn_confirm" CssClass="button" runat="server" OnClick="btn_confirm_Click" Text="Confirm" Width="276px" Height="50px" TabIndex="6" />
            </p>
            <asp:Label ID="lbl_error_owner" CssClass="lbl_error" runat="server" ForeColor="White" Font-Bold="True" Font-Size="Large"></asp:Label>
            <asp:Label ID="lbl_error_card" CssClass="lbl_error" runat="server" ForeColor="White" Font-Bold="True" Font-Size="Large"></asp:Label>
            <asp:Label ID="lbl_error_ccv" CssClass="lbl_error" runat="server" ForeColor="White" Font-Bold="True" Font-Size="Large"></asp:Label>
        </div>
      <script>
          function clearCCVText()
          {
              document.getElementById('tb_ccv').value = '';
              return false; // Sayfanın yenilenmesini engellemek icin
          }
      </script>
    </form>
    </body>
</html>