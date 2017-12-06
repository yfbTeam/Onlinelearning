using SSSDAL;
using SSSModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSBLL
{
    public class ExamAnalisyBLL
    {
        #region 某考生平均分
        /// <summary>
        /// 某考生平均分
        /// </summary>
        /// <param name="ExampaperID"></param>
        /// <returns></returns>
        public JsonModel GetAvgScore(int ExampaperID)
        {
            ExamAnalisy dal = new ExamAnalisy();
            JsonModel jsonModel = null;
            BLLCommon common = new BLLCommon();
            DataTable dt = dal.GetAvgScore(ExampaperID);
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            list = common.DataTableToList(dt);
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "无数据",
                retData = list
            };
            return jsonModel;
        }
        #endregion

        #region 前五名和后五名
        /// <summary>
        /// 前五名和后五名
        /// </summary>
        /// <param name="Order"></param>
        /// <returns></returns>
        public JsonModel GetTop5Stu(string Order, int ExampaperID)
        {
            ExamAnalisy dal = new ExamAnalisy();
            JsonModel jsonModel = null;
            BLLCommon common = new BLLCommon();
            DataTable dt = dal.GetTop5Stu(Order, ExampaperID);
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            list = common.DataTableToList(dt);
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "无数据",
                retData = list
            };
            return jsonModel;
        }
        #endregion


        #region 统计答题人数和得分率
        /// <summary>
        /// 统计答题人数和得分率
        /// </summary>
        /// <param name="ExampaperID"></param>
        /// <returns></returns>
        public JsonModel AnaliseQuestionScore(string ExampaperID)
        {
            ExamAnalisy dal = new ExamAnalisy();
            JsonModel jsonModel = null;
            BLLCommon common = new BLLCommon();
            DataTable dt = dal.AnaliseQuestionScore( ExampaperID);
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            list = common.DataTableToList(dt);
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "无数据",
                retData = list
            };
            return jsonModel;
           
        }
        #endregion

        #region 答题详情
        /// <summary>
        /// 答题详情
        /// </summary>
        /// <param name="ExampaperID"></param>
        /// <param name="QuestionID"></param>
        /// <returns></returns>
        public JsonModel QuestionScoreDetail(string ExampaperID, string QuestionID)
        {
            ExamAnalisy dal = new ExamAnalisy();
            JsonModel jsonModel = null;
            BLLCommon common = new BLLCommon();
            DataTable dt = dal.QuestionScoreDetail(ExampaperID, QuestionID);
            List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
            list = common.DataTableToList(dt);
            jsonModel = new JsonModel()
            {
                errNum = 0,
                errMsg = "无数据",
                retData = list
            };
            return jsonModel;        
        }
        #endregion
    }
}
