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
    /// Order_Dish 的摘要说明
    /// </summary>
    public class Order_DishHander : IHttpHandler
    {
        Order_DishService bll = new Order_DishService();
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
                        case "GetDishType":
                            GetDishType(context);
                            break;
                        case "Add":
                            Add(context);
                            break;
                        case "Del":
                            Del(context);
                            break;
                        case "Edit":
                            Edit(context);
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
        #region
        private void Add(HttpContext context)
        {
            Order_Dish entity = new Order_Dish();
            entity.Name = context.Request["Name"].SafeToString();
            entity.HotDegree = Convert.ToByte(context.Request["HotDegree"]);
            entity.Price = Convert.ToDecimal(context.Request["Price"]); ;
            entity.Description = context.Request["Description"].SafeToString(); ;
            entity.HotDegree = Convert.ToByte(context.Request["HotDegree"]);
            entity.Photo = context.Request["Photo"].SafeToString();
            entity.Status = Convert.ToInt32(context.Request["Status"]);
            entity.Type = Convert.ToByte(context.Request["Type"]);
            jsonModel = bll.Add(entity);
        }
        private void Edit(HttpContext context)
        {
            int ID = Convert.ToInt32(context.Request["ID"]);
            Order_Dish entity = (Order_Dish)bll.GetEntityById(ID).retData;
            string Status = context.Request["Status"].SafeToString();
            if (Status.Length > 0)
            {
                entity.Status = Convert.ToInt32(Status);
            }
            else
            {
                entity.Name = context.Request["Name"].SafeToString();
                entity.HotDegree = Convert.ToByte(context.Request["HotDegree"]);
                entity.Price = Convert.ToDecimal(context.Request["Price"]); ;
                entity.Description = context.Request["Description"].SafeToString(); ;
                entity.HotDegree = Convert.ToByte(context.Request["HotDegree"]);
                entity.Photo = context.Request["Photo"].SafeToString();
                //entity.Status = Convert.ToInt32(context.Request["Status"]);
                entity.Type = Convert.ToByte(context.Request["Type"]);
            }
            jsonModel = bll.Update(entity);
        }
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
                ht.Add("TableName", "Order_Dish");
                ht.Add("Status", context.Request["Status"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("Name", context.Request["Name"].SafeToString());
                ht.Add("Type", context.Request["Type"].SafeToString());
                ht.Add("ScaleID", context.Request["ScaleID"].SafeToString());
                ht.Add("useDate", context.Request["useDate"].SafeToString());


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
        #endregion

        #region  分类
        private void GetDishType(HttpContext context)
        {
            Order_DishTypeService bll = new Order_DishTypeService();
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("TableName", "Order_DishType");
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