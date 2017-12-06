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
    /// EduHander 的摘要说明
    /// </summary>
    public class EduHander : IHttpHandler
    {
        JsonModel jsonModel = null;
        string sysAccountNo = ConfigHelper.GetConfigString("SysAccountNo");
        string u_handlerUrl = ConfigHelper.GetConfigString("Unified_HandlerUrl").SafeToString();
        JavaScriptSerializer jss = new JavaScriptSerializer();
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
                        //获取专业信息
                        case "GetMajorInfo":
                            GetMajorInfo(context);
                            break;
                        //获取学科信息
                        case "GetSubJect":
                            GetSubJect(context);
                            break;
                        //获取版本信息
                        case "GetBookVersion":
                            GetBookVersion(context);
                            break;
                        case "DelBookVersion":
                            DelBookVersion(context);
                            break;
                        //获取目录信息
                        case "GetBookCatalog":
                            GetBookCatalog(context);
                            break;
                        case "AddCatalog":
                            AddCatalog(context);
                            break;
                        //添加目录信息
                        case "EditCatalog":
                            EditCatalog(context);
                            break;
                        //删除目录信息
                        case "DelCatalog":
                            DelCatalog(context);
                            break;

                        //获取目录信息
                        case "GetBook":
                            GetBook(context);
                            break;
                        case "AddBook":
                            AddBook(context);
                            break;

                        //获取所有信息
                        case "GetPSTVData":
                            GetPSTVData(context);
                            break;
                        case "AddBookVersion":
                            AddBookVersion(context);
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
            //result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            //context.Response.Write(result);
            //context.Response.End();
        }
        private void GetMajorInfo(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/BooKManage.ashx?";
            string urlbady = "Func=GetMajorInfo&SysAccountNo=" + sysAccountNo;

            if (context.Request["Ispage"] == "false")
            {
                urlbady += "&Ispage=false";
            }
            else
            {
                urlbady += "&PageIndex=" + (context.Request["PageIndex"] ?? "1") + "&PageSize=" + (context.Request["PageSize"] ?? "10");
            }

            string PageUrl = urlHead + urlbady + "&parm=" + DateTime.Now.Ticks;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);

            context.Response.Write(result);
            context.Response.End();
        }
        private void GetSubJect(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/BooKManage.ashx?";
            string urlbady = "Func=GetSubJect&SysAccountNo=" + sysAccountNo;

            if (context.Request["Ispage"] == "false")
            {
                urlbady += "&Ispage=false";
            }
            else
            {
                urlbady += "&PageIndex=" + (context.Request["PageIndex"] ?? "1") + "&PageSize=" + (context.Request["PageSize"] ?? "10");
            }
            if (context.Request["Name"].SafeToString().Length > 0)
            {
                urlbady += "&Name=" + context.Request["Name"].SafeToString();
            }
            string PageUrl = urlHead + urlbady + "&parm=" + DateTime.Now.Ticks;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);

            context.Response.Write(result);
            context.Response.End();
        }
        private void AddBookVersion(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/BooKManage.ashx?";
            string urlbady = "Func=AddBookVersion&SysAccountNo=" + sysAccountNo;

            string Name = context.Request["Name"];
            urlbady += "&Name=" + Name;

            string PageUrl = urlHead + urlbady + "&parm=" + DateTime.Now.Ticks;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);

            context.Response.Write(result);
            context.Response.End();
        }
        private void GetBookVersion(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/BooKManage.ashx?";
            string urlbady = "Func=GetBookVersion&SysAccountNo=" + sysAccountNo;

            if (!string.IsNullOrEmpty(context.Request["Ispage"]))
            {
                if (context.Request["Ispage"] == "false")
                {
                    urlbady += "&Ispage=false";
                }
                else
                {
                    urlbady += "&PageIndex=" + (context.Request["PageIndex"] ?? "1") + "&PageSize=" + (context.Request["PageSize"] ?? "10");
                }
            }
            else
            {
                urlbady += "&Ispage=false";

            }

            string PageUrl = urlHead + urlbady + "&parm=" + DateTime.Now.Ticks;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);

            context.Response.Write(result);
            context.Response.End();
        }
        private void DelBookVersion(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/BooKManage.ashx?";
            string urlbady = "Func=DelBookVersion&SysAccountNo=" + sysAccountNo;
            string ID = context.Request["Id"].SafeToString();


            if (ID.Length > 0)
            {
                urlbady += "&ID=" + ID;
            }
            string PageUrl = urlHead + urlbady;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);

            context.Response.Write(result);
            context.Response.End();
        }
        private void DelCatalog(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/BooKManage.ashx?";
            string urlbady = "Func=DelCatalog&SysAccountNo=" + sysAccountNo;
            string ID = context.Request["Id"].SafeToString();


            if (ID.Length > 0)
            {
                urlbady += "&ID=" + ID;
            }
            string PageUrl = urlHead + urlbady;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();

        }

        private void AddCatalog(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/BooKManage.ashx?";
            string urlbady = "Func=AddCatalog&SysAccountNo=" + sysAccountNo;
            string BookID = context.Request["TextbooxID"].SafeToString();
            string Name = context.Request["Name"].SafeToString();
            string Pid = context.Request["PID"].SafeToString();


            if (BookID.Length > 0)
            {
                urlbady += "&BookID=" + BookID;
            }
            if (Name.Length > 0)
            {
                urlbady += "&Name=" + Name;
            }
            if (Pid.Length > 0)
            {
                urlbady += "&Pid=" + Pid;
            }
            string PageUrl = urlHead + urlbady;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);

            context.Response.Write(result);
            context.Response.End();

        }

        private void EditCatalog(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/BooKManage.ashx?";
            string urlbady = "Func=EditCatalog&SysAccountNo=" + sysAccountNo;

            string Name = context.Request["Name"].SafeToString();
            string Id = context.Request["Id"].SafeToString();


            if (Name.Length > 0)
            {
                urlbady += "&Name=" + Name;
            }

            if (Id.Length > 0)
            {
                urlbady += "&Id=" + Id;
            }
            string PageUrl = urlHead + urlbady;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);

            context.Response.Write(result);
            context.Response.End();

        }

        private void GetBookCatalog(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/BooKManage.ashx?";
            string urlbady = "Func=GetBookCatalog&SysAccountNo=" + sysAccountNo;
            if (context.Request["Ispage"] == "false")
            {
                urlbady += "&Ispage=false";
            }
            else
            {
                urlbady += "&PageIndex=" + (context.Request["PageIndex"] ?? "1") + "&PageSize=" + (context.Request["PageSize"] ?? "10");
            }
            string BookID = context.Request["TextbooxID"].SafeToString();
            if (BookID.Length > 0)
            {
                urlbady += "&BookID=" + BookID;
            }
            if (context.Request["Name"].SafeToString().Length > 0)
            {
                urlbady += "&Name=" + context.Request["Name"].SafeToString();
            }
            string Pid = context.Request["PID"].SafeToString();
            if (Pid.Length > 0)
            {
                urlbady += "&Pid=" + Pid;
            }
            string PageUrl = urlHead + urlbady + "&parm=" + DateTime.Now.Ticks;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);

            context.Response.Write(result);
            context.Response.End();
        }

        private void AddBook(HttpContext context)
        {
            string result = "";
            string[] SubIDArry = context.Request["Subject[]"].SafeToString().Split(',');
            for (int i = 0; i < SubIDArry.Length; i++)
            {
                string urlHead = u_handlerUrl + "/EduManage/BooKManage.ashx?";
                string urlbady = "Func=AddBook&SysAccountNo=" + sysAccountNo;

                string Name = context.Request["Name"];
                urlbady += "&Name=" + Name;

                string MajorID = context.Request["Major"].SafeToString();
                string VersionID = context.Request["Version"].SafeToString();
                urlbady += "&MajorID=" + MajorID;
                urlbady += "&VersionID=" + VersionID;
                urlbady += "&SubID=" + SubIDArry[i];


                string PageUrl = urlHead + urlbady;
                LogService.WriteLog(PageUrl + urlbady);
                result = NetHelper.RequestPostUrl(PageUrl, urlbady);

            }
            context.Response.Write(result);
            context.Response.End();

        }

        private void GetBook(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/BooKManage.ashx?";
            string urlbady = "Func=GetBook&SysAccountNo=" + sysAccountNo;

            if (!string.IsNullOrEmpty(context.Request["Ispage"]))
            {
                if (context.Request["Ispage"] == "false")
                {
                    urlbady += "&Ispage=false";
                }
                else
                {
                    urlbady += "&PageIndex=" + (context.Request["PageIndex"] ?? "1") + "&PageSize=" + (context.Request["PageSize"] ?? "10");
                }
                if (context.Request["Name"].SafeToString().Length > 0)
                {
                    urlbady += "&Name=" + context.Request["Name"].SafeToString();
                }
            }
            else
            {
                urlbady += "&Ispage=false";

            }

            string PageUrl = urlHead + urlbady + "&parm=" + DateTime.Now.Ticks;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);

            context.Response.Write(result);
            context.Response.End();
        }
        private void GetPSTVData(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/BooKManage.ashx?";
            string urlbady = "Func=GetPSTVData&SysAccountNo=" + sysAccountNo;

            if (!string.IsNullOrEmpty(context.Request["Ispage"]))
            {
                if (context.Request["Ispage"] == "false")
                {
                    urlbady += "&Ispage=false";
                }
                else
                {
                    urlbady += "&PageIndex=" + (context.Request["PageIndex"] ?? "1") + "&PageSize=" + (context.Request["PageSize"] ?? "10");
                }
            }
            else
            {
                urlbady += "&Ispage=false";

            }

            string PageUrl = urlHead + urlbady + "&parm=" + DateTime.Now.Ticks;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);

            context.Response.Write(result);
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