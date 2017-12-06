using SSSDAL;
using SSSIBLL;
using SSSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
namespace SSSBLL
{
    public partial class Exam_PaperService : BaseService<Exam_Paper>, IExam_PaperService
    {
        Exam_PaperDal epdal = new Exam_PaperDal();
        Exam_PaperObjQDal epqdal = new Exam_PaperObjQDal();
        Exam_PaperSubQDal epsdal = new Exam_PaperSubQDal();

        public JsonModel addexams(Hashtable ht, string where = "")
        {
            BLLCommon common = new BLLCommon();
            try
            {

                object modList = epdal.addexams(ht, where);
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = modList
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        public JsonModel upExam_ExamPaperDal(Hashtable ht, string where = "")
        {
            BLLCommon common = new BLLCommon();
            try
            {

                object modList = epdal.upExam_PaperDal(ht, where);
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = modList
                };
                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        public JsonModel GetdataEP(Hashtable ht, string where = "")
        {
            return GetJsonModelByDataTable(epdal.GetList(ht, where));
        }

        #region 查询题目
        /// <summary>
        /// 方法放到考试系统专用BLL中
        /// 查看方法
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="where"></param>
        /// <returns></returns>
        public JsonModel GetListtimuEPQ(Hashtable ht, string where = "")
        {
            return GetJsonModelByDataTable(epqdal.GetListtimu(ht, where));
        }
        public JsonModel GetListtimuEPS(Hashtable ht, string where = "")
        {
            return GetJsonModelByDataTable(epsdal.GetListtimu(ht, where));
        }
        #endregion
        public JsonModel GetdataEPQ(Hashtable ht, string where = "")
        {
            return GetJsonModelByDataTable(epqdal.GetList(ht, where));
        }
        public JsonModel GetdataEPS(Hashtable ht, string where = "")
        {
            return GetJsonModelByDataTable(epsdal.GetList(ht, where));
        }
    }
}
