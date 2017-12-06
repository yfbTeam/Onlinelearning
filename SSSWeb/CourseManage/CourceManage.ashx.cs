using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SSSBLL;
using System.Web.Script.Serialization;
using SSSModel;
using SSSUtility;
using System.Collections;

namespace SSSWeb.CourseManage
{
    /// <summary>
    /// CourceManage1 的摘要说明
    /// </summary>
    public class CourceManage1 : IHttpHandler
    {
        CourseService bll = new CourseService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        Course_ChapterService courcebll = new Course_ChapterService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            // HttpPostedFile hpf = HttpContext.Current.Request.Files["imgfile"];//HttpPostedFile提供对客户端已上载的单独文件的访问        string savepath = context.Server.MapPath("." + hpf.FileName);//路径,相对于服务器当前的路径        hpf.SaveAs(savepath);//保存        context.Response.Write("保存成功"+hpf.FileName);
            string FuncName = context.Request["Func"].ToString();
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
                        case "AddCource":
                            AddCource(context);
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
                        case "AdjustStu":
                            AdjustStu(context);
                            break;

                        case "AddCourseByModol":
                            AddCourseByModol(context);
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
        #endregion

        #region 获取报名学生信息
        private void GetSelStu(HttpContext context)
        {
            string result = "";
            //CommonHandler common = new CommonHandler();
            Couse_SelstuinfoService selbll = new Couse_SelstuinfoService();
            string CourseID = context.Request["CourseID"].SafeToString();
            //string ClassID = context.Request["ClassID"].SafeToString();
            jsonModel = selbll.GetDataByCourceID(CourseID);
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();

            //if (ClassID.Length > 0)
            //{
            //    jsonModel = common.AddCreateNameForData(jsonModel1, 2, false, ClassID, "", "StuNo");
            //}
            //else { jsonModel = common.AddCreateNameForData(jsonModel1, 0, false, ClassID, "", "StuNo"); }
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
                ht.Add("TableName", "Course");
                ht.Add("OperSymbol", context.Request["OperSymbol"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("StudyTerm", context.Request["StudyTerm"].SafeToString());
                ht.Add("IdCard", context.Request["IdCard"].SafeToString());
                ht.Add("CourseType", context.Request["CourseType"].SafeToString());
                ht.Add("Name", context.Request["Name"].SafeToString());
                if (!string.IsNullOrWhiteSpace(context.Request["IsCharge"])) ht.Add("IsCharge", context.Request["IsCharge"]);
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
                cource.CatagoryID = context.Request["CatagoryID"].SafeToString();
                cource.CourceType = Convert.ToByte(context.Request["CourceType"]);
                string OldCourceType = context.Request["OldCourceType"].SafeToString();
                string OldStatus = context.Request["OldStatus"].SafeToString();
                string CerName = context.Request["CerName"].SafeToString();
                string CerModel = context.Request["CerModel"].SafeToString();

                if (cource.CourceType == 1)
                {
                    cource.Status = 1;
                }
                else { cource.Status = 0; }
                cource.Grade = context.Request["Grade"].SafeToString();
                cource.StudyTerm = int.Parse(context.Request["StudyTerm"]);
                cource.CreateUID = context.Request["CreateUID"].SafeToString();
                cource.StartTime = Convert.ToDateTime(context.Request["StartTime"]);
                cource.EndTime = Convert.ToDateTime(context.Request["EndTime"]);
                cource.StuMaxCount = Convert.ToInt32(context.Request["StuMaxCount"]);

                string Message = "";
                if (context.Request["ID"].SafeToString().Length > 0)
                {
                    if (OldCourceType == "2" && cource.CourceType == 2)
                    {
                        cource.Status = int.Parse(OldStatus);
                    }
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
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}