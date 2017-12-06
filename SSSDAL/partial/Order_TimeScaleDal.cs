using SSSIDAL;
using SSSModel;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSDAL
{
    public partial class Order_TimeScaleDal : BaseDal<Order_TimeScale>, IOrder_TimeScaleDal
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
                str.Append(@"select * from Order_TimeScale ");
                int StartIndex = 0;
                int EndIndex = 0;
               
                dt = SQLHelp.GetListByPage("(" + str.ToString() + ")", "", "ID", StartIndex,
                    EndIndex, false, null, out RowCount);
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
