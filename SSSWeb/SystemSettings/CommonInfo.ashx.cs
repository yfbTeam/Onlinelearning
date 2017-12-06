using SSSModel;
using SSSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SSSWeb.SystemSettings
{
    /// <summary>
    /// CommonInfo 的摘要说明
    /// </summary>
    public class CommonInfo : IHttpHandler
    {
        JsonModel jsonModel = null;
        string sysAccountNo = ConfigHelper.GetConfigString("SysAccountNo");
        string u_handlerUrl = ConfigHelper.GetConfigString("Unified_HandlerUrl").SafeToString();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        //学年学期（新）
                        case "GetTerm":
                            GetTerm(context);
                            break;
                        //用户信息（全部、教师学生）
                        case "GetUserInfoData":
                            GetUserInfoData(context);
                            break;
                        case "EditUser":
                            EditUser(context);
                            break;
                        //获取年级数据
                        case "GetGrade":
                            GetGrade(context);
                            break;
                        //获取班级数据
                        case "GetClass":
                            GetClass(context);
                            break;
                        case "GetGradeClass":
                            GetGradeClass(context);
                            break;
                        case "GetOrg":
                            GetOrg(context);
                            break;
                        case "GetLeftNavigationMenu":
                            GetLeftNavigationMenu(context);
                            break;
                        case "GetTeacherPower":
                            GetTeacherPower(context);
                            break;
                        case "MyExamination":
                            MyExamination(context);
                            break;
                        case "GetAllTeacherInfo":
                            GetAllTeacherInfo(context);
                            break;
                        case "GetSchoolAll":
                            GetSchoolAll(context);
                            break;
                        case "AddStudent":
                            AddStudent(context);
                            break;
                        case "GetTeacherData":
                            GetTeacherData(context);
                            break;
                        case "GetTeacherPageData":
                            GetTeacherPageData(context);
                            break;
                        case "GetStudentPageData":
                            GetStudentPageData(context);
                            break;
                        case "GetClassStudent":
                            GetClassStudent(context);
                            break;
                        case "GetStudentByTeacher":
                            GetStudentByTeacher(context);
                            break;
                        case "EditMenuCode":
                            EditMenuCode(context);
                            break;
                        case "GetMajor":
                            GetMajor(context);
                            break;
                        case "UpStuPass":
                            UpStuPass(context);
                            break;
                        case "StuMessage":
                            StuMessage(context);
                            break;
                        case "NoticesForKeyWord":
                            NoticesForKeyWord(context);
                            break;
                        case "UpdatePassword":
                            UpdatePassword(context);
                            break;
                        case "SavePassword":
                            SavePassword(context);
                            break;
                        case "ValidationUserByIDCardAndName":
                            ValidationUserByIDCardAndName(context);
                            break;
                        case "ExportStu":
                            ExportStu(context);
                            break;
                        case "GetUserInfoByIDCard":
                            GetUserInfoByIDCard(context);
                            break;
                        case "RegisterUpdateStudent":
                            RegisterUpdateStudent(context);
                            break;
                        case "OA":
                            OA(context);
                            break;
                        case "AdminSendMessage":
                            AdminSendMessage(context);
                            break;


                        default:
                            break;
                    }
                }
                catch (Exception ex)
                {
                    jsonModel = new JsonModel
                    {
                        errNum = 404,
                        errMsg = "无此方法",
                        retData = ""
                    };
                }

            }
        }
        public void AdminSendMessage(HttpContext context)
        {
            System.Web.Script.Serialization.JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            JsonModel jsonModel = new JsonModel();
            try
            {
                string Subject = context.Request["Title"];
                string Body = context.Request["Contents"];
                string Email = context.Request["Email"];
                SendMailMessage.SendMessage(Subject, Body, Email);
                jsonModel = new JsonModel()
                {
                    errMsg = "success",
                    errNum = 0
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errMsg = ex.Message,
                    errNum = 400
                };
                context.Response.Write("{\"result\":" + jss.Serialize(jsonModel) + "}");
            }

        }
        private void OA(HttpContext context)
        {
            string u_handlerOA = ConfigHelper.GetConfigString("u_handlerOA").SafeToString();

            string result = NetHelper.RequestPostUrl(u_handlerOA, "");
            context.Response.Write(result);
            context.Response.End();
        }
        private void ExportStu(HttpContext context)
        {
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string SystemKey = context.Request["SystemKey"].SafeToString();
            string InfKey = context.Request["InfKey"].SafeToString();
            string FilePath = context.Request["FilePath"].SafeToString();

            string urlbady = "func=ImportStudent&SystemKey=" + SystemKey + "&InfKey=" + InfKey + "&FilePath=" + FilePath;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #region 学生修改密码
        /// <summary>
        /// 学生修改密码
        /// </summary>
        /// <param name="context"></param>
        private void UpStuPass(HttpContext context)
        {
            //http://192.168.1.101:8085/UserHandler.ashx?func=UpdatePassword&LoginName=fangxiao&OldPassword=yfb%40123&NewPassword=pwd%40123
            string LoginName = context.Request["LoginName"].SafeToString();
            string OldPassword = context.Request["OldPassword"].SafeToString();
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/UserHandler.ashx?";
            string NewPassword = context.Request["NewPassword"].SafeToString();
            string urlbady = "func=UpdatePassword&LoginName=" + LoginName + "&OldPassword=" + OldPassword + "&NewPassword=" + NewPassword;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion
        #region 学生班级动态
        /// <summary>
        /// ClassID班级id；Type 0通知;1动态
        /// </summary>
        /// <param name="context"></param>
        private void StuMessage(HttpContext context)
        {
            string ClassID = context.Request["ClassID"].SafeToString();
            string Type = context.Request["Type"].SafeToString();
            string Id = context.Request["Id"].SafeToString();
            string urlbady = "Func=GetClassNewsData&ClassID=" + ClassID + "&Type=" + Type + "&Id=" + Id;
            string urlHead = ConfigHelper.GetConfigString("ClassWebUrl").SafeToString() + "/SystemSettings/ClassNewsHandler.ashx?";
            string result = NetHelper.RequestPostUrl(urlHead, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion
        #region 专业信息
        /// <summary>
        /// 专业信息
        /// </summary>
        /// <param name="context"></param>
        private void GetMajor(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/MajorHandler.ashx?";
            string Pid = context.Request["Pid"].SafeToString();
            string urlbady = "func=GetMajorData&SystemKey=" + SystemKey + "&InfKey=tjjyse";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 获取权限码（新）
        /// <summary>
        /// 获取权限码
        /// </summary>
        /// <param name="context"></param>
        private void GetLeftNavigationMenu(HttpContext context)
        {
            string UserIDCard = context.Request["UserIDCard"].SafeToString();
            //string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            //string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/SystemSettings/MenuHandler.ashx?";
            string urlHead = "http://192.168.1.2:8090/SystemSettings/MenuHandler.ashx?";
            string Pid = context.Request["Pid"].SafeToString();
            //string urlbady = "func=GetMenuByPidAndIDCard&SystemKey=" + SystemKey + "&InfKey=lhsfrz&UserIDCard=" + UserIDCard + "&pid=" + Pid;
            string urlbady = "func=GetMenuByPidAndIDCard&UserIDCard=" + UserIDCard + "&pid=" + Pid;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 获取用户信息（新）
        private void EditUser(HttpContext context)
        {


            string urlHead = u_handlerUrl + "/UserManage/UserInfo.ashx?";
            string urlbady = "Func=EditUser";


            string ID = context.Request["ID"] ?? ""; //true 为学生；false 为老师；空为全部
            string UserType = context.Request["UserType"].SafeToString();
            string Name = context.Request["Name"].SafeToString();
            string Nickname = context.Request["Nickname"].SafeToString();
            string Email = context.Request["Email"].SafeToString();
            string Sex = context.Request["Sex"].SafeToString();
            string Birthday = context.Request["Birthday"].SafeToString();
            string Phone = context.Request["Phone"].SafeToString();
            string IDCard = context.Request["IDCard"].SafeToString();
            string Address = context.Request["Address"].SafeToString();
            string Remarks = context.Request["Remarks"].SafeToString();
            string HeadPic = context.Request["HeadPic"].SafeToString();
            string LoginName = context.Request["LoginName"].SafeToString();
            urlbady += "&ID=" + ID + "&UserType=" + UserType + "&Email=" + Email + "&Name=" + HttpUtility.UrlDecode(Name) + "&LoginName=" + LoginName + "&Nickname=" + HttpUtility.UrlDecode(Nickname) + " &Sex = " + Sex + "&Birthday=" + Birthday + "&Phone=" + Phone + "&IDCard=" + IDCard + " &Address=" + Address + "&Remarks=" + Remarks + " &HeadPic=" + HeadPic;
            string PageUrl = urlHead + urlbady;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        private void GetOrgUser(HttpContext context)
        {
            JavaScriptSerializer jss = new JavaScriptSerializer();

            string urlHead = u_handlerUrl + "/UserManage/UserInfo.ashx?";
            string urlbady = "Func=GetData&SysAccountNo=" + sysAccountNo + "&Ispage=false&IsStu=false";
            string PageUrl = urlHead + urlbady;
            LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            JsonModel jsonModel = jss.Deserialize<JsonModel>(result);
            Dictionary<string, object> ht = jsonModel.retData as Dictionary<string, object>;

        }
        private void GetUserInfoData(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/UserManage/UserInfo.ashx?";
            string urlbady = "Func=GetData&SysAccountNo=" + sysAccountNo;

            if (!string.IsNullOrEmpty(context.Request["Ispage"]))
            {
                if (context.Request["Ispage"] == "false")
                {
                    urlbady += "&Ispage=false";
                }
                else
                {
                    urlbady += "&PageIndex=" + (context.Request["PageIndex"] ?? "1") + "&PageSize=" + (context.Request["PageSize"] ?? "10");
                }
            }
            else
            {
                urlbady += "&Ispage=false";

            }
            string isStu = context.Request["IsStu"] ?? ""; //true 为学生；false 为老师；空为全部
            string AcademicId = context.Request["Type"] ?? "0";
            if (!string.IsNullOrEmpty(isStu))
            {
                urlbady += "&IsStu=" + isStu + "&AcademicId=" + AcademicId;
            }
            if (!string.IsNullOrEmpty(context.Request["UniqueNos"]))
            {
                urlbady += "&UniqueNo=" + context.Request["UniqueNos"];
            }
            if (!string.IsNullOrEmpty(context.Request["JoinNoConn"]))
            {
                urlbady += "&JoinNoConn=" + context.Request["JoinNoConn"];
            }
            if (!string.IsNullOrEmpty(context.Request["Name"]))
            {
                urlbady += "&Name=" + context.Request["Name"].SafeToString();
            }
            if (!string.IsNullOrEmpty(context.Request["LoginName"]))
            {
                urlbady += "&GetLoginName=" + context.Request["LoginName"].SafeToString();
            }
            if (!string.IsNullOrEmpty(context.Request["TeaNo"]))
            {
                urlbady += "&TeaNo=" + context.Request["TeaNo"].SafeToString();
            }
            if (!string.IsNullOrEmpty(context.Request["OrgNo"]))
            {
                urlbady += "&OrgNo=" + context.Request["OrgNo"].SafeToString();
            }
            if (!string.IsNullOrEmpty(context.Request["NoFeedBack"]))
            {
                urlbady += "&NoFeedBack=" + context.Request["NoFeedBack"].SafeToString();
            }
            if (!string.IsNullOrEmpty(context.Request["HeadteacherNO"]))
            {
                urlbady += "&HeadteacherNO=" + context.Request["HeadteacherNO"].SafeToString();
            }
            
            //string PageUrl = urlHead + urlbady;
            //LogService.WriteLog(PageUrl + urlbady);
            string result = NetHelper.RequestPostUrl(urlHead, urlbady);
            //JavaScriptSerializer jss = new JavaScriptSerializer();
            //int starIndex = result.IndexOf(":") + 1;
            //int endIndex = result.LastIndexOf("}");
            //result = result.Substring(starIndex, endIndex - starIndex);

            //JsonModel jsonModel = jss.Deserialize<JsonModel>(result);
            //Dictionary<string, object> ht = jsonModel.retData as Dictionary<string, object>;
            //(new System.Collections.Generic.Mscorlib_DictionaryDebugView<string,object>(((Dictionary<string,object>)(((object[])(jsonModel.retData))[0])))).Items[0].key

            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 获取学年学期（新）
        private void GetTerm(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/EduManage/StudySection.ashx?";
            string urlbady = "Func=GetData&SysAccountNo=" + sysAccountNo;
            if (!string.IsNullOrEmpty(context.Request["Ispage"]))
            {
                urlbady += "&PageIndex=" + (context.Request["PageIndex"] ?? "1") + "&PageSize=" + (context.Request["PageSize"] ?? "10");
            }
            else
            {
                urlbady += "&Ispage=false";
            }
            urlbady += "&Status=" + context.Request["Status"] ?? "0";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }

        #endregion

        #region 年级
        /// <summary>
        /// 年级
        /// </summary>
        /// <param name="context"></param>
        private void GetGrade(HttpContext context)
        {
            string AcademicId = context.Request["AcademicId"];
            string Ispage = context.Request["Ispage"];
            string urlHead = u_handlerUrl + "/EduManage/GradeHandler.ashx?";
            string urlbady = "Func=GetData&SysAccountNo=" + sysAccountNo + "&AcademicId=" + AcademicId + "&Ispage=" + Ispage;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 班级
        /// <summary>
        /// 班级
        /// </summary>
        /// <param name="context"></param>
        private void GetClass(HttpContext context)
        {
            string AcademicId = context.Request["AcademicId"];
            string Ispage = context.Request["Ispage"];
            string HeadteacherNO = context.Request["HeadteacherNO"].SafeToString();
            string urlHead = u_handlerUrl + "/EduManage/ClassHandler.ashx?";
            string urlbady = "Func=GetData&SysAccountNo=" + sysAccountNo + "&AcademicId=" + AcademicId + "&Ispage=" + Ispage + "&HeadteacherNO=" + HeadteacherNO;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        private void GetGradeClass(HttpContext context)
        {
            string AcademicId = context.Request["AcademicId"];
            string Ispage = context.Request["Ispage"];
            string urlHead = u_handlerUrl + "/EduManage/GradeHandler.ashx?";
            string urlbady = "Func=GetGradClass&SysAccountNo=" + sysAccountNo + "&AcademicId=" + AcademicId + "&Ispage=" + Ispage;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion
        private void GetOrg(HttpContext context)
        {
            string Ispage = context.Request["Ispage"];
            string HeadteacherNO = context.Request["HeadteacherNO"].SafeToString();
            string urlHead = u_handlerUrl + "/Organiz/Organiz.ashx?";
            string urlbady = "Func=GetData&SysAccountNo=" + sysAccountNo + "&Ispage=" + Ispage + "&HeadteacherNO=" + HeadteacherNO;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }


        #region 师资力量数据
        /// <summary>
        /// 师资力量数据
        /// </summary>
        /// <param name="context"></param>
        protected void GetTeacherPower(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("PortalSystemKey");
            string MK = ConfigHelper.GetConfigString("PortalInfKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) param += "&PageIndex=" + context.Request["PageIndex"];
            if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) param += "&PageSize=" + context.Request["PageSize"];
            if (!string.IsNullOrWhiteSpace(context.Request["TeacherIDCard"])) param += "&TeacherIDCard=" + context.Request["TeacherIDCard"];
            if (!string.IsNullOrWhiteSpace(context.Request["Pageing"])) param += "&Pageing=" + context.Request["Pageing"];
            string urlbady = "func=GetTeacherByStudent&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 我的试卷
        /// <summary>
        /// 我的试卷
        /// </summary>
        /// <param name="context"></param>
        private void MyExamination(HttpContext context)
        {
            string userid = context.Request["userid"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            string urlbady = "func=GetTeacherClassSubject&SystemKey=" + SystemKey + "&InfKey=kaoshifq&TeacherIDCard" + userid;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 获取所有教师

        /// <summary>
        /// 所有教师
        /// </summary>
        /// <param name="context"></param>
        private void GetAllTeacherInfo(HttpContext context)
        {
            //string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            //string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            //string urlbady = "func=GetTeacherData&SystemKey=qg_xcjx_1&InfKey=sxskwid";
            string urlHead = u_handlerUrl + "/UserManage/UserInfo.ashx?";
            string urlbady = "Func=GetData&SysAccountNo=" + sysAccountNo + "&Ispage=false&IsStu=false";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }

        #endregion

        #region 获取学校
        /// <summary>
        /// 获取学校
        /// </summary>
        /// <param name="context"></param>
        protected void GetSchoolAll(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/SchoolHandler.ashx?";
            string urlbady = "func=GetSchoolAll&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region 新增学生
        /// <summary>
        /// 新增学生
        /// </summary>
        /// <param name="context"></param>
        protected void AddStudent(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("PortalSystemKey");
            string MK = ConfigHelper.GetConfigString("PortalInfKey");
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["Name"])) param += "&Name=" + context.Request["Name"];
            if (!string.IsNullOrWhiteSpace(context.Request["Nickname"])) param += "&Nickname=" + context.Request["Nickname"];
            if (!string.IsNullOrWhiteSpace(context.Request["IDCard"])) param += "&IDCard=" + context.Request["IDCard"];
            if (!string.IsNullOrWhiteSpace(context.Request["LoginName"])) param += "&LoginName=" + context.Request["LoginName"];
            //if (!string.IsNullOrWhiteSpace(context.Request["SchoolID"])) param += "&SchoolID=" + context.Request["SchoolID"];
            //if (!string.IsNullOrWhiteSpace(context.Request["State"])) param += "&State=" + context.Request["State"];
            //if (!string.IsNullOrWhiteSpace(context.Request["SchoolNO"])) param += "&SchoolNO=" + context.Request["SchoolNO"];
            if (!string.IsNullOrWhiteSpace(context.Request["Sex"])) param += "&Sex=" + context.Request["Sex"];
            if (!string.IsNullOrWhiteSpace(context.Request["Birthday"])) param += "&Birthday=" + context.Request["Birthday"];
            if (!string.IsNullOrWhiteSpace(context.Request["Phone"])) param += "&Phone=" + context.Request["Phone"];
            if (!string.IsNullOrWhiteSpace(context.Request["Address"])) param += "&Address=" + context.Request["Address"];
            if (!string.IsNullOrWhiteSpace(context.Request["Password"])) param += "&Password=" + context.Request["Password"];
            if (!string.IsNullOrWhiteSpace(context.Request["Email"])) param += "&Email=" + context.Request["Email"];
            //if (!string.IsNullOrWhiteSpace(context.Request["Remarks"])) param += "&Remarks=" + context.Request["Remarks"];
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/UserHandler.ashx?";
            string urlbady = "func=Register&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }
        #endregion

        #region  查询教室个人或多人信息（门户）
        /// <summary>
        /// 查询教室个人或多人信息（门户）
        /// </summary>
        /// <param name="context"></param>
        protected void GetTeacherData(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("PortalSystemKey");
            string MK = ConfigHelper.GetConfigString("PortalInfKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["IDCard"])) param += "&IDCard=" + context.Request["IDCard"];
            string urlbady = "func=GetTeacherData&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }
        protected void GetTeacherPageData(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("PortalSystemKey");
            string MK = ConfigHelper.GetConfigString("PortalInfKey_qx");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/TeacherHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) param += "&PageIndex=" + context.Request["PageIndex"];
            if (!string.IsNullOrWhiteSpace(context.Request["pageSize"])) param += "&pageSize=" + context.Request["pageSize"];
            string urlbady = "func=GetTeacherPageData&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        /// <summary>
        /// 查询学生（门户权限）
        /// </summary>
        /// <param name="context"></param>
        protected void GetStudentPageData(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("PortalSystemKey");
            string MK = ConfigHelper.GetConfigString("PortalInfKey_qx");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) param += "&PageIndex=" + context.Request["PageIndex"];
            if (!string.IsNullOrWhiteSpace(context.Request["pageSize"])) param += "&pageSize=" + context.Request["pageSize"];
            string urlbady = "func=GetStudentPageData&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        /// <summary>
        /// 根据学生查询本班所有同学
        /// </summary>
        /// <param name="context"></param>
        protected void GetClassStudent(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string MK = ConfigHelper.GetConfigString("EmailInfKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["IDCard"])) param += "&IDCard=" + context.Request["IDCard"];
            string urlbady = "func=GetClassStudent&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        public void GetStudentByTeacher(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string MK = ConfigHelper.GetConfigString("EmailInfKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["TeacherIDCard"])) param += "&TeacherIDCard=" + context.Request["TeacherIDCard"];
            string urlbady = "func=GetStudentByTeacher&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }


        private void EditMenuCode(HttpContext context)
        {
            string MenuID = context.Request["MenuID"].SafeToString();
            string MenuCode = context.Request["MenuCode"].SafeToString();
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/SystemSettings/MenuHandler.ashx?";
            string urlbady = "func=EditMenuCode&SystemKey=xlf_self&InfKey=lhsfrz&MenuID=" + MenuID + "&MenuCode=" + MenuCode;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }



        #endregion

        public void NoticesForKeyWord(HttpContext context)
        {
            string urlHead = System.Configuration.ConfigurationManager.AppSettings["KeyWord"] + "/Handler/QueryKeyWord.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["PageIndex"])) param += "&PageIndex=" + context.Request["PageIndex"];
            if (!string.IsNullOrWhiteSpace(context.Request["PageSize"])) param += "&PageSize=" + context.Request["PageSize"];
            string urlbady = "SearchKey=" + context.Request["SearchKey"];
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        public void UpdatePassword(HttpContext context)
        {
            string urlHead = System.Configuration.ConfigurationManager.AppSettings["KeyWord"] + "/Handler/UserHandler.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["LoginName"])) param += "&LoginName=" + context.Request["LoginName"];
            if (!string.IsNullOrWhiteSpace(context.Request["OldPassword"])) param += "&OldPassword=" + context.Request["OldPassword"];
            if (!string.IsNullOrWhiteSpace(context.Request["NewPassword"])) param += "&NewPassword=" + context.Request["NewPassword"];
            string urlbady = "func=UpdatePassword";
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        public void SavePassword(HttpContext context)
        {
            string urlHead = u_handlerUrl + "/UserManage/UserInfo.ashx?";
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["LoginName"])) param += "&GetLoginName=" + context.Request["LoginName"];
            if (!string.IsNullOrWhiteSpace(context.Request["Password"])) param += "&Password=" + context.Request["Password"];
            string urlbady = "func=UpdatePwdByLoginName";
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }

        public void ValidationUserByIDCardAndName(HttpContext context)
        {
            string SystemKey = "wewefw";
            string MK = "ewfsss";
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/UserHandler.ashx?";
            string param = string.Empty;
            param += "&IDCard=" + context.Request["IDCard"];
            param += "&Name=" + context.Request["Name"];
            string urlbady = "func=ValidationUserByIDCardAndName&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
        }
        /*
        public void RegisterCount(HttpContext context)
        {
            string SystemKey = "";
            string MK = "";
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/UserHandler.ashx?";
            string urlbady = "func=RegisterCount&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }
        */
        public void GetUserInfoByIDCard(HttpContext context)
        {
            string LoginName = "";
            if (!string.IsNullOrWhiteSpace(context.Request["LoginName"])) LoginName = context.Request["LoginName"];
            string urlHead = u_handlerUrl + "/UserManage/UserInfo.ashx?";
            string urlbady = "func=GetData&Ispage=false&LoginName=" + LoginName;
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);
            context.Response.Write(result);
            context.Response.End();
        }

        public void RegisterUpdateStudent(HttpContext context)
        {
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string MK = "lhsfrz";
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=RegisterUpdateStudent&SystemKey=" + SystemKey + "&InfKey=" + MK;
            string param = string.Empty;
            if (!string.IsNullOrWhiteSpace(context.Request["IDCard"])) param += "&IDCard=" + context.Request["IDCard"];
            if (!string.IsNullOrWhiteSpace(context.Request["LoginName"])) param += "&LoginName=" + context.Request["LoginName"];
            if (!string.IsNullOrWhiteSpace(context.Request["Sex"])) param += "&Sex=" + context.Request["Sex"];
            if (!string.IsNullOrWhiteSpace(context.Request["Phone"])) param += "&Phone=" + context.Request["Phone"];
            if (!string.IsNullOrWhiteSpace(context.Request["Address"])) param += "&Address=" + context.Request["Address"];
            if (!string.IsNullOrWhiteSpace(context.Request["Password"])) param += "&Password=" + context.Request["Password"];
            if (!string.IsNullOrWhiteSpace(context.Request["Nickname"])) param += "&Nickname=" + context.Request["Nickname"];
            if (!string.IsNullOrWhiteSpace(context.Request["Email"])) param += "&Email=" + context.Request["Email"];
            string PageUrl = urlHead + urlbady + param;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady + param);
            context.Response.Write(result);
            context.Response.End();
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