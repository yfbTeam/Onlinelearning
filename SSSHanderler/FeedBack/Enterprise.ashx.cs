using SSSBLL;
using SSSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using SSSUtility;
using System.Collections;
namespace SSSHanderler.FeedBack
{
    /// <summary>
    /// Enterprise 的摘要说明
    /// </summary>
    public class Enterprise : IHttpHandler
    {
        FeedBack_EnterpriseInfoService bll = new FeedBack_EnterpriseInfoService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string FuncName = context.Request["Func"].SafeToString();
            string result = string.Empty;

            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "GetPageList":
                            GetPageList(context);
                            break;
                        case "DelEnterprise":
                            DelEnterprise(context);
                            break;
                        case "AddEnterprise":
                            AddEnterprise(context);
                            break;
                        case "GetJobList":
                            GetJobList(context);
                            break;
                        case "AddJob":
                            AddJob(context);
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

        #region 获取企业信息
        /// <summary>
        /// 获取课程信息
        /// </summary>
        /// <param name="context"></param>
        private void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("Name", context.Request["Name"].SafeToString());
                ht.Add("Status", context.Request["Status"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("LoginName", context.Request["LoginName"].SafeToString());
                ht.Add("PassWord", context.Request["PassWord"]);
                bool Ispage = true;
                if (context.Request["Ispage"].SafeToString().Length > 0)
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                jsonModel = bll.GetPage(ht, Ispage);
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
        private void GetJobList(HttpContext context)
        {
            FeedBack_EnterJobService bll = new FeedBack_EnterJobService();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "FeedBack_EnterJob");
                string EnterID = context.Request["EnterID"].SafeToString();

                jsonModel = bll.GetPage(ht, false, " and EnterID=" + EnterID);
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

        #region 添加企业

        private void AddEnterprise(HttpContext context)
        {
            try
            {
                FeedBack_EnterpriseInfo entity = new FeedBack_EnterpriseInfo();
                string ID = context.Request["ID"].SafeToString();
                string Status = context.Request["Status"].SafeToString();
                string Job = context.Request["Job"].SafeToString().TrimEnd(',');
                if (ID.Length > 0)
                {
                    entity = (FeedBack_EnterpriseInfo)bll.GetEntityById(Convert.ToInt32(ID)).retData;
                }
                if (Status.Length > 0)
                {
                    entity.Status = Convert.ToInt32(Status);
                }
                else
                {
                    entity.Name = context.Request["Name"].SafeToString();
                    entity.ContactMan = context.Request["ContactMan"].SafeToString();
                    entity.ContactPhone = context.Request["ContactPhone"].SafeToString();
                    entity.LoginName = context.Request["LoginName"].SafeToString();
                    entity.PassWord = context.Request["PassWord"].SafeToString();
                    entity.Email = context.Request["Email"].SafeToString();
                }
                if (ID.Length > 0)
                {
                    jsonModel = bll.Update(entity);
                }
                else
                {
                    string result = bll.AddEnterprise(entity, Job);
                    if (result == "")
                    {
                        jsonModel = new JsonModel()
                        {
                            errNum = 1,
                            errMsg = "",
                            retData = ""
                        };

                    }
                    else
                    {
                        jsonModel = new JsonModel()
                        {
                            errNum = 404,
                            errMsg = result,
                            retData = ""
                        };
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
        private void AddJob(HttpContext context)
        {
            FeedBack_EnterJobService bll = new FeedBack_EnterJobService();
            try
            {
                FeedBack_EnterJob entity = new FeedBack_EnterJob();
                string ID = context.Request["ID"].SafeToString();
                string Status = context.Request["Status"].SafeToString();
                if (ID.Length > 0)
                {
                    entity = (FeedBack_EnterJob)bll.GetEntityById(Convert.ToInt32(ID)).retData;
                    if (Status.Length > 0)
                    {
                        entity.Status = Convert.ToInt32(Status);
                    }
                }

                if (ID.Length > 0)
                {
                    jsonModel = bll.Update(entity);
                }
                else
                {
                    entity.EnterID = Convert.ToInt32(context.Request["EnterID"]);
                    entity.Name = context.Request["Name"].SafeToString();
                    jsonModel = bll.Add(entity);
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
        #region 删除企业

        private void DelEnterprise(HttpContext context)
        {
            string ID = context.Request["ID"].SafeToString();
            try
            {
                jsonModel = bll.Delete(Convert.ToInt32(ID));
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