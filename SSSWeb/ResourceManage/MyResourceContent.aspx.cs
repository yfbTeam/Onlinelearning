using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SSSWeb.CourseManage
{
    public partial class MyResourceContent : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HUserIdCard.Value = UserInfo.UniqueNo;
        }

    }
}