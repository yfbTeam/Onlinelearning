using DotNetCasClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SSSWeb
{
    public partial class Index : System.Web.UI.Page
    {
        public string name = "";
        public CasAuthenticationTicket casTicket;
        protected void Page_Load(object sender, EventArgs e)
        {
            FormsAuthenticationTicket tkt = CasAuthentication.GetFormsAuthenticationTicket();
            name = tkt.Name;
            LoginName.Value = name;
            casTicket = CasAuthentication.ServiceTicketManager.GetTicket(tkt.UserData);
            //string result = "";
        }
    }
}