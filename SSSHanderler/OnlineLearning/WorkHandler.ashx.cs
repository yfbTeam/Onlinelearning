using SSSBLL;
using SSSModel;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SSSHanderler.OnlineLearning
{
    /// <summary>
    /// WorkHandler 的摘要说明
    /// </summary>
    public class WorkHandler : IHttpHandler
    {
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        CommonHandler common = new CommonHandler();
        Course_WorkService workService = new Course_WorkService();
        Course_WorkCorrectRelService corelService = new Course_WorkCorrectRelService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetWorkDataPage":
                        GetWorkDataPage(context);
                        break;
                    case "AddWork":
                        AddWork(context);
                        break;
                    case "EditWork":
                        EditWork(context);
                        break;
                    case "DeleteWork":
                        DeleteWork(context);
                        break;
                    case "GetWorkById":
                        GetWorkById(context);
                        break;
                    case "GetWorkCorrectRelDataPage":
                        GetWorkCorrectRelDataPage(context);
                        break;
                    case "GetWorkCorrectRelById":
                        GetWorkCorrectRelById(context);
                        break;
                    case "AddWorkCorrectRel":
                        AddWorkCorrectRel(context);
                        break;
                    case "EditWorkCorrectRel":
                        EditWorkCorrectRel(context);
                        break;
                    case "TeaCorr_WorkCorrectRel":
                        TeaCorr_WorkCorrectRel(context);
                        break;
                    case "GetStuWorkCompleteInfo":
                        GetStuWorkCompleteInfo(context);
                        break;
                    case "GetWorkStatisticsInfo":
                        GetWorkStatisticsInfo(context);
                        break;
                    case "GetCourseWorkStatistics":
                        GetCourseWorkStatistics(context);
                        break;
                    case "GetStuSubWorkDetail":
                        GetStuSubWorkDetail(context);
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
        private void GetStuSubWorkDetail(HttpContext context)
        {
            string StuNo = context.Request["StuNo"].SafeToString();
            string CourseID = context.Request["CourseID"].SafeToString();
            jsonModel = common.AddCreateNameForData(workService.GetStuSubWorkDetail(StuNo, CourseID), false, "CreateUID", "CorrectTime");
        }
        #region 获取作业表的分页数据
        private void GetWorkDataPage(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("CouseID", context.Request["CourseID"] ?? "");
                ht.Add("ChapterID", context.Request["ChapterID"] ?? "");
                ht.Add("PointID", context.Request["PointID"] ?? "");
                ht.Add("WorkId", context.Request["WorkId"] ?? "");
                ht.Add("Name", context.Request["Name"] ?? "");
                ht.Add("StuIDCard", context.Request["StuIDCard"] ?? "");
                ht.Add("UserIdCard", context.Request["UserIdCard"] ?? "");
                ht.Add("ClassID", context.Request["ClassID"] ?? "");
                ht.Add("ChapterName", context.Request["ChapterName"] ?? "");
                bool ispage = true;
                if (!string.IsNullOrEmpty(context.Request["ispage"]))
                {
                    ispage = Convert.ToBoolean(context.Request["ispage"]);
                }
                ht.Add("PageIndex", context.Request["PageIndex"] ?? "1");
                ht.Add("PageSize", context.Request["PageSize"] ?? "10");
                jsonModel = common.AddCreateNameForData(workService.GetPage(ht, ispage), ispage);
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

        #region 添加作业
        private void AddWork(HttpContext context)
        {
            string name = context.Request["Name"];
            Course_Work work = new Course_Work();
            work.CouseID = Convert.ToInt32(context.Request["CourseID"]);
            work.ChapterID = context.Request["ChapterID"] ?? "";
            work.PointID = Convert.ToInt32(context.Request["PointID"]);
            work.Name = name;
            work.Requirement = context.Request["Requirement"] ?? "";
            work.StartTime = Convert.ToDateTime(context.Request["StartTime"]);
            work.EndTime = Convert.ToDateTime(context.Request["EndTime"]);
            work.Attachment = context.Request["Attachment"];
            work.CreateUID = context.Request["UserIdCard"];
            work.CreateTime = DateTime.Now;
            work.IsDelete = 0;
            jsonModel = workService.Add(work);
        }
        #endregion

        #region 编辑作业
        private void EditWork(HttpContext context)
        {
            string name = context.Request["Name"];
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = workService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Course_Work work = jsonModel.retData as Course_Work;
                work.Id = itemid;
                work.Name = name;
                work.Requirement = context.Request["Requirement"] ?? "";
                work.StartTime = Convert.ToDateTime(context.Request["StartTime"]);
                work.EndTime = Convert.ToDateTime(context.Request["EndTime"]);
                work.EditUID = context.Request["UserIdCard"];
                work.Attachment = context.Request["Attachment"];
                work.EidtTime = DateTime.Now;
                jsonModel = workService.Update(work);
            }
        }
        #endregion

        #region 删除作业
        private void DeleteWork(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["DelId"]);
            jsonModel = workService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Course_Work work = jsonModel.retData as Course_Work;
                work.Id = itemid;
                work.IsDelete = 1;
                jsonModel = workService.Update(work);
            }
        }
        #endregion

        #region 根据Id获取作业详情
        private void GetWorkById(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = workService.GetEntityById(itemid);
        }
        #endregion

        #region 获取作业批改关系表的数据
        private void GetWorkCorrectRelDataPage(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("CouseID", context.Request["CourseID"] ?? "");
                ht.Add("ChapterID", context.Request["ChapterID"] ?? "");
                ht.Add("PointID", context.Request["PointID"] ?? "");
                ht.Add("WorkId", context.Request["WorkId"] ?? "");
                ht.Add("Name", context.Request["Name"] ?? "");
                ht.Add("TerIDCard", context.Request["TerIDCard"] ?? "");
                ht.Add("StuIDCard", context.Request["StuIDCard"] ?? "");
                ht.Add("CorrectStatus", context.Request["CorrectStatus"] ?? ""); //"null" 或者 "not null"                              
                bool ispage = true;
                if (!string.IsNullOrEmpty(context.Request["ispage"]))
                {
                    ispage = Convert.ToBoolean(context.Request["ispage"]);
                }
                ht.Add("PageIndex", context.Request["PageIndex"] ?? "1");
                ht.Add("PageSize", context.Request["PageSize"] ?? "10");
                jsonModel = common.AddCreateNameForData(corelService.GetPage(ht, ispage), ispage);
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

        #region 根据Id获取作业批改关系表详情
        private void GetWorkCorrectRelById(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = corelService.GetEntityById(itemid);
        }
        #endregion

        #region 上传作业
        private void AddWorkCorrectRel(HttpContext context)
        {
            Course_WorkCorrectRel corel = new Course_WorkCorrectRel();
            corel.WorkId = Convert.ToInt32(context.Request["WorkId"]);
            corel.Contents = context.Request["Contents"] ?? "";
            corel.Attachment = context.Request["Attachment"];
            corel.CreateUID = context.Request["UserIdCard"];
            corel.CreateTime = DateTime.Now;
            corel.EidtTime = DateTime.Now;
            jsonModel = workService.AddWorkCorrectRel(corel, context.Request["ClassID"] ?? "");
        }
        #endregion

        #region 修改上传的作业
        private void EditWorkCorrectRel(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = corelService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Course_WorkCorrectRel corel = jsonModel.retData as Course_WorkCorrectRel;
                corel.Id = itemid;
                corel.Contents = context.Request["Contents"] ?? "";
                corel.Attachment = context.Request["Attachment"];
                corel.EditUID = context.Request["UserIdCard"];
                corel.EidtTime = DateTime.Now;
                jsonModel = corelService.Update(corel);
                if (jsonModel.errNum == 0)
                {
                    jsonModel.retData = itemid;
                }
            }
        }
        #endregion

        #region 教师批改作业
        private void TeaCorr_WorkCorrectRel(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = corelService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Course_WorkCorrectRel corel = jsonModel.retData as Course_WorkCorrectRel;
                corel.Id = itemid;
                corel.Score = Convert.ToInt32(context.Request["Score"]);
                corel.ScoreStatus = Convert.ToByte(context.Request["ScoreStatus"]);
                corel.CorrectContent = context.Request["CorrectContent"] ?? "";
                corel.CorrectUID = context.Request["UserIdCard"];
                corel.CorrectTime = DateTime.Now;
                jsonModel = corelService.Update(corel);
            }
        }
        #endregion

        #region 获取学生作业的完成信息
        private void GetStuWorkCompleteInfo(HttpContext context)
        {
            Hashtable ht = new Hashtable();
            ht.Add("WorkId", context.Request["WorkId"] ?? "");
            ht.Add("IsGroupIDCard", context.Request["IsGroupIDCard"] ?? "1");
            string status = context.Request["ScoreStatus"] ?? "0";
            ht.Add("ScoreStatus", status);
            string courseID = context.Request["CourseID"].SafeToString();
            List<Dictionary<string, object>> list = StudyTheCourseStaff(context, courseID);
            jsonModel = workService.GetStuWorkCompleteInfo(ht);
            if (jsonModel.errNum == 0)
            {
                List<Dictionary<string, object>> comList = jsonModel.retData as List<Dictionary<string, object>>;
                List<string> stuCard = (from dic in comList select dic["CreateUID"].ToString()).ToList();
                List<Dictionary<string, object>> rtnList = (from dic in list
                                                            where stuCard.Contains(dic["UniqueNo"].ToString())
                                                            select dic).ToList();
                if (status == "0")
                {
                    rtnList = list.Except(rtnList).ToList();
                }
                jsonModel = new JsonModel()
                {
                    errNum = rtnList.Count > 0 ? 0 : 999,
                    errMsg = rtnList.Count > 0 ? "success" : "无数据！",
                    retData = rtnList
                };
            }
        }
        #endregion

        #region 获取作业统计信息
        private void GetWorkStatisticsInfo(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("WorkId", context.Request["WorkId"] ?? "");
                ht.Add("StuIDCard", context.Request["StuIDCard"] ?? "");
                DataTable dt = workService.GetWorkStatisticsInfo(ht);
                if (dt != null && dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    List<object> rtnList = new List<object>();
                    rtnList.Add(new { name = "优", value = row["ScoreStatus1"].SafeToString() });
                    rtnList.Add(new { name = "良", value = row["ScoreStatus2"].SafeToString() });
                    rtnList.Add(new { name = "中", value = row["ScoreStatus3"].SafeToString() });
                    rtnList.Add(new { name = "差", value = row["ScoreStatus4"].SafeToString() });
                    rtnList.Add(new { name = "未批改作业", value = row["uncorrect"].SafeToString() });
                    string courseID = context.Request["CourseID"].SafeToString();
                    string courseType = context.Request["CourseType"] ?? "1";
                    int allcount = new Couse_SelstuinfoService().GetLearnStaffCountByCourceID(courseID);
                    rtnList.Add(new { name = "未提交作业", value = allcount - Convert.ToInt32(row["comCount"].SafeToString()) });
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = rtnList
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "暂无作业统计信息！",
                        retData = ""
                    };
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
            }
        }
        #endregion

        #region 获取某课程下学生作业的统计信息
        private void GetCourseWorkStatistics(HttpContext context)
        {
            try
            {

                string courseID = context.Request["CourseID"].SafeToString();
                string courseType = context.Request["CourseType"] ?? "1";
                Hashtable ht = new Hashtable();
                ht.Add("CouseID", courseID);
                ht.Add("IsGroupIDCard", context.Request["IsGroupIDCard"] ?? "1");
                List<Dictionary<string, object>> list = StudyTheCourseStaff(context, courseID);
                List<Dictionary<string, object>> comList = new List<Dictionary<string, object>>();
                DataTable staDt = workService.GetWorkStatisticsInfo(ht);
                if (staDt != null && staDt.Rows.Count > 0)
                {
                    comList = new BLLCommon().DataTableToList(staDt);
                }
                if (list != null && list.Count > 0)
                {
                    foreach (Dictionary<string, object> curdic in list)
                    {
                        Dictionary<string, object> curStu = (from dic in comList
                                                             where dic["CreateUID"].ToString() == curdic["UniqueNo"].ToString()
                                                             select dic).FirstOrDefault();
                        curdic.Add("comCount", curStu == null ? "0" : curStu["comCount"].ToString());
                        curdic.Add("ScoreStatus1", curStu == null ? "0" : curStu["ScoreStatus1"].ToString());
                        curdic.Add("ScoreStatus2", curStu == null ? "0" : curStu["ScoreStatus2"].ToString());
                        curdic.Add("ScoreStatus3", curStu == null ? "0" : curStu["ScoreStatus3"].ToString());
                        curdic.Add("ScoreStatus4", curStu == null ? "0" : curStu["ScoreStatus4"].ToString());
                        curdic.Add("uncorrect", curStu == null ? "0" : curStu["uncorrect"].ToString());
                    }
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = list
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "暂无作业统计信息！",
                        retData = ""
                    };
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
            }
        }
        #endregion

        #region 正在学习该课程的员工
        private List<Dictionary<string, object>> StudyTheCourseStaff(HttpContext context, string courseID)
        {
            Couse_SelstuinfoService selstuinfoService = new Couse_SelstuinfoService();
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            jsonModel = selstuinfoService.GetLearnStaffByCourceID(courseID);
            if (jsonModel.errNum == 0)
            {
                DataTable dt = jsonModel.retData as DataTable;
                string ids = string.Join(",", dt.AsEnumerable().Select(row => row["IDS"].ToString()).ToArray());
                if (!string.IsNullOrEmpty(ids))
                {
                    list = new CommonHandler().GetUnifiedUserData(ids);
                }
            }
            return list;
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