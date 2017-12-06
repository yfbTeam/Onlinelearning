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
    public partial class Course_WorkDal : BaseDal<Course_Work>, ICourse_WorkDal
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
                sbSql4org.Append(@"select distinct work.*,convert(varchar(10),work.EndTime,21) as EndTime_Format
                                  ,co.Name as CouseName,co.IsOpen,chap.*,knowledge.Name as KnowLedgeName
                            ,(select count(1) from Course_WorkCorrectRel where WorkId= work.Id) as WorkRelCount
                            ,case when convert(varchar(10),getdate(),21)<=convert(varchar(10),work.EndTime,21) then 1 else 0 end as IsCanCorrect");
                if (ht.ContainsKey("UserIdCard") && !string.IsNullOrEmpty(ht["UserIdCard"].SafeToString()))
                {
                    sbSql4org.Append(@" ,case when work.CreateUID=@UserIdCard then 1 else 0 end as IsCreate ");
                    pms.Add(new SqlParameter("@UserIdCard", ht["UserIdCard"].ToString()));
                }
                if (ht.ContainsKey("StuIDCard") && !string.IsNullOrEmpty(ht["StuIDCard"].SafeToString()))
                {
                    sbSql4org.Append(@",isnull(workrel.Id,0) as WorkRelId,case when workrel.CorrectUID is null then 0 else 1 end as IsCorrect
                                       ,(select count(1) from Couse_Selstuinfo where StuNo=@StuIDCard and CourseID=work.CouseID) as IsMember ");
                    pms.Add(new SqlParameter("@StuIDCard", ht["StuIDCard"].ToString()));
                }
                sbSql4org.Append(" from course_work work ");
                if (ht.ContainsKey("StuIDCard") && !string.IsNullOrEmpty(ht["StuIDCard"].SafeToString()))
                {
                    sbSql4org.Append(@" left join Course_WorkCorrectRel workrel on workrel.WorkId=work.Id and workrel.CreateUID=@StuIDCard ");
                }
                sbSql4org.Append(@" left join Course co on co.ID=work.CouseID 
                                   left join (select content.ID as SingChapterID,
                                    (case when convert(nvarchar,chapter.ID) is null then '' else convert(nvarchar,chapter.ID)+'|' end
                                    +case when convert(nvarchar,knot.ID) is null then '' else +convert(nvarchar,knot.ID)+'|' end
                                    +isnull(convert(nvarchar,content.ID),'')) as ComChapterID ,
                                    isnull(chapter.Name,'') ChapterName,isnull(knot.Name,'') KnotName,isnull(content.Name,'') ContentHName 
                                    from Course_Chapter content 
                                    left join Course_Chapter knot on content.Pid=knot.ID
                                    left join Course_Chapter chapter on knot.Pid=chapter.ID) chap on chap.ComChapterID=work.ChapterID
                                    left join Course_Chapter knowledge on knowledge.ID=work.PointID ");
                sbSql4org.Append(" where work.IsDelete=0 ");
                if (ht.ContainsKey("CouseID") && !string.IsNullOrEmpty(ht["CouseID"].ToString()))
                {
                    sbSql4org.Append(" and work.CouseID=@CouseID ");
                    pms.Add(new SqlParameter("@CouseID", ht["CouseID"].ToString()));
                }
                if (ht.ContainsKey("WorkId") && !string.IsNullOrEmpty(ht["WorkId"].SafeToString()))
                {
                    sbSql4org.Append(@" and work.ID=@WorkId ");
                    pms.Add(new SqlParameter("@WorkId", ht["WorkId"].SafeToString()));
                }
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].ToString()))
                {
                    sbSql4org.Append(" and work.Name like N'%' + @Name + '%' ");
                    pms.Add(new SqlParameter("@Name", ht["Name"].ToString()));
                }
                if (ht.ContainsKey("ChapterID") && !string.IsNullOrEmpty(ht["ChapterID"].SafeToString()))
                {
                    sbSql4org.Append(" and '|'+work.ChapterID+'|'  like N'|' + @ChapterID + '|%' ");
                    pms.Add(new SqlParameter("@ChapterID", ht["ChapterID"].ToString()));
                }
                if (ht.ContainsKey("PointID") && !string.IsNullOrEmpty(ht["PointID"].ToString()))
                {
                    sbSql4org.Append(" and work.PointID=@PointID ");
                    pms.Add(new SqlParameter("@PointID", ht["PointID"].ToString()));
                }
                if (ht.ContainsKey("ChapterName") && !string.IsNullOrEmpty(ht["ChapterName"].ToString()))
                {
                    sbSql4org.Append(" and (chap.ChapterName like N'%' + @ChapterName + '%' or chap.KnotName like N'%' + @ChapterName + '%' or chap.ContentHName like N'%' + @ChapterName + '%' or knowledge.Name like N'%' + @ChapterName + '%') ");
                    pms.Add(new SqlParameter("@ChapterName", ht["ChapterName"].ToString()));
                }
                return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }

        #region 获取员工作业完成信息
        public DataTable GetStuWorkCompleteInfo(Hashtable ht)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            DataTable dt = new DataTable();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select distinct count(1) as ComCount ");
                string isGroupIDCard = ht["IsGroupIDCard"].SafeToString();
                if (isGroupIDCard == "1")
                {
                    sbSql4org.Append(",rel.CreateUID ");
                }
                sbSql4org.Append(@" from Course_WorkCorrectRel rel
	                                inner join Course_Work work on rel.WorkId=work.ID and work.IsDelete=0 
                                    where 1=1 ");
                if (ht.ContainsKey("CouseID") && !string.IsNullOrEmpty(ht["CouseID"].SafeToString()))
                {
                    sbSql4org.Append(" and work.CouseID=@CouseID ");
                    pms.Add(new SqlParameter("@CouseID", ht["CouseID"].SafeToString()));
                }
                if (ht.ContainsKey("ChapterID") && !string.IsNullOrEmpty(ht["ChapterID"].SafeToString()))
                {
                    sbSql4org.Append(" and '|'+work.ChapterID+'|'  like N'|' + @ChapterID + '|%' ");
                    pms.Add(new SqlParameter("@ChapterID", ht["ChapterID"].SafeToString()));
                }
                if (ht.ContainsKey("WorkId") && !string.IsNullOrEmpty(ht["WorkId"].SafeToString()))
                {
                    sbSql4org.Append(@" and work.ID=@WorkId ");
                    pms.Add(new SqlParameter("@WorkId", ht["WorkId"].SafeToString()));
                }
                if (ht.ContainsKey("ScoreStatus") && !string.IsNullOrEmpty(ht["ScoreStatus"].SafeToString()))
                {
                    if (ht["ScoreStatus"].SafeToString() == "0")
                    { }
                    else if (ht["ScoreStatus"].SafeToString() == "5")
                    {
                        sbSql4org.Append(@" and rel.CorrectUID is null ");
                    }
                    else
                    {
                        sbSql4org.Append(@" and rel.ScoreStatus=@ScoreStatus ");
                        pms.Add(new SqlParameter("@ScoreStatus", ht["ScoreStatus"].SafeToString()));
                    }
                }
                if (ht.ContainsKey("StuIDCard") && !string.IsNullOrEmpty(ht["StuIDCard"].SafeToString()))
                {
                    sbSql4org.Append(" and rel.CreateUID=@StuIDCard ");
                    pms.Add(new SqlParameter("@StuIDCard", ht["StuIDCard"].ToString()));
                }
                if (isGroupIDCard == "1")
                {
                    sbSql4org.Append(@" group by rel.CreateUID ");
                }
                dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        #endregion

        #region 获取作业统计信息
        public DataTable GetWorkStatisticsInfo(Hashtable ht)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            DataTable dt = new DataTable();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select count(1) as comCount, 
                                isnull(sum(case when ScoreStatus=1 then 1 else 0 end),0) as ScoreStatus1, 
                                isnull(sum(case when ScoreStatus=2 then 1 else 0 end),0) as ScoreStatus2,
                                isnull(sum(case when ScoreStatus=3 then 1 else 0 end),0) as ScoreStatus3,
                                isnull(sum(case when ScoreStatus=4 then 1 else 0 end),0) as ScoreStatus4,
                                isnull(sum(case when CorrectUID is null then 1 else 0 end),0) as uncorrect ");
                string isGroupIDCard = ht["IsGroupIDCard"].SafeToString();
                if (isGroupIDCard == "1")
                {
                    sbSql4org.Append(",rel.CreateUID ");
                }
                sbSql4org.Append(@" from Course_WorkCorrectRel rel 
                                inner join Course_Work work on rel.WorkId=work.ID and work.IsDelete=0 
                                inner join Couse_Selstuinfo sel on sel.CourseID=work.CouseID and sel.StuNo=rel.CreateUID
                                where 1=1 ");
                if (ht.ContainsKey("CouseID") && !string.IsNullOrEmpty(ht["CouseID"].SafeToString()))
                {
                    sbSql4org.Append(" and work.CouseID=@CouseID ");
                    pms.Add(new SqlParameter("@CouseID", ht["CouseID"].SafeToString()));
                }
                if (ht.ContainsKey("WorkId") && !string.IsNullOrEmpty(ht["WorkId"].SafeToString()))
                {
                    sbSql4org.Append(@" and rel.WorkId=@WorkId ");
                    pms.Add(new SqlParameter("@WorkId", ht["WorkId"].SafeToString()));
                }
                if (ht.ContainsKey("StuIDCard") && !string.IsNullOrEmpty(ht["StuIDCard"].SafeToString()))
                {
                    sbSql4org.Append(" and rel.CreateUID=@StuIDCard ");
                    pms.Add(new SqlParameter("@StuIDCard", ht["StuIDCard"].ToString()));
                }
                if (isGroupIDCard == "1")
                {
                    sbSql4org.Append(@" group by rel.CreateUID ");
                }
                dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        #endregion

        #region 获取可能需要发通知的作业
        public DataTable GetEnableSendMesWork()
        {
            DataTable dt = new DataTable();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select work.Id,work.CouseID,work.Name,co.CourceType from Course_Work work
                            left join Course co on work.CouseID=co.ID
                            where work.IsDelete=0 and convert(varchar(10),dateadd(d,1,work.EndTime),21)= convert(varchar(10),getdate(),21) ");
                dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, null);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        #endregion

        #region 获取课程作业完成情况详细信息
        /// <summary>
        /// 获取课程作业完成情况详细信息
        /// </summary>
        /// <param name="StuNo"></param>
        /// <param name="CourseID"></param>
        /// <returns></returns>
        public DataTable GetStuSubWorkDetail(string StuNo, string CourseID)
        {
            string strSql = "select a.Name,b.CreateTime,b.CorrectTime,b.Score,case b.ScoreStatus when 1 then '优' when 2 then '良' when 3 then '中' when 4 then '差' end as StoreLevel,b.Attachment,b.CreateUID,b.CorrectUID from [dbo].[Course_Work] a left join Course_WorkCorrectRel b on a.Id=b.WorkId and b.CreateUID='" +
               StuNo + "' where a.CouseID=" + CourseID;
            DataTable dt = SQLHelp.ExecuteDataTable(strSql, CommandType.Text, null);
            return dt;
        }
        #endregion
    }
}
