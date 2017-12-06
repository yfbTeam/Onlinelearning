
using SSSBLL;
using SSSModel;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace SSSHanderler
{
    /// <summary>
    /// TextbookVersionHandler 的摘要说明
    /// </summary>
    public class TextbookVersionHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        //Plat_LogInfoService log = new Plat_LogInfoService();
        JsonModel jsonModel = null;
        BLLCommon com = new BLLCommon();
        Plat_TextbookVersionService BLL = new Plat_TextbookVersionService();
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "GetTextbookVersionData":
                        GetTextbookVersionData(context);
                        break;
                    case "GetTextbookVersionPageData":
                        GetTextbookVersionPageData(context);
                        break;
                    case "DeleteTextbookVersion":
                        DeleteTextbookVersion(context);
                        break;
                    case "AddTextbookVersion":
                        AddTextbookVersion(context);
                        break;
                    case "GetTextbookVersionById":
                        GetTextbookVersionById(context);
                        break;
                    case "UpdateTextbookVersion":
                        UpdateTextbookVersion(context);
                        break;
                    case "Plat_GetTVData":
                        Plat_GetTVData(context);
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
            string result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.ContentType = "text/plain";
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

        /// <summary>
        /// 获得教材版本数据
        /// </summary>
        /// <param name="context"></param>
        public void GetTextbookVersionData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                //获取参数值
               
                sb.Append(" and IsDelete=0");
                ht.Add("func", "GetTextbookVersionData");
                ht.Add("Columns", "*");
                ht.Add("TableName", "Plat_TextbookVersion");
                ht.Add("Where", sb.ToString());

                jsonModel = com.GetData(ht);
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
                return;
            }
        }
        /// <summary>
        /// 获得教材版本数据
        /// </summary>
        /// <param name="context"></param>
        public void Plat_GetTVData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
                //获取参数值
                sb.Append(" and IsDelete=0");
                ht.Add("Columns", "*");
                ht.Add("TableName", "Plat_TextbookVersion");
                ht.Add("Where", sb.ToString());

                jsonModel = com.GetData_NoVerification(ht);
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
                return;
            }
        }

        /// <summary>
        /// 获得教材版本分页数据
        /// </summary>
        /// <param name="context"></param>
        public void GetTextbookVersionPageData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
              
                if (context.Request["PageIndex"] != null)
                {
                    ht.Add("PageIndex", context.Request["PageIndex"].ToString());
                }
                if (context.Request["PageSize"] != null)
                {
                    ht.Add("PageSize", context.Request["PageSize"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Name"]))
                {
                    sb.Append(" and Name like '%" + context.Request["Name"].ToString() + "%'");
                }
                sb.Append(" and IsDelete=0");
                ht.Add("func", "GetTextbookVersionPageData");
                ht.Add("Columns", "*");
                ht.Add("TableName", "Plat_TextbookVersion");
                ht.Add("Where", sb.ToString());

                jsonModel = com.GetPagingData(ht);
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
                return;
            }
        }

        /// <summary>
        /// 修改删除状态
        /// </summary>
        /// <param name="context"></param>
        public void DeleteTextbookVersion(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

               
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "loss",
                        retData = ""
                    };
                    return;
                }

                ht.Add("func", "DeleteTextbookVersion");
               
                jsonModel = BLL.DeleteFalse(Convert.ToInt32(ht["Id"].ToString()));
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
                return;
            }
        }

        /// <summary>
        /// 新增教材版本
        /// </summary>
        /// <param name="context"></param>
        public void AddTextbookVersion(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

               
                ht.Add("func", "AddTextbookVersion");
                
                Plat_TextbookVersion model = new Plat_TextbookVersion();
                if (context.Request["Name"] != null)
                {
                    model.Name = context.Request["Name"].ToString();
                }
                if (context.Request["UserIDCard"] != null)
                {
                    model.Creator = context.Request["UserIDCard"].ToString();
                }
                model.CreateTime = DateTime.Now;
                model.IsDelete = 0;
                jsonModel = BLL.Add(model);

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
                return;
            }
        }
        /// <summary>
        /// 获得教材版本数据
        /// </summary>
        /// <param name="context"></param>
        public void GetTextbookVersionById(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
              
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "loss",
                        retData = ""
                    };
                    return;
                }

                ht.Add("func", "GetTextbookVersionById");
               
                jsonModel = BLL.GetEntityById(Convert.ToInt32(ht["Id"].ToString()));
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
                return;
            }
        }

        /// <summary>
        /// 修改科目
        /// </summary>
        /// <param name="context"></param>
        public void UpdateTextbookVersion(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();

                //获取参数值
                if (context.Request["SystemKey"] != null)
                {
                    ht.Add("SystemKey", context.Request["SystemKey"].ToString());
                }
                if (context.Request["InfKey"] != null)
                {
                    ht.Add("InfKey", context.Request["InfKey"].ToString());
                }
                ht.Add("func", "UpdateTextbookVersion");
               
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ht.Add("Id", context.Request["Id"].ToString());
                }
                Plat_TextbookVersion model = new Plat_TextbookVersion();
                JsonModel JsonModel1 = BLL.GetEntityById(Convert.ToInt32(ht["Id"].ToString()));
                if (JsonModel1.errNum != 0)
                {
                    jsonModel = JsonModel1;
                    return;
                }
                model = (Plat_TextbookVersion)(JsonModel1.retData);
                if (context.Request["Name"] != null)
                {
                    model.Name = context.Request["Name"].ToString();
                }
                if (context.Request["UserIDCard"] != null)
                {
                    model.Editor = context.Request["UserIDCard"].ToString();
                }
                model.EditTime = DateTime.Now;
                jsonModel = BLL.Update(model);
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
                return;
            }
        }
    }
}