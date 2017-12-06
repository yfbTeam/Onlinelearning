using SSSBLL;
using SSSHanderler.OnlineLearning;
using SSSModel;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;


namespace SSSHanderler.Recruit
{
    /// <summary>
    /// RecruitHandler 的摘要说明
    /// </summary>
    public class RecruitHandler : IHttpHandler
    {
        Recruit_InfoService bll = new Recruit_InfoService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        CommonHandler common = new CommonHandler();

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
                        case "ChangeStatus":
                            ChangeStatus(context);
                            break;
                        case "GetStuInfo":
                            GetStuInfo(context);
                            break;
                        //学生报名
                        case "SinIn":
                            SinIn(context);
                            break;
                        case "Check":
                            Check(context);
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
        #region
        private void Check(HttpContext context)
        {
            Recruit_StuService bll = new Recruit_StuService();
            string ID = context.Request["ID"].SafeToString();
            Recruit_Stu entity = (Recruit_Stu)bll.GetEntityById(Convert.ToInt32(ID)).retData;
            entity.Status = Convert.ToInt32(context.Request["Status"]);
            jsonModel = bll.Update(entity);
        }
        private void SinIn(HttpContext context)
        {
            Recruit_StuService bll = new Recruit_StuService();
            Recruit_Stu entity = new Recruit_Stu();

            entity.Name = context.Request["Name"].SafeToString();
            entity.Address = context.Request["Address"].SafeToString();
            entity.ContactPhone = context.Request["ContactPhone"].SafeToString();
            entity.GraduSchol = context.Request["GraduSchol"].SafeToString();
            entity.InfoNo = context.Request["InfoNo"].SafeToString();
            entity.Intrested = context.Request["Intrested"].SafeToString();

            jsonModel = bll.Add(entity);
        }
        private void Add(HttpContext context)
        {
            Recruit_Info entity = new Recruit_Info();
            string ID = context.Request["ID"].SafeToString();
            if (ID.Trim().Length > 0)
            {
                entity = (Recruit_Info)bll.GetEntityById(Convert.ToInt32(ID)).retData;
            }
            entity.Name = context.Request["Name"].SafeToString();
            entity.BeginTime = Convert.ToDateTime(context.Request["BeginTime"]);
            entity.EndTime = Convert.ToDateTime(context.Request["EndTime"]); ;
            entity.EnrollmentPlan = Convert.ToInt32(context.Request["EnrollmentPlan"]); ;
            entity.EnrollMents = Convert.ToInt32(context.Request["EnrollMents"]);
            entity.Photo = context.Request["Photo"].SafeToString();
            entity.HotLine = context.Request["HotLine"].SafeToString();
            entity.Introduce = context.Request["Introduce"].SafeToString();
            entity.CreateUID = context.Request["CreateUID"].SafeToString();
            if (ID.Trim().Length > 0)
            {
                jsonModel = bll.Update(entity);
            }
            else
            {
                jsonModel = bll.Add(entity);
            }
        }
        private void ChangeStatus(HttpContext context)
        {
            string ID = context.Request["ID"].SafeToString();

            Recruit_Info entity = (Recruit_Info)bll.GetEntityById(Convert.ToInt32(ID)).retData;
            entity.Status = Convert.ToInt32(context.Request["Status"]);
            jsonModel = bll.Update(entity);

        }
        private void Del(HttpContext context)
        {
            int ID = Convert.ToInt32(context.Request["ID"]);
            jsonModel = bll.Delete(ID);
        }
        private void GetStuInfo(HttpContext context)
        {
            Recruit_StuService bll = new Recruit_StuService();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("PlanName", context.Request["PlanName"].SafeToString());
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
        #region 获取信息

        private void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("Name", context.Request["Name"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
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

        #endregion
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