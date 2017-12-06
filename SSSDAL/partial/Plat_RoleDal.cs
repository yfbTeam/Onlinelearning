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
    public partial class Plat_RoleDal : BaseDal<Plat_Role>, IPlat_RoleDal
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
                sbSql4org.Append(@"select * from Plat_Role where 1=1");

                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and Id ='{0}' ", ht["ID"].ToString());
                }
                if (ht.ContainsKey("UserIDCard") && !string.IsNullOrEmpty(ht["UserIDCard"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and  Id in(select RoleId from Plat_RoleOfUser where UserIDCard='" + ht["UserIDCard"].SafeToString() + "')");
                }

                if (IsPage)
                {
                    PageIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    PageSize = Convert.ToInt32(ht["EndIndex"].ToString());
                }
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

        #region 获取全部角色，返回DataTable
        /// <summary>
        /// 获取全部角色，返回DataTable
        /// </summary>
        public DataTable GetAllRoleList()
        {
            StringBuilder sbSql4org;
            List<SqlParameter> pms = new List<SqlParameter>();
            sbSql4org = new StringBuilder();
            sbSql4org.Append(@"select distinct * from Plat_Role where IsDelete=0 order by Id desc ");
            return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
        }
        #endregion
        #region 获取某用户的角色信息
        /// <summary>
        /// 获取某用户的角色信息
        /// </summary>
        public DataTable GetRoleByUser(Hashtable ht)
        {
            StringBuilder sbSql4org;
            List<SqlParameter> pms = new List<SqlParameter>();
            sbSql4org = new StringBuilder();
            sbSql4org.Append(@"select distinct * 
                                from Plat_RoleOfUser rel
                                inner join Plat_Role sys_role on rel.RoleId=sys_role.Id and sys_role.IsDelete=0
                                where 1=1 ");
            if (ht.ContainsKey("UserIDCard") && !string.IsNullOrEmpty(ht["UserIDCard"].ToString()))
            {
                sbSql4org.Append(" and rel.UserIDCard=@UserIDCard  ");
                pms.Add(new SqlParameter("@UserIDCard", ht["UserIDCard"].ToString()));
            }
            return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
        }
        #endregion
    }
}
