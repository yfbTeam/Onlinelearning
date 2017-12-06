using SSSIDAL;
using SSSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SSSUtility;
using System.Data;
namespace SSSDAL
{
    public partial class MyResource_CapacityAllDal
    {
        public int UpdateBase(string BaseLen)
        {
            int result = 0;
            string strSql = "select * from MyResource_CapacityAll";
            DataTable dt = SQLHelp.ExecuteDataTable(strSql, CommandType.Text, null);
            if (dt.Rows.Count > 0)
            {
                strSql = "update MyResource_CapacityAll set BaseLen=" + BaseLen;
                result = SQLHelp.ExecuteNonQuery(strSql, CommandType.Text, null);
            }
            else
            {
                strSql = "insert into MyResource_CapacityAll(baseLen) values(" + BaseLen + ")";
                result = SQLHelp.ExecuteNonQuery(strSql, CommandType.Text, null);
            }
            return result;
        }
        public DataTable GetAllUserInfo(string CreateUID)
        {
            string strSql = "select * from ( (select sum(FileSize) as SumSize,CreateUID from MyResource group by CreateUID) a FULL JOIN (select ID,AddLen,UserID,(AddLen+(select BaseLen from MyResource_CapacityAll)) as AllLen from MyResource_CapacityEach) b on b.UserID=a.CreateUID)";
            if (CreateUID.Length > 0)
            {
                strSql += " where UserID='" + CreateUID + "'";
            }
            DataTable dt = SQLHelp.ExecuteDataTable(strSql, CommandType.Text, null);
            return dt;
        }
    }
}
