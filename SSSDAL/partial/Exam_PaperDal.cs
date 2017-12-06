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
    public partial class Exam_PaperDal : BaseDal<Exam_Paper>, IExam_PaperDal
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
                sbSql4org.Append(@"select ep.*,
                                    case ep.Status when 1 then '启用' else '禁用' END as StatusShow,ep.Title as Name,
                                    case ep.Type when 1 then '考试' when 2 then '测试' when 4 then '调查问卷' else '作业' end as TypeShow,
                                    case ep.Difficulty when 1 then '简单' when 2 then '中等' else '困难' end as DifficultyShow,
                                    convert(varchar(10),ep.CreateTime,21) as CreateTime_Format                                    
                                    from Exam_Paper as ep
                                    where 1=1 ");
                if (ht.ContainsKey("Status") && !string.IsNullOrEmpty(ht["Status"].ToString()))
                {
                    sbSql4org.Append(" and  ep.Status=@Status ");
                    pms.Add(new SqlParameter("@Status", ht["Status"].ToString()));
                }
                //if (ht.ContainsKey("Category") && !string.IsNullOrEmpty(ht["Category"].ToString()))
                //{
                //    sbSql4org.Append(" and ep.Major like  N'%'+@Category + '%' ");
                //    pms.Add(new SqlParameter("@Category", ht["Category"].ToString()));
                //}
                if (ht.ContainsKey("KlpointID") && !string.IsNullOrEmpty(ht["KlpointID"].ToString()))
                {
                    sbSql4org.Append(" and ep.Klpoint=@KlpointID ");
                    pms.Add(new SqlParameter("@KlpointID", ht["KlpointID"].ToString()));
                }
                if (ht.ContainsKey("Book") && !string.IsNullOrEmpty(ht["Book"].ToString()))
                {
                    sbSql4org.Append(" and ep.Book like @Book ");
                    pms.Add(new SqlParameter("@Book", ht["Book"].ToString()));
                }
                if (ht.ContainsKey("Type") && !string.IsNullOrEmpty(ht["Type"].ToString()))
                {
                    sbSql4org.Append(" and ep.Type=@Type ");
                    pms.Add(new SqlParameter("@Type", ht["Type"].ToString()));
                }
                if (ht.ContainsKey("Title") && !string.IsNullOrEmpty(ht["Title"].ToString()))
                {
                    sbSql4org.Append(" and ep.Title like N'%' + @Title + '%' ");
                    pms.Add(new SqlParameter("@Title", ht["Title"].ToString()));
                }
                if (ht.ContainsKey("IsRelease") && !string.IsNullOrEmpty(ht["IsRelease"].ToString()))
                {
                    sbSql4org.Append(" and ep.IsRelease=@IsRelease ");
                    pms.Add(new SqlParameter("@IsRelease", ht["IsRelease"].ToString()));
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
        public DataTable GetList(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select ex.Status,ex.CreateUID,ep.ID,ex.ID as exid,ep.FullScore,ep.ExamTime,ep.Title as name,ep.evaluate from Exam_Paper ep left join Exam_Examination ex on ep.ID=ex.ExampaperID where 1=1");
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and ep.ID in ({0})", ht["ID"].ToString());

                }
                if (ht.ContainsKey("CreateUID") && !string.IsNullOrEmpty(ht["CreateUID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and ex.CreateUID = '{0}'", ht["CreateUID"].ToString());

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

        public object addexams(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                string sql = string.Format(@" insert into Exam_Paper(Title,Klpoint,Book,Type,FullScore,ExamTime,Difficulty,Status,IsRelease,CreateTime,CreateUID) values('{0}',{1},'{2}',{3},{4},{5},{6},{7},{8},'{9}','{10}')", ht["Title"].ToString(), ht["Klpoint"].ToString(), ht["Book"].ToString(), ht["Type"].ToString(), ht["FullScore"].ToString(), ht["ExamTime"].ToString(), ht["Difficulty"].ToString(), ht["Status"].ToString(), ht["IsRelease"].ToString(), DateTime.Now, ht["Author"].ToString());
                SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms.ToArray());
                int i = Convert.ToInt32(GetId());
                return i;
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        public object upExam_PaperDal(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                string sql = string.Format(@" update Exam_Paper set WorkBeginTime='{0}',WorkEndTime='{1}',ClassID='{2}',IsRelease={3},evaluate='{4}' where ID={5}", ht["WorkBeginTime"].ToString(), ht["WorkEndTime"].ToString(), ht["ClassID"].ToString(), ht["IsRelease"].ToString(), ht["evaluate"].ToString(), ht["ID"].ToString());
                return SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms.ToArray()); ;
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }

        public object GetId()
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            string sql = "select  ident_current('Exam_Paper') as id";
            return SQLHelp.ExecuteScalar(sql, CommandType.Text, pms.ToArray());
        }

    }
}
