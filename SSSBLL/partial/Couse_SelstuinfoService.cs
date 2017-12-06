using SSSDAL;
using SSSIBLL;
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
    public partial class Couse_SelstuinfoService : BaseService<Couse_Selstuinfo>, ICouse_SelstuinfoService
    {
        Couse_SelstuinfoDal dal = new Couse_SelstuinfoDal();
        BLLCommon common = new BLLCommon();

        public JsonModel GetDataByCourceID(string CourceID)
        {


            JsonModel jsonModel = null;
            try
            {
                DataTable dt = dal.GetDataByCourceID(CourceID);
                if (dt != null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = common.DataTableToList(dt)
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }


        }
        public JsonModel SinLogAdd(string UserID, string CourseID)
        {
            JsonModel jsonModel = null;
            try
            {
                string result = dal.SinLogAdd(UserID, CourseID);
                if (result == "")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "",
                        retData = "成功"
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = result,
                        retData = ""
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        #region 获取正在学习某课程的员工
        public JsonModel GetLearnStaffByCourceID(string courceID, string isFinish = "")
        {
            JsonModel jsonModel = null;
            try
            {
                DataTable dt = dal.GetLearnStaffByCourceID(courceID, isFinish);
                if (dt != null)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = dt
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        #endregion
        #region 获取正在学习某课程的员工人数
        public int GetLearnStaffCountByCourceID(string courceID, string isFinish = "")
        {
            return dal.GetLearnStaffCountByCourceID(courceID, isFinish);
        }
        #endregion
        #region 获取正在学习某课程的员工UniqueNo字符串
        public string GetLearnStaffUniqueNosByCourceID(string courceID, string isFinish = "")
        {
            return dal.GetLearnStaffUniqueNosByCourceID(courceID, isFinish);
        }
        #endregion

        public JsonModel GetMyLessonsByType(Hashtable ht, bool IsPage = true)
        {
            int RowCount = 0;
            BLLCommon common = new BLLCommon();

            int PageIndex = 0;
            int PageSize = 0;
            if (IsPage)
            {
                //增加起始条数、结束条数
                ht = common.AddStartEndIndex(ht);
                PageIndex = Convert.ToInt32(ht["PageIndex"]);
                PageSize = Convert.ToInt32(ht["PageSize"]);
            }
            DataTable modList = dal.GetMyLessonsByType(ht, out RowCount, IsPage);
            return GetJsonModelByDataTable(modList);
            /*try
            {
                int PageIndex = 0;
                int PageSize = 0;
                if (IsPage)
                {
                    //增加起始条数、结束条数
                    ht = common.AddStartEndIndex(ht);
                    PageIndex = Convert.ToInt32(ht["PageIndex"]);
                    PageSize = Convert.ToInt32(ht["PageSize"]);
                }
                DataTable modList = dal.GetMyLessonsByType(ht, out RowCount, IsPage);

                //DataTable modList = CurrentDal.GetListByPage(ht, out RowCount, IsPage, where);

                //定义分页数据实体
                PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList == null || modList.Rows.Count <= 0)
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
                list = common.DataTableToList(modList);

                if (IsPage)
                {
                    //总页数
                    int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
                    //将数据封装到PagedDataModel分页数据实体中
                    pagedDataModel = new PagedDataModel<Dictionary<string, object>>()
                    {
                        PageCount = PageCount,
                        PagedData = list,
                        PageIndex = PageIndex,
                        PageSize = PageSize,
                        RowCount = RowCount
                    };
                    //将分页数据实体封装到JSON标准实体中
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = pagedDataModel
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = list
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
            }*/
        }
        #region 设置课程完成
        /// <summary>
        /// 设置课程完成
        /// </summary>
        /// <param name="IsFinish"></param>
        /// <param name="CourseID"></param>
        /// <param name="StuNo"></param>
        /// <returns></returns>
        public JsonModel SetStuCourseFinish(int IsFinish, int CourseID, string StuNo)
        {
            JsonModel jsonModel = null;
            try
            {
                bool Flag = dal.SetStuCourseFinish(IsFinish, CourseID, StuNo);
                if (Flag)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "",
                        retData = "成功"
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "设置失败",
                        retData = ""
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }

        }
        #endregion

        #region 调整选课人员
        /// <summary>
        /// 调整选课人员
        /// </summary>
        /// <param name="CourseID"></param>
        /// <param name="StuNo"></param>
        /// <returns></returns>
        public JsonModel AdJustStu(int CourseID, string StuNo, string Type)
        {
            JsonModel jsonModel = null;
            try
            {
                string ReturnResult = dal.AdJustStu(CourseID, StuNo, Type);
                if (ReturnResult.Split('-')[0] == "0")
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = ReturnResult.Split('-')[1],
                        retData = ""
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = ReturnResult.Split('-')[1],
                        retData = ""
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }

        }
        #endregion


    }
}
