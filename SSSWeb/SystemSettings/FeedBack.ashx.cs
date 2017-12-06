using SSSModel;
using SSSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SSSWeb.SystemSettings
{
    /// <summary>
    /// FeedBack 的摘要说明
    /// </summary>
    public class FeedBack : IHttpHandler
    {
        JsonModel jsonModel = null;
        JavaScriptSerializer jss = new JavaScriptSerializer();
        string u_handlerUrl = ConfigHelper.GetConfigString("Unified_HandlerUrl").SafeToString();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            string result = string.Empty;
            try
            {
                if (FuncName != null && FuncName != "")
                {
                    switch (FuncName)
                    {
                        case "Add":
                            Add(context);
                            break;
                        case "Edit":
                            Edit(context);
                            break;
                        case "Del":
                            Del(context);
                            break;
                      
                        default:
                            jsonModel = new JsonModel()
                            {
                                errNum = 5,
                                errMsg = "没有此方法",
                                retData = ""
                            };
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        private void Add(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/FeedBack.ashx?";
            string urlbady = "Func=Add&StuNo=" + context.Request["StuNo"].SafeToString();
            string result = NetHelper.RequestPostUrl(urlHead, urlbady);

            context.Response.Write(result);
            context.Response.End();
        }
        private void Edit(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/FeedBack.ashx?";
            string urlbady = "Func=Edit&StuNo=" + context.Request["StuNo"].SafeToString() + "&Status=" + context.Request["Status"].SafeToString();
            string result = NetHelper.RequestPostUrl(urlHead, urlbady);
            context.Response.End();
        }
        private void Del(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/FeedBack.ashx?";
            string urlbady = "Func=Del&StuNo=" + context.Request["StuNo"].SafeToString();
            string result = NetHelper.RequestPostUrl(urlHead, urlbady);
            context.Response.End();

        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}