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
    public partial class Order_DishDal : BaseDal<Order_Dish>, IOrder_DishDal
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
                str.Append(@"select a.*,b.Name as TypeName from  Order_Dish a inner join Order_DishType b on a.Type=b.ID where 1=1 ");
                int StartIndex = 0;
                int EndIndex = 0;
                string Where = "";
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    str.Append(" and a.ID = " + ht["ID"].SafeToString());
                }
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].SafeToString()))
                {
                    str.Append(" and a.Name like '%" + ht["Name"].SafeToString() + "%'");
                }
                if (ht.ContainsKey("Status") && !string.IsNullOrEmpty(ht["Status"].SafeToString()))
                {
                    str.Append(" and a.Status=" + ht["Status"].SafeToString());
                }
                if (ht.ContainsKey("Type") && !string.IsNullOrEmpty(ht["Type"].SafeToString()))
                {
                    str.Append(" and a.Type = " + ht["Type"].SafeToString());
                }
                if (ht.ContainsKey("ScaleID") && !string.IsNullOrEmpty(ht["ScaleID"].SafeToString()))
                {
                    str.Append("  and a.id not in ( select DishID from Order_DishMenu where UseDate='" + ht["useDate"].SafeToString() + "' and ScaleID=" + ht["ScaleID"].SafeToString() + ")");
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
    }
}
