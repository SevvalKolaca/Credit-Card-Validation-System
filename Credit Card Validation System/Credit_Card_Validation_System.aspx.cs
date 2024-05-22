using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


namespace Web_Based
{

    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void tb_card_number_TextChanged(object sender, EventArgs e)
        {
            // Girilen metnin yalnızca sayısal karakterlerden oluştuğunu kontrol et
            if (!tb_card_number.Text.All(char.IsDigit))
            {
                lbl_error_card.Text = "!!! Credit card number is in invalid format. !!!";
                tb_card_number.Text = "";
            }
            else if (tb_card_number.Text.Length < 13)
            {
                lbl_error_card.Text = "!!! Credit card number has an inappropriate number of digits !!!";
                tb_card_number.Text = "";
            }
            else
                DetectCardType(tb_card_number.Text);
        }

        protected void tb_owner_TextChanged(object sender, EventArgs e)
        {

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private bool ccvTextChanged = false;
        protected void tb_ccv_TextChanged(object sender, EventArgs e)
        {
            string ccv = tb_ccv.Text;
            string cardNumber = tb_card_number.Text;

            if (!(ccv.Length == 3 || ccv.Length == 4))
            {
                ccvTextChanged = false;
            }
            else
            {
                ccvTextChanged = true;
            }
        }

        protected void btn_confirm_Click(object sender, EventArgs e)
        {
            // Kart numarası uzunluğu 0 ise veya tüm rakamlardan oluşmuyorsa veya Luhn algoritmasına uymuyorsa
            if (tb_card_number.Text.Length == 0 ||
                !tb_card_number.Text.All(char.IsDigit) ||
                !checkLuhn(tb_card_number.Text))
            {
                lbl_error_card.Text = "!!! Invalid card number. !!!";
                return; // Kart numarası hatalıysa işlemi sonlandır
            }

            // Ad ve soyadın geçerliliğini kontrol et
            string fullName = tb_owner.Text.Trim();
            string[] names = fullName.Split(' ');
            foreach (string name in names)
            {
                if (!name.All(char.IsLetter))
                {
                    lbl_error_owner.Text = "!!! Entered name type is not valid !!!";
                    return; // Ad ve soyad hatalıysa işlemi sonlandır
                }
            }

            // CCV'nin uygunluğunu kontrol et
            if (!(tb_ccv.Text.Length == 3 || tb_ccv.Text.Length == 4))
            {
                lbl_error_ccv.Text = "!!! Invalid CCV !!!";
                return; // CCV hatalıysa işlemi sonlandır
            }

            // Tarih geçerliliğini kontrol et
            date_validation(ddl_year, ddl_month, lbl_error_card);

            // Tüm doğrulama işlemleri başarılıysa bu blok çalışacak
            tb_owner.Text = "";
            tb_card_number.Text = "";
            tb_ccv.Text = "";
            ddl_month.SelectedIndex = 0;
            ddl_year.SelectedIndex = 0;
            lbl_error_card.Text = " CREDIT CARD IS VALID";
        }


        public void DetectCardType(string cardNumber)
        {
            // Visa kontrolü
            if ((cardNumber.Length == 13 || cardNumber.Length == 16) && cardNumber.StartsWith("4"))
            {
                img_mastercard.BorderColor = ColorTranslator.FromHtml("#FFFFFF");
                img_amex.BorderColor = ColorTranslator.FromHtml("#FFFFFF");
                img_visa.BorderColor = ColorTranslator.FromHtml("#FF0066");
            }
            // MasterCard kontrolü
            else if (cardNumber.Length == 16 &&
                     (cardNumber.StartsWith("51") || cardNumber.StartsWith("52") ||
                      cardNumber.StartsWith("53") || cardNumber.StartsWith("54") ||
                      cardNumber.StartsWith("55") ||
                      Enumerable.Range(2221, 499).Any(range => cardNumber.StartsWith(range.ToString()))))
            {
                img_amex.BorderColor = ColorTranslator.FromHtml("#FFFFFF");
                img_visa.BorderColor = ColorTranslator.FromHtml("#FFFFFF");
                img_mastercard.BorderColor = ColorTranslator.FromHtml("#FF0066");
            }
            // American Express kontrolü
            else if (cardNumber.Length == 15 &&
                     (cardNumber.StartsWith("34") || cardNumber.StartsWith("37")))
            {
                img_mastercard.BorderColor = ColorTranslator.FromHtml("#FFFFFF");
                img_visa.BorderColor = ColorTranslator.FromHtml("#FFFFFF");
                img_amex.BorderColor = ColorTranslator.FromHtml("#FF0066");
                tb_card_number.Attributes["style"] = "~/images/visa.png";
            }
            else
                lbl_error_card.Text = "!!! Unknown card type. !!!";
        }
     
        static void date_validation(DropDownList year, DropDownList month, Label error)
        {
            try
            {
                // Seçilen yıl ve ay değerlerini al
                int selectedYear = int.Parse(year.Items[year.SelectedIndex].Value);
                int selectedMonth = int.Parse(month.Items[month.SelectedIndex].Value);

                // Geçerli tarihi oluştur
                DateTime currentDate = DateTime.Now;
                int currentMonth = currentDate.Month;
                int currentYear = currentDate.Year;

                // Geçerli tarihin kontrolü
                if (selectedYear < currentYear || (selectedYear == currentYear && selectedMonth < currentMonth))
                {
                    error.Text = "!!! Invalid Date !!!";
                }
                else
                {
                    error.Text = ""; // Geçerli tarih durumunda hata mesajını temizle
                }
            }
            catch (Exception ex)
            {
                // Hata mesajını günlüğe kaydet veya hata mesajını göster
                Console.WriteLine("Hata: " + ex.Message);
            }
        }

        static bool checkLuhn(String cardNo)
        {
            int nDigits = cardNo.Length;

            int nSum = 0;
            bool isSecond = false;
            for (int i = nDigits - 1; i >= 0; i--)
            {
                int d = cardNo[i] - '0';

                if (isSecond == true)
                    d = d * 2;

                // We add two digits to handle
                // cases that make two digits 
                // after doubling
                nSum += d / 10;
                nSum += d % 10;

                isSecond = !isSecond;
            }
            return (nSum % 10 == 0);
        }
    }
}

