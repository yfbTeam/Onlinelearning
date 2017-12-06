using Newtonsoft.Json.Linq;
using SSSBLL;
using SSSModel;
using SSSUtility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace SSSHanderler.OnlineLearning
{
    /// <summary>
    /// CommonHandler 的摘要说明
    /// </summary>
    public class CommonHandler : IHttpHandler
    {
        string sysAccountNo = ConfigHelper.GetConfigString("SysAccountNo");
        string u_handlerUrl = ConfigHelper.GetConfigString("Unified_HandlerUrl").SafeToString();

        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        public void ProcessRequest(HttpContext context)
        {
            
        }
        #region 为返回的数据添加CreateName列
        /// <summary>
        /// 为返回的数据添加CreateName列
        /// </summary>
        /// <param name="jsonModel">数据</param>
        /// <param name="ispage">数据是否是分页的</param>
        /// <param name="oneUserField">第一个需要返回用户姓名的列</param>       
        /// <param name="twoUserField">第二个需要返回用户姓名的列</param>
        /// <param name="name">根据名称搜索</param>
        /// <param name="BatchUserField">需要返回多个用户姓名的列</param>
        /// <returns></returns>
        public JsonModel AddCreateNameForData(JsonModel jsonModel, bool ispage = false,string oneUserField = "CreateUID",string twoUserField = "", string name = "",string BatchUserField = "")
        {
            if (jsonModel.errNum == 0)
            {
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                PagedDataModel<Dictionary<string, object>> pageModel = null;
                if (ispage)
                {
                    pageModel = jsonModel.retData as PagedDataModel<Dictionary<string, object>>;
                    list = pageModel.PagedData as List<Dictionary<string, object>>;
                }
                else
                {
                    list = jsonModel.retData as List<Dictionary<string, object>>;
                }
                List<Dictionary<string, object>> allList = new List<Dictionary<string, object>>();
                List<Dictionary<string, object>> teaList = (from dic in GetUnifiedUserData("",name,"false")
                                                            select new Dictionary<string, object>() { { "UniqueNo", dic["UniqueNo"].ToString() }, { "Name", dic["Name"].ToString() }, { "AbsHeadPic", dic["AbsHeadPic"].ToString() }, { "OrgName", dic["OrgName"].ToString() } }).ToList<Dictionary<string, object>>();
                List<Dictionary<string, object>> stuList = (from dic in GetUnifiedUserData("", name, "true")
                                                            select new Dictionary<string, object>() { { "UniqueNo", dic["UniqueNo"].ToString() }, { "Name", dic["Name"].ToString() }, { "AbsHeadPic", dic["AbsHeadPic"].ToString() }, { "OrgName", dic["OrgName"].ToString() } }).ToList<Dictionary<string, object>>();
                allList = teaList.Union(stuList).ToList<Dictionary<string, object>>();
                //allList = GetUnifiedUserData("", name);
                if (!string.IsNullOrEmpty(name))
                {
                    List<string> stuUniqueNo = (from dic in allList select dic["UniqueNo"].ToString()).ToList();
                    list = (from dic in list
                            where stuUniqueNo.Contains(dic[oneUserField].ToString())
                            select dic).ToList();
                }
                foreach (Dictionary<string, object> item in list)
                {
                    try
                    {
                        Dictionary<string, object> dicItem = (from dic in allList
                                                              where dic["UniqueNo"].ToString() == item[oneUserField].ToString()
                                                              select dic).FirstOrDefault();
                        item.Add("CreateName", dicItem == null ? "" : dicItem["Name"].ToString());
                        item.Add("PhotoURL", dicItem == null ? "" : dicItem["AbsHeadPic"].ToString());
                        item.Add("OrgName", dicItem == null ? "" : dicItem["OrgName"].ToString());                                              
                        if (!string.IsNullOrEmpty(twoUserField))
                        {
                            Dictionary<string, object> dicItem_two = (from dic in allList
                                                                      where dic["UniqueNo"].ToString() == item[twoUserField].ToString()
                                                                      select dic).FirstOrDefault();
                            item.Add("TwoUserName", dicItem_two == null ? "" : dicItem_two["Name"].ToString());
                            item.Add("TwoAbsHeadPic", dicItem_two == null ? "" : dicItem_two["AbsHeadPic"].ToString());
                        }
                        if (!string.IsNullOrEmpty(BatchUserField))
                        {
                            string batchname = "", batchvalue = item[BatchUserField].ToString();
                            if (!string.IsNullOrEmpty(batchvalue))
                            {
                                string[] valueArray = batchvalue.Split(',');
                                string[] nameValue = (from dic in allList
                                                        where valueArray.Contains(dic["UniqueNo"].ToString())
                                                        select dic["Name"].ToString()).ToArray();
                                batchname = string.Join(",", nameValue);
                            }
                            item.Add("BatchUserName", batchname);
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                   
                }
                if (ispage)
                {
                    pageModel.PagedData = list;
                    jsonModel.retData = pageModel;
                }
                else { jsonModel.retData = list; }
            }
            return jsonModel;
        }
        #endregion

        #region 获取统一认证中心用户信息
        public List<Dictionary<string, object>> GetUnifiedUserData(string uniqueNos = "", string name = "",string IsStu="false")
        {           
            string urlHead = u_handlerUrl + "/UserManage/UserInfo.ashx?";
            string urlbady = "Func=GetData&SysAccountNo=" + sysAccountNo + "&Ispage=false&isStu="+IsStu;
            if (!string.IsNullOrEmpty(uniqueNos))
            {
                urlbady += "&UniqueNo=" + uniqueNos;
            }           
            if (!string.IsNullOrEmpty(name))
            {
                urlbady += "&Name=" + name;
            }
            string PageUrl = urlHead + urlbady;
            return AnalyticalReturnData(NetHelper.RequestPostUrl(PageUrl, urlbady));
        }
        #endregion
        
        #region 获取员工信息
        public string GetLearnStaffData(string ids="")
        {
            string urlHead = u_handlerUrl + "/UserManage/UserInfo.ashx?";
            string urlbady = "Func=GetData&SysAccountNo=" + sysAccountNo + "&Ispage=false";
            if (!string.IsNullOrEmpty(ids))
            {
                urlbady += "&UniqueNo=" + ids;
            }
            string PageUrl = urlHead + urlbady;
            return NetHelper.RequestPostUrl(PageUrl, urlbady);
        }
        #endregion
        
        #region 将接口返回的信息解析为List
        public List<Dictionary<string, object>> AnalyticalReturnData(string result)
        {
            JObject rtnObj = JObject.Parse(result);
            JObject resultObj = JsonTool.GetObjVal(rtnObj, "result");
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            if (JsonTool.GetStringVal(resultObj, "errNum") == "0")
            {
                list = jss.Deserialize<List<Dictionary<string, object>>>(resultObj["retData"].ToString());
            }
            return list;
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