using SSSBLL;
using SSSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using SSSUtility;
using System.Collections;
using SSSHanderler.OnlineLearning;

namespace SSSHanderler.FeedBack
{
    /// <summary>
    /// FeedBack 的摘要说明
    /// </summary>
    public class FeedBack : IHttpHandler
    {
        FeedBack_DepartmentStuService bll = new FeedBack_DepartmentStuService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        CommonHandler common = new CommonHandler();
        string u_handlerUrl = ConfigHelper.GetConfigString("Unified_HandlerUrl").SafeToString();

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
                        case "Add":
                            Add(context);
                            break;
                        case "Del":
                            Del(context);
                            break;
                        case"Edit":
                            Edit(context);
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
        private void Add(HttpContext context)
        {
            FeedBack_DepartmentStu entity = new FeedBack_DepartmentStu();
            string StuNo = context.Request["StuNo"].SafeToString();
            entity.EnterID = Convert.ToInt32(context.Request["EnterID"]);
            entity.JobID = Convert.ToInt32(context.Request["JobID"]);
            entity.StuNo = StuNo;
            jsonModel = bll.Add(entity);
            Add(StuNo);
        }
        private void Del(HttpContext context)
        {
            int ID = Convert.ToInt32(context.Request["ID"]);
            FeedBack_DepartmentStu entity = (FeedBack_DepartmentStu)bll.GetEntityById(ID).retData;
            string StuNo = entity.StuNo;
            jsonModel = bll.Delete(ID);
            Del(StuNo);
        }
        private void Add(string StuNo)
        {
            string urlHead = u_handlerUrl + "/EduManage/FeedBack.ashx?";
            string urlbady = "Func=Add&StuNo=" + StuNo;
            NetHelper.RequestPostUrl(urlHead, urlbady);
        }

        private void Del(string StuNo)
        {
            string urlHead = u_handlerUrl + "/EduManage/FeedBack.ashx?";
            string urlbady = "Func=Del&StuNo=" + StuNo;
            NetHelper.RequestPostUrl(urlHead, urlbady);

        }
        #region 获取信息

        private void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("EnterName", context.Request["EnterName"].SafeToString());
                ht.Add("Status", context.Request["Status"].SafeToString());
                ht.Add("JobName", context.Request["JobName"].SafeToString());
                ht.Add("EnterID", context.Request["EnterID"].SafeToString());
                ht.Add("JobID", context.Request["JobID"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());

                bool Ispage = true;
                if (context.Request["Ispage"].SafeToString().Length > 0)
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                jsonModel = bll.GetPage(ht, Ispage);
                jsonModel = new CommonHandler().AddCreateNameForData(jsonModel, Ispage, "StuNo");

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
        private void Edit(HttpContext context) {
            string ID = context.Request["ID"].SafeToString();
            FeedBack_DepartmentStu entity = (FeedBack_DepartmentStu)bll.GetEntityById(Convert.ToInt32(ID)).retData;
            entity.StartTime = Convert.ToDateTime(context.Request["StartTime"]);
            entity.EndTime = Convert.ToDateTime(context.Request["EndTime"]);
            entity.Content = context.Request["Content"].SafeToString();
            entity.ScoreResult = context.Request["ScoreResult"].SafeToString();
            entity.IdentifidMsg = context.Request["IdentifidMsg"].SafeToString();
            entity.Status = 1;
            string StuNo = entity.StuNo;
            jsonModel = bll.Update(entity);
            if (jsonModel.errNum==1)
            {
                Del(StuNo);
            }

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