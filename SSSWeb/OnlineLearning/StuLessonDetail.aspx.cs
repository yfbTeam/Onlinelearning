﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SSSWeb.OnlineLearning
{
    public partial class StuLessonDetail : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (UserInfo != null)
            {
                HUserIdCard.Value = UserInfo.UniqueNo;
                HStuIDCard.Value = UserInfo.UniqueNo;
                HUserName.Value = UserInfo.Name;
            }
        }
    }
}