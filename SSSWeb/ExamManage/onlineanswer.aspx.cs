using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SSSWeb.ExamManage
{
    public partial class onlineanswer : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hIDCard.Value = UserInfo.UniqueNo;
            hName.Value = UserInfo.Name;
            //hnamee.Value = Request["name"];
            hid.Value = Request["id"];
        }
    }
}