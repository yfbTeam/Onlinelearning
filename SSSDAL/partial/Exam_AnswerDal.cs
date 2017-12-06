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
    public partial class Exam_AnswerDal : BaseDal<Exam_Answer>, IExam_AnswerDal
    {
        #region 获取主观题客观题详细答案信息
        public DataTable GetAnswerListSub(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@" select ea.QuestionID,eq.Analysis,eq.Content,eq.Type,eq.Answer,ea.Score as mescore,ea.Answer as meAnswer,eq.Score from Exam_Answer ea left join Exam_PaperSubQ eq on ea.QuestionID=eq.ID where 1=1");
                if (ht.ContainsKey("Type") && !string.IsNullOrEmpty(ht["Type"].SafeToString()))
                {
                    sbSql4org.Append(" and ea.Type=@Type ");
                    pms.Add(new SqlParameter("@Type", ht["Type"].SafeToString()));
                }
                if (ht.ContainsKey("ExamID") && !string.IsNullOrEmpty(ht["ExamID"].SafeToString()))
                {
                    sbSql4org.Append(" and ea.ExamID=@ExamID ");
                    pms.Add(new SqlParameter("@ExamID", ht["ExamID"].SafeToString()));
                }

                return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        public DataTable GetAnswerListObj(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@" select eq.Content,eq.Type,eq.OptionA,eq.OptionB,eq.OptionC,eq.OptionD,eq.OptionE,eq.OptionF,eq.Answer,ea.Score as mescore,ea.Answer as meAnswer,eq.Score from Exam_Answer ea left join Exam_PaperObjQ eq on ea.QuestionID=eq.ID where 1=1");
                if (ht.ContainsKey("Type") && !string.IsNullOrEmpty(ht["Type"].SafeToString()))
                {
                    sbSql4org.Append(" and ea.Type=@Type ");
                    pms.Add(new SqlParameter("@Type", ht["Type"].SafeToString()));
                }
                if (ht.ContainsKey("ExamID") && !string.IsNullOrEmpty(ht["ExamID"].SafeToString()))
                {
                    sbSql4org.Append(" and ea.ExamID=@ExamID ");
                    pms.Add(new SqlParameter("@ExamID", ht["ExamID"].SafeToString()));
                }
                return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        #endregion

        #region 获取试卷总得分
        /// <summary>
        /// 获取试卷总得分
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="Where"></param>
        /// <returns></returns>
        public DataTable GetList(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select SUM(Score) as examscoree from Exam_Answer where 1=1");
                if (ht.ContainsKey("ExamID") && !string.IsNullOrEmpty(ht["ExamID"].SafeToString()))
                {
                    sbSql4org.Append("  and  ExamID=@ExamID ");
                    pms.Add(new SqlParameter("@ExamID", ht["ExamID"].SafeToString()));
                }
                return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        #endregion

        #region  更新试卷总得分
        /// <summary>
        /// 更新试卷总得分
        /// </summary>
        /// <param name="modle"></param>
        /// <returns></returns>
        public int upExam_Answer(Exam_Answer modle)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                string sql = string.Format(@" update Exam_Answer set Score={0} where ExamID={1} and QuestionID={2} and Type={3}", modle.Score, modle.ExamId, modle.QuestionId, modle.Type);
                return SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms.ToArray()); ;
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return 0;
            }
        }
        #endregion

    }
}
