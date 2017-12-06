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
    public partial class CourseDal : BaseDal<Course>, ICourseDal
    {

        #region 分页获取课程信息重写
        /// <summary>
        /// 分页获取课程信息重写
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="IsPage"></param>
        /// <param name="where"></param>
        /// <returns></returns>
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                StringBuilder str = new StringBuilder();
                string StuNo = ht["StuNo"].SafeToString();
                str.Append(@"select a.*, case a.status when 0 then '初始化' when 2 then '创建完成' when 3 then '教室预约中'  when 4 then '教室预约成功' when 5 then '教室预约失败' when 1 then '课程已发布' end as StatusName,Catogary.Name as CatogaryName,c.ModelID as CerModel,c.Name as CerName,b.stuNo,(select count(1) from Topic tpc where tpc.IsDelete=0 and tpc.Type=0 and tpc.CouseID=a.ID) as TopicCount,
                            (select count(1) from CertificateList where CertificateID=c.ID) as ApplyCertNum
                                from Course a inner join Course_Catagory Catogary on a.CourceType=Catogary.ID left join CertificateCourse d on a.ID=d.CourseID left join CertificateManage c on d.CertificateID=c.ID left join Couse_Selstuinfo b on a.id=b.CourseID and b.stuNo='" + StuNo + "' where 1=1");
                int StartIndex = 0;
                int EndIndex = 0;
                string Where = "";
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    str.Append(" and a.ID = " + ht["ID"].SafeToString());
                }//当前登录用户(如果不是管理员 只能看自己创建和分配给自己的课程）
                if (ht.ContainsKey("CreateUID") && !string.IsNullOrEmpty(ht["CreateUID"].SafeToString()))
                {
                    if (ht["CreateUID"].SafeToString() != "00000000000000000X")
                    {
                        str.Append(" and (a.CreateUID = '" + ht["CreateUID"].SafeToString() + "' or a.LecturerName like '%" + ht["CreateUID"].SafeToString() + "%')");
                    }
                }
                if (ht.ContainsKey("OperSymbol") && !string.IsNullOrEmpty(ht["OperSymbol"].SafeToString()))
                {
                    str.Append(" and a.EndTime" + ht["OperSymbol"].SafeToString() + "'" + DateTime.Now + "'");
                }
                if (ht.ContainsKey("StudyTerm") && !string.IsNullOrEmpty(ht["StudyTerm"].SafeToString()))
                {
                    str.Append(" and a.StudyTerm=" + ht["StudyTerm"].SafeToString());
                }
                if (ht.ContainsKey("IdCard") && !string.IsNullOrEmpty(ht["IdCard"].SafeToString()))
                {
                    str.Append(" and a.LecturerName like '%" + ht["IdCard"].SafeToString() + "%'");
                }
                if (ht.ContainsKey("CourseType") && !string.IsNullOrEmpty(ht["CourseType"].SafeToString()))
                {
                    str.Append(" and a.CourceType=" + ht["CourseType"].SafeToString() + "");
                }
                if (ht.ContainsKey("IsCharge") && !string.IsNullOrWhiteSpace(ht["IsCharge"].SafeToString()))
                {
                    str.Append(" and a.IsCharge=" + ht["IsCharge"].SafeToString() + "");
                }
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].SafeToString()))
                {
                    str.Append(" and a.Name like '%" + ht["Name"].SafeToString() + "%'");
                }
                if (ht.ContainsKey("Boutique") && !string.IsNullOrEmpty(ht["Boutique"].SafeToString()))
                {
                    str.Append(" and a.Boutique=" + ht["Boutique"].SafeToString() + "");
                }
                if (ht.ContainsKey("MaxClickNum") && !string.IsNullOrEmpty(ht["MaxClickNum"].SafeToString()))
                {
                    str.Append(" and a.ClickNum>=" + ht["MaxClickNum"].SafeToString() + "");
                }
                if (ht.ContainsKey("RecentlyTime") && !string.IsNullOrEmpty(ht["RecentlyTime"].SafeToString()))
                {
                    str.Append(" and a.CreateTime>='" + ht["RecentlyTime"].SafeToString() + "'");
                }
                if (ht.ContainsKey("CatagoryID") && !string.IsNullOrEmpty(ht["CatagoryID"].SafeToString()))
                {
                    str.Append(" and a.CatagoryID='" + ht["CatagoryID"].SafeToString() + "'");
                }
                if (ht.ContainsKey("StuID") && !string.IsNullOrEmpty(ht["StuID"].SafeToString()))
                {
                    str.Append(" and a.ID in (select CourseID from Couse_Selstuinfo where StuNo in (" + ht["StuID"].SafeToString() + "))");
                }
                if (ht.ContainsKey("Status") && !string.IsNullOrEmpty(ht["Status"].SafeToString()))
                {
                    str.Append(" and a.Status =" + ht["Status"].SafeToString());
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
        #endregion

        #region 报名
        /// <summary>
        /// 报名
        /// </summary>
        /// <param name="courseid">课程编号</param>
        /// <param name="stuno">学生编号</param>
        /// <returns></returns>
        public string StuSingUp(string courseid, string stuno, string ClassID)
        {
            if (ClassID != "")
            {
                SqlParameter[] param = { 
                                       new SqlParameter("@ClassID",ClassID),
                                       new SqlParameter("@CouseID",courseid),
                                       new SqlParameter("@StuNo", stuno),
                                   };
                return SQLHelp.ExecuteScalar("StuSingUp", CommandType.StoredProcedure, param).ToString();

            }
            else
            {
                SqlParameter[] param = { 
                                       new SqlParameter("@CouseID",courseid),
                                       new SqlParameter("@StuNo", stuno),
                                   };
                return SQLHelp.ExecuteScalar("StuSingUp", CommandType.StoredProcedure, param).ToString();

            }

        }
        /*
         public string StuSingUp_MTG(string courseid, string stuno, string ClssID)
         {
             SqlParameter[] param = { 
                                        new SqlParameter("@ClssID",ClssID),
                                        new SqlParameter("@CouseID",courseid),
                                        new SqlParameter("@StuNo", stuno),
                                    };
             return SQLHelp.ExecuteScalar("StuSingUp", CommandType.StoredProcedure, param).ToString();

         }
         * */
        #endregion

        #region 添加课程
        /// <summary>
        /// 添加课程
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string AddCourse(Course entity, string CerName, string CerModel)
        {
            SqlParameter[] param = { 
                                      new SqlParameter("@Name",entity.Name),
                                       new SqlParameter("@ImageUrl", entity.ImageUrl),
                                       new SqlParameter("@CourceType",entity.CourceType),
                                       new SqlParameter("@CourseIntro",entity.CourseIntro), 
                                       new SqlParameter("@StudyPlace",entity.StudyPlace),
                                       new SqlParameter("@CreateUID",entity.CreateUID),
                                       new SqlParameter("@LecturerName",entity.LecturerName),
                                       new SqlParameter("@CerName",CerName),
                                       new SqlParameter("@CerModel",CerModel)

                                   };
            object obj = SQLHelp.ExecuteScalar("AddCource", CommandType.StoredProcedure, param);
            string result = "";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion

        #region 添加课程-门头沟
        /// <summary>
        /// 添加课程
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string AddCourse_MTG(Course entity)
        {
            SqlParameter[] param = { 
                                      new SqlParameter("@Name",entity.Name),
                                       new SqlParameter("@ImageUrl", entity.ImageUrl),
                                       new SqlParameter("@CourceType",entity.CourceType),
                                       new SqlParameter("@CourseIntro",entity.CourseIntro), 
                                       new SqlParameter("@StudyPlace",entity.StudyPlace),
                                       new SqlParameter("@CreateUID",entity.CreateUID),
                                       new SqlParameter("@LecturerName",entity.LecturerName),
                                       new SqlParameter("@SelMinNum",entity.SelMinNum),
                                       new SqlParameter("@SelMaxNum",entity.SelMaxNum),
                                       new SqlParameter("@WeekID",entity.WeekID)
                                   };
            object obj = SQLHelp.ExecuteScalar("AddCource", CommandType.StoredProcedure, param);
            string result = "";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion
        #region 添加课程-农职
        /// <summary>
        /// 添加课程
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string AddCourse_NG(Course entity, string ClassNo)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@Name",entity.Name),
                                       new SqlParameter("@ImageUrl", entity.ImageUrl),
                                       new SqlParameter("@CourceType",entity.CourceType),
                                       new SqlParameter("@CourseIntro",entity.CourseIntro), 
                                       new SqlParameter("@StudyPlace",entity.StudyPlace),
                                       new SqlParameter("@CreateUID",entity.CreateUID),
                                       new SqlParameter("@LecturerName",entity.LecturerName),                                      
                                       new SqlParameter("@ClassNo",ClassNo)
                                   };
            object obj = SQLHelp.ExecuteScalar("AddCource", CommandType.StoredProcedure, param);
            string result = "";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion

        #region 发布课程
        public string RealeseCourse(string ID, string StartTime, string EndTime, string Classes)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@ID",ID),
                                       new SqlParameter("@StartTime", StartTime),
                                       new SqlParameter("@EndTime",EndTime),
                                       new SqlParameter("@Classes",Classes)                                     
                                   };
            object obj = SQLHelp.ExecuteScalar("RealeseCourse", CommandType.StoredProcedure, param);
            string result = obj.ToString();

            return result;
        }
        #endregion

        #region 课程删除
        public string DelCourse(string courseid, string IDCard)
        {
            SqlParameter[] param = { 
                                      new SqlParameter("@ID",courseid),
                                      new SqlParameter("@CreateUID", IDCard)
                                   };
            object obj = SQLHelp.ExecuteScalar("DelCourse", CommandType.StoredProcedure, param);
            string result = "";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion

        #region 修改课程
        /// <summary>
        /// 添加课程
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string UpdateCourse(Course entity, string CerName, string CerModel)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@Name",entity.Name),
                                       new SqlParameter("@ImageUrl", entity.ImageUrl),
                                       new SqlParameter("@CourceType",entity.CourceType),
                                       new SqlParameter("@CourseIntro",entity.CourseIntro), 
                                       new SqlParameter("@StudyPlace",entity.StudyPlace),
                                       new SqlParameter("@ID",entity.ID),
                                       new SqlParameter("@EidtTime",DateTime.Now),
                                       new SqlParameter("@LecturerName",entity.LecturerName),
                                       new SqlParameter("@CerName",CerName),
                                       new SqlParameter("@CerModel",CerModel)
                                   };
            object obj = SQLHelp.ExecuteScalar("UpdateCourse", CommandType.StoredProcedure, param);
            string result = "";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion

        #region 修改课程-门头沟
        /// <summary>
        /// 添加课程
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string UpdateCourse_MTG(Course entity)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@Name",entity.Name),
                                       new SqlParameter("@ImageUrl", entity.ImageUrl),
                                       new SqlParameter("@CourceType",entity.CourceType),
                                       new SqlParameter("@CourseIntro",entity.CourseIntro), 
                                       new SqlParameter("@StudyPlace",entity.StudyPlace),
                                       new SqlParameter("@ID",entity.ID),
                                       new SqlParameter("@EidtTime",DateTime.Now),
                                       new SqlParameter("@LecturerName",entity.LecturerName),
                                       new SqlParameter("@SelMinNum",entity.SelMinNum),
                                       new SqlParameter("@SelMaxNum",entity.SelMaxNum),
                                       new SqlParameter("@WeekID",entity.WeekID)
                                   };
            object obj = SQLHelp.ExecuteScalar("UpdateCourse", CommandType.StoredProcedure, param);
            string result = "";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion

        #region 分类获取课程信息
        /// <summary>
        ///分类获取课程信息
        /// </summary>
        /// <param name="top"></param>
        /// <returns></returns>
        public DataTable GetCourseByType(int top, string StuNo, Hashtable ht)
        {

            DataTable dt = new DataTable();
            StringBuilder str = new StringBuilder();
            str.Append("select tb1.*,b.stuNo from(select ID,EndTime,Name,ImageUrl,CourceType,CourseType,LecturerName,GradeName,RigistType,row_number() " +
               "over(partition by CourseType order by ID desc) as rownum  from Course where 1=1");
            if (ht.ContainsKey("ClassID") && !string.IsNullOrEmpty(ht["ClassID"].SafeToString()))
            {
                str.Append(" and id in (select CourseID from [dbo].[ClassCourse] where ClassID=" + ht["ClassID"].SafeToString() + ")");
            }
            if (ht.ContainsKey("CourceType") && !string.IsNullOrEmpty(ht["CourceType"].SafeToString()))
            {
                str.Append(" and CourceType=" + ht["CourceType"].SafeToString());
            }
            if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].SafeToString()))
            {
                str.Append(" and Name=" + ht["Name"].SafeToString());
            }
            str.Append(") as tb1 left join Couse_Selstuinfo b on tb1.id=b.CourseID and b.stuNo='" + StuNo + "' where rownum<4");
            dt = SQLHelp.ExecuteDataTable(str.ToString(), CommandType.Text, null);
            //dt = SQLHelp.GetListByPage("(" + str.ToString() + ")", "", "", StartIndex, EndIndex, IsPage, null);

            return dt;
        }
        #endregion

        #region 学生调整
        /// <summary>
        /// 学生调整
        /// </summary>
        /// <param name="Type">1:分配2：删除</param>
        /// <param name="FreeStuIDs">未分配学生</param>
        /// <param name="StuIDs">已分配学生</param>
        /// <returns></returns>
        public string AdjustStu(int Type, string FreeStuIDs, string StuIDs, string CourseID, string CreateUID, string StuName)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@Type",Type),
                                       new SqlParameter("@FreeStuIDs", FreeStuIDs),
                                       new SqlParameter("@StuIDs",StuIDs),
                                       new SqlParameter("@CourseID",CourseID),
                                       new SqlParameter("@CreateUID", CreateUID),
                                       new SqlParameter("@StuName",StuName)
                                   };
            return SQLHelp.ExecuteScalar("AdjustStu", CommandType.StoredProcedure, param).ToString();

        }
        #endregion

        #region 添加课程模版
        /// <summary> 
        /// 添加课程模版
        /// </summary>
        /// <param name="CourceID"></param>
        /// <param name="ModelName"></param>
        /// <returns></returns>
        public string ModoleAdd(int CourceID, string ModelName, string CreateUID, string CourseMes)
        {
            SqlParameter[] parm = { 
                                  new SqlParameter("@CourceID",CourceID),
                                  new SqlParameter("@ModoleName",ModelName),
                                  new SqlParameter("@CourseMes",CourseMes),
                                  new SqlParameter("@CreateUID",CreateUID)
                                  };
            object obj = SQLHelp.ExecuteScalar("Course_Model_Add", CommandType.StoredProcedure, parm);
            return obj.SafeToString();
        }
        #endregion

        #region 根据模版添加课程
        /// <summary>
        /// 根据模版添加课程
        /// </summary>
        /// <param name="ModelID"></param>
        /// <param name="CourceName"></param>
        /// <param name="CourseMessage"></param>
        /// <returns></returns>
        public string AddCourseByModol(int ModelID, string CourceName, string CourseMessage, string CreateUID)
        {
            SqlParameter[] parm = { 
                                  new SqlParameter("@ModelID",ModelID),
                                  new SqlParameter("@CourceName",CourceName),
                                  new SqlParameter("@CourseMessage",CourseMessage),
                                  new SqlParameter("@CreateUID",CreateUID)
                                  };
            object obj = SQLHelp.ExecuteScalar("Course_AddByModel", CommandType.StoredProcedure, parm);
            return obj.SafeToString();
        }
        #endregion

        #region 获取热门课程
        /// <summary>
        /// 获取热门课程
        /// </summary>
        /// <returns></returns>
        public DataTable HotCourse(string StuNo)
        {
            try
            {
                SqlParameter[] pa ={
                                 new SqlParameter("@StuNo",StuNo)
                             };
                DataTable dt = SQLHelp.ExecuteDataTable("HotCourse", CommandType.StoredProcedure, pa);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
                throw;
            }

        }
        #endregion

        //#region 统计课程类型
        ///// <summary>
        ///// 统计课程类型
        ///// </summary>
        ///// <param name="Type"></param>
        ///// <returns></returns>
        //public string CouseTypeAnalis(string Type)
        //{
        //    string result = "";
        //    string strSql = "select COUNT(1) as Num from Course where EndTime" + Type + "GETDATE() group by CourceType order by CourceType";
        //    DataTable dt = SQLHelp.ExecuteDataTable(strSql, CommandType.Text, null);
        //    for (int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        result += dt.Rows[i]["Num"] + ",";
        //    }
        //    return "[" + result.TrimEnd(',') + "]";
        //}
        //#endregion

        #region 统计课程任务完成情况
        /// <summary>
        /// 统计课程任务完成情况
        /// </summary>
        /// <param name="Type"></param>
        /// <returns></returns>
        public DataTable CouseTaskAnalis(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].SafeToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].SafeToString());
            }
            try
            {
                string strSql = "select  a.Name as TaskName,a.ID,a.CourseID,a.ChapterID,b.CreateUID,a.Weight,c.Name as CourseName,isnull(b.CreateUID,0) as Complete " +
                                "from Couse_TaskInfo a left join Course_TaskRel b on a.ID=b.TaskID inner join Course c on a.CourseID=c.ID and a.IsDelete=0 and b.CreateUID='" +
                                ht["CreateUID"].SafeToString() + "'";
                DataTable dt = SQLHelp.GetListByPage("(" + strSql + ")", "", "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        #endregion

        #region 统计课程完成情况
        /// <summary>
        /// 统计课程类型
        /// </summary>
        /// <param name="Type"></param>
        /// <returns></returns>
        public DataTable CouseCompleteAnalis(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].SafeToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].SafeToString());
            }
            try
            {
                string strSql = "select a.ID,a.Name,b.*,(select sum(weight) from Couse_TaskInfo where CourseID=a.ID)as AllWeigth from course a inner join (select  a.CourseID,b.CreateUID,sum(weight) as CompleteWeight from Couse_TaskInfo a left join Course_TaskRel b on a.ID=b.TaskID and a.IsDelete=0 group by CourseID,b.CreateUID)b on a.ID=b.CourseID and b.CreateUID is not null";
                DataTable dt = SQLHelp.GetListByPage("(" + strSql + ")", "", "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        #endregion


    }
}
