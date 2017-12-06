using SSSIDAL;
using SSSModel;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSDAL
{
    public partial class FeedBack_DepartmentStuDal : BaseDal<FeedBack_DepartmentStu>, IFeedBack_DepartmentStuDal
    {
        #region 分页获取分配信息重写
        /// <summary>
        /// 分页获取分配信息重写
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
                str.Append(@"select a.*,b.Name as EnterName,c.Name as JobName from FeedBack_DepartmentStu a inner join FeedBack_EnterpriseInfo b on a.EnterID=b.ID inner join FeedBack_EnterJob c on a.JobID=c.ID
 where 1=1 ");
                int StartIndex = 0;
                int EndIndex = 0;

                if (ht.ContainsKey("EnterID") && !string.IsNullOrEmpty(ht["EnterID"].SafeToString()))
                {
                    str.Append(" and a.EnterID = " + ht["EnterID"].SafeToString());
                }
                if (ht.ContainsKey("JobID") && !string.IsNullOrEmpty(ht["JobID"].SafeToString()))
                {
                    str.Append(" and JobID=" + ht["JobID"].SafeToString());
                }
                if (ht.ContainsKey("EnterName") && !string.IsNullOrEmpty(ht["EnterName"].SafeToString()))
                {
                    str.Append(" and EnterName like '%" + ht["EnterName"].SafeToString() + "%'");
                }
                if (ht.ContainsKey("JobName") && !string.IsNullOrEmpty(ht["JobName"].SafeToString()))
                {
                    str.Append(" and JobName like '%" + ht["JobName"].SafeToString() + "%'");
                }
                if (ht.ContainsKey("Status") && !string.IsNullOrEmpty(ht["Status"].SafeToString()))
                {
                    str.Append(" and a.Status=" + ht["Status"].SafeToString() + "");
                }
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    str.Append(" and a.ID=" + ht["ID"].SafeToString() + "");
                }
                
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("(" + str.ToString() + ")", "", "", StartIndex, EndIndex, IsPage, null, out RowCount);
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
