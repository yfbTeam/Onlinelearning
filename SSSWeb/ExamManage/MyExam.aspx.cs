using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SSSWeb.ExamManage
{
    public partial class MyExam : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hName.Value = UserInfo.Name;
            hSF.Value = UserInfo.UserType;
            hIDCard.Value = UserInfo.UniqueNo;
        }
    }
}