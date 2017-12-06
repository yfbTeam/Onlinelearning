using SSSBLL;
using SSSModel;
using SSSUtility;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SSSWeb.ResourceManage
{
    /// <summary>
    /// ResouceFileUpload 的摘要说明
    /// </summary>
    public class ResouceFileUpload : IHttpHandler
    {
        JsonModel jsonModel = null;
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        public void ProcessRequest(HttpContext context)
        {
            LogService.WriteLog(DateTime.Now.ToString() + "TableName:" + context.Request["TableName"].SafeToString());
            context.Response.Headers.Add("Access-Control-Allow-Origin", "*");
            try
            {
                if (context.Request["REQUEST_METHOD"] == "OPTIONS")
                {
                    context.Response.End();
                }
                context.Response.ContentType = "text/plain";
                string Type = context.Request["TableName"].SafeToString();
                switch (Type)
                {
                    case "Resource":
                        UploadResource(context);
                        break;
                    case "Resources_Open":
                        UploadResources_Open(context);
                        break;
                    case "MyResource":
                        UploadMyResource(context);
                        break;
                    case "ResourcesInfo":
                        UploadResourcesInfo(context);
                        break;
                    default:
                        break;
                }
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }

        }
        private void UploadResourcesInfo(HttpContext context)
        {
            ResourcesInfoService Bll = new ResourcesInfoService();
            string FoldUrl = context.Request["FoldUrl"] == null ? "" : context.Request["FoldUrl"].SafeToString();
            FoldUrl = ConfigHelper.GetConfigString("FileManageName") + FoldUrl;
            string GroupName = context.Request["GroupName"].SafeToString().Trim();
            string CatagoryID = context.Request["CatagoryID"].SafeToString().Trim().Replace("|0", "");
            string ChapterID = context.Request["ChapterID"].SafeToString().Trim();
            string result = "0";
            string CreateUID = context.Request["CreateUID"].SafeToString();

            try
            {

                if (!FileHelper.IsExistDirectory(context.Server.MapPath(FoldUrl + "/" + GroupName)))
                {
                    FileHelper.CreateDirectory(context.Server.MapPath(FoldUrl + "/" + GroupName));
                }
               
                HttpPostedFile file = context.Request.Files[0];

                string ext = Path.GetExtension(file.FileName);

                string fileName = Path.GetFileName(file.FileName);
                string p = FoldUrl + "/" + fileName;

                string path = context.Server.MapPath(p);

                #region 处理文件同名问题
                if (FileHelper.IsExistFile(path))
                {
                    int i = 0;
                    while (true)
                    {
                        i++;
                        if (!FileHelper.IsExistFile(context.Server.MapPath(FoldUrl + "/" + fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1])))
                        {
                            fileName = fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1];
                            p = FoldUrl + "/" + fileName;
                            path = context.Server.MapPath(p);

                            break;
                        }
                    }
                }
                #endregion

                file.SaveAs(path);
                ResourcesInfo re = new ResourcesInfo();
                re.Name = fileName.Replace(ext, "");
                re.FileSize = file.ContentLength;
                re.FileUrl = p;
                re.FileIcon = "ico-" + fileName.Split('.')[1] + "b.png";
                re.FileIconBig = "ico-" + fileName.Split('.')[1] + "t.png";
                re.postfix = ext.ToLower();
                re.CreateUID = CreateUID;
                re.EditUID = CreateUID;

                re.DownCount = 0;
                re.CheckMessage = "";
                re.CatagoryID = CatagoryID;
                re.ChapterID = ChapterID == "" ? "0" : ChapterID;
                re.IsOpen = 0;
                re.Status = 0;
                re.FileGroup = HttpUtility.UrlDecode(GroupName);
                jsonModel = Bll.Add(re);
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
            LogService.WriteLog(result);
            context.Response.Write(result);
            context.Response.End();
        }
        private void UploadMyResource(HttpContext context)
        {
            {
                MyResourceService Bll = new MyResourceService();

                JsonModel jsonModel = null;
                JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
                string CreateUID = context.Request["CreateUID"].SafeToString();
                string FoldUrl = ConfigHelper.GetConfigString("FileManageName") + context.Request["FoldUrl"].SafeToString();
                if (FoldUrl.IndexOf(CreateUID) < 0)
                {
                    FoldUrl += "/" + CreateUID;
                }
                string Pid = context.Request.Form["Pid"].SafeToString();
                string result = "0";
                string code = context.Request.Form["code"].SafeToString().Trim();

                try
                {
                    if (!FileHelper.IsExistDirectory(context.Server.MapPath(FoldUrl)))
                    {
                        FileHelper.CreateDirectory(context.Server.MapPath(FoldUrl));
                    }
                    HttpPostedFile file = context.Request.Files[0];

                    string ext = Path.GetExtension(file.FileName);

                    string fileName = Path.GetFileName(file.FileName);// DateTime.Now.Ticks + ext;

                    string p = FoldUrl + "/" + fileName;

                    string path = context.Server.MapPath(p);

                    #region 处理文件同名问题
                    if (FileHelper.IsExistFile(path))
                    {
                        int i = 0;
                        while (true)
                        {
                            i++;
                            if (!FileHelper.IsExistFile(context.Server.MapPath(FoldUrl + "/" + fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1])))
                            {
                                fileName = fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1];
                                p = FoldUrl + "/" + fileName;
                                path = context.Server.MapPath(p);

                                break;
                            }
                        }
                    }
                    #endregion
                    file.SaveAs(path);
                    SSSModel.MyResource re = new SSSModel.MyResource();
                    string Name = fileName.Replace(ext, "");
                    re.Name = Name;
                    re.PID = int.Parse(Pid);
                    re.FileSize = file.ContentLength;
                    re.FileUrl = p;
                    re.FileIcon = "ico-" + fileName.Split('.')[1] + "b.png";
                    re.FileIconBig = "ico-" + fileName.Split('.')[1] + "t.png";

                    re.postfix = ext.ToLower();
                    re.CreateUID = CreateUID;
                    re.EditUID = CreateUID;
                    re.IsFolder = 0;
                    if (Pid == "0")
                    {
                        re.code = "0";
                    }
                    else
                    {
                        re.code = code == "0" ? re.PID.ToString() : code + "|" + re.PID;
                    }

                    jsonModel = Bll.Add(re);
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
        private void UploadResources_Open(HttpContext context)
        {
            JsonModel jsonModel = null;
            JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            string CreateUID = context.Request["CreateUID"].SafeToString();
            string FoldUrl = HttpUtility.UrlDecode(context.Request["FoldUrl"]);
            string UrlPre = ConfigHelper.GetConfigString("FileManageName");
            if (FoldUrl.IndexOf(UrlPre) < 0)
            {
                FoldUrl = UrlPre + FoldUrl;
            }
            if (FoldUrl.IndexOf(CreateUID) < 0)
            {
                FoldUrl += "/" + CreateUID;
            }
            string Pid = context.Request.Form["Pid"].SafeToString();
            string result = "0";
            string code = context.Request.Form["code"].SafeToString().Trim();

            try
            {
                if (!FileHelper.IsExistDirectory(context.Server.MapPath(FoldUrl)))
                {
                    FileHelper.CreateDirectory(context.Server.MapPath(FoldUrl));
                }
                HttpPostedFile file = context.Request.Files[0];

                string ext = Path.GetExtension(file.FileName);

                string fileName = Path.GetFileName(file.FileName);// DateTime.Now.Ticks + ext;

                string p = FoldUrl + "/" + fileName;

                string path = context.Server.MapPath(p);

                #region 处理文件同名问题
                if (FileHelper.IsExistFile(path))
                {
                    int i = 0;
                    while (true)
                    {
                        i++;
                        if (!FileHelper.IsExistFile(context.Server.MapPath(FoldUrl + "/" + fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1])))
                        {
                            fileName = fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1];
                            p = FoldUrl + "/" + fileName;
                            path = context.Server.MapPath(p);

                            break;
                        }
                    }
                }
                #endregion
                file.SaveAs(path);

                Resources_OpenService Bll = new Resources_OpenService();
                Resources_Open re = new Resources_Open();
                string Name = fileName.Replace(ext, "");
                re.Name = Name;
                re.PID = int.Parse(Pid);
                re.FileSize = file.ContentLength;
                re.FileUrl = p;
                re.postfix = ext.ToLower();
                re.CreateUID = CreateUID;
                re.EditUID = CreateUID;
                re.IsFolder = 0;
                re.Status = 0;
                if (Pid == "0")
                {
                    re.code = "0";
                }
                else
                {
                    if (code == "0")
                    {
                        re.code = re.PID.ToString();
                    }
                    else
                    {
                        re.code = code + "|" + re.PID;
                    }
                }
                jsonModel = Bll.Add(re);
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
        private void UploadResource(HttpContext context)
        {
            JsonModel jsonModel = null;
            JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            string CreateUID = context.Request["CreateUID"].SafeToString();
            string FoldUrl = HttpUtility.UrlDecode(context.Request["FoldUrl"]);
            string UrlPre = ConfigHelper.GetConfigString("FileManageName");
            if (FoldUrl.IndexOf(UrlPre) < 0)
            {
                FoldUrl = UrlPre + FoldUrl;
            }
            if (FoldUrl.IndexOf(CreateUID) < 0)
            {
                FoldUrl += "/" + CreateUID;
            }
            string Pid = context.Request.Form["Pid"].SafeToString();
            string result = "0";
            string code = context.Request.Form["code"].SafeToString().Trim();

            try
            {
                if (!FileHelper.IsExistDirectory(context.Server.MapPath(FoldUrl)))
                {
                    FileHelper.CreateDirectory(context.Server.MapPath(FoldUrl));
                }
                HttpPostedFile file = context.Request.Files[0];

                string ext = Path.GetExtension(file.FileName);

                string fileName = Path.GetFileName(file.FileName);// DateTime.Now.Ticks + ext;

                string p = FoldUrl + "/" + fileName;

                string path = context.Server.MapPath(p);

                #region 处理文件同名问题
                if (FileHelper.IsExistFile(path))
                {
                    int i = 0;
                    while (true)
                    {
                        i++;
                        if (!FileHelper.IsExistFile(context.Server.MapPath(FoldUrl + "/" + fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1])))
                        {
                            fileName = fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1];
                            p = FoldUrl + "/" + fileName;
                            path = context.Server.MapPath(p);

                            break;
                        }
                    }
                }
                #endregion
                file.SaveAs(path);

                ResourceService Bll = new ResourceService();
                Resource re = new Resource();
                string Name = fileName.Replace(ext, "");
                re.Name = Name;
                re.PID = int.Parse(Pid);
                re.FileSize = file.ContentLength;
                re.FileUrl = p;
                re.postfix = ext.ToLower();
                re.CreateUID = CreateUID;
                re.EditUID = CreateUID;
                re.IsFolder = 0;
                if (Pid == "0")
                {
                    re.code = "0";
                }
                else
                {
                    re.code = code == "0" ? re.PID.ToString() : code + "|" + re.PID;
                }

                jsonModel = Bll.Add(re);

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
        /*private void Upload(HttpContext context)
        {
            JsonModel jsonModel = null;
            JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
            string CreateUID = context.Request["CreateUID"].SafeToString();
            string FoldUrl = HttpUtility.UrlDecode(context.Request["FoldUrl"]);
            string UrlPre = ConfigHelper.GetConfigString("FileManageName");
            if (FoldUrl.IndexOf(UrlPre) < 0)
            {
                FoldUrl = UrlPre + FoldUrl;
            }
            if (FoldUrl.IndexOf(CreateUID) < 0)
            {
                FoldUrl += "/" + CreateUID;
            }
            string Pid = context.Request.Form["Pid"].SafeToString();
            string result = "0";
            string code = context.Request.Form["code"].SafeToString().Trim();

            try
            {
                if (!FileHelper.IsExistDirectory(context.Server.MapPath(FoldUrl)))
                {
                    FileHelper.CreateDirectory(context.Server.MapPath(FoldUrl));
                }
                HttpPostedFile file = context.Request.Files[0];

                string ext = Path.GetExtension(file.FileName);

                string fileName = Path.GetFileName(file.FileName);// DateTime.Now.Ticks + ext;

                string p = FoldUrl + "/" + fileName;

                string path = context.Server.MapPath(p);

                #region 处理文件同名问题
                if (FileHelper.IsExistFile(path))
                {
                    int i = 0;
                    while (true)
                    {
                        i++;
                        if (!FileHelper.IsExistFile(context.Server.MapPath(FoldUrl + "/" + fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1])))
                        {
                            fileName = fileName.Split('.')[0] + "(" + i + ")" + "." + fileName.Split('.')[1];
                            p = FoldUrl + "/" + fileName;
                            path = context.Server.MapPath(p);

                            break;
                        }
                    }
                }
                #endregion
                file.SaveAs(path);
                if (context.Request["Type"].SafeToString() == "Resource")
                {
                    ResourceService Bll = new ResourceService();
                    Resource re = new Resource();
                    string Name = fileName.Replace(ext, "");
                    re.Name = Name;
                    re.PID = int.Parse(Pid);
                    re.FileSize = file.ContentLength;
                    re.FileUrl = p;
                    re.postfix = ext.ToLower();
                    re.CreateUID = CreateUID;
                    re.EditUID = CreateUID;
                    re.IsFolder = 0;
                    if (Pid == "0")
                    {
                        re.code = "0";
                    }
                    else
                    {
                        re.code = code == "0" ? "" : code + "|" + re.PID;
                    }

                    jsonModel = Bll.Add(re);
                }
                else
                {
                    ResourcesInfoService Bll = new ResourcesInfoService();
                    ResourcesInfo re = new ResourcesInfo();
                    string Name = fileName.Replace(ext, "");
                    re.Name = Name;
                    //re.PID = int.Parse(Pid);
                    re.FileSize = file.ContentLength;
                    re.FileUrl = p;
                    re.postfix = ext.ToLower();
                    re.CreateUID = CreateUID;
                    re.EditUID = CreateUID;
                    re.IsFolder = 0;
                    re.Status = 0;
                    if (Pid == "0")
                    {
                        re.code = "0";
                    }
                    else
                    {
                        re.code = code == "0" ? "" : code + "|" + re.PID;
                    }

                    jsonModel = Bll.Add(re);
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
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";

            context.Response.Write(result);
            context.Response.End();
        }*/
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}