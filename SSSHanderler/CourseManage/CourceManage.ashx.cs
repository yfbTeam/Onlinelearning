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
using SSSHanderler.OnlineLearning;
namespace SSSWeb.CourseManage
{
    /// <summary>
    /// CourceManage 的摘要说明
    /// </summary>
    public class CourceManage : IHttpHandler
    {
        CourseService bll = new CourseService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        Course_ChapterService courcebll = new Course_ChapterService();
        CommonHandler common = new CommonHandler();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            // HttpPostedFile hpf = HttpContext.Current.Request.Files["imgfile"];//HttpPostedFile提供对客户端已上载的单独文件的访问        string savepath = context.Server.MapPath("." + hpf.FileName);//路径,相对于服务器当前的路径        hpf.SaveAs(savepath);//保存        context.Response.Write("保存成功"+hpf.FileName);
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
                        case "Course_WeekSet":
                            Course_WeekData(context);
                            break;
                        case "EditWeeKSet":
                            EditWeeKSet(context);
                            break;
                        case "AddWeeKSet":
                            AddWeeKSet(context);
                            break;
                        case "DelCourse_Week":
                            DelCourse_Week(context);
                            break;
                        case "AddCource":
                            AddCource(context);
                            break;
                        case "AddCource_MTG":
                            AddCource_MTG(context);
                            break;
                        case "AddCource_NG":
                            AddCource_NG(context);
                            break;
                        case "RealeseCourse":
                            RealeseCourse(context);
                            break;
                        case "Chapator":
                            Chapator(context);
                            break;
                        case "ChapatorM":
                            ChapatorM(context);
                            break;
                        case "AddNewMenu":
                            AddNewMenu(context);
                            break;
                        case "DelMenu":
                            DelMenu(context);
                            break;
                        case "TaskInfo":
                            TaskInfo(context);
                            break;
                        case "SingUp":
                            SingUp(context);
                            break;
                       
                        case "CourceCheck":
                            CourceCheck(context);
                            break;
                        case "GetCourseByType":
                            GetCourseByType(context);
                            break;
                        case "GetSelStu":
                            GetSelStu(context);
                            break;
                        case "GetFreeStu":
                            GetFreeStu(context);
                            break;
                        //获取签到记录
                        case "GetSingLog":
                            GetSingLog(context);
                            break;
                        //签到时间设置
                        case "SingActiveTime":
                            SingActiveTimeData(context);
                            break;
                        //修改有效签到时间
                        case "EditActiveTime":
                            EditActiveTime(context);
                            break;
                        case "AddCourseByModol":
                            AddCourseByModol(context);
                            break;
                        case "HotCourse":
                            HotCourse(context);
                            break;

                        case "reMenuName":
                            reMenuName(context);
                            break;
                        case "DelCourse":
                            DelCourse(context);
                            break;
                        case "SortMenu":
                            SortMenu(context);
                            break;
                        //case "CouseTypeAnalis":
                        //    CouseTypeAnalis(context);
                        //    break;
                        //case "CouseTypeAnalis":
                        //    CouseTypeAnalis(context);
                        //    break;
                        case "SetStuCourseFinish":
                            SetStuCourseFinish(context);
                            break;
                        case "AdJustStu":
                            AdJustStu(context);
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


        #region 修改签到有效时间
        private void EditActiveTime(HttpContext context)
        {
            string result = "";

            SingActiveTimeService bll = new SingActiveTimeService();
            string Data = context.Request["Data"];
            string[] DataWeek = Data.Split('-');
            for (int i = 0; i < DataWeek.Length; i++)
            {
                if (DataWeek[i].SafeToString().Length > 1)
                {
                    string[] ModelArry = DataWeek[i].Split(',');
                    string WeekValue = ModelArry[0].Replace("{", "");
                    string BeginTime = ModelArry[1];
                    string EndTime = ModelArry[2].Replace("}", "");
                    List<SingActiveTime> list = (List<SingActiveTime>)bll.GetEntityListByField("WeekValue", WeekValue).retData;
                    SingActiveTime model = (SingActiveTime)list[0];

                    if (model.BeginTime != BeginTime || model.EndTime != EndTime)
                    {
                        model.BeginTime = BeginTime;
                        model.EndTime = EndTime;
                        jsonModel = bll.Update(model);
                    }
                }
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";

            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 获取签到时间设置
        private void SingActiveTimeData(HttpContext context)
        {
            string result = "";
            Hashtable ht = new Hashtable();
            SingActiveTimeService bll = new SingActiveTimeService();
            ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
            ht.Add("PageSize", context.Request["PageSize"].SafeToString());
            bool Ispage = true;
            if (context.Request["Ispage"].SafeToString().Length > 0)
            {
                Ispage = Convert.ToBoolean(context.Request["Ispage"]);
            }
            jsonModel = bll.GetPage(ht, Ispage);
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 获取签到记录
        /// <summary>
        /// 获取签到记录
        /// </summary>
        /// <param name="context"></param>
        private void GetSingLog(HttpContext context)
        {
            string result = "";
            UserSinLogService bll = new UserSinLogService();
            string Name = context.Request["Name"].SafeToString();
            string IsEffective = context.Request["IsEffective"].SafeToString();
            string BeginTime = context.Request["BeginTime"].SafeToString();
            string EndTime = context.Request["EndTime"].SafeToString();
            Hashtable ht = new Hashtable();
            ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
            ht.Add("PageSize", context.Request["PageSize"].SafeToString());
            ht.Add("Name", Name);
            ht.Add("IsEffective", IsEffective);
            ht.Add("BeginTime", BeginTime);
            ht.Add("EndTime", EndTime);
            bool Ispage = true;
            if (context.Request["Ispage"].SafeToString().Length > 0)
            {
                Ispage = Convert.ToBoolean(context.Request["Ispage"]);
            }
            jsonModel = common.AddCreateNameForData(bll.GetPage(ht, Ispage), Ispage, "StuNo");
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 调整选课人员
        private void AdJustStu(HttpContext context)
        {
            string result = "";
            Couse_SelstuinfoService bll = new Couse_SelstuinfoService();
            int CourseID = int.Parse(context.Request["CourseID"]);
            string Type = context.Request["Type"].SafeToString();
            string StuNo = "";
            if (Type == "0")
            {
                StuNo = context.Request["StuNo"].SafeToString();
            }
            else
            {
                StuNo = context.Request["StuNo[]"].SafeToString();
            }
            jsonModel = bll.AdJustStu(CourseID, StuNo, Type);
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 设置课程完成
        private void SetStuCourseFinish(HttpContext context)
        {
            string result = "";
            Couse_SelstuinfoService bll = new Couse_SelstuinfoService();
            int IsFinish = int.Parse(context.Request["IsFinish"]);
            int CourseID = int.Parse(context.Request["CourseID"]);
            string StuNo = context.Request["StuNo"];
            jsonModel = bll.SetStuCourseFinish(IsFinish, CourseID, StuNo);
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        //#region 统计课程类型
        ///// <summary>
        ///// 调整目录排序
        ///// </summary>
        ///// <param name="context"></param>
        //private void CouseTypeAnalis(HttpContext context)
        //{
        //    try
        //    {
        //        string Type = context.Request["Type"].SafeToString();
        //        string result = bll.CouseTypeAnalis(Type);

        //        jsonModel = new JsonModel
        //        {
        //            errNum = 0,
        //            errMsg = "",
        //            retData = result
        //        };

        //    }
        //    catch (Exception ex)
        //    {
        //        jsonModel = new JsonModel
        //        {
        //            errNum = 400,
        //            errMsg = ex.Message,
        //            retData = ""
        //        };
        //    }
        //}
        //#endregion

        #region 调整目录排序
        /// <summary>
        /// 调整目录排序
        /// </summary>
        /// <param name="context"></param>
        private void SortMenu(HttpContext context)
        {
            Course_ChapterService chapterdll = new Course_ChapterService();
            try
            {
                int ID = Convert.ToInt32(context.Request["ID"]);
                string Type = context.Request["Type"].SafeToString();
                string result = chapterdll.EditChapterSort(ID, Type);
                if (result == "")
                {
                    jsonModel = new JsonModel
                    {
                        errNum = 0,
                        errMsg = "修改成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel
                    {
                        errNum = 999,
                        errMsg = result,
                        retData = ""
                    };
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
            }
        }
        #endregion

        #region 删除课程

        private void DelCourse(HttpContext context)
        {
            string ID = context.Request["ID"].SafeToString();
            string IdCard = context.Request["IdCard"].SafeToString();
            string Message = "";
            try
            {

                Message = bll.DelCourse(ID, IdCard);
                if (Message == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "操作成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = Message,
                        retData = ""
                    };
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

        #region 修改课程目录名称
        /// <summary>
        /// 修改文件夹（文件夹）名称
        /// </summary>
        /// <param name="context"></param>
        private void reMenuName(HttpContext context)
        {
            string result = "";
            JsonModel jsonModel = null;
            JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();

            Course_Chapter modol = new Course_Chapter();
            string Name = context.Request["NewName"].SafeToString();
            modol.ID = Convert.ToInt32(context.Request["ID"]);
            modol.Name = Name;
            jsonModel = courcebll.Update(modol);
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }

        #endregion

        #region 获取热门课程
        /// <summary>
        /// 获取热门课程
        /// </summary>
        /// <param name="context"></param>
        private void HotCourse(HttpContext context)
        {
            try
            {
                jsonModel = common.AddCreateNameForData(bll.HotCourse(context.Request["StuNo"]), false);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
            }

        }
        #endregion

        #region 根据模版生成课程
        /// <summary>
        /// 根据模版生成课程
        /// </summary>
        /// <param name="context"></param>
        private void AddCourseByModol(HttpContext context)
        {
            try
            {
                string ModelID = context.Request["ModelID"].SafeToString();
                string CourseName = context.Request["CourseName"].SafeToString();
                string CourseMes = context.Request["CourseMes"].SafeToString();
                string CreateUID = context.Request["CreateUID"].SafeToString();
                string ReturnMessage = bll.AddCourseByModol(int.Parse(ModelID), CourseName, CourseMes, CreateUID);
                int ReturnFlag = 0;
                if (ReturnMessage.Length > 0)
                {
                    ReturnFlag = 2;
                }
                jsonModel = new JsonModel
                {
                    errNum = ReturnFlag,
                    errMsg = ReturnMessage,
                    retData = ""
                };
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
            }

        }
        #endregion

        /*
        #region 调整报名学生
        /// <summary>
        /// 调整报名学生
        /// </summary>
        /// <param name="context"></param>
        private void AdjustStu(HttpContext context)
        {
            try
            {
                string Type = context.Request["Type"].SafeToString();
                string FreeStuIDs = context.Request["FreeStuIDs"].SafeToString();
                string StuIDs = context.Request["StuIDs"].SafeToString();
                string CourseID = context.Request["CourseID"].SafeToString();
                string CreateUID = context.Request["CreateUID"].SafeToString();
                string Result = bll.AdjustStu(int.Parse(Type), FreeStuIDs, StuIDs, CourseID, CreateUID, "");
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = Result,
                    retData = ""
                };
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
        #endregion*/

        #region 获取报名学生信息
        private void GetSelStu(HttpContext context)
        {
            CommonHandler common = new CommonHandler();
            Couse_SelstuinfoService selbll = new Couse_SelstuinfoService();
            string CourseID = context.Request["CourseID"].SafeToString();
            string ClassID = context.Request["ClassID"].SafeToString();
            JsonModel jsonModel1 = selbll.GetDataByCourceID(CourseID);
            if (ClassID.Length > 0)
            {
                jsonModel = common.AddCreateNameForData(jsonModel1, false, "StuNo");
            }
            else { jsonModel = common.AddCreateNameForData(jsonModel1, false, "StuNo"); }
        }
        #endregion

        #region 班级内所有学生

        private void GetFreeStu(HttpContext context)
        {
            BLLCommon common = new BLLCommon();
            ClassCourseService classCourse = new ClassCourseService();
            string CourseID = context.Request["CourseID"].SafeToString();

            Hashtable ht = new Hashtable();
            ht.Add("TableName", "ClassCourse");
            string ReturnCourseID = "";

            jsonModel = classCourse.GetPage(ht, false, " and CourseID=" + CourseID);
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();

            if (jsonModel.retData.SafeToString().Length > 0)
            {
                list = (List<Dictionary<string, object>>)jsonModel.retData;

                for (int i = 0; i < list.Count; i++)
                {
                    ReturnCourseID += list[i]["ClassID"] + ",";
                }
            }
            GetClassID(ReturnCourseID.TrimEnd(','), context);
            //return ReturnCourseID;
        }
        /// <summary>
        /// 班级内所有学生
        /// </summary>
        /// <param name="pid"></param>
        private void GetClassID(string ClassID, HttpContext context)
        {
            string loginName = context.Request["loginName"].SafeToString();
            string passWord = context.Request["passWord"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string RequestClassID = context.Request["ClassID"].SafeToString();
            ClassID = RequestClassID == "" ? ClassID : RequestClassID;
            if (ClassID == "")
            {
                ClassID = "0";
            }
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=GetStudentData&ClassID=" + ClassID + "&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);


            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 根据分类获取课程信息
        /// <summary>
        /// 根据分类获取课程信息
        /// </summary>
        /// <param name="context"></param>
        private void GetCourseByType(HttpContext context)
        {
            string Stu = context.Request["Stu"].SafeToString();
            Hashtable ht = new Hashtable();
            ht.Add("ClassID", context.Request["ClassID"].SafeToString());
            ht.Add("CourceType", context.Request["CourceType"].SafeToString());
            ht.Add("Name", context.Request["Name"].SafeToString());
            int num = int.Parse(context.Request["Num"]);
            jsonModel = bll.GetCourseByType(num, Stu, ht);
            jsonModel = new CommonHandler().AddCreateNameForData(jsonModel, false, "CreateUID", "", "", "LecturerName");
        }
        #endregion

        #region 课程审核
        /// <summary>
        /// 课程审核
        /// </summary>
        /// <param name="contex"></param>
        private void CourceCheck(HttpContext contex)
        {
            Course cource = new Course();
            cource.Status = int.Parse(contex.Request["Status"].SafeToString());
            cource.ID = Convert.ToInt32(contex.Request["ID"]);
            jsonModel = bll.Update(cource);
        }
        #endregion

        #region 报名
        /// <summary>
        /// 报名
        /// </summary>
        /// <param name="context"></param>
        private void SingUp(HttpContext context)
        {
            try
            {
                string CouseID = context.Request["CourseID"].ToString();
                string StuNo = context.Request["StuNo"].ToString();
                string ClssID = context.Request["ClssID"].SafeToString();
                string flag = bll.StuSingUp(CouseID, StuNo, ClssID);
                int returnNo = 0;
                if (flag.Length > 0)
                {
                    returnNo = 5;
                }
                jsonModel = new JsonModel
                {
                    errNum = returnNo,
                    errMsg = flag,
                    retData = ""
                };
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

        #region 获取任务信息
        /// <summary>
        /// 获取任务信息
        /// </summary>
        /// <param name="context"></param>
        private void TaskInfo(HttpContext context)
        {
            Couse_TaskInfoService taskbll = new Couse_TaskInfoService();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("CourseID", context.Request["CourceID"].ToString());
                ht.Add("ChapterID", context.Request["ChapterID"].ToString());
                //ht.Add("ID", context.Request.Form["ID"].ToString());

                jsonModel = taskbll.GetPage(ht, false);
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


        private void Course_WeekData(HttpContext context)
        {
            try
            {
                Course_WeekSetService bll = new Course_WeekSetService();
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Course_WeekSet");

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
        private void EditWeeKSet(HttpContext context)
        {
            try
            {
                Course_WeekSetService bll = new Course_WeekSetService();
                Course_WeekSet entity = (Course_WeekSet)bll.GetEntityById(Convert.ToInt32(context.Request["ID"])).retData;
                string WeekIDs = context.Request["WeekIDs"].SafeToString().TrimEnd(',');
                string WeekNames = context.Request["WeekNames"].SafeToString().TrimEnd(',');
                entity.WeekIDs = WeekIDs;
                entity.WeekNames = WeekNames;
                jsonModel = bll.Update(entity);

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
        private void AddWeeKSet(HttpContext context)
        {
            try
            {
                Course_WeekSetService bll = new Course_WeekSetService();
                Course_WeekSet entity = new Course_WeekSet();
                string WeekIDs = context.Request["WeekIDs"].SafeToString().TrimEnd(',');
                string WeekNames = context.Request["WeekNames"].SafeToString().TrimEnd(',');
                entity.WeekIDs = WeekIDs;
                entity.WeekNames = WeekNames;
                jsonModel = bll.Add(entity);

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
        private void DelCourse_Week(HttpContext context)
        {
            try
            {
                Course_WeekSetService bll = new Course_WeekSetService();
                int ID = Convert.ToInt32(context.Request["Id"]);
                jsonModel = bll.Delete(ID);

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
        #region 获取课程信息
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
                ht.Add("OperSymbol", context.Request["OperSymbol"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("StudyTerm", context.Request["StudyTerm"].SafeToString());
                ht.Add("IdCard", context.Request["IdCard"].SafeToString());
                ht.Add("CourseType", context.Request["CourseType"].SafeToString());
                ht.Add("Name", context.Request["Name"].SafeToString());
                ht.Add("StuID", context.Request["StuID"].SafeToString());
                ht.Add("StuNo", context.Request["StuNo"].SafeToString());
                ht.Add("Status", context.Request["Status"].SafeToString());
                ht.Add("CreateUID", context.Request["CreateUID"].SafeToString());
                if (!string.IsNullOrWhiteSpace(context.Request["IsCharge"])) ht.Add("IsCharge", context.Request["IsCharge"]);
                bool Ispage = true;
                if (context.Request["Ispage"].SafeToString().Length > 0)
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                jsonModel = bll.GetPage(ht, Ispage);
                jsonModel = new CommonHandler().AddCreateNameForData(jsonModel, Ispage, "CreateUID", "", "", "LecturerName");
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

        #region 添加课程

        private void AddCource(HttpContext context)
        {
            try
            {
                Course cource = new Course();
                string Name = context.Request["Name"].SafeToString();
                cource.Name = context.Request["Name"].SafeToString();
                cource.CourseIntro = context.Request["CourseIntro"].SafeToString();
                cource.ImageUrl = context.Request["CoursePic"].SafeToString();
                cource.StudyPlace = context.Request["StudyPlace"].SafeToString();
                cource.CourceType = Convert.ToByte(context.Request["CourceType"]);
                cource.LecturerName = context.Request["LecturerName[]"].SafeToString();
                cource.CreateUID = context.Request["CreateUID"].SafeToString();
                string CerName = context.Request["CerName"].SafeToString();
                string CerModel = context.Request["CerModel"].SafeToString();
                string Message = "";
                if (context.Request["ID"].SafeToString().Length > 0)
                {
                    cource.EditUID = context.Request["CreateUID"].SafeToString();
                    cource.EidtTime = DateTime.Now;
                    cource.ID = Convert.ToInt32(context.Request["ID"]);
                    Message = bll.UpdateCourse(cource, CerName, CerModel);
                }
                else
                {
                    Message = bll.AddCourse(cource, CerName, CerModel);
                }
                if (Message == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "操作成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = Message,
                        retData = ""
                    };
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

        private void RealeseCourse(HttpContext context)
        {
            try
            {
                Course cource = new Course();
                string ID = context.Request["ID"].SafeToString();
                string StartTime = context.Request["StartTime"].SafeToString();
                string EndTime = context.Request["EndTime"].SafeToString();
                string Classes = context.Request["Classes"].SafeToString();
                string Message = bll.RealeseCourse(ID, StartTime, EndTime, Classes);

                if (Message == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "发布成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = Message,
                        retData = ""
                    };
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
        #region 添加课程_农职

        private void AddCource_NG(HttpContext context)
        {
            try
            {
                Course cource = new Course();
                string Name = context.Request["Name"].SafeToString();
                cource.Name = context.Request["Name"].SafeToString();
                cource.CourseIntro = context.Request["CourseIntro"].SafeToString();
                cource.ImageUrl = context.Request["CoursePic"].SafeToString();
                cource.StudyPlace = context.Request["StudyPlace"].SafeToString();
                cource.CourceType = Convert.ToByte(context.Request["CourceType"]);
                cource.LecturerName = context.Request["LecturerName[]"].SafeToString();
                cource.CreateUID = context.Request["CreateUID"].SafeToString();
                cource.SelMaxNum = Convert.ToInt32(context.Request["SelMaxNum"]);
                cource.SelMinNum = Convert.ToInt32(context.Request["SelMinNum"]);
                cource.WeekID = Convert.ToInt32(context.Request["WeekID"]);
                string ClassNo = context.Request["ClassNo"].SafeToString();
                string Message = "";
                if (context.Request["ID"].SafeToString().Length > 0)
                {
                    cource.EditUID = context.Request["CreateUID"].SafeToString();
                    cource.EidtTime = DateTime.Now;
                    cource.ID = Convert.ToInt32(context.Request["ID"]);
                    Message = bll.UpdateCourse_MTG(cource);
                }
                else
                {
                    Message = bll.AddCourse_NG(cource, ClassNo);
                }
                if (Message == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "操作成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = Message,
                        retData = ""
                    };
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
        #region 添加课程_门头沟

        private void AddCource_MTG(HttpContext context)
        {
            try
            {
                Course cource = new Course();
                string Name = context.Request["Name"].SafeToString();
                cource.Name = context.Request["Name"].SafeToString();
                cource.CourseIntro = context.Request["CourseIntro"].SafeToString();
                cource.ImageUrl = context.Request["CoursePic"].SafeToString();
                cource.StudyPlace = context.Request["StudyPlace"].SafeToString();
                cource.CourceType = Convert.ToByte(context.Request["CourceType"]);
                cource.LecturerName = context.Request["LecturerName[]"].SafeToString();
                cource.CreateUID = context.Request["CreateUID"].SafeToString();
                cource.SelMaxNum = Convert.ToInt32(context.Request["SelMaxNum"]);
                cource.SelMinNum = Convert.ToInt32(context.Request["SelMinNum"]);
                cource.WeekID = Convert.ToInt32(context.Request["WeekID"]);
                string Message = "";
                if (context.Request["ID"].SafeToString().Length > 0)
                {
                    cource.EditUID = context.Request["CreateUID"].SafeToString();
                    cource.EidtTime = DateTime.Now;
                    cource.ID = Convert.ToInt32(context.Request["ID"]);
                    Message = bll.UpdateCourse_MTG(cource);
                }
                else
                {
                    Message = bll.AddCourse_MTG(cource);
                }
                if (Message == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "操作成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = Message,
                        retData = ""
                    };
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

        #region 获取左侧导航
        /// <summary>
        /// 获取左侧导航
        /// </summary>
        /// <param name="context"></param>
        private void Chapator(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Course_Chapter");
                ht.Add("CourseID", context.Request["CourseID"].ToString());
                ht.Add("Type", context.Request["Type"].SafeToString());
                ht.Add("Pid", context.Request["Pid"] ?? "");
                jsonModel = courcebll.GetPage(ht, false);
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
        /// <summary>
        /// 获取章节
        /// 移动端--返回视频
        /// </summary>
        /// <param name="context"></param>
        private void ChapatorM(HttpContext context)
        {
            try
            {
                Chapator(context);
                string CourseID = context.Request["CourseID"].ToString();
                string IsVideo = "1";
                string WebUrl = System.Configuration.ConfigurationManager.ConnectionStrings["WebUrl"].ToString();
                if (jsonModel.errNum == 0)
                {

                    List<Dictionary<string, object>> list = jsonModel.retData as List<Dictionary<string, object>>;
                    List<Dictionary<string, object>> list1 = new List<Dictionary<string, object>>();
                    Couse_ResourceService bll = new Couse_ResourceService();
                    foreach (Dictionary<string, object> item in list)
                    {
                        if (item["Pid"].ToString() == "0")
                        {
                            Dictionary<string, object> dic = new Dictionary<string, object>();
                            dic.Add("ID", item["ID"].ToString());
                            dic.Add("Name", item["Name"].ToString());
                            dic.Add("Pid", item["Pid"].ToString());
                            dic.Add("VideoURL", "");
                            dic.Add("NodeName", "章");
                            list1.Add(dic);

                            foreach (Dictionary<string, object> item1 in list)
                            {
                                if (item1["Pid"].ToString() == item["ID"].ToString())
                                {
                                    Dictionary<string, object> dic1 = new Dictionary<string, object>();
                                    dic1.Add("ID", item1["ID"].ToString());
                                    dic1.Add("Name", item1["Name"].ToString());
                                    dic1.Add("Pid", item1["Pid"].ToString());
                                    dic1.Add("VideoURL", "");
                                    dic1.Add("NodeName", "节");
                                    list1.Add(dic1);
                                    //foreach (Dictionary<string, object> item2 in list)
                                    //{
                                    //    if (item2["Pid"].ToString() == item1["ID"].ToString())
                                    //    {
                                    //        Dictionary<string, object> dic2 = new Dictionary<string, object>();
                                    //        dic2.Add("ID", item2["ID"].ToString());
                                    //        dic2.Add("Name", item2["Name"].ToString());
                                    //        dic2.Add("Pid", item2["Pid"].ToString());
                                    //        dic2.Add("VideoURL", "");
                                    //        dic2.Add("NodeName", "课时");
                                    //        list1.Add(dic2);
                                    //    }
                                    //}
                                }
                            }
                            //获取视频信息
                            List<Dictionary<string, object>> ListVideo = new List<Dictionary<string, object>>();
                            Hashtable htZhang = new Hashtable();
                            htZhang.Add("CouseID", CourseID);
                            htZhang.Add("IsVideo", IsVideo);
                            htZhang.Add("ChapterID", item["ID"].ToString());
                            htZhang.Add("StuIdCard", "");

                            JsonModel jsonModelVideo = bll.GetPage(htZhang, false);
                            if (jsonModelVideo.errNum == 0)
                            {
                                ListVideo = jsonModelVideo.retData as List<Dictionary<string, object>>;
                            }
                            //添加视频
                            foreach (Dictionary<string, object> itemVideo in ListVideo)
                            {
                                Dictionary<string, object> dicVideo = new Dictionary<string, object>();
                                dicVideo.Add("ID", itemVideo["ID"].ToString());
                                dicVideo.Add("Name", itemVideo["Name"].ToString());
                                dicVideo.Add("Pid", itemVideo["ChapterID"].ToString());
                                dicVideo.Add("VideoURL", WebUrl + itemVideo["FileUrl"].ToString());
                                dicVideo.Add("NodeName", "视频");
                                list1.Add(dicVideo);
                            }
                        }
                    }

                    jsonModel.retData = list1;
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
        /// <summary>
        /// 添加左侧导航
        /// </summary>
        /// <param name="context"></param>
        private void AddNewMenu(HttpContext context)
        {
            try
            {
                string Type = context.Request["type"].SafeToString();
                Course_Chapter chapter = new Course_Chapter();
                chapter.Name = context.Request["FileName"].SafeToString();
                chapter.CourseID = Convert.ToInt32(context.Request["CourseID"]);
                chapter.Pid = Convert.ToInt32(context.Request["Pid"]);
                chapter.MenuType = int.Parse(Type);
                jsonModel = courcebll.Add(chapter);
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
        /// <summary>
        /// 删除左侧导航
        /// </summary>
        /// <param name="context"></param>
        private void DelMenu(HttpContext context)
        {
            try
            {
                int ID = Convert.ToInt32(context.Request["ID"]);
                string DelResult = courcebll.DelChapter(ID);
                if (DelResult == "0")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "删除成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 100,
                        errMsg = DelResult,
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