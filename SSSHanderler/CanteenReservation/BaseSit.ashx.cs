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


namespace SSSHanderler.CanteenReservation
{
    /// <summary>
    /// BaseSit 的摘要说明
    /// </summary>
    public class BaseSit : IHttpHandler
    {
        Order_CanteenService bll = new Order_CanteenService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        CommonHandler common = new CommonHandler();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string FuncName = context.Request["Func"].SafeToString();
            string result = string.Empty;

            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "GetCanteeData":
                            GetCanteeData(context);
                            break;

                        case "Add":
                            Add(context);
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

        #region 修改餐厅基本信息
        private void Add(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Order_Canteen");

                jsonModel = bll.GetPage(ht, false);
                Order_Canteen entity = new Order_Canteen();
                entity.Name = context.Request["Name"].SafeToString();
                entity.AddressMsg = context.Request["AddressMsg"].SafeToString();
                entity.BeginTime = context.Request["BeginTime"].SafeToString();
                entity.EndTime = context.Request["BeginTime"].SafeToString();
                entity.Notice = context.Request["Notice"].SafeToString();
                entity.Photo = context.Request["Photo"].SafeToString();

                if (jsonModel.errNum == 0)
                {
                    entity.ID = Convert.ToInt32(context.Request["ID"]);
                    jsonModel = bll.Update(entity);
                }
                else
                {
                    jsonModel = bll.Add(entity);
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

        #region 获取信息

        private void GetCanteeData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Order_Canteen");

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