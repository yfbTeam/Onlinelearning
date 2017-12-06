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

namespace SSSHanderler.ExamManage
{
    /// <summary>
    /// PaperHandler 的摘要说明
    /// </summary>
    public class PaperHandler : IHttpHandler
    {
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        CommonHandler common = new CommonHandler();
        Exam_PaperService papService = new Exam_PaperService();
        Exam_PaperObjQService objPService = new Exam_PaperObjQService();
        Exam_PaperSubQService subPService = new Exam_PaperSubQService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["action"].ToString();
            string result = string.Empty;
            try
            {
                switch (action)
                {
                    case "GetExamPaperDataPage":
                        GetExamPaperDataPage(context);
                        break;
                    case "GetPaperById":
                        GetPaperById(context);
                        break;
                    case "ChangPaperStatus":
                        ChangPaperStatus(context);
                        break;

                    case "addexamlist":
                        addexamlist(context);
                        break;
                    case "upExam_PaperDal":
                        upExam_PaperDal(context);
                        break;
                    case "GetExamPaper":
                        GetExamPaper(context);
                        break;
                    #region 组卷

                    case "addExam_ExamPaperSubQ":
                        addExam_ExamPaperSubQ(context);
                        break;
                    case "addExam_ExamPaperObjQ":
                        addExam_ExamPaperObjQ(context);
                        break;
                    #endregion

                    #region 根据分类查询题库和试卷中各类题的数量

                    //试卷中客观题个数
                    case "GetQNumByTypePaperObj":
                        GetQNumByTypePaperObj(context);
                        break;
                    //试卷中主观题个数
                    case "GetQNumByTypePaperSub":
                        GetQNumByTypePaperSub(context);
                        break;
                    #endregion

                    case "GetQDetailOfPaperObj":
                        GetQDetailOfPaperObj(context);
                        break;
                    case "GetQDetailOfPaperSub":
                        GetQDetailOfPaperSub(context);
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


        #region 获取试卷表的分页数据
        private void GetExamPaperDataPage(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Category", context.Request["Book"] ?? "");
                ht.Add("Book", context.Request["Book"] ?? "");
                ht.Add("KlpointID", context.Request["KlpointID"] ?? "");
                ht.Add("Type", context.Request["Type"] ?? "");
                ht.Add("Title", context.Request["Title"] ?? "");
                ht.Add("Status", context.Request["Status"] ?? "1");
                ht.Add("IsRelease", context.Request["IsRelease"] ?? "1");
                bool ispage = true;
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["IsPage"]))
                {
                    ispage = false;
                }
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                jsonModel = common.AddCreateNameForData(papService.GetPage(ht, ispage), ispage);
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

        #region 根据Id获取试卷详情
        private void GetPaperById(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = papService.GetEntityById(itemid);
        }
        #endregion

        #region 修改试卷的启用或禁用状态
        /// <summary>
        /// 修改试卷的启用或禁用状态
        /// </summary>
        private void ChangPaperStatus(HttpContext context)
        {
            try
            {
                string status = context.Request["Status"].SafeToString();
                string paperId = context.Request["PaperId"].SafeToString();
                jsonModel = papService.GetEntityById(Convert.ToInt32(paperId));
                if (jsonModel.errNum == 0)
                {
                    Exam_Paper paper = jsonModel.retData as Exam_Paper;
                    paper.Status = Convert.ToByte(status);
                    jsonModel = papService.Update(paper);
                }
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog("ChangPaperStatus_修改试卷的启用或禁用状态|||" + ex.Message);
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
            }
        }
        #endregion

        #region 新增试卷 试题副本
        private void addExam_ExamPaperObjQ(HttpContext context)
        {
            try
            {

                Exam_PaperObjQ model = new Exam_PaperObjQ();
                model.PaperId = Convert.ToInt32(context.Request["ExampaperID"]);
                model.Type = Convert.ToInt32(context.Request["Type"]);
                model.TypeName = "";
                model.Content = context.Request["Content"];
                model.OptionA = context.Request["OptionA"];
                model.OptionB = context.Request["OptionB"];
                model.OptionC = context.Request["OptionC"];
                model.OptionD = context.Request["OptionD"];
                model.OptionE = context.Request["OptionE"];
                model.OptionF = context.Request["OptionF"];
                model.Difficulty = Convert.ToByte(context.Request["Difficulty"]);
                model.Answer = context.Request["Answer"];
                model.Score = Convert.ToDecimal(context.Request["Score"]);
                model.IsShowAnalysis = Convert.ToByte(context.Request["IsShowAnalysis"]);
                model.Analysis = context.Request["Analysis"];
                model.OrderId = Convert.ToInt32(context.Request["OrderID"]);

                jsonModel = objPService.Add(model);
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
        private void addExam_ExamPaperSubQ(HttpContext context)
        {
            try
            {
                Exam_PaperSubQ model = new Exam_PaperSubQ();
                model.PaperId = Convert.ToInt32(context.Request["ExampaperID"]);
                model.Type = Convert.ToInt32(context.Request["Type"]);
                model.TypeName = "";
                model.Content = context.Request["Content"];
                model.Difficulty = Convert.ToByte(context.Request["Difficulty"]);
                model.Answer = context.Request["Answer"];
                model.Score = Convert.ToDecimal(context.Request["Score"]);
                model.IsShowAnalysis = Convert.ToByte(context.Request["IsShowAnalysis"]);
                model.Analysis = context.Request["Analysis"];
                model.OrderId = Convert.ToInt32(context.Request["OrderID"]);

                jsonModel = subPService.Add(model);
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

        #region 根据分类查询题库和试卷中各类题的数量
        private void GetQNumByTypePaperObj(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExampaperID", context.Request["ExampaperID"] ?? "");
                jsonModel = papService.GetdataEPQ(ht);
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
        private void GetQNumByTypePaperSub(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExampaperID", context.Request["ExampaperID"] ?? "");
                jsonModel = papService.GetdataEPS(ht);
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
        private void addexamlist(HttpContext context)
        {
            try
            {
                string Type = context.Request["Type"];
                Hashtable ht = new Hashtable();
                ht.Add("Title", context.Request["Title"] ?? "");
                ht.Add("ExamTime", context.Request["ExamTime"] ?? "");
                ht.Add("Difficulty", context.Request["Difficulty"] ?? "");
                ht.Add("Status", context.Request["Status"] ?? "");
                ht.Add("Type", context.Request["Type"] ?? "");
                ht.Add("FullScore", context.Request["FullScore"] ?? "");
                ht.Add("Klpoint", context.Request["Klpoint"] ?? "");
                ht.Add("IsRelease", context.Request["IsRelease"] ?? "");
                ht.Add("Author", context.Request["Author"] ?? "");
                ht.Add("Book", context.Request["Book"] ?? "");
                jsonModel = papService.addexams(ht);
                //组卷成功，清空购物车
                if (jsonModel.errNum==0)
                {
                    if (Type == "Radom")
                    {
                        if (CacheHelper.Contains("TestbasketRandom"))
                        {
                            DataTable newtestbasket = CacheHelper.GetCache<DataTable>("TestbasketRandom");
                            for (int i = 0; i < newtestbasket.Rows.Count; i++)
                            {
                                if (newtestbasket.Rows[i]["UserNo"].SafeToString() == context.Request["Author"].SafeToString())
                                {
                                    newtestbasket.Rows[i].Delete();
                                }
                            }
                            CacheHelper.SetCacheHours("TestbasketRandom", newtestbasket, 2);

                        }

                    }
                    else
                    {
                        DataTable Testbasket = CacheHelper.GetCache<DataTable>("Testbasket");
                        for (int i = 0; i < Testbasket.Rows.Count; i++)
                        {
                            if (Testbasket.Rows[i]["UserNo"].SafeToString() == context.Request["Author"].SafeToString())
                            {
                                Testbasket.Rows[i].Delete();
                            }
                        }
                       
                        CacheHelper.SetCacheHours("Testbasket", Testbasket, 2);

                    }
                    //if (Type == "Radom")
                    //{
                    //    if (CacheHelper.Contains("Testbasket"))
                    //    {
                    //        CacheHelper.ClearCache("Testbasket");
                    //    }
                    //}
                    //else
                    //{
                    //    if (CacheHelper.Contains("TestbasketRandom"))
                    //    {
                    //        CacheHelper.ClearCache("TestbasketRandom");
                    //    }
                    //}
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
        private void GetExamPaper(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("CreateUID", context.Request["CreateUID"] ?? "");
                jsonModel = papService.GetdataEP(ht);
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
        #region 发布试卷
        /// <summary>
        /// 发布试卷
        /// </summary>
        /// <param name="context"></param>
        private void upExam_PaperDal(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("WorkBeginTime", context.Request["WorkBeginTime"] ?? "");
                ht.Add("WorkEndTime", context.Request["WorkEndTime"] ?? "");
                ht.Add("ClassID", context.Request["ClassID"] ?? "");
                ht.Add("IsRelease", context.Request["IsRelease"] ?? "");
                ht.Add("evaluate", context.Request["evaluate"] ?? "");
                jsonModel = papService.upExam_ExamPaperDal(ht);
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

        #region 获取试卷中题目的详细信息
        private void GetQDetailOfPaperObj(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExampaperID", context.Request["ExampaperID"] ?? "");
                ht.Add("Title", context.Request["Title"] ?? "");
                jsonModel = papService.GetListtimuEPQ(ht);
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
        private void GetQDetailOfPaperSub(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ExampaperID", context.Request["ExampaperID"] ?? "");
                ht.Add("Title", context.Request["Title"] ?? "");
                jsonModel = papService.GetListtimuEPS(ht);
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