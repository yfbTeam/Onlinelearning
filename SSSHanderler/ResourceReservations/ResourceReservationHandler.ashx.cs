using SSSBLL;
using SSSModel;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SSSHanderler.ResourceReservations
{
    /// <summary>
    /// ResourceReservationHandler 的摘要说明
    /// </summary>
    public class ResourceReservationHandler : IHttpHandler
    {

        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        Appoint_ResourceReservationService resourceService = new Appoint_ResourceReservationService();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string func = context.Request["Func"];
            string result = string.Empty;
            try
            {
                switch (func)
                {
                    case "GetPageList":
                        GetPageList(context);
                        break;
                    case "AddResourceReservation":
                        AddResourceReservation(context);
                        break;
                    case "DelResourceReservation":
                        DelResourceReservation(context);
                        break;
                    case "ChangeStatus":
                        ChangeStatus(context);
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

        #region 获取资源表的分页数据
        private void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("ResourceTypeName", context.Request["ResourceTypeName"] ?? "");
                ht.Add("AppoIntmentTime", context.Request["AppoIntmentTime"] ?? "");
                ht.Add("TimeInterval", context.Request["TimeInterval"] ?? "");
                ht.Add("ReservationTimeInterval", context.Request["ReservationTimeInterval"] ?? "");
                ht.Add("ReservationAppoIntmentTime", context.Request["ReservationAppoIntmentTime"] ?? "");
                ht.Add("ReSourceInfoId", context.Request["ReSourceInfoId"] ?? "");
                ht.Add("ReSourceClassId", context.Request["ReSourceClassId"] ?? "");
                ht.Add("IDCard", context.Request["IDCard"] ?? "");
                ht.Add("ApprovalStutus", context.Request["ApprovalStutus"] ?? "");
                ht.Add("TableName", "Appoint_ResourceReservation");
                bool ispage = true;
                if (!string.IsNullOrEmpty(context.Request["ispage"]))
                {
                    ispage = Convert.ToBoolean(context.Request["ispage"]);
                }
                if (ispage)
                {
                    ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                    ht.Add("PageSize", context.Request["pageSize"].SafeToString());
                }

                jsonModel = resourceService.GetPage(ht, ispage);
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

        private void AddResourceReservation(HttpContext context)
        {
            try
            {
                Appoint_ResourceReservation resource = new Appoint_ResourceReservation();
                string CourseID = context.Request["CourseID"].SafeToString();
                if (!string.IsNullOrEmpty(context.Request["ReSourceInfoId"]))
                {
                    resource.ReSourceInfoId = Convert.ToInt32(context.Request["ReSourceInfoId"]);
                }
                if (!string.IsNullOrEmpty(context.Request["ReSourceClassId"]))
                {
                    resource.ReSourceClassId = Convert.ToInt32(context.Request["ReSourceClassId"]);
                }
                if (!string.IsNullOrEmpty(context.Request["TimeInterval"]))
                {
                    resource.TimeInterval = context.Request["TimeInterval"];
                }
                if (!string.IsNullOrEmpty(context.Request["AppoIntmentTime"]))
                {
                    resource.AppoIntmentTime = Convert.ToDateTime(context.Request["AppoIntmentTime"]);
                }
                if (!string.IsNullOrEmpty(context.Request["Name"]))
                {
                    resource.Name = context.Request["Name"];
                }

                if (!string.IsNullOrEmpty(context.Request["School"]))
                {
                    resource.School = context.Request["School"];
                }

                if (!string.IsNullOrEmpty(context.Request["Address"]))
                {
                    resource.Address = context.Request["Address"];
                }

                if (!string.IsNullOrEmpty(context.Request["Telephone"]))
                {
                    resource.Telephone = context.Request["Telephone"];
                }

                if (!string.IsNullOrEmpty(context.Request["Remark"]))
                {
                    resource.Remark = context.Request["Remark"];
                }
                if (!string.IsNullOrEmpty(context.Request["ApprovalStutus"]))
                {
                    resource.ApprovalStutus = Convert.ToByte(context.Request["ApprovalStutus"]);
                }
                if (!string.IsNullOrEmpty(context.Request["ApprovalOpinion"]))
                {
                    resource.ApprovalOpinion = context.Request["ApprovalOpinion"];
                }

                if (!string.IsNullOrEmpty(context.Request["UserIdCard"]))
                {
                    resource.IDCard = context.Request["UserIdCard"];
                }

                if (!string.IsNullOrEmpty(context.Request["ApprovalPeople"]))
                {
                    resource.ApprovalPeople = context.Request["ApprovalPeople"];
                }
                resource.CourceID = CourseID == "" ? 0 : Convert.ToInt32(CourseID);

                if (!string.IsNullOrEmpty(context.Request["ID"]))
                {
                    resource.Id = Convert.ToInt32(context.Request["ID"]);
                    resource.Editor = context.Request["UserName"]; ;
                    resource.UpdateTime = DateTime.Now;
                    jsonModel = resourceService.Update(resource);
                    //修改课程状态（教室预约中）
                    if (CourseID.Length > 0 && jsonModel.errNum == 0)
                    {
                        CourseService bll = new CourseService();
                        Course course = (Course)bll.GetEntityById(Convert.ToInt32(CourseID)).retData;
                        if (context.Request["ApprovalStutus"].SafeToString() == "3")
                        {
                            course.Status = 5;
                        }
                        else if (context.Request["ApprovalStutus"].SafeToString() == "1")
                        {
                            course.Status = 4;
                        }
                        bll.Update(course);
                    }
                }
                else
                {
                    resource.Applicant = context.Request["UserName"]; ;
                    resource.Creator = context.Request["UserName"]; ;
                    resource.CreateTime = DateTime.Now;
                    jsonModel = resourceService.Add(resource);
                    //修改课程状态（教室预约中）
                    if (CourseID.Length > 0 && jsonModel.errNum == 0)
                    {
                        CourseService bll = new CourseService();
                        Course course = (Course)bll.GetEntityById(Convert.ToInt32(CourseID)).retData;
                        course.Status = 3;
                        bll.Update(course);
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
        }

        private void DelResourceReservation(HttpContext context)
        {
            int id = 0;
            if (context.Request["ID"] == null || !string.IsNullOrEmpty(context.Request["ID"].ToString()))
            {
                id = Convert.ToInt32(context.Request["ID"]);
            }
            jsonModel = resourceService.GetEntityById(id);
            if (jsonModel.errNum == 0)
            {
                Appoint_ResourceReservation resource = jsonModel.retData as Appoint_ResourceReservation;
                resource.Id = id;
                resource.IsDelete = 1;
                resource.Editor = context.Request["UserName"];
                resource.UpdateTime = DateTime.Now;
                jsonModel = resourceService.Update(resource);
            }
        }

        #endregion

        #region 更改状态
        public void ChangeStatus(HttpContext context)
        {
            Appoint_ResourceReservation resource = new Appoint_ResourceReservation();
            resource.Id = Convert.ToInt32(context.Request["Id"]);
            resource.UseStatus = Convert.ToByte(context.Request["Status"]);
            resource.IsDelete = 1;
            resource.Editor = context.Request["UserName"];
            resource.UpdateTime = DateTime.Now;
            jsonModel = resourceService.Update(resource);
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