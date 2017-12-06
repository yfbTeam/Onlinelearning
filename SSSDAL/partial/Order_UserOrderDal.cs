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
    public partial class Order_UserOrderDal : BaseDal<Order_UserOrder>, IOrder_UserOrderDal
    {
        #region 分页获取数据重写
        /// <summary>
        /// 分页获取数据重写
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
                str.Append(@" select a.*,b.name as ScaleName,c.Name as DishName,d.Name as TypeName,c.Price,datediff(day,a.CreateTime,GETDATE()) as DiffDay from Order_UserOrder a 
 inner join Order_TimeScale b on a.scaleid=b.id inner join Order_Dish c on a.dishid=c.id inner join Order_DishType d on c.type=d.id where 1=1 ");
                int StartIndex = 0;
                int EndIndex = 0;
                string Where = "";
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    str.Append(" and a.ID = " + ht["ID"].SafeToString());
                }
                if (ht.ContainsKey("BeginTime") && !string.IsNullOrEmpty(ht["BeginTime"].SafeToString()))
                {
                    str.Append(" and a.CreateTime > '" + ht["BeginTime"].SafeToString() + "'");
                }
                if (ht.ContainsKey("EndTime") && !string.IsNullOrEmpty(ht["EndTime"].SafeToString()))
                {
                    str.Append(" and a.CreateTime < '" + ht["CreateTime"].SafeToString() + "'");
                }
                if (ht.ContainsKey("Status") && !string.IsNullOrEmpty(ht["Status"].SafeToString()))
                {
                    str.Append(" and a.Status=" + ht["Status"].SafeToString());
                }
                if (ht.ContainsKey("CreateUID") && !string.IsNullOrEmpty(ht["CreateUID"].SafeToString()))
                {
                    str.Append(" and a.CreateUID='" + ht["CreateUID"].SafeToString() + "'");
                }
                if (ht.ContainsKey("DiffDay") && !string.IsNullOrEmpty(ht["DiffDay"].SafeToString()))
                {
                    if (ht["DiffDay"].SafeToString() == "0")
                    {
                        str.Append("  and datediff(day,a.CreateTime,GETDATE()) =0");
                    }
                    else
                    {
                        str.Append("  and datediff(day,a.CreateTime,GETDATE()) >0");
                    }
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
        public int SureOrder(string CreateUID)
        {
            string strSql = "update Order_UserOrder set Status=1 where CreateUID='" + CreateUID + "' and Status=0";
            return SQLHelp.ExecuteNonQuery(strSql, CommandType.Text, null);
        }
    }
}
