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

    public partial class MyResource_CapacityEachDal : BaseDal<MyResource_CapacityEach>, IMyResource_CapacityEachDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
            }
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select * from ( (select sum(FileSize) as SumSize,CreateUID from MyResource group by CreateUID) a FULL JOIN (select ID,AddLen,UserID,(AddLen+(select BaseLen from MyResource_CapacityAll)) as AllLen from MyResource_CapacityEach) b on b.UserID=a.CreateUID)");

                if (ht.ContainsKey("CreateUID") && !string.IsNullOrEmpty(ht["CreateUID"].ToString()))
                {
                    sbSql4org.Append(" where UserID='" + ht["CreateUID"] + "' ");
                }

                DataTable dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
                if (dt.Rows.Count <= 0 && ht.ContainsKey("CreateUID") && !string.IsNullOrEmpty(ht["CreateUID"].ToString()))
                {
                    AddEach(ht["CreateUID"].SafeToString());
                    return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
                }
                else
                {
                    return dt;
                }
            }
            catch (Exception ex)
            {
                return null;
            }

        }
        private void AddEach(string UserID)
        {
            string strSql = "insert into MyResource_CapacityEach(UserID,AddLen) values ('" + UserID + "',0)";
            SQLHelp.ExecuteNonQuery(strSql, CommandType.Text, null);
        }

    }
}
