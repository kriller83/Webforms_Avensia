using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Net.Mail;
using AvensiaWebShop.Models;
using System.Web.UI;
using System.Xml.Serialization;
using AvensiaWebShop.Controller;

namespace AvensiaWebShop
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            ScriptResourceDefinition myScriptResourceDefinition = new ScriptResourceDefinition();
            myScriptResourceDefinition.Path = "~/Scripts/jquery-1.9.1.js";
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", null, myScriptResourceDefinition);
        }

        public void Application_Error(object sender, EventArgs e)
        {
            //ApplicationLogg(Server.GetLastError());

            try
            {
                //ApplicationErrorMail(Server.GetLastError());
            }
            catch (Exception ex)
            {
                //ApplicationLogg(ex);
            }
        }

        private void ApplicationLogg(Exception ex)
        {
            string errorDescription = "Avensia Webshop:\r\n" + ex;
            string eventLogName = "Error! Something broke the page...";

            if (!EventLog.SourceExists(eventLogName))
            {
                EventLog.CreateEventSource(eventLogName, eventLogName);
            }

            EventLog log = new EventLog();
            log.Source = eventLogName;
            log.WriteEntry(errorDescription, EventLogEntryType.Error);
        }

        private void ApplicationErrorMail(Exception ex)
        {
            string errorMessage = "Error description:\r\n" + ex;

            var fromAddress = new MailAddress("shopbot@flycycle.se", "FlyCycle Bot");
            var toAddress = new MailAddress("admin@flycycle.se");

            var subject = "Sidfel!";
            var body = errorMessage + " Please reestablish the webpage asap";

            WebShopController.SendMail(fromAddress, toAddress, subject, body, MailPriority.High);
        }
    }
}
