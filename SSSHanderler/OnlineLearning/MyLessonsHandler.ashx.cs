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
    /// MyLessonsHandler 的摘要说明
    /// </summary>
    public class MyLessonsHandler : IHttpHandler
    {
        string sysAccountNo = ConfigHelper.GetConfigString("SysAccountNo");
        string u_handlerUrl = ConfigHelper.GetConfigString("Unified_HandlerUrl").SafeToString();

        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        Couse_SelstuinfoService selstuinfoService = new Couse_SelstuinfoService();
        SomeTableClickService clickService = new SomeTableClickService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string loginname = HttpContext.Current.Request["loginname"] ?? "";
            string idcard = context.Request["useridcard"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetMyLessonsDataPage":
                        GetMyLessonsDataPage(context);
                        break;                    
                    case "OperSomeTableClick":
                        OperSomeTableClick(context);
                        break;
                    case "StudyTheCourseStaff":
                        result = StudyTheCourseStaff(context);
                        break;                    
                    case "GetMyLessonsByType":
                        GetMyLessonsByType(context);
                        break;
                    case "SetLastStudyTime":
                        SetLastStudyTime(context);
                        break;
                    case "SinLogAdd":
                        SinLogAdd(context);
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
            result = string.IsNullOrEmpty(result) ? "{\"result\":" + jss.Serialize(jsonModel) + "}" : result;
            context.Response.Write(result);
            context.Response.End();
        }

        private void SinLogAdd(HttpContext context) {
            try
            {
                string UserID = context.Request["UserID"].SafeToString();
                string CourseID = context.Request["CourseID"].SafeToString();
                jsonModel = selstuinfoService.SinLogAdd(UserID,CourseID);
                //jsonModel = new CommonHandler().AddCreateNameForData(jsonModel, ispage, "StuNo", "", context.Request["StuName"] ?? "", "LecturerName");
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
        #region 获取我的课程的分页数据
        private void GetMyLessonsDataPage(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("StuNo", context.Request["StuNo"] ?? "");
                ht.Add("CourseID", context.Request["CourseID"] ?? "");
                ht.Add("Name", context.Request["Name"] ?? "");
                ht.Add("CourceType", context.Request["CourceType"] ?? "");
                ht.Add("IsPercent", context.Request["IsPercent"] ?? "");
                ht.Add("IsFinish", context.Request["IsFinish"] ?? "");
                ht.Add("TeaID", context.Request["TeaID"].SafeToString());
                ht.Add("ClassNo", context.Request["ClassNo"].SafeToString());
                ht.Add("CheckUser", context.Request["CheckUser"].SafeToString());
                bool ispage = true;
                if (!string.IsNullOrEmpty(context.Request["ispage"]))
                {
                    ispage = Convert.ToBoolean(context.Request["ispage"]);
                }
                ht.Add("PageIndex", HttpContext.Current.Request["PageIndex"] ?? "1");
                ht.Add("PageSize", HttpContext.Current.Request["PageSize"] ?? "10");
                jsonModel = selstuinfoService.GetPage(ht, ispage);
                jsonModel = new CommonHandler().AddCreateNameForData(jsonModel, ispage, "StuNo", "",context.Request["StuName"]??"", "LecturerName");
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

        #region 添加或编辑视频查看记录
        private void OperSomeTableClick(HttpContext context)
        {
            SomeTableClick click = new SomeTableClick();
            int clickid = Convert.ToInt32(context.Request["Clickid"] ?? "0");
            click.Id = clickid;
            click.RelationId = Convert.ToInt32(context.Request["RelationId"]);
            click.Type = Convert.ToByte(context.Request["Type"] ?? "0");
            click.WatchTime = float.Parse(context.Request["WatchTime"]);
            if (clickid == 0)
            {
                click.ClickTime = Convert.ToDateTime(context.Request["ClickTime"]);
                click.LastTime = DateTime.Now;
            }
            else
            {
                click.ClickTime = DateTime.Now;
                click.LastTime = Convert.ToDateTime(context.Request["LastTime"]);
            }
            click.ClickNum = Convert.ToInt32(context.Request["ClickNum"]) + 1;
            click.IsLookEnd = Convert.ToByte(context.Request["IsLookEnd"] ?? "0");
            click.CreateUID = context.Request["UserIdCard"];
            Hashtable ht = new Hashtable();
            ht.Add("ClassID", context.Request["ClassID"] ?? "");
            ht.Add("DownTime", context.Request["DownTime"]);
            ht.Add("TotalTime", context.Request["TotalTime"]);
            jsonModel = clickService.OperSomeTableClick(click, ht);
        }
        #endregion

        #region 正在学习该课程的员工
        private string StudyTheCourseStaff(HttpContext context)
        {
            string result = string.Empty;
            string courseID = context.Request["CourseID"].SafeToString();
            jsonModel = selstuinfoService.GetLearnStaffByCourceID(courseID);
            if (jsonModel.errNum == 0)
            {
                DataTable dt = jsonModel.retData as DataTable;
                string ids = string.Join(",", dt.AsEnumerable().Select(row => row["IDS"].ToString()).ToArray());
                if (!string.IsNullOrEmpty(ids))
                {
                    result = new CommonHandler().GetLearnStaffData(ids);
                }
                else
                {
                    result = "{\"result\":{\"retData\":\"\",\"errMsg\":\"success\",\"errNum\":0,\"status\":null}}";
                }
            }
            return result;
        }
        #endregion              

        #region 获取我的课程的分页数据
        private void GetMyLessonsByType(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("StuNo", context.Request["StuNo"] ?? "");
                ht.Add("ClassID", context.Request["ClassID"] ?? "");
                ht.Add("PageIndex", context.Request["PageIndex"] ?? "1");
                ht.Add("PageSize", context.Request["PageSize"] ?? "10");
                ht.Add("CourseType", context.Request["CourseType"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("Name", context.Request["Name"].SafeToString());
                bool IsPage = true;
                if (context.Request["IsPage"].SafeToString().Length > 0)
                {
                    IsPage = Convert.ToBoolean(context.Request["IsPage"]);
                }
                jsonModel = selstuinfoService.GetMyLessonsByType(ht, IsPage);
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

        #region 设置最后学习时间
        private void SetLastStudyTime(HttpContext context)
        {
            int itemid = Convert.ToInt32(context.Request["ItemId"]);
            jsonModel = selstuinfoService.GetEntityById(itemid);
            if (jsonModel.errNum == 0)
            {
                Couse_Selstuinfo sel = jsonModel.retData as Couse_Selstuinfo;
                sel.ID = itemid;                
                sel.LastStudyTime = DateTime.Now;
                jsonModel = selstuinfoService.Update(sel);                
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