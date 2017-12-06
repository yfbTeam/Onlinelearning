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
    /// UserOrder 的摘要说明
    /// </summary>
    public class UserOrder : IHttpHandler
    {

        Order_UserOrderService bll = new Order_UserOrderService();
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
                        case "GetData":
                            GetData(context);
                            break;

                        case "Add":
                            Add(context);
                            break;
                        case "OrderSure":
                            OrderSure(context);
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
        private void OrderSure(HttpContext context)
        {
            string CreateUID = context.Request["CreateUID"].SafeToString();
            int num = bll.SureOrder(CreateUID);
            if (num > 0)
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
                    errMsg = "0条订单确认成功",
                    retData = ""
                };
            }
        }
        private void Del(HttpContext context)
        {
            try
            {
                string ID = context.Request["ID"].SafeToString();
                jsonModel = bll.Delete(Convert.ToInt32(ID));
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
        #region 添加订单
        private void Add(HttpContext context)
        {
            try
            {
                Order_UserOrder entity = new Order_UserOrder();
                entity.CreateUID = context.Request["CreateUID"].SafeToString();
                string result = context.Request["result"].SafeToString().TrimEnd(',');
                //ScaleID + '-' + DashiID + '-' + DashNum + ',';
                foreach (string item in result.Split(','))
                {
                    entity.DishID = Convert.ToInt32(item.Split('-')[1]);
                    entity.Peaces = Convert.ToInt32(item.Split('-')[2]);
                    entity.ScaleID = Convert.ToByte(item.Split('-')[0]);
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

        private void GetData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Status", context.Request["Status"].SafeToString());
                ht.Add("BeginTime", context.Request["BeginTime"].SafeToString());
                ht.Add("EndTime", context.Request["EndTime"].SafeToString());
                ht.Add("CreateUID", context.Request["CreateUID"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("DiffDay", context.Request["DiffDay"].SafeToString());


                bool Ispage = true;
                if (context.Request["IsPage"].SafeToString().Length > 0)
                {
                    Ispage = Convert.ToBoolean(context.Request["IsPage"]);

                }
                jsonModel = common.AddCreateNameForData(bll.GetPage(ht, Ispage), Ispage);
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