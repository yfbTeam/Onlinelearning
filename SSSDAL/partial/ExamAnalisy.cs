using SSSUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSDAL
{
    public class ExamAnalisy
    {
        #region  某考生平均分
        /// <summary>
        /// 某考生平均分
        /// </summary>
        /// <param name="ExampaperID"></param>
        /// <returns></returns>
        public DataTable GetAvgScore(int ExampaperID)
        {
            string strSql = " select COUNT(*) as AllNum,MAX(Score) as maxScore,MIN(Score) as minScore,AVG(Score) as avgScore,Round(convert(float,sum(case when score>90 then 1 else 0 end))/convert(float,COUNT(1)),2)as youxiu," +
 "Round(convert(float,sum(case when score>70 and score<90 then 1 else 0 end))/convert(float,COUNT(1)),2)as lianghao, Round(convert(float,sum(case when score>60 and score<70 then 1 else 0 end))/convert(float,COUNT(1)),2) as hege" +
 ", Round(convert(float,sum(case when score<60 then 1 else 0 end))/convert(float,COUNT(1)),2) as buhege, Round(convert(float,sum(case when score>60 then 1 else 0 end))/convert(float,COUNT(1)),2) as jige from Exam_Examination where ExampaperID=" + ExampaperID + "group by ExampaperID";
            DataTable dt = SQLHelp.ExecuteDataTable(strSql, CommandType.Text, null);
            return dt;
        }
        #endregion

        #region 前五名和后五名

        /// <summary>
        /// 前五名和后五名
        /// </summary>
        /// <param name="Order"></param>
        /// <returns></returns>
        public DataTable GetTop5Stu(string Order, int ExampaperID)
        {
            string strSql = "select top 5 CreateUID,Score from Exam_Examination where ExampaperID=" + ExampaperID + " order by Score " + Order;
            DataTable dt = SQLHelp.ExecuteDataTable(strSql, CommandType.Text, null);
            return dt;
        }
        #endregion

        #region 统计答题人数和得分率
        /// <summary>
        /// 统计答题人数和得分率
        /// </summary>
        /// <param name="ExampaperID"></param>
        /// <returns></returns>
        public DataTable AnaliseQuestionScore(string ExampaperID)
        {
            string strSql = @"with ok as (
(select a.Id as ExamPaperID,a.Title as ExamPaperName,d.Content as QuestionName,d.Id as QuestionID,d.Answer as TrueAnswer,d.Score as AllScore,c.Answer as MyAnswer,c.Score as MyScore,b.CreateUID as StuID
from Exam_Paper a inner join Exam_Examination b on a.Id=b.ExampaperID inner join Exam_Answer c on b.ID=c.ExamId inner join Exam_PaperObjQ d on c.QuestionId=d.Id)
union
(select a.Id as ExamPaperID,a.Title as ExamPaperName,d.Content as QuestionName,d.Id as QuestionID,d.Answer as TrueAnswer,d.Score as AllScore,c.Answer as MyAnswer,c.Score as MyScore,b.CreateUID as StuID
from Exam_Paper a inner join Exam_Examination b on a.Id=b.ExampaperID inner join Exam_Answer c on b.ID=c.ExamId inner join Exam_PaperSubQ d on c.QuestionId=d.Id )
)
SELECT QuestionID,QuestionName,COUNT(StuID) AS 答题人数,STR(SUM(MyScore)*100/SUM(AllScore),4,0)+'%' as 得分率 FROM OK where 1=1";
            if (ExampaperID.Length > 0)
            {
                strSql += @" and ExamPaperID=" + ExampaperID;
            }
            strSql += " GROUP BY QuestionName,QuestionID";
            DataTable dt = SQLHelp.ExecuteDataTable(strSql, CommandType.Text, null);
            return dt;
        }
        #endregion

        #region 答题详情
        /// <summary>
        /// 答题详情
        /// </summary>
        /// <param name="ExampaperID"></param>
        /// <param name="QuestionID"></param>
        /// <returns></returns>
        public DataTable QuestionScoreDetail(string ExampaperID, string QuestionID)
        {
            string strSql = @"select * from (
(select a.Id as ExamPaperID,a.Title as ExamPaperName,d.Content as QuestionName,d.Id as QuestionID,d.Answer as TrueAnswer,d.Score as AllScore,c.Answer as MyAnswer,c.Score as MyScore,b.CreateUID as StuID
from Exam_Paper a inner join Exam_Examination b on a.Id=b.ExampaperID inner join Exam_Answer c on b.ID=c.ExamId inner join Exam_PaperObjQ d on c.QuestionId=d.Id)
union
(select a.Id as ExamPaperID,a.Title as ExamPaperName,d.Content as QuestionName,d.Id as QuestionID,d.Answer as TrueAnswer,d.Score as AllScore,c.Answer as MyAnswer,c.Score as MyScore,b.CreateUID as StuID
from Exam_Paper a inner join Exam_Examination b on a.Id=b.ExampaperID inner join Exam_Answer c on b.ID=c.ExamId inner join Exam_PaperSubQ d on c.QuestionId=d.Id )) a where 1=1 ";
            if (ExampaperID.Length > 0)
            {
                strSql += @" and ExamPaperID=" + ExampaperID;
            }
            if (QuestionID.Length > 0)
            {
                strSql += @" and QuestionID=" + QuestionID;
            }
            DataTable dt = SQLHelp.ExecuteDataTable(strSql, CommandType.Text, null);
            return dt;

        }
        #endregion
    }
}
