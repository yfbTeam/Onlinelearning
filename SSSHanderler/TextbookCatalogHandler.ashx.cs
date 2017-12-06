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
    /// TextbookCatalogHandler 的摘要说明
    /// </summary>
    public class TextbookCatalogHandler : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        //Plat_LogInfoService log = new Plat_LogInfoService();
        JsonModel jsonModel = null;
        BLLCommon com = new BLLCommon();
        Plat_TextbookCatalogService BLL = new Plat_TextbookCatalogService();

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            string func = context.Request["func"] ?? "";
            try
            {
                switch (func)
                {
                    case "GetTextbookCatalogData":
                        GetTextbookCatalogData(context);
                        break;
                    case "UpdateTextbookCatalog":
                        UpdateTextbookCatalog(context);
                        break;
                    case "AddTextbookCatalog":
                        AddTextbookCatalog(context);
                        break;
                    case "DeleteTextbookCatalog":
                        DeleteTextbookCatalog(context);
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

        private void DeleteTextbookCatalog(HttpContext context)
        {
            try
            {
                string ID = "";
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ID = context.Request["Id"].ToString();
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
                jsonModel = BLL.DeleteFalse(Convert.ToInt32(ID));
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

        private void AddTextbookCatalog(HttpContext context)
        {
            try
            {
                //获取参数值
                Plat_TextbookCatalog model = new Plat_TextbookCatalog();
                if (context.Request["Name"] != null)
                {
                    model.Name = context.Request["Name"].ToString();
                }
                if (!string.IsNullOrWhiteSpace(context.Request["PID"]))
                {
                    model.PID = Convert.ToInt32(context.Request["PID"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["TextbooxID"]))
                {
                    model.TextbooxID = Convert.ToInt32(context.Request["TextbooxID"].ToString());
                }
                if (!string.IsNullOrWhiteSpace(context.Request["Creator"]))
                {
                    model.Creator = context.Request["Creator"].ToString();
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

        private void UpdateTextbookCatalog(HttpContext context)
        {
            try
            {
                string ID = "";
                if (!string.IsNullOrWhiteSpace(context.Request["Id"]))
                {
                    ID = context.Request["Id"].ToString();
                }
                Plat_TextbookCatalog model = new Plat_TextbookCatalog();
                JsonModel JsonModel1 = BLL.GetEntityById(Convert.ToInt32(ID));
                if (JsonModel1.errNum != 0)
                {
                    jsonModel = JsonModel1;
                    return;
                }
                model = (Plat_TextbookCatalog)(JsonModel1.retData);
                if (context.Request["Name"] != null)
                {
                    model.Name = context.Request["Name"].ToString();
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

        /// <summary>
        /// 获得教材目录数据
        /// </summary>
        /// <param name="context"></param>
        public void GetTextbookCatalogData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                StringBuilder sb = new StringBuilder();
               
                if (!string.IsNullOrWhiteSpace(context.Request["TextbooxID"]))
                {
                    sb.Append(" and TextbooxID ='" + context.Request["TextbooxID"].ToString() + "'");
                }
                if (!string.IsNullOrWhiteSpace(context.Request["PID"]))
                {
                    sb.Append(" and PID ='" + context.Request["PID"].ToString() + "'");
                }
                sb.Append(" and IsDelete=0");
                ht.Add("func", "GetTextbookCatalogData");
                ht.Add("Columns", "*");
                ht.Add("TableName", "Plat_TextbookCatalog");
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
    }
}