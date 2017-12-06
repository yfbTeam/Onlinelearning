using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SSSBLL;
using SSSModel;
using SSSUtility;
using System.Web.Script.Serialization;
using System.Collections;
using System.Data;

namespace SSSWeb.CourseManage
{
    /// <summary>
    /// CouseResource 的摘要说明
    /// </summary>
    public class CouseResource : IHttpHandler
    {

        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        Couse_ResourceService bll = new Couse_ResourceService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            string result = string.Empty;

            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "GetResourceList":
                            GetResourceList(context);
                            break;
                       
                        case "getWeikeByID":
                            getWeikeByID(context);
                            break;
                        default:
                            jsonModel = new JsonModel()
                            {
                                errNum = 404,
                                errMsg = "无此方法",
                                retData = ""
                            };
                            break;
                    }
                    LogService.WriteLog("");
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
                result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
                context.Response.Write(result);
                context.Response.End();
            }
        }
        /// <summary>
        /// 绑定微课资源
        /// </summary>
        /// <param name="context"></param>
        private void getWeikeByID(HttpContext context)
        {
            string result = "";
            try
            {
                Hashtable ht = new Hashtable();
                string ID = context.Request["ID"];
                ht.Add("Couse_ResourceID", ID);
                jsonModel = bll.GetPage(ht, false);
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
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();

        }
        

        #region 获取资料信息
        /// <summary>
        /// 获取课程信息
        /// </summary>
        /// <param name="context"></param>
        private void GetResourceList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("CouseID", context.Request["CourceID"].ToString());
                //1视频资源0普通资源
                ht.Add("IsVideo", context.Request["IsVideo"].ToString());
                //章节编号
                ht.Add("ChapterID", context.Request["ChapterID"].ToString());

                ht.Add("StuIdCard", context.Request["StuIdCard"] ?? "");
                //资源名称
                ht.Add("ResName", context.Request["ResName"] ?? "");
                //课程类型（1必修课；2选修课）
                ht.Add("CourceType", context.Request["CourceType"] ?? "");
                //ht.Add("ID", context.Request.Form["ID"].ToString());

                jsonModel = bll.GetPage(ht, false);
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
        #endregion

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}