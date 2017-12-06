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
    public partial class Order_DishMenuDal : BaseDal<Order_DishMenu>, IOrder_DishMenuDal
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
                str.Append(@"select a.*,b.Name as ScaleName,b.BeginTime,b.EndTime,c.ID as EachDishID,c.Name as DishName,c.Photo,c.HotDegree,c.Price,d.Name as DishType,DATEDIFF(MINUTE,UseDate,GETDATE()) as diffMinite,datediff( MINUTE,'00:00:00',BeginTime) as minMinite,datediff( MINUTE,'00:00:00',EndTime) as maxMinite from
 Order_DishMenu a inner join Order_TimeScale b on a.ScaleID=b.ID inner join Order_Dish c on a.DishID=c.ID inner join Order_DishType d on c.Type=d.ID ");
                int StartIndex = 0;
                int EndIndex = 0;
                string Where = "";
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    str.Append(" and a.ID = " + ht["ID"].SafeToString());
                }
                if (ht.ContainsKey("UseDate") && !string.IsNullOrEmpty(ht["UseDate"].SafeToString()))
                {
                    str.Append(" and a.UseDate = '" + ht["UseDate"].SafeToString() + "'");
                }
                if (ht.ContainsKey("ScaleID") && !string.IsNullOrEmpty(ht["ScaleID"].SafeToString()))
                {
                    str.Append(" and a.ScaleID=" + ht["ScaleID"].SafeToString());
                }
                if (ht.ContainsKey("DishID") && !string.IsNullOrEmpty(ht["DishID"].SafeToString()))
                {
                    str.Append(" and a.DishID = " + ht["DishID"].SafeToString());
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
        public string OrderMenuAdd(string useDate, string ScaleID, string DishIDArry)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@useDate",useDate),
                                       new SqlParameter("@ScaleID", ScaleID),
                                       new SqlParameter("@DishIDArry",DishIDArry.TrimEnd(','))
                                   };
            object obj = SQLHelp.ExecuteScalar("AddOrderMenu", CommandType.StoredProcedure, param);
            string result = "";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
    }
}
