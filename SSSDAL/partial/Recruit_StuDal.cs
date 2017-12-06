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
    public partial class Recruit_StuDal : BaseDal<Recruit_Stu>, IRecruit_StuDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            int PageIndex = 0;
            int PageSize = 0;
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select a.*,b.Name as PlanName from Recruit_Stu a inner join Recruit_Info b on a.InfoNo=b.InfoNo where 1=1");

                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and a.Id ='{0}' ", ht["ID"].ToString());
                }
                if (ht.ContainsKey("PlanName") && !string.IsNullOrEmpty(ht["PlanName"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and b.Name like'%{0}%' ", ht["PlanName"].ToString());
                }
                
                if (IsPage)
                {
                    PageIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    PageSize = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                //dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, null);
                dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", where, "", PageIndex, PageSize, IsPage, null, out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw 
                return null;
            }
            return dt;
        }
    }
}
