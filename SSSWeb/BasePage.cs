using SSSModel;
using SSSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SSSWeb
{
    #region 自己的统一登陆
    
    public class BasePage : System.Web.UI.Page
    {
        protected Sys_User UserInfo { get; set; }
        protected override void OnInit(EventArgs e)
        {
            string TokenPath = ConfigHelper.GetConfigString("TokenPath");
            //登陆页地址 从Web.config 读取
            string LoginPage = ConfigHelper.GetConfigString("LoginPage");
            try
            {
                string action = Request["action"];
                if (!string.IsNullOrEmpty(action) && action == "loginOut")   //退出登录
                {
                    Response.Cookies["LoginCookie_Author"].Expires = DateTime.Now.AddDays(-3);
                    Response.Cookies["ClassID"].Expires = DateTime.Now.AddDays(-3);
                    Response.Cookies["TokenID"].Expires = DateTime.Now.AddDays(-3);
                    //跳转登陆页面
                    Response.Redirect(LoginPage);
                }
                else
                {
                    JavaScriptSerializer jss = new JavaScriptSerializer();
                    if (Request.Cookies["LoginCookie_Author"] != null && !string.IsNullOrWhiteSpace(Request.Cookies["LoginCookie_Author"].Value))
                    {
                        string loginCookie = "";
                        if (Request.Cookies["TokenID"] != null && !string.IsNullOrWhiteSpace(Request.Cookies["TokenID"].Value))
                        {
                            #region
                            var postData = "&Func=GetUserInfoByToken&tokenID=" + System.Web.HttpUtility.UrlDecode(Request.Cookies["TokenID"].Value) + "&returnUrl=" + Request.Url.ToString();
                            string result = NetHelper.RequestPostUrl(TokenPath, postData);

                            if (!string.IsNullOrWhiteSpace(result))
                            {
                                int starIndex = result.IndexOf(":") + 1;
                                int endIndex = result.LastIndexOf("}");
                                result = result.Substring(starIndex, endIndex - starIndex);
                                JsonModel jsonModel = jss.Deserialize<JsonModel>(result);
                                if (jsonModel != null && jsonModel.retData != null && jsonModel.errNum == 0)
                                {
                                    Dictionary<string, object> ht = jsonModel.retData as Dictionary<string, object>;
                                    if (ht != null)
                                    {
                                        Sys_User item = new Sys_User();
                                        System.Reflection.PropertyInfo[] properties = item.GetType().GetProperties();
                                        foreach (System.Reflection.PropertyInfo property in properties)
                                        {
                                            if (ht.ContainsKey(property.Name))
                                            {
                                                if (property.PropertyType.Name.StartsWith("String"))
                                                    property.SetValue(item, ht[property.Name].SafeToString(), null);
                                                if (property.PropertyType.Name.StartsWith("Int32"))
                                                    property.SetValue(item, Convert.ToInt32(ht[property.Name]), null);
                                                if (property.PropertyType.Name.StartsWith("DateTime"))
                                                    property.SetValue(item, Convert.ToDateTime(ht[property.Name]), null);
                                                if (property.PropertyType.Name.StartsWith("Byte"))
                                                    property.SetValue(item, Convert.ToByte(ht[property.Name]), null);
                                            }
                                        }
                                        UserInfo = item;
                                        Response.Cookies["LoginCookie_Author"].Value = HttpUtility.UrlEncode(JsonHelper.SerializeObject(UserInfo));
                                        Response.Cookies["username"].Expires = DateTime.MaxValue;
                                    }
                                }
                                else
                                {
                                    Response.Cookies["LoginCookie_Author"].Expires = DateTime.Now.AddDays(-3);
                                    Response.Cookies["ClassID"].Expires = DateTime.Now.AddDays(-3);
                                    Response.Cookies["TokenID"].Expires = DateTime.Now.AddDays(-3);

                                    Response.Redirect(LoginPage);
                                }
                            }
                            #endregion
                        }
                        else
                        {
                            loginCookie = System.Web.HttpUtility.UrlEncode(Request.Cookies["LoginCookie_Author"].Value);
                            Sys_User item = jss.Deserialize<Sys_User>(loginCookie);
                            UserInfo = item;

                        }
                    }
                    else if (Request.Cookies["TokenID"] != null && !string.IsNullOrWhiteSpace(Request.Cookies["TokenID"].Value))
                    {
                        #region
                        var postData = "&Func=GetUserInfoByToken&tokenID=" + System.Web.HttpUtility.UrlDecode(Request.Cookies["TokenID"].Value) + "&returnUrl=" + Request.Url.ToString();
                        string result = NetHelper.RequestPostUrl(TokenPath, postData);

                        if (!string.IsNullOrWhiteSpace(result))
                        {
                            int starIndex = result.IndexOf(":") + 1;
                            int endIndex = result.LastIndexOf("}");
                            result = result.Substring(starIndex, endIndex - starIndex);
                            JsonModel jsonModel = jss.Deserialize<JsonModel>(result);
                            if (jsonModel != null && jsonModel.retData != null && jsonModel.errNum == 0)
                            {
                                Dictionary<string, object> ht = jsonModel.retData as Dictionary<string, object>;
                                if (ht != null)
                                {
                                    Sys_User item = new Sys_User();
                                    System.Reflection.PropertyInfo[] properties = item.GetType().GetProperties();
                                    foreach (System.Reflection.PropertyInfo property in properties)
                                    {
                                        if (ht.ContainsKey(property.Name))
                                        {
                                            if (property.PropertyType.Name.StartsWith("String"))
                                                property.SetValue(item, ht[property.Name].SafeToString(), null);
                                            if (property.PropertyType.Name.StartsWith("Int32"))
                                                property.SetValue(item, Convert.ToInt32(ht[property.Name]), null);
                                            if (property.PropertyType.Name.StartsWith("DateTime"))
                                                property.SetValue(item, Convert.ToDateTime(ht[property.Name]), null);
                                            if (property.PropertyType.Name.StartsWith("Byte"))
                                                property.SetValue(item, Convert.ToByte(ht[property.Name]), null);
                                        }
                                    }
                                    UserInfo = item;
                                    Response.Cookies["LoginCookie_Author"].Value = HttpUtility.UrlEncode(JsonHelper.SerializeObject(UserInfo));
                                    Response.Cookies["username"].Expires = DateTime.MaxValue;
                                }
                                if (Request.Url.ToString().IndexOf("Login.aspx") > -1 || Request.Url.ToString().IndexOf("Resgister.aspx") > -1)
                                    Response.Redirect("/Index.aspx");
                                else
                                    Response.Redirect(Request.Url.ToString());
                            }
                            else
                            {
                                Response.Cookies["LoginCookie_Author"].Expires = DateTime.Now.AddDays(-3);
                                Response.Cookies["ClassID"].Expires = DateTime.Now.AddDays(-3);
                                Response.Cookies["TokenID"].Expires = DateTime.Now.AddDays(-3);

                                Response.Redirect(LoginPage);
                            }
                        }
                        #endregion
                    }
                    else
                    {
                        Response.Redirect(LoginPage);
                    }
                    if (UserInfo.AbsHeadPic == ""|| UserInfo.HeadPic=="")
                    {
                        UserInfo.AbsHeadPic = "../images/Ci27jlb8o1yAAVzUAAAXXN3q5BM579.jpg";
                    }
                }
                base.OnInit(e);
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);
                Response.Redirect(LoginPage);
            }
        }
    }

    [Serializable]
    public partial class Sys_User
    {
        /// <summary>
        ///主键 
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        ///用户唯一值 
        /// </summary>
        public string UniqueNo { get; set; }
        /// <summary>
        ///用户类型 
        /// </summary>
        public string UserType { get; set; }
        /// <summary>
        ///姓名 
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        ///昵称 
        /// </summary>
        public string Nickname { get; set; }
        /// <summary>
        ///性别 
        /// </summary>
        public string Sex { get; set; }
        /// <summary>
        ///联系电话 
        /// </summary>
        public string Phone { get; set; }
        /// <summary>
        ///出生日期 
        /// </summary>
        public string Birthday { get; set; }
        /// <summary>
        ///用户账号 
        /// </summary>
        public string LoginName { get; set; }
        /// <summary>
        ///密码 
        /// </summary>
        public string Password { get; set; }
        /// <summary>
        ///身份证件号 
        /// </summary>
        public string IDCard { get; set; }
        /// <summary>
        ///相对路径头像 
        /// </summary>
        public string HeadPic { get; set; }
        /// <summary>
        /// 绝对路径头像
        /// </summary>
        public string AbsHeadPic { get; set; }
        /// <summary>
        ///注册的组织机构 
        /// </summary>
        public string RegisterOrg { get; set; }
        /// <summary>
        ///认证类型 
        /// </summary>
        public string AuthenType { get; set; }
        /// <summary>
        ///现住址 
        /// </summary>
        public string Address { get; set; }
        /// <summary>
        ///备注 
        /// </summary>
        public string Remarks { get; set; }
        /// <summary>
        ///创建人 
        /// </summary>
        public string CreateUID { get; set; }
        /// <summary>
        ///创建时间 
        /// </summary>
        public DateTime CreateTime { get; set; }
        /// <summary>
        ///修改人 
        /// </summary>
        public string EditUID { get; set; }
        /// <summary>
        ///修改时间 
        /// </summary>
        public DateTime EditTime { get; set; }
        /// <summary>
        ///启用/禁用 
        /// </summary>
        public string IsEnable { get; set; }
        /// <summary>
        ///是否删除 
        /// </summary>
        public string IsDelete { get; set; }

        public string CheckMsg { get; set; }

        public int IsFirstLogin { get; set; }
        public string Email { get; set; }
    }
    #endregion
    /*#region 财贸统一登陆
    
    public class BasePage : System.Web.UI.Page
    {
        protected Sys_User UserInfo { get; set; }

        protected override void OnInit(EventArgs e)
        {
            try
            {
                JavaScriptSerializer jss = new JavaScriptSerializer();
                string loginCookie = System.Web.HttpUtility.UrlDecode(Request.Cookies["LoginCookie_Author"].Value);
                loginCookie = loginCookie.Substring(1, loginCookie.Length - 2);

                Sys_User item = jss.Deserialize<Sys_User>(loginCookie);
                UserInfo = item;

                if (UserInfo.AbsHeadPic == ""||UserInfo.HeadPic=="")
                {
                    UserInfo.AbsHeadPic = "/images/Ci27jlb8o1yAAVzUAAAXXN3q5BM579.jpg";
                }





                base.OnInit(e);
            }
            catch (Exception ex)
            {
                LogHelper.Error(ex);

                Response.Redirect("~/Index.aspx");
            }
        }
    }

    [Serializable]
    public class Sys_User
    {
        public int rowNum { get; set; }
        /// <summary>
        ///主键 
        /// </summary>
        public int Id { get; set; }
        /// <summary>
        ///用户唯一值 
        /// </summary>
        public string UniqueNo { get; set; }
        /// <summary>
        ///用户类型 
        /// </summary>
        public string UserType { get; set; }
        /// <summary>
        ///姓名 
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        ///昵称 
        /// </summary>
        public string Nickname { get; set; }
        /// <summary>
        ///性别 
        /// </summary>
        public string Sex { get; set; }
        /// <summary>
        ///联系电话 
        /// </summary>
        public string Phone { get; set; }
        /// <summary>
        ///出生日期 
        /// </summary>
        public string Birthday { get; set; }
        /// <summary>
        ///用户账号 
        /// </summary>
        public string LoginName { get; set; }
        /// <summary>
        ///密码 
        /// </summary>
        public string Password { get; set; }           /// <summary>
        ///身份证件号 
        /// </summary>
        public string IDCard { get; set; }
        /// <summary>
        ///相对路径头像 
        /// </summary>
        public string HeadPic { get; set; }
        /// <summary>
        /// 绝对路径头像
        /// </summary>
        public string AbsHeadPic { get; set; }
        /// <summary>
        ///注册的组织机构 
        /// </summary>
        public string RegisterOrg { get; set; }
        /// <summary>
        ///认证类型 
        /// </summary>
        public string AuthenType { get; set; }
        /// <summary>
        ///现住址 
        /// </summary>
        public string Address { get; set; }
        /// <summary>
        ///备注 
        /// </summary>
        public string Remarks { get; set; }
        /// <summary>
        ///创建人 
        /// </summary>
        public string CreateUID { get; set; }
        /// <summary>
        ///创建时间 
        /// </summary>
        public DateTime CreateTime { get; set; }
        /// <summary>
        ///修改人 
        /// </summary>
        public string EditUID { get; set; }
        /// <summary>
        ///修改时间 
        /// </summary>
        public DateTime EditTime { get; set; }
        /// <summary>
        ///启用/禁用 
        /// </summary>
        public string IsEnable { get; set; }
        /// <summary>
        ///是否删除 
        /// </summary>
        public string IsDelete { get; set; }

        public string CheckMsg { get; set; }

        public int IsFirstLogin { get; set; }
    }
    #endregion*/
}