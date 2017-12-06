using SSSBLL;
using SSSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using SSSUtility;
using SSSHanderler.OnlineLearning;
namespace SSSHanderler.ExamManage
{
    /// <summary>
    /// AnaliseHander 的摘要说明
    /// </summary>
    public class AnaliseHander : IHttpHandler
    {

        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        ExamAnalisyBLL bll = new ExamAnalisyBLL();
        CommonHandler common = new CommonHandler();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["action"].ToString();
            string result = string.Empty;
            try
            {
                if (action != null && action != "")
                {
                    switch (action)
                    {
                        case "GetAvgScore":
                            GetAvgScore(context);
                            break;
                        case "GetTop5Stu":
                            GetTop5Stu(context);
                            break;
                        case "AnaliseQuestionScore":
                            AnaliseQuestionScore(context);
                            break;
                        case "QuestionScoreDetail":
                            QuestionScoreDetail(context);
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
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }
        private void AnaliseQuestionScore(HttpContext context)
        {
            string ExamID = context.Request["ExamID"].SafeToString();
            jsonModel = bll.AnaliseQuestionScore(ExamID);
        }
        private void QuestionScoreDetail(HttpContext context)
        {
            string ExamID = context.Request["ExamID"].SafeToString();
            string QID = context.Request["QID"].SafeToString();
            jsonModel = common.AddCreateNameForData(bll.QuestionScoreDetail(ExamID, QID), false, "StuID");
        }
        private void GetAvgScore(HttpContext context)
        {
            int ExamID = 0;
            if (context.Request["ExamID"].SafeToString().Length > 0 && context.Request["ExamID"].SafeToString() != "undefined")
            {
                ExamID = int.Parse(context.Request["ExamID"]);
            }
            jsonModel = bll.GetAvgScore(ExamID);
        }
        private void GetTop5Stu(HttpContext context)
        {
            int ExamID = 0;
            string Order = context.Request["Order"];
            if (context.Request["ExamID"].SafeToString().Length > 0 && context.Request["ExamID"].SafeToString() != "undefined")
            {
                ExamID = int.Parse(context.Request["ExamID"]);
            }
            jsonModel = common.AddCreateNameForData(bll.GetTop5Stu(Order, ExamID));
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