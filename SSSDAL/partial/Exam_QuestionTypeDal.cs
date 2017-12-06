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
    public partial class Exam_QuestionTypeDal : BaseDal<Exam_QuestionType>, IExam_QuestionTypeDal
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
                sbSql4org.Append(@"select ID,Name,QType,case QType when 1 then '主观' when 2 then '客观 ' END as QTypeShowfrom from Exam_QuestionType where 1=1 ");
                //if (ht.ContainsKey("Status") && !string.IsNullOrEmpty(ht["Status"].ToString()))
                //{
                //    sbSql4org.Append(" and  Status=@Status ");
                //    pms.Add(new SqlParameter("@Status", ht["Status"].ToString()));
                //}
                if (ht.ContainsKey("Title") && !string.IsNullOrEmpty(ht["Title"].ToString()))
                {
                    sbSql4org.Append(" and Name like N'%' + @Title + '%' ");
                    pms.Add(new SqlParameter("@Title", ht["Title"].ToString()));
                }
                if (ht.ContainsKey("OptionType") && !string.IsNullOrEmpty(ht["OptionType"].ToString()))
                {
                    sbSql4org.Append(" and Name <> '判断题' ");
                }
                return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "ID Asc", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                return null;
            }

        }
        
    }
}
