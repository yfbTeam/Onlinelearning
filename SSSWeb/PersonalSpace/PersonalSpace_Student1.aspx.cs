﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SSSWeb.PersonalSpace
{
    public partial class PersonalSpace_Student : BasePage
    {
        public string PhotoName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            PhotoName = UserInfo.AbsHeadPic.Substring(UserInfo.AbsHeadPic.LastIndexOf("/"), UserInfo.AbsHeadPic.Length - UserInfo.AbsHeadPic.LastIndexOf("/"));
        }
    }
}