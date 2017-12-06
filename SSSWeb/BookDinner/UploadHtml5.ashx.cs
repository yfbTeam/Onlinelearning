using SSSBLL;
using SSSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using SSSUtility;
using System.IO;

namespace SSSWeb.BookDinner
{
    /// <summary>
    /// UploadHtml5 的摘要说明
    /// </summary>
    public class UploadHtml5 : IHttpHandler
    {
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        Couse_ResourceService bll = new Couse_ResourceService();
        ChangeFilePhy fileChange = new ChangeFilePhy();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.Headers.Add("Access-Control-Allow-Origin", "*");
            if (context.Request["REQUEST_METHOD"] == "OPTIONS")
            {
                context.Response.End();
            }
            string FuncName = context.Request["Func"].SafeToString();
            string result = string.Empty;

            context.Response.ContentType = "text/plain";
            context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "Uplod"://普通资源
                            Uplod(context);
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
            }
        }

        #region 上传资源      
        /// <summary>
        /// 上传普通资源
        /// </summary>
        /// <param name="context"></param>
        private void Uplod(HttpContext context)
        {
            string result = "";
            HttpPostedFile file = HttpContext.Current.Request.Files[0];
            string Fpath = ConfigHelper.GetConfigString("FileManageName") + "/Attatchment/Dinner";
            FileHelper.CreateDirectory(context.Server.MapPath(Fpath));

            string ext = Path.GetExtension(file.FileName);

            string fileName = Path.GetFileName(file.FileName); //DateTime.Now.Ticks + ext;

            string p = Fpath + "/" + fileName;

            string path = context.Server.MapPath(p);
            #region 处理文件同名问题
            if (FileHelper.IsExistFile(path))
            {
                int i = 0;
                while (true)
                {
                    i++;
                    if (!FileHelper.IsExistDirectory(context.Server.MapPath(Fpath + "/" + fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1])))
                    {
                        fileName = fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1];
                        p = Fpath + "/" + fileName;
                        path = context.Server.MapPath(p);

                        break;
                    }
                }
            }
            #endregion
            file.SaveAs(path);
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "",
                retData = p
            };
            result = string.IsNullOrEmpty(result) ? "{\"result\":" + jss.Serialize(jsonModel) + "}" : result;
            context.Response.Write(result);
            context.Response.End();

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