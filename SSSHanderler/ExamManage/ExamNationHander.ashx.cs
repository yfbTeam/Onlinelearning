using SSSBLL;
using SSSHanderler.OnlineLearning;
using SSSModel;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SSSHanderler.ExamManage
{
    /// <summary>
    /// ExamNationHander 的摘要说明
    /// </summary>
    public class ExamNationHander : IHttpHandler
    {
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();

        Exam_ExaminationService nationservice = new Exam_ExaminationService();
        Exam_service examservice = new Exam_service();
        Exam_AnswerService awBll = new Exam_AnswerService();
        CommonHandler common = new CommonHandler();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["action"].ToString();
            string result = string.Empty;
            try
            {
                switch (action)
                {
                    //获取试卷（未答、已答、未阅、已阅）
                    case "GetExamNPageList":
                        GetExamNPageList(context);
                        break;
                    //获取试卷总得分
                    case "GetdataEA":
                        GetdataEA(context);
                        break;
                    #region Exam_Answer（操作）
                    //添加答案
                    case "addExam_ExamAnswer":
                        addExam_ExamAnswer(context);
                        break;
                    case "upExam_ExamAnswer":
                        upExam_ExamAnswer(context);
                        break;
                    //获取答案客观题详情
                    case "GetAnswerListObj":
                        GetAnswerListObj(context);
                        break;
                    //获取答案主观题详情
                    case "GetAnswerListSub":
                        GetAnswerListSub(context);
                        break;
                    #endregion

                    #region  Exam_Examination（操作）
                    //新增答题记录
                    case "addExamination":
                        addExamination(context);
                        break;
                    //更新学生答题状态（有数据且Status=1）
                    case "upExam_Examination":
                        upExam_Examination(context);
                        break;
                    #endregion

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
        #region 获取试卷总得分
        /// <summary>
        ///获取试卷总得分
        /// </summary>
        /// <param name="context"></param>
        private void GetdataEA(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExamID", context.Request["ExamID"] ?? "");
                jsonModel = examservice.GetdataEA(ht);
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
        #region 修改试卷总得分
        private void upExam_ExamAnswer(HttpContext context)
        {
            try
            {
                Exam_Answer model = new Exam_Answer();
                model.ExamId = Convert.ToInt32(context.Request["ExamID"]);
                model.Score = Convert.ToDecimal(context.Request["Score"]);
                model.Type = Convert.ToInt32(context.Request["Type"]);
                model.QuestionId = Convert.ToInt32(context.Request["QuestionId"]);

                jsonModel = examservice.upExam_ExamAnswer(model);
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

        #region 答案数据添加（Exam_Answer）
        /// <summary>
        /// 答案数据添加（Exam_Answer）
        /// </summary>
        /// <param name="context"></param>
        private void addExam_ExamAnswer(HttpContext context)
        {
            try
            {
                string ExamID = context.Request["ExamID"].SafeToString();
                Exam_Answer model = new Exam_Answer();
                model.ExamId = Convert.ToInt32(ExamID);
                model.QuestionId = Convert.ToInt32(context.Request["QuestionID"]);
                model.PaperId = Convert.ToInt32(context.Request["QuestionID"]);
                model.Type = Convert.ToInt32(context.Request["Type"]);
                model.Answer = context.Request["Answer"];
                model.Score = Convert.ToDecimal(context.Request["Score"]);
                jsonModel = awBll.Add(model);
                if (jsonModel.errNum == 0)
                {
                    Exam_Examination modol = new Exam_Examination();
                    modol.ID = int.Parse(ExamID);
                    modol.Status = 1;
                    nationservice.Update(modol);
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
        #endregion
        #region 获取主客观题答案详细信息
        private void GetAnswerListSub(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Type", context.Request["Type"] ?? "");
                ht.Add("ExamID", context.Request["ExamID"] ?? "");
                jsonModel = examservice.GetAnswerListSub(ht);
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

        private void GetAnswerListObj(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Type", context.Request["Type"] ?? "");
                ht.Add("ExamID", context.Request["ExamID"] ?? "");
                jsonModel = examservice.GetAnswerListObj(ht);
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

        #region 新增答题记录
        /// <summary>
        /// 新增答题记录
        /// </summary>
        /// <param name="context"></param>
        private void addExamination(HttpContext context)
        {
            Hashtable ht1 = new Hashtable();
            ht1.Add("CreateUID", context.Request["CreateUID"] ?? "");
            ht1.Add("ExampaperID", context.Request["ExampaperID"] ?? "");

            JsonModel jModol = nationservice.GetPage(ht1, false);
            if (jModol.errNum == 0)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 999,
                    errMsg = "已有数据",
                    retData = ""
                };
            }
            else
            {
                try
                {
                    Exam_Examination model = new Exam_Examination();
                    model.CreateUID = context.Request["CreateUID"];
                    model.ExampaperID = Convert.ToInt32(context.Request["ExampaperID"]);
                    model.Score = Convert.ToDecimal(context.Request["Score"]);
                    model.Status = Convert.ToInt32(context.Request["Status"]);
                    model.Marker = Convert.ToInt32(context.Request["Marker"]);
                    model.AnswerBeginTime = Convert.ToDateTime(context.Request["AnswerBeginTime"]);
                    model.AnswerEndTime = Convert.ToDateTime(context.Request["AnswerEndTime"]);

                    jsonModel = examservice.addExamination(model);
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
        }
        #endregion
        #region 更新学生答题状态（有数据且Status=1）
        /// <summary>
        /// 更新学生答题状态（有数据且Status=1）
        /// </summary>
        /// <param name="context"></param>
        private void upExam_Examination(HttpContext context)
        {
            try
            {
                int ID = Convert.ToInt32(context.Request["ID"]);
                Exam_Examination model = (Exam_Examination)(nationservice.GetEntityById(ID).retData);
                model.Status = Convert.ToInt32(context.Request["Status"]);
                nationservice.Update(model);
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

        #region 获取试卷（未答、已答、未阅、已阅）
        /// <summary>
        /// 获取试卷（未答、已答、未阅、已阅）
        /// </summary>
        /// <param name="context"></param>
        private void GetExamNPageList(HttpContext context)
        {  
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Status", context.Request["Status"] ?? "");
                ht.Add("Title", context.Request["Title"] ?? "");
                ht.Add("Type", context.Request["Type"] ?? "");
                ht.Add("ClassID", context.Request["ClassID"] ?? "");
                ht.Add("Book", context.Request["Book"] ?? "");
                ht.Add("noCreateUID", context.Request["noCreateUID"] ?? "");
                ht.Add("CreateUID", context.Request["CreateUID"] ?? "");
                ht.Add("tStatus", context.Request["tStatus"] ?? "");
                ht.Add("AnswerUser", context.Request["AnswerUser"].SafeToString());
                bool ispage = true;
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["IsPage"]))
                {
                    ispage = false;
                }
                ht.Add("PageIndex", context.Request["PageIndex"] ?? "");
                ht.Add("PageSize", context.Request["PageSize"] ?? "");
                jsonModel =common.AddCreateNameForData(nationservice.GetPage(ht, ispage), ispage,"CreateUID","PaperAuthor");
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