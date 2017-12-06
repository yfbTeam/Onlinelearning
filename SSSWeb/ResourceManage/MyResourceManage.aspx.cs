using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SSSWeb.CourseManage
{
    public partial class MyResource : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (UserInfo != null)
            {

                HUserName.Value = UserInfo.Name;
            }
        }

       
    }
}