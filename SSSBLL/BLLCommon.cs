using SSSModel;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace SSSBLL
{
    public class BLLCommon
    {
        /// <summary>
        /// 根据第几页、每页条数增加起始条数、结束条数
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public Hashtable AddStartEndIndex(Hashtable ht)
        {
            try
            {
                int PageIndex = Convert.ToInt32(ht["PageIndex"]);
                int PageSize = Convert.ToInt32(ht["PageSize"]);
                ht.Add("StartIndex", (((PageIndex - 1) * PageSize) + 1).ToString());
                ht.Add("EndIndex", (PageIndex * PageSize).ToString());
            }
            catch (Exception)
            {

                throw;
            }
            return ht;
        }
        /// <summary>
        /// 无验证-不分页
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public JsonModel GetData_NoVerification(Hashtable ht)
        {
            BLLCommon com = new BLLCommon();
            JsonModel JsonModel;
            try
            {
                string SQL = " select " + ht["Columns"].ToString() + " from " + ht["TableName"].ToString() + " where 1=1 ";
                if (ht.Contains("Where") && !string.IsNullOrWhiteSpace(ht["Where"].ToString()))
                {
                    SQL += ht["Where"].ToString();
                }
                if (ht.Contains("Order") && !string.IsNullOrWhiteSpace(ht["Order"].ToString()))
                {
                    SQL += " order by " + ht["Order"].ToString();
                }
                DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text);
                if (dt == null)
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "失败",
                        retData = ""
                    };
                    LogService.WriteErrorLog("DataTable为NULL");
                    return JsonModel;
                }
                if (dt.Rows.Count == 0)
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return JsonModel;
                }
                JsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "成功",
                    retData = com.DataTableToList(dt)
                };
                return JsonModel;
            }
            catch (Exception ex)
            {

                JsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
                return JsonModel;
            }
        }
        /// <summary>
        /// DataTable转换成Json格式
        /// </summary>
        /// <param name="dt">要转换的DataTable</param>        
        /// <returns>Json字符串</returns>
        public string DataTableToJson(DataTable dt)
        {
            if (dt == null) return string.Empty;
            StringBuilder sb = new StringBuilder();
            sb.Append("{\"");
            sb.Append(dt.TableName);
            sb.Append("\":[");
            foreach (DataRow r in dt.Rows)
            {
                sb.Append("{");
                foreach (DataColumn c in dt.Columns)
                {
                    sb.Append("\"");
                    sb.Append(c.ColumnName);
                    sb.Append("\":\"");
                    sb.Append(r[c].ToString().Replace("\\", "//"));
                    sb.Append("\",");
                }
                sb.Remove(sb.Length - 1, 1);
                sb.Append("},");
            }
            sb.Remove(sb.Length - 1, 1);
            sb.Append("]}");
            return sb.ToString();
        }

        /// <summary>
        /// DataTable转换成List
        /// </summary>
        /// <param name="dt">要转换的DataTable</param>        
        /// <returns>List<Dictionary<string, object>></returns>
        public List<Dictionary<string, object>> DataTableToList(DataTable dt)
        {
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            foreach (DataRow dr in dt.Rows)
            {
                Dictionary<string, object> result = new Dictionary<string, object>();
                foreach (DataColumn dc in dt.Columns)
                {
                    result.Add(dc.ColumnName, dr[dc].ToString());
                }
                list.Add(result);
            }
            return list;
        }

        /// <summary>
        /// JSON序列化
        /// </summary>
        public static string JsonSerializer<T>(T t)
        {
            DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
            MemoryStream ms = new MemoryStream();
            ser.WriteObject(ms, t);
            string jsonString = Encoding.UTF8.GetString(ms.ToArray());
            ms.Close();
            //替换Json的Date字符串
            string p = @"\\/Date\((\d+)\+\d+\)\\/";
            MatchEvaluator matchEvaluator = new MatchEvaluator(ConvertJsonDateToDateString);
            Regex reg = new Regex(p);
            jsonString = reg.Replace(jsonString, matchEvaluator);
            return jsonString;
        }

        /// <summary>
        /// JSON反序列化
        /// </summary>
        public static T JsonDeserialize<T>(string jsonString)
        {
            //将"yyyy-MM-dd HH:mm:ss"格式的字符串转为"\/Date(1294499956278+0800)\/"格式
            string p = @"\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}";
            MatchEvaluator matchEvaluator = new MatchEvaluator(ConvertDateStringToJsonDate);
            Regex reg = new Regex(p);
            jsonString = reg.Replace(jsonString, matchEvaluator);
            DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
            MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(jsonString));
            T obj = (T)ser.ReadObject(ms);
            return obj;
        }

        /// <summary>
        /// 将Json序列化的时间由/Date(1294499956278+0800)转为字符串
        /// </summary>
        private static string ConvertJsonDateToDateString(Match m)
        {
            string result = string.Empty;
            DateTime dt = new DateTime(1970, 1, 1);
            dt = dt.AddMilliseconds(long.Parse(m.Groups[1].Value));
            dt = dt.ToLocalTime();
            result = dt.ToString("yyyy-MM-dd HH:mm:ss");
            return result;
        }

        /// <summary>
        /// 将时间字符串转为Json时间
        /// </summary>
        private static string ConvertDateStringToJsonDate(Match m)
        {
            string result = string.Empty;
            DateTime dt = DateTime.Parse(m.Groups[0].Value);
            dt = dt.ToUniversalTime();
            TimeSpan ts = dt - DateTime.Parse("1970-01-01");
            result = string.Format("\\/Date({0}+0800)\\/", ts.TotalMilliseconds);
            return result;
        }
        /// <summary>
        /// 有验证-不分页
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public JsonModel GetData(Hashtable ht)
        {
            BLLCommon com = new BLLCommon();
            JsonModel JsonModel = null;
            try
            {

                string SQL = " select * from (";
                SQL += " select " + ht["Columns"].ToString() + " from " + ht["TableName"].ToString() + " where 1=1 ";
                if (ht.Contains("Where") && !string.IsNullOrWhiteSpace(ht["Where"].ToString()))
                {
                    SQL += ht["Where"].ToString();
                }
                if (ht.Contains("Order") && !string.IsNullOrWhiteSpace(ht["Order"].ToString()))
                {
                    SQL += " order by " + ht["Order"].ToString();
                }
                SQL += ") T";
                DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text);
                if (dt == null)
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "失败",
                        retData = ""
                    };
                    LogService.WriteErrorLog("DataTable为NULL");
                }
                else if (dt.Rows.Count == 0)
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                }
                else
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "",
                        retData = com.DataTableToList(dt)
                    };
                };
            }
            catch (Exception ex)
            {

                JsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
            return JsonModel;
        }
        /// <summary>
        /// 分页
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public JsonModel GetPagingData(Hashtable ht)
        {
            BLLCommon com = new BLLCommon();
            JsonModel JsonModel;
            List<SqlParameter> List = new List<SqlParameter>();
            try
            {
                if (!ht.Contains("PageIndex") || !ht.Contains("PageSize"))
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 3,
                        errMsg = "loss",
                        retData = ""
                    };
                    return JsonModel;
                }
                int PageIndex = Convert.ToInt32(ht["PageIndex"]);
                int PageSize = Convert.ToInt32(ht["PageSize"]);
                ht.Add("StartIndex", (((PageIndex - 1) * PageSize) + 1).ToString());
                ht.Add("EndIndex", (PageIndex * PageSize).ToString());

                string SQL = " select * from (";
                SQL += " select " + ht["Columns"].ToString() + " from " + ht["TableName"].ToString() + " where 1=1 ";
                if (ht.Contains("Where") && !string.IsNullOrWhiteSpace(ht["Where"].ToString()))
                {
                    SQL += ht["Where"].ToString();
                }
                if (ht.Contains("Order") && !string.IsNullOrWhiteSpace(ht["Order"].ToString()))
                {
                    SQL += " order by " + ht["Order"].ToString();
                }
                SQL += ") T1 ";
                //DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text);
                DataTable dt = GetListByPage("(" + SQL + ")", "", "", Convert.ToInt32(ht["StartIndex"].ToString()), Convert.ToInt32(ht["EndIndex"].ToString()), List.ToArray());
                if (dt == null)
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "失败",
                        retData = ""
                    };
                    LogService.WriteErrorLog("DataTable为NULL");
                    return JsonModel;
                }
                if (dt.Rows.Count == 0)
                {
                    JsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return JsonModel;
                }
                int RowCount = GetRecordCount("(" + SQL + ") T", "", List.ToArray());
                //JsonModel.retData = DataTableToList(dt);
                //定义分页数据实体
                PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
                //总页数
                int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
                //将数据封装到PagedDataModel分页数据实体中
                pagedDataModel = new PagedDataModel<Dictionary<string, object>>()
                {
                    PageCount = PageCount,
                    PagedData = DataTableToList(dt),
                    PageIndex = PageIndex,
                    PageSize = PageSize,
                    RowCount = RowCount
                };
                JsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "成功",
                    retData = pagedDataModel
                };
                return JsonModel;
            }
            catch (Exception ex)
            {

                JsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
                return JsonModel;
            }
        }
        /// <summary>
        /// 获取记录总数
        /// </summary>
        /// <param name="strWhere">条件</param>
        /// <returns>记录总数</returns>
        public int GetRecordCount(string TableName, string strWhere, SqlParameter[] parms4org)
        {
            StringBuilder sbSql = new StringBuilder();
            sbSql.Append("select count(1) FROM " + TableName);
            if (strWhere.Trim() != "")
            {
                sbSql.Append(" where 1=1" + strWhere);
            }

            object obj = SQLHelp.ExecuteScalar(sbSql.ToString(), CommandType.Text, parms4org);

            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        /// <param name="strWhere">条件</param>
        /// <param name="orderby">排序</param>
        /// <param name="startIndex">起始行数</param>
        /// <param name="endIndex">结束行数</param>
        /// <returns>DataSet</returns>
        public DataTable GetListByPage(string TableName, string strWhere, string orderby, int startIndex, int endIndex, SqlParameter[] parms4org, bool ispage = true)
        {
            StringBuilder sbSql = new StringBuilder();
            sbSql.Append("SELECT * FROM ( ");
            sbSql.Append(" SELECT ROW_NUMBER() OVER (");
            if (!string.IsNullOrEmpty(orderby.Trim()))
            {
                sbSql.Append("order by T." + orderby);
            }
            else
            {
                sbSql.Append("order by T.ID desc");
            }
            sbSql.Append(")AS rowNum, T.*  from " + TableName + " T ");
            if (!string.IsNullOrEmpty(strWhere.Trim()))
            {
                sbSql.Append(" WHERE 1=1 " + strWhere);
            }
            sbSql.Append(" ) TT");
            if (ispage)
            {
                sbSql.AppendFormat(" WHERE TT.rowNum between {0} and {1}", startIndex, endIndex);
            }
            return SQLHelp.ExecuteDataTable(sbSql.ToString(), CommandType.Text, parms4org);
        }
    }
}
