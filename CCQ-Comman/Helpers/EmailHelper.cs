using Microsoft.SharePoint;
using Microsoft.SharePoint.Utilities;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace CCQ_Comman.Helpers
{
   public class EmailHelper
    {
        public static bool SendEmail(string toAddress, string fromEmail, string subject, string body)
        {
            bool boolSendEmail = false;

            try
            {
               
                SPSecurity.RunWithElevatedPrivileges(delegate ()
                {
                    MailMessage message = new MailMessage(fromEmail,toAddress, subject, body);
                    
                    message.IsBodyHtml = true;
                    string smtpServer = ConfigurationManager.AppSettings["SMTPServer"];
                    SmtpClient smtp = new SmtpClient(smtpServer);

                    smtp.Send(message);
                });
            }
            catch (Exception ex)
            {
                boolSendEmail = false;

            }
            return boolSendEmail;
        }

    }
}
