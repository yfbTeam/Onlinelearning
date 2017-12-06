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
    /// Order_DishMenuHander 的摘要说明
    /// </summary>
    public class Order_DishMenuHander : IHttpHandler
    {
        Order_DishMenuService bll = new Order_DishMenuService();
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
                        case "GetPageList":
                            GetPageList(context);
                            break;
                        case "GetTimeScale":
                            GetTimeScale(context);
                            break;
                        case "Add":
                            Add(context);
                            break;
                        case "Del":
                            Del(context);
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
        #region  订餐时间段
        private void GetTimeScale(HttpContext context)
        {
            Order_TimeScaleService bll = new Order_TimeScaleService();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Order_TimeScale");
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
        #region 分配菜单
        private void Add(HttpContext context)
        {
            try
            {
                string useDate = context.Request["useDate"].SafeToString();
                string ScaleID = context.Request["ScaleID"].SafeToString();
                string DishIDArry = context.Request["DishIDArry"].SafeToString();

                string result = bll.OrderMenuAdd(useDate, ScaleID, DishIDArry);
                if (result == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = result,
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

        private void Del(HttpContext context)
        {
            int ID = Convert.ToInt32(context.Request["ID"]);
            jsonModel = bll.Delete(ID);
        }

        #region 获取信息

        private void GetPageList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("UseDate", context.Request["UseDate"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("ScaleID", context.Request["ScaleID"].SafeToString());
                ht.Add("DishID", context.Request["DishID"].SafeToString());
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



        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}