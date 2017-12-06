using Newtonsoft.Json.Linq;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace SSSWeb.PersonalSpace
{
    /// <summary>
    /// ToExcelHandler 的摘要说明
    /// </summary>
    public class ToExcelHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        
                        case "StuDoc":
                            StuDoc(context);
                            break;

                    }
                }
                catch (Exception ex)
                {
                    LogService.WriteErrorLog(ex.Message);
                }
            }

        }
        

        #region 学生信息
        /// <summary>
        /// 学生信息
        /// </summary>
        /// <param name="context"></param>
        private void StuDoc(HttpContext context)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("IDCard");
            dt.Columns.Add("LoginName");
            dt.Columns.Add("SchoolID");
            dt.Columns.Add("State");
            dt.Columns.Add("Name");
            dt.Columns.Add("Sex");
            dt.Columns.Add("Address");
            dt.Columns.Add("Phone");
            string IDCard = context.Request["IDCard"].SafeToString();
            string SystemKey = ConfigHelper.GetConfigString("SystemKey");
            string urlHead = ConfigHelper.GetConfigString("HandlerUrl").SafeToString() + "/StudentHandler.ashx?";
            string urlbady = "func=GetStudentData&IDCard=" + IDCard + "&SystemKey=" + SystemKey + "&InfKey=lhsfrz";
            string PageUrl = urlHead + urlbady;
            string result = NetHelper.RequestPostUrl(PageUrl, urlbady);


            JObject rtnObj = JObject.Parse(result);
            JObject resultObj = JsonTool.GetObjVal(rtnObj, "result");
            if (JsonTool.GetStringVal(resultObj, "errNum") == "0")
            {
                JArray retData = JsonTool.GetArryVal(resultObj, "retData");
                JObject curUser = retData[0] as JObject;

                DataRow dr = dt.NewRow();
                dr["IDCard"] = JsonTool.GetStringVal(curUser, "IDCard");
                dr["LoginName"] = JsonTool.GetStringVal(curUser, "LoginName");
                dr["SchoolID"] = JsonTool.GetStringVal(curUser, "SchoolID");
                dr["State"] = JsonTool.GetStringVal(curUser, "State");
                dr["Name"] = JsonTool.GetStringVal(curUser, "Name");
                dr["Sex"] = JsonTool.GetStringVal(curUser, "Sex");
                dr["Address"] = JsonTool.GetStringVal(curUser, "Address");
                dr["Phone"] = JsonTool.GetStringVal(curUser, "Phone");
                dt.Rows.Add(dr);
            }

            ExcelHelper.ExportByWeb(dt, "身份证号,登录账号,学校ID,状态,姓名,性别,家庭住址,电话", "学生信息", "Sheet1");
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