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
    public partial class FeedBack_EnterpriseInfoDal : BaseDal<FeedBack_EnterpriseInfo>, IFeedBack_EnterpriseInfoDal
    {
        #region 分页获取数据重写
        /// <summary>
        /// 分页获取数据重写
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
                str.Append(@"select * , Job = stuff
                          ((SELECT     ',' + Name
                              FROM         FeedBack_EnterJob AS t
                              WHERE     t .EnterID = FeedBack_EnterpriseInfo.id FOR xml path('')), 1, 1, '') from FeedBack_EnterpriseInfo where 1=1 ");
                int StartIndex = 0;
                int EndIndex = 0;
                string Where = "";
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    str.Append(" and ID = " + ht["ID"].SafeToString());
                }

                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].SafeToString()))
                {
                    str.Append(" and Name like '%" + ht["Name"].SafeToString() + "%'");
                }
                if (ht.ContainsKey("Status") && !string.IsNullOrEmpty(ht["Status"].SafeToString()))
                {
                    str.Append(" and Status=" + ht["Status"].SafeToString());
                }
                if (ht.ContainsKey("PassWord") && !string.IsNullOrEmpty(ht["PassWord"].SafeToString()))
                {
                    str.Append(" and PassWord = '" + ht["PassWord"].SafeToString() + "'");
                }
                if (ht.ContainsKey("LoginName") && !string.IsNullOrEmpty(ht["LoginName"].SafeToString()))
                {
                    str.Append(" and LoginName='" + ht["LoginName"].SafeToString() + "'");
                }

                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("(" + str.ToString() + ")", Where, "", StartIndex,
                    EndIndex, IsPage, null, out RowCount);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        #endregion

        public string AddEnterprise(FeedBack_EnterpriseInfo entity, string job)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@Name",entity.Name),
                                       new SqlParameter("@ContactMan", entity.ContactMan),
                                       new SqlParameter("@ContactPhone",entity.ContactPhone),
                                       new SqlParameter("@LoginName",entity.LoginName), 
                                       new SqlParameter("@PassWord",entity.PassWord),
                                       new SqlParameter("@Email",entity.Email),
                                       new SqlParameter("@Job",job)
                                   };
            object obj = SQLHelp.ExecuteScalar("AddEnterprise", CommandType.StoredProcedure, param);
            string result = "";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
    }
}
