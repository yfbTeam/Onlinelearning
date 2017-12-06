using SSSIDAL;
using SSSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SSSUtility;

namespace SSSDAL
{
    public partial class SingActiveTimeDal : BaseDal<SingActiveTime>, ISingActiveTimeDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                StringBuilder str = new StringBuilder();
                str.Append(@"select WeekValue,'Week'+WeekValue as WeekID,'BeginTime'+WeekValue as BeginTimeID,'EndTime'+WeekValue as EndTimeID,BeginTime,EndTime,
case WeekValue when '1' then '周日'  when '7' then '周六' when '6' then '周五' when '5' then '周四' when '4' then '周三' when '3' then '周二' else '周一' end as WeekName
from SingActiveTime ");

                int StartIndex = 0;
                int EndIndex = 0;
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("(" + str.ToString() + ")", Where, "WeekValue", StartIndex,
                    EndIndex, IsPage, null, out RowCount);

            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
    }
}
