using SSSBLL;
using SSSModel;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
namespace SSSHanderler.SystemSettings
{
    /// <summary>
    /// ModelHander 的摘要说明
    /// </summary>
    public class ModelHander : IHttpHandler
    {
        ModelManageService bll = new ModelManageService();
        ModelCatogoryService Catogorybll = new ModelCatogoryService();
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonModel jsonModel = null;
        Course_ChapterService courcebll = new Course_ChapterService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string FuncName = context.Request["Func"].ToString();
            string result = string.Empty;

            if (FuncName != null && FuncName != "")
            {
                try
                {
                    switch (FuncName)
                    {
                        case "GetModelList":
                            GetModelList(context);
                            break;
                        case "DelModel":
                            DelModel(context);
                            break;
                        case "AddModol":
                            AddModol(context);
                            break;
                        //添加桌面应用
                        case "AddDeskModel":
                            AddDeskModel(context);
                            break;
                        case "ModelCatogory":
                            ModelCatogory(context);
                            break;
                        case "DelCatagory":
                            DelCatagory(context);
                            break;
                        case "AddCatory":
                            AddCatory(context);
                            break;
                        case "Skin":
                            Skin(context);
                            break;
                        case "AddSkin":
                            AddSkin(context);
                            break;
                        case "GetSubButtonByUrl":
                            GetSubButtonByUrl(context);
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
        #region 根据url查找子级button
        private void GetSubButtonByUrl(HttpContext context)
        {
            try
            {
                jsonModel = bll.GetSubButtonByUrl(context.Request["Url"], context.Request["UniqueNo"]);
                jsonModel.errMsg = context.Request["UniqueNo"].SafeToString() == "00000000000000000X" ? "1" : "0";
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
        private void Skin(HttpContext context)
        {
            Hashtable ht = new Hashtable();
            ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
            ht.Add("PageSize", context.Request["PageSize"].SafeToString());
            ht.Add("TableName", "UserSkin");

            UserSkinService skinbll = new UserSkinService();
            DataTable dt = skinbll.GetData(ht, false, " and UserID='" + context.Request["UserID"] + "'");
            if (dt.Rows.Count > 0)
            {
                jsonModel = new JsonModel
                {
                    errNum = 0,
                    errMsg = "",
                    retData = dt.Rows[0]["SkinImage"]
                };
            }
            else
            {
                jsonModel = new JsonModel
                {
                    errNum = 0,
                    errMsg = "",
                    retData = "../AppManage/images/6.jpg"
                };
            }

        }
        private void AddSkin(HttpContext context)
        {
            UserSkinService skinbll = new UserSkinService();
            UserSkin entity = new UserSkin();
            entity.SkinImage = context.Request["SkinImage"].SafeToString();
            entity.UserID = context.Request["UserID"].SafeToString();

            jsonModel = skinbll.Update(entity);

        }
        private void DelCatagory(HttpContext context)
        {
            ModelCatogoryService Catogorybll = new ModelCatogoryService();
            try
            {
                int ID = int.Parse(context.Request["ID"]);
                jsonModel = Catogorybll.Delete(ID);
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
        private void AddDeskModel(HttpContext context)
        {
            try
            {
                User_Model_RelService userModeldll = new User_Model_RelService();
                string AddIDS = context.Request["AddIDS"].SafeToString();
                string DelIDS = context.Request["DelIDS"].SafeToString();
                string IDCard = context.Request["IDCard"].SafeToString();
                bool Flag = userModeldll.SetDesk(AddIDS, DelIDS, IDCard);
                if (Flag == true)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "设置成功",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 400,
                        errMsg = "设置失败",
                        retData = ""
                    };
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
        private void AddModol(HttpContext context)
        {

            try
            {
                ModelManage model = new ModelManage();
                string ModelName = context.Request["ModelName"].SafeToString();
                string ModelType = context.Request["ModelType"].SafeToString();
                string OpenType = context.Request["OpenType"].SafeToString();
                string ModelCss = context.Request["ModelCss"].SafeToString();
                string iconCss = context.Request["iconCss"].SafeToString();
                string LinkUrl = context.Request["LinkUrl"].SafeToString();
                string OrderNum = context.Request["OrderNum"].SafeToString();
                string ID = context.Request["ID"].SafeToString();
                model.ModelName = ModelName;
                model.ModelType = int.Parse(ModelType);
                model.OpenType = OpenType;
                model.ModelCss = ModelCss;
                model.iconCss = iconCss;
                model.LinkUrl = LinkUrl;
                model.MenuType = int.Parse(context.Request["MenuType"]);
                model.IsMenu = context.Request["MenuType"] == "2" ? true : false;

                if (OrderNum.Length > 0)
                {
                    model.OrderNum = int.Parse(OrderNum);
                }
                else
                {
                    model.OrderNum = 0;
                }
                if (ID.Length > 0)
                {
                    model.ID = int.Parse(ID);
                    jsonModel = bll.Update(model);
                }
                else
                {
                    model.Pid = Convert.ToInt32(context.Request["Pid"]);

                    jsonModel = bll.AddModelMenu(model, context.Request["UniqueNo"]);
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
        private void AddCatory(HttpContext context)
        {
            ModelCatogoryService Catogorybll = new ModelCatogoryService();
            try
            {
                ModelCatogory model = new ModelCatogory();
                string Name = context.Request["Name"].SafeToString();
                string Status = context.Request["Status"];
                string ID = context.Request["ID"].SafeToString();
                string SortNum = context.Request["SortNum"].SafeToString();
                model.Name = Name;
                model.Status = int.Parse(Status);
                model.SortNum = int.Parse(SortNum);
                if (ID.Length > 0)
                {
                    model.ID = int.Parse(ID);
                    jsonModel = Catogorybll.Update(model);
                }
                else
                {
                    jsonModel = Catogorybll.Add(model);
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
        private void DelModel(HttpContext context)
        {
            try
            {
                int ID = int.Parse(context.Request["ID"]);
                jsonModel = bll.DeleteModelMenu(ID);
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
        #region 获取模块信息
        /// <summary>
        /// 获取课程信息
        /// </summary>
        /// <param name="context"></param>
        private void ModelCatogory(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                string ID = context.Request["ID"].SafeToString();
                string Status = context.Request["Status"].SafeToString();
                ht.Add("ID", ID);
                ht.Add("Status", Status);

                jsonModel = Catogorybll.GetPage(ht, false);
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

        #region 获取模块信息
        /// <summary>
        /// 获取课程信息
        /// </summary>
        /// <param name="context"></param>
        private void GetModelList(HttpContext context)
        {
            try
            {
                string IsShow = "";
                if (context.Request["IsShow"].SafeToString().Length > 0)
                {
                    IsShow = context.Request["IsShow"].SafeToString();
                }
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("ModelType", context.Request["ModelType"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("IDCard", context.Request["IDCard"].SafeToString());
                ht.Add("IsShow", IsShow);
                ht.Add("Pid", context.Request["Pid"].SafeToString());

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