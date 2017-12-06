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

namespace SSSHanderler.Certificate
{
    /// <summary>
    /// Certificate 的摘要说明
    /// </summary>
    public class Certificate : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        Course_ChapterService courcebll = new Course_ChapterService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].SafeToString();
            string result = string.Empty;

            if (FuncName != null && FuncName != "")
            {

                switch (FuncName)
                {
                    case "GetModolList":
                        GetModolList(context);
                        break;
                    case "GetCertificates":
                        GetCertificates(context);
                        break;

                    case "GetPlatCertificate":
                        GetPlatCertificate(context);
                        break;

                    case "AddPlatCertificate":
                        AddPlatCertificate(context);
                        break;
                    case "ApplyCert":
                        ApplyCert(context);
                        break;
                    case "CheckApply":
                        CheckApply(context);
                        break;
                    case "DelPlatCertificate":
                        DelPlatCertificate(context);
                        break;

                    case "EditCert":
                        EditCert(context);
                        break;
                    default:
                        jsonModel = new JsonModel()
                        {
                            errNum = 404,
                            errMsg = "无此方法",
                            retData = ""
                        };
                        result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
                        context.Response.Write(result);
                        break;
                }
                LogService.WriteLog("");

            }
            context.Response.End();
        }
        private void EditCert(HttpContext context)
        {
            string result = "";
            string ID = context.Request["ID"].SafeToString();
            string Attachment = context.Request["Attachment"].SafeToString();
            string Type = context.Request["Type"].SafeToString();
            if (Type == "1")
            {
                CertificateListService bll = new CertificateListService();
                CertificateList modole = new CertificateList();
                modole.ID = int.Parse(ID);
                modole.Attachment = Attachment;
                jsonModel = bll.Update(modole);
            }
            else
            {
                CertificateManageService bll = new CertificateManageService();
                CertificateManage modole = new CertificateManage();
                modole.ID = int.Parse(ID);
                modole.Attachment = Attachment;
                jsonModel = bll.Update(modole);
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
        }



        #region 证书申请审核
        /// <summary>
        /// 证书申请审核
        /// </summary>
        /// <param name="context"></param>
        private void CheckApply(HttpContext context)
        {
            string result = "";
            string ID = context.Request["ID"].SafeToString();
            string CheckMessage = context.Request["CheckMessage"].SafeToString();
            string isPass = context.Request["isPass"].SafeToString();
            string UserIdCard = context.Request["UserIdCard"].SafeToString();
            CertificateListService bll = new CertificateListService();
            CertificateList modle = new CertificateList();
            modle.ID = int.Parse(ID);
            modle.Status = int.Parse(isPass);
            modle.EditTime = DateTime.Now;
            modle.EditUID = UserIdCard;
            modle.ApplyMessage = CheckMessage;
            jsonModel = bll.Update(modle);
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);

        }
        #endregion

        #region 证书申请
        //证书申请
        private void ApplyCert(HttpContext context)
        {
            string result = "";
            string StuNo = context.Request["StuNo"].SafeToString();
            string CertificateID = context.Request["CertificateID"].SafeToString();

            CertificateManageService bll = new CertificateManageService();
            string Messagee = bll.Apply(CertificateID, StuNo);
            if (Messagee == "")
            {
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = Messagee,
                    retData = ""
                };
            }
            else
            {
                jsonModel = new JsonModel()
                {
                    errNum = 999,
                    errMsg = Messagee,
                    retData = ""
                };
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
        }
        #endregion

        #region 添加平台证书
        private void AddPlatCertificate(HttpContext context)
        {
            string result = "";
            string Name = context.Request["Name"].SafeToString();
            string Course = context.Request["Course[]"].SafeToString();
            string UserIdCard = context.Request["UserIdCard"].SafeToString();
            string ModelID = context.Request["ModelID"].SafeToString();
            CertificateManageService bll = new CertificateManageService();
            string ID = context.Request["ID"].SafeToString();
            if (ID.Length > 0)
            {
                string Messagee = bll.PlatCertificateEdit(Name, Course, UserIdCard, ModelID, int.Parse(ID));
                if (Messagee == "修改成功")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = Messagee,
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = Messagee,
                        retData = ""
                    };
                }
            }
            else
            {
                string Messagee = bll.PlatCertificateAdd(Name, Course, UserIdCard, ModelID);
                if (Messagee == "添加成功")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = Messagee,
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                        {
                            errNum = 0,
                            errMsg = Messagee,
                            retData = ""
                        };
                }
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
        }
        #endregion



        #region 删除平台正式
        /// <summary>
        /// 删除平台正式
        /// </summary>
        /// <param name="context"></param>
        private void DelPlatCertificate(HttpContext context)
        {
            string result = "";
            string UserIdCard = context.Request["UserIdCard"].SafeToString();

            string ID = context.Request["ID"].SafeToString();
            CertificateManageService CertificateManage = new CertificateManageService();
            string Messagee = CertificateManage.PlatCertificateDel(UserIdCard, int.Parse(ID));

            if (Messagee == "删除成功")
            {
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = Messagee,
                    retData = ""
                };
            }
            else
            {
                jsonModel = new JsonModel()
                {
                    errNum = 999,
                    errMsg = Messagee,
                    retData = ""
                };
            }

            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);

        }
        #endregion

        #region 获取平台证书
        private void GetPlatCertificate(HttpContext context)
        {
            string result = "";
            Hashtable ht = new Hashtable();
            ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
            ht.Add("PageSize", context.Request["PageSize"].SafeToString());
            string CertID = context.Request["ID"].SafeToString();
            string StuNo = context.Request["StuNo"].SafeToString();
            string UserType = context.Request["UserType"].SafeToString();
            bool Ispage = true;
            if (context.Request["Ispage"].SafeToString().Length > 0)
            {
                Ispage = Convert.ToBoolean(context.Request["Ispage"]);
            }
            string str = "";
            if (UserType == "1")
            {
                str="select a.*,b.ImageUrl "+
                //,c.Status as SelStatus 
                "from CertificateManage a inner join CertificateModol b on a.ModelID=b.ID";
                //left join CertificateList c on a.ID=c.CertificateID and c.CreateUID='" + StuNo + "'";

            }
            else
            {
                str = "select a.*,b.ImageUrl,d.Status as SelStatus,e.StuNo from CertificateManage a inner join CertificateModol b on a.ModelID=b.ID inner join CertificateCourse c on a.id=c.CertificateID inner join Couse_Selstuinfo e on c.CourseID=e.CourseID and e.StuNo='" + StuNo
                  + "' left join CertificateList d on a.ID=d.CertificateID and d.CreateUID='" + StuNo + "'";
            }
            if (CertID.Length > 0)
            {
                str += " and a.ID=" + CertID;
            }
            ht.Add("TableName", "(" + str + ")");

            CertificateManageService CertificateManage = new CertificateManageService();
            JsonModel CertiModel = CertificateManage.GetPage(ht, Ispage, "");
            result = "{";
            result += "\"CertificateManage\":" + jss.Serialize(CertiModel);

            Hashtable ht1 = new Hashtable();
            ht1.Add("PageIndex", context.Request["PageIndex"].SafeToString());
            ht1.Add("PageSize", context.Request["PageSize"].SafeToString());
            //ht1.Add("TableName", "(select b.Title,T.*  from Exam_ExamPaper b,CertificateExam T  WHERE 1=1  and T.examID=b.ID)");

            //CertificateExamService CertificateExam = new CertificateExamService();
            //JsonModel Exam = CertificateManage.GetPage(ht1, false);
            //result += ",\"Exam\":" + jss.Serialize(Exam);

            Hashtable ht2 = new Hashtable();
            ht2.Add("PageIndex", context.Request["PageIndex"].SafeToString());
            ht2.Add("PageSize", context.Request["PageSize"].SafeToString());
            ht2.Add("TableName", "(select b.Name as CourseName,T.* from Course b,CertificateCourse T  WHERE 1=1  and T.CourseID=b.ID)");

            CertificateCourseService CertificateCourse = new CertificateCourseService();
            JsonModel Course = CertificateCourse.GetPage(ht2, false);
            result += ",\"Course\":" + jss.Serialize(Course);
            result += "}";
            context.Response.Write(result);

        }
        #endregion



        #region 获取证书模板信息
        /// <summary>
        /// 获取培训信息
        /// </summary>
        /// <param name="context"></param>
        private void GetModolList(HttpContext context)
        {
            CertificateModolService modelDll = new CertificateModolService();
            string result = "";
            try
            {
                Hashtable ht = new Hashtable();
                //ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                //ht.Add("PageSize", context.Request["PageSize"].ToString());
                ht.Add("TableName", "CertificateModol");
                jsonModel = modelDll.GetPage(ht, false);
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
        }
        #endregion

        #region 证书列表

        private void GetCertificates(HttpContext context)
        {
            CommonHandler common = new CommonHandler();
            CertificateListService modelDll = new CertificateListService();
            string result = "";
            try
            {
                bool Ispage = false;
                if (context.Request["Ispage"].SafeToString().Length > 0)
                {
                    Ispage = Convert.ToBoolean(context.Request["Ispage"]);
                }
                Hashtable ht = new Hashtable();
                //ht.Add("TableName", "CertificateList");
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("NStatus", context.Request["PageSize"].SafeToString());
                ht.Add("IDCard", context.Request["IDCard"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("CertificateID", context.Request["CertificateID"].SafeToString());
                ht.Add("Status", context.Request["Status"].SafeToString());
                ht.Add("Identifier", context.Request["Identifier"].SafeToString());
                ht.Add("CourceID", context.Request["CourceID"].SafeToString());

                
                jsonModel = common.AddCreateNameForData(modelDll.GetPage(ht, Ispage), Ispage);
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