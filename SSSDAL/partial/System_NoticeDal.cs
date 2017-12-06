using SSSIDAL;
using SSSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SSSUtility;
namespace SSSDAL
{
    public partial class System_NoticeDal : BaseDal<System_Notice>, ISystem_NoticeDal
    {
        #region 分页获取通知
        /// <summary>
        /// 分页获取课程信息重写
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="IsPage"></param>
        /// <param name="where"></param>
        /// <returns></returns>
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                StringBuilder str = new StringBuilder();
                string StuNo = ht["StuNo"].SafeToString();
                str.Append(@"select * from System_Notice where 1=1");
                int StartIndex = 0;
                int EndIndex = 0;
                string Where = "";
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    str.Append(" and ID = " + ht["ID"].SafeToString());
                }

                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].SafeToString()))
                {
                    str.Append(" and Title like '%" + ht["Title"].SafeToString() + "%'");
                }
                if (ht.ContainsKey("Type") && !string.IsNullOrEmpty(ht["Type"].SafeToString()))
                {
                    str.Append(" and Type=" + ht["Type"].SafeToString() + "");
                }
                if (ht.ContainsKey("IsTop") && !string.IsNullOrEmpty(ht["IsTop"].SafeToString()))
                {
                    str.Append(" and IsTop=" + ht["IsTop"].SafeToString() + "");
                }

                if (ht.ContainsKey("IsAll") && !string.IsNullOrEmpty(ht["IsAll"].SafeToString()))
                {
                    str.Append(" and IsAll=" + ht["IsAll"].SafeToString());
                }
                if (ht.ContainsKey("UserNo") && !string.IsNullOrEmpty(ht["UserNo"].SafeToString()))
                {
                    str.Append(" and ((ReviwerUserIDS like '%" + ht["UserNo"].SafeToString() + "%'");
                    if (ht.ContainsKey("Org") && !string.IsNullOrEmpty(ht["Org"].SafeToString()))
                    {
                        str.Append(" or ReviwerOrgS like '%" + ht["Org"].SafeToString() + "%') or  IsAll=1)");
                    }
                    if (ht.ContainsKey("CreateUID") && !string.IsNullOrEmpty(ht["CreateUID"].SafeToString()))
                    {
                        str.Append(" or CreateUID ='" + ht["CreateUID"].SafeToString() + "'");
                    }
                }

                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("(" + str.ToString() + ")", Where, "IsTop desc, ID desc", StartIndex,
                   EndIndex, IsPage, null, out RowCount);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        #endregion
    }
}
