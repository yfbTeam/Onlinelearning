using SSSIDAL;
using SSSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SSSUtility;

namespace SSSDAL
{
    public partial class Couse_SelstuinfoDal : BaseDal<Couse_Selstuinfo>, ICouse_SelstuinfoDal
    {
        private void CheckRequedCourse(string StuNo, string ClassID)
        {
            SqlParameter[] pa = { 
                                new SqlParameter("@StuNo",StuNo),
                                new SqlParameter("@ClassID",ClassID)
                                };
            SQLHelp.ExecuteNonQuery("CheckRequedCourse", CommandType.StoredProcedure, pa);
        }
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            if (ht.ContainsKey("CheckUser") && !string.IsNullOrEmpty(ht["CheckUser"].ToString()))
            {
                CheckRequedCourse(ht["StuNo"].SafeToString(), ht["ClassNo"].SafeToString()); 
            }
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
                string operSymbol = "";
                sbSql4org.Append(@"select distinct co.*,sel.ID as SelId,sel.IsFinish,sel.StuNo,sel.LastStudyTime,sel.CreateTime as SelTime
                               ,(select count(1) from Topic tpc where tpc.IsDelete=0 and tpc.Type=0 and tpc.CouseID=co.ID) as TopicCount ");
                sbSql4org.Append(" ,'" + operSymbol + "' as OperSymbol ");
                if (ht.ContainsKey("StuNo") && !string.IsNullOrEmpty(ht["StuNo"].ToString()))
                {
                    sbSql4org.Append(@" ,cevalue.Evalue,isnull(fav.ID,0) as FavoriteID ");
                }
                if (ht.ContainsKey("IsPercent") && !string.IsNullOrEmpty(ht["IsPercent"].ToString()))
                {
                    DataTable percentDt = SQLHelp.ExecuteDataTable("select Name,Value,Percentage,SqlStr from Course_Percent where IsShow=1 and IsStatistics=1 ", CommandType.Text, null);
                    if (percentDt != null && percentDt.Rows.Count > 0)
                    {
                        string perstr = "";
                        int rowcount = percentDt.Rows.Count;
                        for (int p = 0; p < rowcount; p++)
                        {
                            DataRow curRow = percentDt.Rows[p];
                            string curname = curRow["Name"].ToString(), curvalue = curRow["Value"].ToString()
                                   , percent = curRow["Percentage"].ToString(), sqlstr = curRow["SqlStr"].ToString();
                            if (!string.IsNullOrEmpty(sqlstr))
                            {
                                perstr += @" select '" + curname + "|" + percent + "|'+" + sqlstr;
                                if (p + 1 < rowcount && !string.IsNullOrEmpty(percentDt.Rows[p + 1]["SqlStr"].ToString()))
                                {
                                    perstr += @" union ";
                                }
                            }
                        }
                        if (!string.IsNullOrEmpty(perstr))
                        {
                            sbSql4org.Append(@",(select STUFF((select ','+pinfo from(" + perstr + ") Per FOR XML PATH('')),1,1,'')) as CoStatistics ");
                        }
                        else
                        {
                            sbSql4org.Append(@",'' as CoStatistics ");
                        }
                    }
                }

                #region sql
                /*1.视频：@"cast((select count(1) from Couse_Resource base where base.CouseID = sel.CourseID and base.IsVideo = 1) as varchar(20))+'|'
                         + cast((select isnull(sum(case when sub.IsLookEnd = 1 then 1 when sub.TotalTime = 0 then 0 else sub.LongTime / sub.TotalTime end), 0) from SomeTableClick sub          
                         inner join Couse_Resource base on base.ID = sub.RelationId and base.IsVideo = 1   
                          where sub.Type = 0 and sub.CreateUID = sel.StuNo and base.CouseID = sel.CourseID) as varchar(20)) as pinfo " 
                */
                /*2.作业：@"cast((select count(1) from Course_Work base where base.CouseID=sel.CourseID and base.IsDelete=0) as varchar(20))+'|' 
                         +cast((select count(1) from Course_WorkCorrectRel sub
                         inner join Course_Work base on sub.WorkId=base.Id  and base.IsDelete=0 
                          where sub.CreateUID=sel.StuNo and base.CouseID=sel.CourseID) as varchar(20)) as pinfo "                     
                */
                #endregion
                sbSql4org.Append(@" from Couse_Selstuinfo sel inner join Course co on sel.CourseID=co.ID ");
                if (ht.ContainsKey("StuNo") && !string.IsNullOrEmpty(ht["StuNo"].ToString()))
                {
                    string StuNo = ht["StuNo"].ToString();
                    if (StuNo.IndexOf(",") < 0)
                    {
                        StuNo = "'" + StuNo + "'";
                    }
                    sbSql4org.Append(@" left join System_Favorites fav on fav.RelationID=co.ID and fav.Creator in (" + StuNo +
                        ") and fav.Type=1  left join Course_Evalue cevalue on co.ID=cevalue.CouseID and  cevalue.CreateUID in (" + StuNo + ")");
                }
                sbSql4org.Append(@" where 1=1 ");
                if (ht.ContainsKey("TeaID") && !string.IsNullOrEmpty(ht["TeaID"].ToString()))
                {
                    sbSql4org.Append(" and co.LecturerName like N'%' + @TeaID + '%' ");
                    pms.Add(new SqlParameter("TeaID", ht["TeaID"].ToString()));
                }
                if (ht.ContainsKey("CourseID") && !string.IsNullOrEmpty(ht["CourseID"].ToString()))
                {
                    sbSql4org.Append(" and co.ID=@CourseID ");
                    pms.Add(new SqlParameter("@CourseID", ht["CourseID"].ToString()));
                }
                if (ht.ContainsKey("StuNo") && !string.IsNullOrEmpty(ht["StuNo"].ToString()))
                {
                    //sbSql4org.Append(@" and sel.StuNo=@StuNo ");
                    string StuNo = ht["StuNo"].ToString();
                    if (StuNo.IndexOf(",") < 0)
                    {
                        StuNo = "'" + StuNo + "'";
                    }
                    sbSql4org.Append(@" and sel.StuNo in (" + StuNo + ") ");
                    // pms.Add(new SqlParameter("@StuNo", ht["StuNo"].ToString()));
                }
                if (ht.ContainsKey("IsFinish") && !string.IsNullOrEmpty(ht["IsFinish"].ToString()))
                {
                    sbSql4org.Append(@" and sel.IsFinish=@IsFinish ");
                    pms.Add(new SqlParameter("@IsFinish", ht["IsFinish"].ToString()));
                }
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].ToString()))
                {
                    sbSql4org.Append(" and co.Name like N'%' + @Name + '%' ");
                    pms.Add(new SqlParameter("@Name", ht["Name"].ToString()));
                }
                if (ht.ContainsKey("CourceType") && !string.IsNullOrEmpty(ht["CourceType"].ToString()))
                {
                    sbSql4org.Append(" and co.CourceType =@CourceType");
                    pms.Add(new SqlParameter("@CourceType", ht["CourceType"].SafeToString()));
                }
                LogService.WriteLog(ht["IsPercent"].ToString() + ";" + sbSql4org.SafeToString());

                return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        public string SinLogAdd(string UserID, string CourseID)
        {
            SqlParameter[] pa = { 
                                new SqlParameter("@UserID",UserID),
                                new SqlParameter("@CourseID",CourseID)
                                };

            object obj = SQLHelp.ExecuteScalar("SinLogAdd", CommandType.StoredProcedure, pa);
            return obj.ToString();
        }
        public DataTable GetDataByCourceID(string CourceID)
        {
            return SQLHelp.ExecuteDataTable("select * from Couse_Selstuinfo where CourseID='" + CourceID + "'", CommandType.Text, null);

        }
        public DataTable GetLearnStaffByCourceID(string courceID, string isFinish)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            string sql = @"select distinct StuNo as IDS from Couse_Selstuinfo where CourseID=@CourseID ";
            pms.Add(new SqlParameter("@CourseID", courceID));
            if (!string.IsNullOrEmpty(isFinish))
            {
                sql += " and IsFinish=@IsFinish ";
                pms.Add(new SqlParameter("@IsFinish", isFinish));
            }
            return SQLHelp.ExecuteDataTable(sql, CommandType.Text, pms.ToArray());
        }
        public int GetLearnStaffCountByCourceID(string courceID, string isFinish)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            string sql = @"select distinct count(1) from Couse_Selstuinfo where CourseID=@CourseID ";
            pms.Add(new SqlParameter("@CourseID", courceID));
            if (!string.IsNullOrEmpty(isFinish))
            {
                sql += " and IsFinish=@IsFinish ";
                pms.Add(new SqlParameter("@IsFinish", isFinish));
            }
            object obj = SQLHelp.ExecuteScalar(sql, CommandType.Text, pms.ToArray());
            return Convert.ToInt32(obj);
        }
        #region 获取正在学习某课程的员工UniqueNo字符串
        public string GetLearnStaffUniqueNosByCourceID(string courceID, string isFinish = "0")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            string sql = @"select isnull(STUFF((select distinct ',' + CAST(StuNo AS NVARCHAR(MAX)) from Couse_Selstuinfo where CourseID=@CourseID ";
            pms.Add(new SqlParameter("@CourseID", courceID));
            if (!string.IsNullOrEmpty(isFinish))
            {
                sql += " and IsFinish=@IsFinish ";
                pms.Add(new SqlParameter("@IsFinish", isFinish));
            }
            sql += " FOR xml path('')), 1, 1, ''),'') ";
            object obj = SQLHelp.ExecuteScalar(sql, CommandType.Text, pms.ToArray());
            return obj.ToString();
        }
        #endregion
        /// <summary>
        /// <option value="1">所有课程</option>
        //<option value="2">已注册课程</option>
        //<option value="3">可匿名访问课程</option>
        //<option value="4">可注册课程</option>
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="RowCount"></param>
        /// <param name="IsPage"></param>
        /// <returns></returns>
        public DataTable GetMyLessonsByType(Hashtable ht, out int RowCount, bool IsPage = true)
        {
            DataTable dt = new DataTable();
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
                string ClassID = ht["ClassID"].SafeToString();
                if (ClassID.Length == 0)
                {
                    ClassID = "0";
                }
                string StuNo = ht["StuNo"].SafeToString();
                string Type = ht["CourseType"].SafeToString();
                string Name = ht["Name"].SafeToString();

                StringBuilder sbSql4org = new StringBuilder();

                sbSql4org.Append(@"select IsCharge,Name,ImageUrl,CourceType,LecturerName,CourseIntro,GradeName,ID,EndTime," + Type + " as CurrentType from [dbo].[Course] where 1=1 ");
                if (Name.Length > 0)
                {
                    sbSql4org.Append(" and Name like '%" + Name + "%'");
                }
                switch (Type)
                {
                    case "1"://所有课程
                        sbSql4org.Append(@" and IsOpen=1 union
                                        select IsCharge,Name,ImageUrl,CourceType,LecturerName,CourseIntro,GradeName,ID,EndTime," + Type + " as CurrentType from [dbo].[Course] where CourceType=1 and id in (select courseid from [dbo].[ClassCourse] where [ClassID]=" + ClassID +
                                        ")union select IsCharge,Name,ImageUrl,CourceType,LecturerName,CourseIntro,GradeName,ID,EndTime," + Type + " as CurrentType from [dbo].[Course] where CourceType=2 and id in (select CourseID from [dbo].[Couse_Selstuinfo] where stuno='" + StuNo + "')");
                        break;
                    case "2"://已注册课程
                        sbSql4org.Append(@" and CourceType=2 and ID in (select CourseID from [dbo].[Couse_Selstuinfo] where stuno='" + StuNo + "')");
                        break;
                    case "3"://可匿名访问课程
                        sbSql4org.Append(@" and IsOpen=1");
                        break;
                    case "4"://可注册课程
                        sbSql4org.Append(@" and CourceType=2 and ID in (select courseid from [dbo].[ClassCourse] where [ClassID]=" + ClassID + " and courseid not in (select CourseID from [dbo].[Couse_Selstuinfo] where stuno='" + StuNo + "'))");
                        break;
                    default:
                        break;
                }
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.Append(" and ID = " + ht["ID"].SafeToString());
                }
                dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", "", "", StartIndex, EndIndex, IsPage, null, out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
            return dt;
        }

        #region 设置课程完成
        /// <summary>
        /// 设置课程完成
        /// </summary>
        /// <param name="IsFinish"></param>
        /// <param name="CourseID"></param>
        /// <param name="StuNo"></param>
        /// <returns></returns>
        public bool SetStuCourseFinish(int IsFinish, int CourseID, string StuNo)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@IsFinish", IsFinish));
            pms.Add(new SqlParameter("@CourseID", CourseID));
            pms.Add(new SqlParameter("@StuNo", StuNo));
            string strSql = @"update Couse_Selstuinfo set IsFinish=@IsFinish";
            if (IsFinish == 1)
            {
                strSql += ",FinishTime=GETDATE()";
            }
            strSql += " where CourseID=@CourseID and StuNo=@StuNo";
            int i = SQLHelp.ExecuteNonQuery(strSql, CommandType.Text, pms.ToArray());
            if (i > 0)
            {
                return true;
            }
            else
                return false;
        }
        #endregion

        #region 调整选课人员
        /// <summary>
        /// 调整选课人员
        /// </summary>
        /// <param name="CourseID">课程ID</param>
        /// <param name="StuNo">学员UniquNo（，分割）</param>
        /// <returns></returns>
        public string AdJustStu(int CourseID, string StuNo, string Type)
        {
            SqlParameter[] pa = { 
                                new SqlParameter("@CourseID",CourseID),
                                new SqlParameter("@StuNo",StuNo),
                                new SqlParameter("@Type",Type)
                                };

            object obj = SQLHelp.ExecuteScalar("AdjustSelStu", CommandType.StoredProcedure, pa);
            return obj.SafeToString();
        }
        #endregion

    }
}
