using SSSIDAL;
using SSSModel;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSDAL
{
    public partial class UserSinLogDal : BaseDal<UserSinLog>, IUserSinLogDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                StringBuilder str = new StringBuilder();
                str.Append(@"select a.StuNo,c.*,b.Name from Couse_Selstuinfo a inner join Course b on a.CourseID=b.ID left join UserSinLog c on a.StuNo=c.CreateUID and a.CourseID=c.CourseID where 1=1");
                int StartIndex = 0;
                int EndIndex = 0;

                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].SafeToString()))
                {
                    str.Append(" and b.Name like '%" + ht["Name"].SafeToString() + "%'");
                }
                if (ht.ContainsKey("IsEffective") && !string.IsNullOrEmpty(ht["IsEffective"].SafeToString()))
                {
                    if (ht["IsEffective"].SafeToString() == "0")
                    {
                        str.Append(" and (IsEffective!=1  or IsEffective is null)");
                    }
                    else
                    {
                        str.Append(" and IsEffective=1");
                    }
                }

                if (ht.ContainsKey("BeginTime") && !string.IsNullOrEmpty(ht["BeginTime"].SafeToString()))
                {
                    str.Append(" and c.CreateTime >'" + ht["BeginTime"].SafeToString() + "'");
                }
                if (ht.ContainsKey("EndTime") && !string.IsNullOrEmpty(ht["EndTime"].SafeToString()))
                {
                    str.Append(" and c.CreateTime <'" + ht["EndTime"].SafeToString() + "'");
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
    }
}
