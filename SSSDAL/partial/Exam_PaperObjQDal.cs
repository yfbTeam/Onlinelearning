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
    public partial class Exam_PaperObjQDal : BaseDal<Exam_PaperObjQ>, IExam_PaperObjQDal
    {
        public DataTable GetList(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@" select COUNT(*) as sum,et.Name,sum(eq.Score) as score from Exam_PaperObjQ as eq left join Exam_QuestionType as et on eq.Type=et.ID where 1=1");
                if (ht.ContainsKey("ExampaperID") && !string.IsNullOrEmpty(ht["ExampaperID"].SafeToString()))
                {
                    sbSql4org.Append(" and eq.paperID=@ExampaperID ");
                    pms.Add(new SqlParameter("@ExampaperID", ht["ExampaperID"].SafeToString()));
                }
                sbSql4org.Append("  group by (et.Name)  ");
                return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        //有问题查一下****************************
        public DataTable GetListtimu(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@" select eq.OrderID,eq.Score,et.Name,eq.ID,eq.OptionA,eq.OptionB,eq.OptionC,eq.OptionD,eq.OptionE,eq.OptionF,eq.Type,eq.Content,eq.Analysis,eq.Answer,et.QType from Exam_PaperObjQ as eq left join Exam_QuestionType as et on eq.Type=et.ID where 1=1");
                if (ht.ContainsKey("ExampaperID") && !string.IsNullOrEmpty(ht["ExampaperID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and eq.paperID={0}", ht["ExampaperID"].ToString());

                }
                if (ht.ContainsKey("Title") && !string.IsNullOrEmpty(ht["Title"].SafeToString()))
                {
                    sbSql4org.Append(" and et.Name=@Title ");
                    pms.Add(new SqlParameter("@Title", ht["Title"].SafeToString()));
                }
                //sbSql4org.Append(" order by (OrderID) desc ");
                return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
      
    }
}
