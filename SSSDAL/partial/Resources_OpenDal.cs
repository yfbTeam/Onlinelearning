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

    public partial class Resources_OpenDal : BaseDal<Resources_Open>, IResources_OpenDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                string DocName = (string)ht["DocName"];
                string GroupName = ht["GroupName"].SafeToString();
                string Postfixs = ht["Postfixs"].SafeToString();
                string CatagoryID = ht["CatagoryID"].SafeToString();
                string ChapterID = ht["ChapterID"].SafeToString();
                string IDCard = ht["IDCard"].SafeToString();
                string CreateUID = ht["CreateUID"].SafeToString();
                string Status = ht["Status"].SafeToString();
                string ID = ht["ID"].SafeToString();
                string IDS = ht["IDS"].SafeToString();
                string Pid = ht["Pid"].SafeToString();
                string IsFolder = ht["IsFolder"].SafeToString();
                string LoginCheckUser = ht["LoginCheckUser"].SafeToString();
                int StartIndex = 0;
                int EndIndex = 0;
                StringBuilder sb = new StringBuilder();
                sb.Append("select ID,CreateUID,EditUID,Pid,EidtTime,Status,CheckUsers,CheckMessage,code,IsFolder,Name+postfix as Name,FileUrl,CreateTime,FileSize,FileGroup,postfix,CASE postfix WHEN '' THEN 'file' else right(postfix,LEN(postfix) - 1) end  as postfix1 from Resources_Open where 1=1");
                if (LoginCheckUser.Length > 0)
                {
                    sb.Append("and Pid in (select id from Resources_Open where CheckUsers like '%" + LoginCheckUser + "%')");
                }
                if (CreateUID.Length > 0)
                {
                    sb.Append(" and (Status=1 or CreateUID = '" + CreateUID + "')");
                }
                if (IsFolder.Length > 0)
                {
                    sb.Append(" and IsFolder =" + IsFolder);
                }
                if (Status.Length > 0)
                {
                    sb.Append(" and Status in (" + Status + ")");
                    if (CreateUID.Length > 0)
                    {
                        sb.Append(" or CreateUID = '" + CreateUID + "'");
                    }
                }

                if (DocName.SafeToString().Length > 0)
                {
                    sb.Append(" and Name like '%" + DocName + "%'");
                }
                if (GroupName.Length > 0)
                {
                    sb.Append(" and FileGroup = '" + GroupName + "'");
                }
                if (ID.Length > 0)
                {
                    sb.Append(" and ID = " + ID);
                }
                if (IDS.Length > 0)
                {
                    sb.Append(" and ID in(" + IDS + ") ");
                }
                if (Postfixs.Length > 0)
                {
                    sb.Append(" and postfix in (" + GetPostfixs(int.Parse(Postfixs)) + ")");
                }
                if (ChapterID.Length > 0)
                {
                    sb.Append(" and ChapterID=" + ChapterID);
                }
                else if (ChapterID.Length == 0 && CatagoryID.Length > 0)
                {
                    sb.Append(" and '|'+CatagoryID+'|' like '|" + CatagoryID + "|%'");
                }
                if (Postfixs.Length > 0)
                {
                    sb.Append(" and postfix in (" + GetPostfixs(int.Parse(Postfixs)) + ")");
                    if (Pid.Length > 0 && Pid != "0")
                    {
                        sb.Append(" and Pid=" + Pid);
                    }
                }
                else
                {
                    if (Pid.Length > 0)
                    {
                        sb.Append(" and Pid=" + Pid);
                    }
                }
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }

                dt = SQLHelp.GetListByPage("(" + sb.ToString() + ")", where, "", StartIndex, EndIndex, IsPage, null, out RowCount);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        public int Del(string ID)
        {
            string strSql = "delete from Resources_Open where ID=" + ID + " or PID=" + ID + " or '|'+code like  '|'+(select code from Resources_Open where id=" + ID + ") +'|%'";
            int Result = SQLHelp.ExecuteNonQuery(strSql, CommandType.Text, null);
            return Result;
        }
        private string GetPostfixs(int id)
        {
            ResourceTypeDal dal = new ResourceTypeDal();
            ResourceType mo = new ResourceType();
            mo = dal.GetEntityById(mo, id);
            return mo.Postfixs;
        }

    }
}
