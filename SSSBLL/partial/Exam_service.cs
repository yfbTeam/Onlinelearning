using SSSDAL;
using SSSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSBLL
{
    public class Exam_service
    {
        Exam_AnswerDal eadal = new Exam_AnswerDal();
        Exam_ExaminationDal emdal = new Exam_ExaminationDal();

        public JsonModel upExam_ExamAnswer(Exam_Answer model)
        {
            BLLCommon common = new BLLCommon();
            try
            {

                int result = eadal.upExam_Answer(model);
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (result > 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "success",
                        retData = ""
                    };
                }

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

        public JsonModel addExamination(Exam_Examination entity, string where = "")
        {
            BLLCommon common = new BLLCommon();
            try
            {

                object modList = emdal.addExamination(entity, where);
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

        public JsonModel GetdataEA(Hashtable ht, string where = "")
        {
            return GetJsonModelByDataTable(eadal.GetList(ht, where));
        }

        public JsonModel GetAnswerListSub(Hashtable ht, string where = "")
        {
            return GetJsonModelByDataTable(eadal.GetAnswerListSub(ht, where));
        }
        public JsonModel GetAnswerListObj(Hashtable ht, string where = "")
        {
            return GetJsonModelByDataTable(eadal.GetAnswerListObj(ht, where));
        }
        private JsonModel GetJsonModelByDataTable(DataTable modList)
        {
            try
            {
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList.Rows.Count <= 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return jsonModel;
                }
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                list = new BLLCommon().DataTableToList(modList);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "success",
                    retData = list
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
    }
}
