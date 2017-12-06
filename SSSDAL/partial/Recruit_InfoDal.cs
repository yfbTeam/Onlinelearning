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
    public partial class Recruit_InfoDal : BaseDal<Recruit_Info>, IRecruit_InfoDal
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
                sbSql4org.Append(@"select *,(select COUNT(1) from Recruit_Stu where InfoNo=Recruit_Info.InfoNo) as SinNum  from Recruit_Info where 1=1");

                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and Id ='{0}' ", ht["ID"].ToString());
                }

               
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and Name like '%{0}%' ", ht["Name"].ToString());
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
