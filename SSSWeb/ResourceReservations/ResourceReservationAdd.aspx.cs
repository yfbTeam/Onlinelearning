using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SSSWeb.ResourceReservations
{
    public partial class ResourceReservationAdd :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserName.Value = UserInfo.Name;
            HUserIdCard.Value = UserInfo.UniqueNo;
        }
    }
}