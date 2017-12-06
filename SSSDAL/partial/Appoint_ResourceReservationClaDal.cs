﻿using SSSIDAL;
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
    public partial class Appoint_ResourceReservationClaDal : BaseDal<Appoint_ResourceReservationCla>, IAppoint_ResourceReservationClaDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string Where)
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                int StartIndex = 0;
                int EndIndex = 0;
                string ID = ht["ID"].SafeToString();
                string PID = ht["PID"].SafeToString();
                string CPID = ht["CPID"].SafeToString();//这个只适用点击Menu取得所有子节点数据
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                if (ID.Length > 0)
                {
                    Where += " and Id=" + ID;
                }
                if (PID.Length > 0)
                {
                    Where += " and PId=" + PID;
                }

                if (CPID.Length > 0)
                {
                    StringBuilder sbSql4org = new StringBuilder();
                    sbSql4org.AppendFormat(@"with temp_Resource as(select Id from Appoint_ResourceReservationCla where Id='{0}' and IsDelete=0 union all
                    select  A.Id from Appoint_ResourceReservationCla A,temp_Resource B where A.PId=B.Id and A.IsDelete=0)
                    select * from temp_Resource", CPID);
                    dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, null);

                }
                else
                {
                    Where += " and IsDelete=0";
                    dt = SQLHelp.GetListByPage((string)ht["TableName"], Where, "", StartIndex,
                       EndIndex, IsPage, null, out RowCount);
                }

            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
    }
}
