
using Newtonsoft.Json.Linq;
using SSSBLL;
using SSSModel;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace SSSHanderler.SystemSettings
{
    /// <summary>
    /// RoleHandler 的摘要说明
    /// </summary>
    public class RoleHandler : IHttpHandler
    {
        Plat_RoleService bll = new Plat_RoleService();
        //Plat_LogInfoService log = new Plat_LogInfoService();
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        BLLCommon bll_com = new BLLCommon();
        string sysAccountNo = ConfigHelper.GetConfigString("SysAccountNo");
        string u_handlerUrl = ConfigHelper.GetConfigString("Unified_HandlerUrl").SafeToString();
        string result = string.Empty;
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string syskey = context.Request["SystemKey"];
            string func = context.Request["func"];
            string loginname = HttpContext.Current.Request["loginname"] ?? "";
            string idcard = context.Request["useridcard"];
            string optionType = string.Empty;
            string methodDescrip = string.Empty;
            try
            {

                switch (func)
                {
                    case "GetRoleTreeData":
                        GetSysRoleTreeData();
                        optionType = ActionConstants.Search;
                        methodDescrip = "获取系统的角色树信息";
                        break;
                    case "GetRoleData":
                        GetRoleData(context);
                        break;
                    case "GetRoleByUser":
                        GetRoleByUser(idcard);
                        optionType = ActionConstants.Search;
                        methodDescrip = "获取某用户的角色信息";
                        break;
                    case "AddRole":
                        AddRole(syskey);
                        optionType = ActionConstants.add;
                        methodDescrip = "添加角色";
                        break;
                    case "EditRole":
                        EditRole(syskey);
                        optionType = ActionConstants.xg;
                        methodDescrip = "编辑角色";
                        break;
                    case "DeleteRole":
                        DeleteRole(syskey);
                        optionType = ActionConstants.del;
                        methodDescrip = "删除角色";
                        break;
                    case "GetUserDataByRoleId":
                        GetUserDataByRoleId(context);
                        optionType = ActionConstants.Search;
                        methodDescrip = "根据角色id获取角色下的用户";
                        break;
                    case "GetNotDataByRoleId":
                        GetUserDataByRoleId(context, " not in ");
                        optionType = ActionConstants.Search;
                        methodDescrip = "根据角色id获取非该角色下的用户列表";
                        break;
                    case "SetRoleMember":
                        SetRoleMember(syskey);
                        optionType = ActionConstants.xg;
                        methodDescrip = "设置角色成员";
                        break;
                    case "DeleteUserRelation":
                        DeleteUserRelation(syskey);
                        optionType = ActionConstants.del;
                        methodDescrip = "将用户移出角色";
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
            if (result == "")
            {
                result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            }
            context.Response.Write(result);
            context.Response.End();
        }
        #region 获取系统的角色树信息
        private void GetRoleData(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                ht.Add("ID", context.Request["ID"].SafeToString());
                ht.Add("UserIDCard", context.Request["UserIDCard"].SafeToString());
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
        private void GetSysRoleTreeData()
        {
            try
            {
                DataTable roledt = bll.GetAllRoleList();
                StringBuilder roleJson = new StringBuilder();
                if (roledt != null)
                {
                    if (roledt.Rows.Count > 0)
                    {
                        for (int i = 0; i < roledt.Rows.Count; i++)
                        {
                            DataRow row = roledt.Rows[i];
                            roleJson.Append("{\"id\":" + row["Id"].ToString() + ", \"pId\": 0, \"name\":\"" + row["Name"].ToString() + "\"},");
                        }
                    }
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = "[" + roleJson.ToString().TrimEnd(',') + "]"
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
        #endregion

        #region
        private void GetRoleByUser(string useridcard)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("UserIDCard", useridcard);
                jsonModel = bll.GetRoleByUser(ht);
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

        #region 添加角色
        private void AddRole(string syskey)
        {
            //string callback = HttpContext.Current.Request["jsoncallback"];
            string name = HttpContext.Current.Request["name"];
            jsonModel = bll.IsNameExists(name, 0, "Name", true);
            if (jsonModel.errNum == 0)
            {
                if (jsonModel.retData.ToString().ToLower() == "true")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = -1,
                        errMsg = "exist",
                        retData = ""
                    };
                }
                else
                {
                    string useridcard = HttpContext.Current.Request["useridcard"];
                    Plat_Role role = new Plat_Role();
                    role.Name = name;
                    role.Creator = useridcard;
                    role.CreateTime = DateTime.Now;
                    role.IsDelete = 0;
                    jsonModel = bll.Add(role);
                }
            }
        }
        #endregion

        #region 编辑角色
        private void EditRole(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int roleid = Convert.ToInt32(HttpContext.Current.Request["roleid"]);
            string name = HttpContext.Current.Request["name"];
            string useridcard = HttpContext.Current.Request["useridcard"];
            jsonModel = bll.IsNameExists(name, roleid, "Name", true);
            if (jsonModel.errNum == 0)
            {
                if (jsonModel.retData.ToString().ToLower() == "true")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = -1,
                        errMsg = "exist",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = bll.GetEntityById(roleid);
                    if (jsonModel.errNum == 0)
                    {
                        Plat_Role role = jsonModel.retData as Plat_Role;
                        role.Id = roleid;
                        role.Name = name;
                        jsonModel = bll.Update(role);
                    }
                }
            }
        }
        #endregion

        #region 删除角色
        private void DeleteRole(string syskey)
        {
            string callback = HttpContext.Current.Request["jsoncallback"];
            int roleid = Convert.ToInt32(HttpContext.Current.Request["roleid"]);
            jsonModel = bll.DeleteRole(roleid);
        }
        #endregion

        #region 根据角色id获取角色下的用户
        private void GetUserDataByRoleId(HttpContext context, string joinStr = " in ")
        {
            try
            {
               

                string UniqueNos = new Plat_RoleOfUserService().GetUserIDByRole(context.Request["roleid"].SafeToString());
                if (UniqueNos == "" && joinStr == " in ")
                {
                    jsonModel = new JsonModel
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                }
                else
                {
                    string urlHead = u_handlerUrl + "/UserManage/UserInfo.ashx?";
                    string urlbady = "Func=GetData&SysAccountNo=" + sysAccountNo;

                    if (!string.IsNullOrEmpty(context.Request["ispage"]))
                    {
                        if (context.Request["ispage"] == "false")
                        {
                            urlbady += "&Ispage=false";
                        }
                        else
                        {
                            urlbady += "&PageIndex=" + (context.Request["PageIndex"] ?? "1") + "&PageSize=" + (context.Request["PageSize"] ?? "10");
                        }
                    }
                    else
                    {
                        urlbady += "&Ispage=false";

                    }
                    string isStu = context.Request["IsStu"] ?? ""; //true 为学生；false 为老师；空为全部
                    string AcademicId = context.Request["Type"] ?? "0";
                    if (!string.IsNullOrEmpty(isStu))
                    {
                        urlbady += "&IsStu=" + isStu + "&AcademicId=" + AcademicId;
                    }

                    urlbady += "&UniqueNo=" + UniqueNos;

                    if (joinStr.Trim() == "not in")
                    {
                        urlbady += "&JoinNoConn= not ";
                    }

                    if (!string.IsNullOrEmpty(context.Request["name"]))
                    {
                        urlbady += "&Name=" + context.Request["name"].SafeToString();
                    }
                    if (!string.IsNullOrEmpty(context.Request["HeadteacherNO"]))
                    {
                        urlbady += "&HeadteacherNO=" + context.Request["HeadteacherNO"].SafeToString();
                    }
                    result = NetHelper.RequestPostUrl(urlHead, urlbady);
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


        #endregion

        #region 设置角色成员
        private void SetRoleMember(string syskey)
        {
            try
            {
                string roleid = HttpContext.Current.Request["roleid"] ?? "";
                string idCardStr = HttpContext.Current.Request["idcardStr"];
                jsonModel = bll.SetRoleMember(roleid, idCardStr);
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

        #region 将用户移出角色
        private void DeleteUserRelation(string syskey)
        {
            Plat_RoleOfUser ruser = new Plat_RoleOfUser();
            ruser.RoleId = Convert.ToInt32(HttpContext.Current.Request["roleid"]);
            ruser.UserIDCard = HttpContext.Current.Request["deluseridcard"];
            jsonModel = new Plat_RoleOfUserService().DeleteUserRelation(ruser);
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