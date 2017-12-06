using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SSSBLL;
using System.Web.Script.Serialization;
using SSSModel;
using SSSUtility;
using System.Collections;
using SSSHanderler.OnlineLearning;
namespace SSSHanderler.SystemSettings
{
    /// <summary>
    /// NoticeManage 的摘要说明
    /// </summary>
    public class NoticeManage : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        System_NoticeService bll = new System_NoticeService();
        CommonHandler common = new CommonHandler();
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
                        case "GetData":
                            GetData(context);
                            break;
                        case "AddNotice":
                            AddNotice(context);
                            break;
                        case "DelNotice":
                            DelNotice(context);
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
        #region 删除

        private void DelNotice(HttpContext context)
        {
            string[] IDArry = context.Request["ID"].SafeToString().Split(',');
            try
            {
                for (int i = 0; i < IDArry.Length; i++)
                {
                    if (IDArry[i].Length > 0)
                    {
                        jsonModel = bll.Delete(Convert.ToInt32(IDArry[i]));
                    }
                }

            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 404,
                    errMsg = ex.Message,
                    retData = ""
                };
            }
        }
        #endregion

        #region 获取信息
        /// <summary>
        /// 获取信息
        /// </summary>
        /// <param name="context"></param>
        private void GetData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                bool Flag = true;
                if (context.Request["IsPage"].SafeToString() != "")
                {
                    Flag = Convert.ToBoolean(context.Request["IsPage"]);
                }
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("IsPage", context.Request["IsPage"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("Name", context.Request["Title"].SafeToString());
                ht.Add("Type", context.Request["Type"].SafeToString());
                ht.Add("IsTop", context.Request["IsTop"].SafeToString());
                ht.Add("IsAll", context.Request["IsAll"].SafeToString());
                ht.Add("UserNo", context.Request["UserNo"].SafeToString());
                ht.Add("Org", context.Request["Org"].SafeToString());
                ht.Add("CreateUID", context.Request["CreateUID"].SafeToString());
                jsonModel = common.AddCreateNameForData(bll.GetPage(ht, Flag), Flag);
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

        #region 添加/修改

        private void AddNotice(HttpContext context)
        {
            try
            {
                System_Notice Entiry = new System_Notice();
                Entiry.Title = context.Request["Title"].SafeToString();
                Entiry.Content = HttpUtility.UrlDecode(context.Request["Content"].SafeToString());
                Entiry.IsAll = Convert.ToInt32(context.Request["IsAll"]); ;
                if (Entiry.IsAll == 1)
                {
                    Entiry.ReviwerOrgS = "";
                    Entiry.ReviwerUserIDS = "";
                }
                else
                {
                    Entiry.ReviwerOrgS = context.Request["ReviwerOrgS"].SafeToString();
                    Entiry.ReviwerUserIDS = context.Request["ReviwerUserIDS"].SafeToString();
                }
                Entiry.IsTop = Convert.ToInt32(context.Request["IsTop"]); ;
                Entiry.Type = Convert.ToInt32(context.Request["Type"]);
                if (context.Request["ID"].SafeToString().Length > 0)
                {
                    Entiry.EditUID = context.Request["CreateUID"].SafeToString();
                    Entiry.EditTime = DateTime.Now;
                    Entiry.ID = Convert.ToInt32(context.Request["ID"]);
                    jsonModel = bll.Update(Entiry);
                }
                else
                {
                    Entiry.CreateUID = context.Request["CreateUID"].SafeToString();

                    jsonModel = bll.Add(Entiry);
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 404,
                    errMsg = ex.Message,
                    retData = ""
                };
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