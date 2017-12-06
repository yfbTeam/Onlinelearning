using SSSBLL;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SSSUtility;
using System.Web.Script.Serialization;
using SSSModel;
using SSSHanderler.OnlineLearning;
namespace SSSHanderler.ResourceManage
{
    /// <summary>
    /// SkySet 的摘要说明
    /// </summary>
    public class SkySet : IHttpHandler
    {
        MyResource_CapacityAllService AllBll = new MyResource_CapacityAllService();
        MyResource_CapacityEachService EachBll = new MyResource_CapacityEachService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        CommonHandler common = new CommonHandler();
        public void ProcessRequest(HttpContext context)
        {
            string result = "";
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            if (FuncName != null && FuncName != "")
            {
                switch (FuncName)
                {
                    case "GetBaseSet":
                        GetBaseSet(context);
                        break;
                    case "BaseSet":
                        BaseSet(context);
                        break;
                    case "EachSet":
                        EachSet(context);
                        break;
                    case "GetAllUserInfo":
                        GetAllUserInfo(context);
                        break;
                    default:
                        break;
                }
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();

        }
        private void GetBaseSet(HttpContext context) {
            MyResource_CapacityAllService bll = new MyResource_CapacityAllService();
            Hashtable ht=new Hashtable();
            ht.Add("TableName","MyResource_CapacityAll");
           jsonModel= bll.GetPage(ht, false);
        }
        private void GetAllUserInfo(HttpContext context)
        {
            MyResource_CapacityEachService bll = new MyResource_CapacityEachService();

            string CreateUID = context.Request["CreateUID"].SafeToString();
            Hashtable ht = new Hashtable();
            ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
            ht.Add("PageSize", context.Request["PageSize"].SafeToString());
            ht.Add("CreateUID", CreateUID);
            bool IsPage=true;
          
            if (context.Request["IsPage"].SafeToString().Length>0)
            {
                IsPage = Convert.ToBoolean(context.Request["IsPage"]);
            }
            jsonModel = bll.GetPage(ht, IsPage);

            jsonModel = common.AddCreateNameForData(jsonModel, IsPage, "UserID");

        }
        private void BaseSet(HttpContext context)
        {
            jsonModel = AllBll.UpdateBase(context.Request["AddLen"].SafeToString());
        }
        private void EachSet(HttpContext context)
        {
            MyResource_CapacityEach entity = new MyResource_CapacityEach();
            string ID = context.Request["ID"].SafeToString();
            entity.AddLen = Convert.ToInt32(context.Request["AddLen"]);
            entity.UserID = context.Request["UserID"].SafeToString();

            if (ID.Length > 0 && ID != "undefined")
            {
                entity.ID = Convert.ToInt32(ID);
                jsonModel = EachBll.Update(entity);
            }
            else
            {
                jsonModel = EachBll.Add(entity);
            }
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