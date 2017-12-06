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

namespace SSSHanderler.CourseManage
{
    /// <summary>
    /// Course_Catagory 的摘要说明
    /// </summary>
    public class Course_Catagory : IHttpHandler
    {

        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        Course_CatagoryService bll = new Course_CatagoryService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            string result = string.Empty;

            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "GetData":
                            GetData(context);
                            break;
                        case "AddCatatory":
                            AddCatatory(context);
                            break;
                        case "EditCatatory":
                            EditCatatory(context);
                            break;
                        case "DelCatatory":
                            DelCatatory(context);
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
        #region 编辑
        private void EditCatatory(HttpContext context)
        {
            bool Flag = true;
            try
            {
                int ID = Convert.ToInt32(context.Request["ID"]);
                string Name = context.Request["Name"].SafeToString();
                SSSModel.Course_Catagory entity = new SSSModel.Course_Catagory();
                jsonModel = bll.GetEntityListByField("Name", Name);
                List<SSSModel.Course_Catagory> list = (List<SSSModel.Course_Catagory>)jsonModel.retData;
                if (list.Count > 1)
                {
                    Flag = false;
                }
                if (list.Count == 1 && list[0].ID == ID)
                {
                    Flag = false;
                }
                if (Flag)
                {
                    entity.ID = ID;
                    entity.Name = Name;
                    jsonModel = bll.Update(entity);
                }
                else
                {
                    jsonModel = new JsonModel()
                        {
                            errNum = 999,
                            errMsg = "名字重复",
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

        #region 添加
        private void AddCatatory(HttpContext context)
        {
            try
            {
                string Name = context.Request["Name"].SafeToString();
                SSSModel.Course_Catagory entity = new SSSModel.Course_Catagory();
                jsonModel = bll.GetEntityListByField("Name", Name);
                if (jsonModel.errNum == 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "名字重复",
                        retData = ""
                    };
                }
                else
                {
                    entity.Name = Name;
                    jsonModel = bll.Add(entity);
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

        #region 删除
        /// <summary>
        /// 删除分类信息
        /// </summary>
        /// <param name="context"></param>
        private void DelCatatory(HttpContext context)
        {
            CourseService coursebll = new CourseService();
            try
            {
                int ID = Convert.ToInt32(context.Request["ID"]);
                Hashtable ht = new Hashtable();

                ht.Add("CourseType", context.Request["ID"].SafeToString());
                jsonModel = coursebll.GetPage(ht, false);
                if (jsonModel.errNum == 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "该分类已被使用不可删除",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = bll.Delete(ID);
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

        #region 获取分类信息
        /// <summary>
        /// 获取分类信息
        /// </summary>
        /// <param name="context"></param>
        private void GetData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Course_Catagory");
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