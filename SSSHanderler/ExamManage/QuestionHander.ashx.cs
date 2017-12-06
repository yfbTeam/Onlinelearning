using SSSBLL;
using SSSHanderler.OnlineLearning;
using SSSModel;
using SSSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace SSSHanderler.ExamManage
{
    /// <summary>
    /// QuestionHander 的摘要说明
    /// </summary>
    public class QuestionHander : IHttpHandler
    {
        JsonModel jsonModel = new JsonModel() { errNum = 0, errMsg = "success", retData = "" };
        JavaScriptSerializer jss = new System.Web.Script.Serialization.JavaScriptSerializer();
        Exam_ObjQuestionService objqservice = new Exam_ObjQuestionService();
        Exam_SubQuestionService subqservice = new Exam_SubQuestionService();
        CacheHelper cachehelper = new CacheHelper();
        CommonHandler common = new CommonHandler();
        //试题类型
        Exam_QuestionTypeService QustionTypeBll = new Exam_QuestionTypeService();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string action = context.Request["action"].ToString();
            string result = string.Empty;
            try
            {
                if (action != null && action != "")
                {
                    switch (action)
                    {
                        //试卷类型
                        case "GetQuestionTypeList":
                            GetQuestionTypeList(context);
                            break;
                        //case "GetQuestion":
                        //    GetQuestion(context);
                        //    break;
                        #region 试题新增修改删除
                        //新增试题
                        case "AddExamQuestion":
                            AddExamQuestion(context);
                            break;
                        //修改试题
                        case "EditExamQuestion":
                            EditExamQuestion(context);
                            break;
                        //获取主观题
                        case "GetExamSubQList":
                            GetExamSubQList(context);
                            break;
                        //获取客观题
                        case "GetExamObjQList":
                            GetExamObjQList(context);
                            break;
                        //修改试题状态
                        case "ChangeQuestionStatus":
                            ChangeQuestionStatus(context);
                            break;
                        //删除试题
                        case "DelQuestion":
                            DelQuestion(context);
                            break;
                        //获取客观题 各种题目的数量、总分数、客观题类型（用于智能组卷）
                        case "GetObjQusetionByDif":
                            GetObjQusetionByDif(context);
                            break;
                        //获取主观题 各种题目的数量、总分数、客观题类型（用于智能组卷）
                        case "GetSubQusetionByDif":
                            GetSubQusetionByDif(context);
                            break;

                        #endregion

                        #region 购物车
                        case "getTextBasketTypeQ":
                            getTextBasketTypeQ(context);
                            break;
                        case "getTestBasket":
                            gettestbasket(context);
                            break;
                        case "AddQToTesstBasket":
                            AddQToTesstBasket(context);
                            break;
                        case "AddBasketOfRandom":
                            AddBasketOfRandom(context);
                            break;

                        case "DelTestBasket":
                            DelTestBasket(context);
                            break;
                        #endregion
                    }
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 5,
                        errMsg = "没有此方法",
                        retData = ""
                    };
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
            result = "{\"result\":" + jss.Serialize(jsonModel) + "}";
            context.Response.Write(result);
            context.Response.End();
        }

        #region 获取主客观题 各种题目的数量、总分数、客观题类型（用于智能组卷）
        private void GetObjQusetionByDif(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("ID", context.Request["ID"] ?? "");
                ht.Add("Difficulty", context.Request["Difficulty"] ?? "");
                ht.Add("Klpoint", context.Request["Klpoint"] ?? "");
                jsonModel = objqservice.GetdataEQ(ht);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        private void GetSubQusetionByDif(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Difficulty", context.Request["Difficulty"] ?? "");
                ht.Add("Klpoint", context.Request["Klpoint"] ?? "");
                ht.Add("ID", context.Request["ID"] ?? "");
                jsonModel = subqservice.GetdataES(ht);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion

        #region 绑定试题类型
        /// <summary>
        /// 绑定试题类型
        /// </summary>
        /// <param name="context"></param>
        public void GetQuestionTypeList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("Title", context.Request["Title"].SafeToString());
                ht.Add("OptionType", context.Request["OptionType"].SafeToString());
                jsonModel = QustionTypeBll.GetPage(ht, false);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion

        #region 购物车
        private DataTable CreateDataTable(string[] str)
        {
            DataTable dt = new DataTable();
            foreach (string item in str)
            {
                dt.Columns.Add(item);
            }
            return dt;
        }
        #region 获取购物车中已添加的各类试题的个数
        /// <summary>
        /// 获取购物车中已添加的各类试题的个数
        /// </summary>
        /// <param name="context"></param>
        private void getTextBasketTypeQ(HttpContext context)
        {
            try
            {
                string Type = context.Request["Type"];
                DataTable dtQType = CreateDataTable(new[] { "Type", "Count", "TypeID" });
                jsonModel = QustionTypeBll.GetEntityListByField("Status", "1");
                List<Exam_QuestionType> list = jsonModel.retData as List<Exam_QuestionType>;
                if (list != null)
                {
                    //循环新增试题类型数据
                    foreach (Exam_QuestionType spitem in list)
                    {
                        DataRow dr = dtQType.NewRow();
                        dr["TypeID"] = spitem.ID;
                        dr["Type"] = spitem.Name;
                        dr["Count"] = 0;
                        dtQType.Rows.Add(dr);
                    }
                }
                if (Type == "Random")
                {
                    if (CacheHelper.Contains("TestbasketRandom"))
                    {
                        DataTable dt = CacheHelper.GetCache<DataTable>("TestbasketRandom");
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            //循环累计数量
                            foreach (DataRow showitem in dtQType.Rows)
                            {
                                //string Type1 = showitem["TypeID"].SafeToString();
                                foreach (DataRow item in dt.Rows)
                                {
                                    string Type2 = item["QType"].SafeToString();
                                    if (Type2 == showitem["Type"].SafeToString() && item["UserNo"].SafeToString() == context.Request["CreateUID"].SafeToString())
                                    {
                                        showitem["Count"] = Convert.ToInt32(item["Count"]);
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    //判断session是否存在试题篮并有数据
                    if (CacheHelper.Contains("Testbasket"))
                    {
                        DataTable dt = CacheHelper.GetCache<DataTable>("Testbasket");
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            //循环累计数量
                            foreach (DataRow showitem in dtQType.Rows)
                            {
                                string Type1 = showitem["TypeID"].SafeToString();
                                foreach (DataRow item in dt.Rows)
                                {
                                    string Type2 = item["Type"].SafeToString();
                                    if (Type2 == Type1 && item["UserNo"].SafeToString() == context.Request["CreateUID"].SafeToString())
                                    {
                                        showitem["Count"] = Convert.ToInt32(showitem["Count"]) + 1;
                                    }
                                }
                            }
                        }
                    }
                }
                //绑定
                BLLCommon common = new BLLCommon();
                List<Dictionary<string, object>> mlist = common.DataTableToList(dtQType);
                jsonModel = new JsonModel()
                {
                    errMsg = "",
                    errNum = 0,
                    retData = mlist
                };

            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errMsg = ex.Message,
                    errNum = 1,
                    retData = ""
                };
                LogService.WriteErrorLog("绑定试题蓝试题类型试题|||" + ex.Message);
            }
        }
        #endregion

        private void DelTestBasket(HttpContext context)
        {
            try
            {
                string Type = context.Request["Type"];//Radom
                string typeid = context.Request["Type"];
                string TypeName = context.Request["TypeName"];
                //清空试题蓝
                if (string.IsNullOrEmpty(typeid))
                {
                    if (Type == "Radom")
                    {
                        if (CacheHelper.Contains("TestbasketRandom"))
                        {
                            DataTable newtestbasket = CacheHelper.GetCache<DataTable>("TestbasketRandom");
                            int Count = newtestbasket.Rows.Count;
                            for (int i = 0; i < Count; i++)
                            {
                                string UserNo = newtestbasket.Rows[0]["UserNo"].SafeToString();
                                string CreateUID = context.Request["CreateUID"].SafeToString();

                                if (UserNo == CreateUID)
                                {
                                    newtestbasket.Rows[0].Delete();
                                }
                            }
                            CacheHelper.SetCacheHours("TestbasketRandom", newtestbasket, 2);

                        }

                    }
                    else
                    {
                        DataTable Testbasket = CacheHelper.GetCache<DataTable>("Testbasket");
                        int Count = Testbasket.Rows.Count;
                        for (int i = 0; i < Count; i++)
                        {
                            string UserNo = Testbasket.Rows[0]["UserNo"].SafeToString();
                            string CreateUID = context.Request["CreateUID"].SafeToString();
                            if (UserNo == CreateUID)
                            {
                                Testbasket.Rows[0].Delete();
                            }
                        }
                        //if (CacheHelper.Contains("Testbasket"))
                        //{
                        //    CacheHelper.ClearCache("Testbasket");

                        //}
                        CacheHelper.SetCacheHours("Testbasket", Testbasket, 2);

                    }
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "删除成功！",
                        retData = ""
                    };
                }
                //删除试题蓝类型试题
                else
                {
                    if (Type == "Radom")
                    {
                        DataTable Testbasket = CacheHelper.GetCache<DataTable>("TestbasketRandom");
                        foreach (DataRow item in Testbasket.Rows)
                        {
                            if (item["QType"].SafeToString() != TypeName && item["UserNo"].SafeToString() == context.Request["CreateUID"].SafeToString())
                            {
                                item["Count"] = "0";
                            }

                        }
                        CacheHelper.SetCacheHours("TestbasketRandom", Testbasket, 2);
                    }
                    else
                    {
                        if (CacheHelper.Contains("Testbasket"))
                        {
                            DataTable Testbasket = CacheHelper.GetCache<DataTable>("Testbasket");
                            DataTable newtestbasket = CreateDataTable(new string[] { "UserNo", "ID", "Type", "QType", "Score" });
                            string ID = context.Request["ID"];
                            //根据试题类型删除试题
                            if (string.IsNullOrEmpty(ID))
                            {
                                //int id = Convert.ToInt32(typeid);

                                foreach (DataRow item in Testbasket.Rows)
                                {
                                    if (item["Type"].SafeToString() != typeid && item["Type"].SafeToString() != TypeName && item["UserNo"] == context.Request["CreateUID"].SafeToString())
                                    {
                                        DataRow newdr = newtestbasket.NewRow();
                                        newdr.ItemArray = item.ItemArray;
                                        newtestbasket.Rows.Add(newdr);
                                    }

                                }
                                CacheHelper.SetCacheHours("Testbasket", newtestbasket, 2);
                                jsonModel = new JsonModel()
                                {
                                    errNum = 0,
                                    errMsg = "删除成功！",
                                    retData = ""
                                };

                            }
                            //根据试题id删除试题
                            else
                            {
                                string QType = context.Request["QType"].SafeToString();
                                foreach (DataRow item in Testbasket.Rows)
                                {
                                    if ((!item["ID"].SafeToString().Equals(ID.ToString()) || !item["QType"].SafeToString().Equals(QType.ToString())) && item["UserNo"] == context.Request["CreateUID"].SafeToString())
                                    {
                                        DataRow newdr = newtestbasket.NewRow();
                                        newdr.ItemArray = item.ItemArray;
                                        newtestbasket.Rows.Add(newdr);
                                    }
                                }
                                CacheHelper.SetCacheHours("Testbasket", newtestbasket, 2);
                                jsonModel = new JsonModel()
                                {
                                    errNum = 0,
                                    errMsg = "删除成功！",
                                    retData = ""
                                };

                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "删除失败！" + ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog("ES_wp_ManualMakeExam_删除试题蓝|||" + ex.Message);
            }
        }
        private void AddBasketOfRandom(HttpContext context)
        {
            try
            {
                string TableName = context.Request["TableName"].SafeToString();
                string QType = context.Request["Type"].SafeToString();
                //string Count = context.Request["Count"].SafeToString();
                DataTable Testbasket = null;
                //判断session里是否存在该试题篮（不存在便新增，存在修改数据）
                if (CacheHelper.Contains("TestbasketRandom"))
                {
                    Testbasket = CacheHelper.GetCache<DataTable>("TestbasketRandom");// context.Session["Testbasket"] as DataTable;

                }
                else
                {                    //新增
                    Testbasket = new DataTable();
                    Testbasket = CreateDataTable(new string[] { "UserNo", "TableName", "QType", "Count" });
                }
                bool Flag = false;

                if (Testbasket.Rows.Count > 0)
                {
                    foreach (DataRow dr in Testbasket.Rows)
                    {
                        if (dr["QType"].SafeToString() == QType && dr["UserNo"] == context.Request["CreateUID"].SafeToString())
                        {
                            dr["Count"] = Convert.ToInt32(dr["Count"]) + 1;
                            Flag = true;
                        }

                    }
                }
                if (!Flag)
                {
                    DataRow Newdr = Testbasket.NewRow();
                    Newdr["UserNo"] = context.Request["CreateUID"].SafeToString();
                    Newdr["TableName"] = TableName;
                    Newdr["QType"] = QType;
                    Newdr["Count"] = 1;
                    Testbasket.Rows.Add(Newdr);
                }

                CacheHelper.SetCacheHours("TestbasketRandom", Testbasket, 2);
                jsonModel = new JsonModel()
                {
                    errNum = 0,
                    errMsg = "添加成功",
                    retData = ""
                };
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        private void AddQToTesstBasket(HttpContext context)
        {
            string id = "";
            try
            {
                string ID = context.Request["ID"].SafeToString();
                string QType = context.Request["QType"].SafeToString();
                string type = context.Request["Type"].SafeToString();
                string Score = context.Request["Score"].SafeToString();
                //判断session里是否存在该试题篮（不存在便新增，存在修改数据）
                if (CacheHelper.Contains("Testbasket"))
                {
                    // DataRow[]drs = CacheHelper.GetCache<DataTable>("Testbasket").Select("UserNo='" + context.Request["CreateUID"].SafeToString() + "'");// context.Session["Testbasket"] as DataTable;
                    DataTable Testbasket = CacheHelper.GetCache<DataTable>("Testbasket");
                    string UserNo = context.Request["CreateUID"].SafeToString();
                    bool ishave = false;
                    foreach (DataRow item in Testbasket.Rows)
                    {
                        string ItemID = item["ID"].SafeToString();
                        string ItemQType = item["QType"].SafeToString();
                        string ItemUserNo = item["UserNo"].SafeToString();
                        if (ItemID == ID && ItemQType == QType && ItemUserNo == UserNo)
                        {
                            ishave = true;
                        }
                    }
                    if (ishave)
                    {
                        jsonModel = new JsonModel()
                          {
                              errNum = 999,
                              errMsg = "该试题已加入了试题篮，请重新选择",
                              retData = ""
                          };
                    }
                    else
                    {
                        //修改
                        //DataRow newdr = Testbasket.NewRow();
                        DataRow dr = Testbasket.NewRow();
                        dr["ID"] = ID;
                        id += ID + ",";
                        dr["Type"] = type;
                        dr["QType"] = QType;
                        dr["Score"] = Score;
                        dr["UserNo"] = context.Request["CreateUID"].SafeToString();
                        Testbasket.Rows.Add(dr);
                        CacheHelper.SetCacheHours("Testbasket", Testbasket, 2);
                        jsonModel = new JsonModel()
                        {
                            errNum = 0,
                            errMsg = "添加成功",
                            retData = ""
                        };

                    }
                }
                else
                {
                    //新增
                    DataTable Testbasket = new DataTable();
                    Testbasket = CreateDataTable(new string[] { "UserNo", "ID", "Type", "QType", "Score" });
                    DataRow dr = Testbasket.NewRow();
                    dr["UserNo"] = context.Request["CreateUID"].SafeToString();
                    dr["ID"] = ID;
                    dr["Type"] = type;
                    dr["QType"] = QType;
                    dr["Score"] = Score;
                    Testbasket.Rows.Add(dr);
                    CacheHelper.SetCacheHours("Testbasket", Testbasket, 2);
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "添加成功",
                        retData = ""
                    };
                }

            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }

        }
        /// <summary>
        /// 获取试题篮
        /// </summary>
        private void gettestbasket(HttpContext context)
        {
            Exam_SubQuestionService bll = new Exam_SubQuestionService();
            DataTable dt = CreateDataTable(new string[] { "UserNo", "ID", "Type", "QType", "Score" });

            try
            {
                var Type = context.Request["Type"];//Radom
                if (Type == "Radom")//"TableName", "QType", "Count"
                {
                    //判断session是否存在试题篮并有数据
                    if (CacheHelper.Contains("TestbasketRandom"))
                    {
                        // DataTable testbasketdb 
                        DataRow[] drs = CacheHelper.GetCache<DataTable>("TestbasketRandom").Select("UserNo='" + context.Request["CreateUID"].SafeToString() + "'");// context.Session["Testbasket"] as DataTable;
                        if (drs != null && drs.Length > 0)
                        {
                            foreach (DataRow dr in drs)
                            {
                                DataTable RadomDt = bll.GetQRadom(dr["TableName"].SafeToString(), dr["QType"].SafeToString(), dr["Count"].SafeToString());
                                foreach (DataRow newDr in RadomDt.Rows)
                                {
                                    dt.Rows.Add(newDr.ItemArray);
                                }
                            }

                            //绑定
                            BLLCommon common = new BLLCommon();
                            List<Dictionary<string, object>> mlist = common.DataTableToList(dt);
                            jsonModel = new JsonModel()
                            {
                                errMsg = "",
                                errNum = 0,
                                retData = mlist
                            };
                        }
                    }
                    else
                    {
                        jsonModel = new JsonModel()
                        {
                            errMsg = "",
                            errNum = 999,
                            retData = ""
                        };
                    }
                }
                else
                {
                    //判断session是否存在试题篮并有数据
                    if (CacheHelper.Contains("Testbasket"))
                    {
                        DataTable dt1 = (DataTable)CacheHelper.GetCache<DataTable>("Testbasket");
                        DataRow[] drs = CacheHelper.GetCache<DataTable>("Testbasket").Select("UserNo='" + context.Request["CreateUID"].SafeToString() + "'");// context.Session["Testbasket"] as DataTable;
                        DataTable testbasketdb = CreateDataTable(new string[] { "UserNo", "ID", "Type", "QType", "Score" });
                        if (drs != null && drs.Length > 0)
                        {
                            foreach (DataRow dr in drs)
                            {
                                testbasketdb.Rows.Add(dr.ItemArray);
                            }
                            //绑定
                            BLLCommon common = new BLLCommon();
                            List<Dictionary<string, object>> mlist = common.DataTableToList(testbasketdb);
                            jsonModel = new JsonModel()
                            {
                                errMsg = "",
                                errNum = 0,
                                retData = mlist
                            };
                        }
                    }
                    else
                    {
                        jsonModel = new JsonModel()
                        {
                            errMsg = "",
                            errNum = 999,
                            retData = ""
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog("绑定试题蓝试题数据|||" + ex.Message);
            }
        }

        #endregion

        #region 新增试题
        /// <summary>
        /// 新增试题
        /// </summary>
        private void AddExamQuestion(HttpContext context)
        {
            try
            {
                int QType = Convert.ToInt32(context.Request["Type"].SafeToString());
                //获取试题类型
                jsonModel = QustionTypeBll.GetEntityById(QType);
                Exam_QuestionType exam_type = jsonModel.retData as Exam_QuestionType;
                //判断主观/客观试题
                if (exam_type.QType.Equals(2))
                {
                    SaveSubjQuestion(QType.ToString(), context);
                }
                else if (exam_type.QType.Equals(1))
                {
                    SaveObjQuestion(QType.ToString(), context);
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 400,
                        errMsg = "试题类型错误",
                        retData = ""
                    };
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog("QuestionHander.AddExamQuestion" + ex.Message);
            }
        }
        #region 主观题添加
        /// <summary>
        /// 主观题添加
        /// </summary>
        /// <param name="list"></param>
        /// <param name="typeid"></param>
        private void SaveSubjQuestion(string typeid, HttpContext context)
        {
            try
            {
                string Content = context.Request["Content"].SafeToString();
                string canswer = context.Request["CAnswer"].SafeToString();
                string difficulty = context.Request["Difficulty"].SafeToString();
                string Major = context.Request["Major"].SafeToString();
                string Subject = context.Request["Subject"].SafeToString();
                string Book = context.Request["Book"].SafeToString();
                Book = Book == "0" ? "0" : Book.Split('|')[1];
                string Chapter = context.Request["Chapter"].SafeToString();
                string Part = context.Request["Part"].SafeToString();
                string Point = context.Request["Point"].SafeToString();
                string Status = context.Request["Status"].SafeToString();
                string Analysis = context.Request["Analysis"].SafeToString();
                string CreateUID = context.Request["CreateUID"];
                string Score = context.Request["Score"];

                string isshowanalysis = context.Request["isshowanalysis"].SafeToString();
                if (!string.IsNullOrEmpty(Content) && !string.IsNullOrEmpty(Major))
                {
                    //string Title = context.Request["Title"];
                    // string query = "Content='" + Content.Trim();//CAML.And(CAML.Eq(CAML.FieldRef("Answer"),CAML.Value(answer)),CAML.And( )),CAML.Eq(CAML.FieldRef("Content"),CAML.Value(question.Trim()))@"<Where><Eq><FieldRef Name='Title' /><Value Type='Text'>"+ Title.Trim() + "</Value></Eq></Where>";
                    JsonModel subqjson = subqservice.GetEntityListByField("Content", Content);
                    List<Exam_SubQuestion> sublist = subqjson.retData as List<Exam_SubQuestion>;
                    if (sublist != null && sublist.Count > 0)
                    {
                        //context.Response.Write("0|新增失败,已存在该试题！");
                        jsonModel = new JsonModel()
                        {
                            errNum = 1,
                            errMsg = "新增失败,已存在该试题！！",
                            retData = ""
                        };
                        return;
                    }
                    Exam_SubQuestion item = new Exam_SubQuestion();
                    item.Type = int.Parse(typeid);
                    item.Difficulty = int.Parse(difficulty);
                    item.Content = Content;
                    if (!string.IsNullOrEmpty(Subject))
                    {

                        item.Catagory = !string.IsNullOrEmpty(context.Request["Book"]) && !context.Request["Book"].Equals("0") && !Subject.Equals("0") ? (Subject + "|" + context.Request["Book"]) : Subject;
                        //item.Major = !string.IsNullOrEmpty(Subject) && !Subject.Equals("0") ? int.Parse(Subject) : int.Parse(Major);
                        item.Klpoint = !string.IsNullOrEmpty(Point) && !Point.Equals("0") ? int.Parse(Point) : !string.IsNullOrEmpty(Part) && !Part.Equals("0") ? int.Parse(Part) : int.Parse(Chapter);
                    }
                    item.Answer = canswer;
                    item.Analysis = Analysis;
                    item.Status = int.Parse(Status);
                    item.IsShowAnalysis = int.Parse(isshowanalysis);
                    item.CreateTime = DateTime.Now;
                    item.CreateUID = CreateUID;//需要改
                    item.Score = Convert.ToInt32(Score);//需要改
                    //item.Book = Book;
                    jsonModel = subqservice.Add(item);

                }
                else
                {
                    LogService.WriteErrorLog("0|新增失败(参数不正确)！");
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "新增失败(参数不正确)！",
                        retData = ""
                    };
                    context.Response.Write(jsonModel);
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_AddExamQuestion_新增试题||||" + ex.Message);
                jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "新增失败！",
                    retData = ""
                };
            }
        }
        #endregion

        #region 客观题添加
        /// <summary>
        /// 客观题添加
        /// </summary>
        /// <param name="list"></param>
        /// <param name="typeid"></param>
        private void SaveObjQuestion(string typeid, HttpContext context)
        {
            try
            {
                string Content = context.Request["Content"];
                string answer = context.Request["Answer"].SafeToString();
                string OptionA = context.Request["OptionA"].SafeToString();
                string OptionB = context.Request["OptionB"].SafeToString();
                string OptionC = context.Request["OptionC"].SafeToString();
                string OptionD = context.Request["OptionD"].SafeToString();
                string OptionE = context.Request["OptionE"].SafeToString();
                string OptionF = context.Request["OptionF"].SafeToString();
                string difficulty = context.Request["Difficulty"];
                string Subject = context.Request["Subject"];
                string Chapter = context.Request["Chapter"];
                string Point = context.Request["Point"];
                string Status = context.Request["Status"];
                string Analysis = context.Request["Analysis"];
                string CreateUID = context.Request["CreateUID"];
                string Score = context.Request["Score"];

                string isshowanalysis = context.Request["isshowanalysis"].SafeToString();
                if (!string.IsNullOrEmpty(answer) && ((!string.IsNullOrEmpty(OptionA))) && !string.IsNullOrEmpty(Status))
                {
                    string query = "Content='" + Content.Trim();//CAML.And(CAML.Eq(CAML.FieldRef("Answer"),CAML.Value(answer)),CAML.And( )),CAML.Eq(CAML.FieldRef("Content"),CAML.Value(question.Trim()))@"<Where><Eq><FieldRef Name='Title' /><Value Type='Text'>"+ Title.Trim() + "</Value></Eq></Where>";
                    jsonModel = objqservice.GetEntityListByField("Content", Content);
                    List<Exam_ObjQuestion> objlist = jsonModel.retData as List<Exam_ObjQuestion>;
                    if (objlist != null && objlist.Count > 0)
                    {
                        jsonModel = new JsonModel()
                        {
                            errNum = 1,
                            errMsg = "新增失败,已存在该试题！！",
                            retData = ""
                        };
                        return;
                    }
                    Exam_ObjQuestion item = new Exam_ObjQuestion();
                    item.Content = Content.Trim();
                    item.Type = int.Parse(typeid);
                    item.OptionA = OptionA;
                    item.OptionB = OptionB;
                    item.OptionC = OptionC;
                    item.OptionD = OptionD;
                    item.OptionE = OptionE;
                    item.OptionF = OptionF;
                    if (!string.IsNullOrEmpty(Subject))
                    {
                        item.Catagory = !string.IsNullOrEmpty(context.Request["Book"]) && !context.Request["Book"].Equals("0") && !Subject.Equals("0") ? (Subject + "|" + context.Request["Book"]) : Subject;
                        item.Klpoint = !string.IsNullOrEmpty(Point) && !Point.Equals("0") ? int.Parse(Point) : int.Parse(Chapter);
                    }
                    item.Answer = answer;
                    item.Difficulty = int.Parse(difficulty);
                    item.Analysis = Analysis;
                    item.Status = int.Parse(Status);
                    item.CreateUID = CreateUID;//需要改
                    item.Score = Convert.ToInt32(Score);//需要改
                    item.IsShowAnalysis = int.Parse(isshowanalysis);
                    jsonModel = objqservice.Add(item);
                }
                else
                {
                    LogService.WriteErrorLog("0|新增失败(参数不正确)！");
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "新增失败(参数不正确)！",
                        retData = ""
                    };
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_AddExamQuestion_新增试题||||" + ex.Message);
                jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "新增失败！",
                    retData = ""
                };
            }
        }
        #endregion
        #endregion

        #region 获取主观试题
        #region 获取主观试题
        /// <summary>
        /// 获取主观试题
        /// </summary>
        /// <param name="context"></param>
        private void GetExamSubQList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("MajorId", context.Request["MajorID"] ?? "");
                ht.Add("KlpointID", context.Request["KlpointID"] ?? "");
                ht.Add("Type", context.Request["Type"].SafeToString().Equals("0") || context.Request["Type"].SafeToString().Equals("") ? "" : context.Request["Type"].SafeToString());
                ht.Add("Title", context.Request["Title"] ?? "");
                ht.Add("ID", context.Request["ID"] ?? "");
                //简单、单选、多选、判断题
                ht.Add("QTypeName", context.Request["QTypeName"] ?? "");


                bool ispage = true;
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["IsPage"]))
                {
                    ispage = false;
                }
                ht.Add("Difficult", context.Request["Difficult"].SafeToString().Equals("0") || context.Request["Difficult"].SafeToString().Equals("") ? "" : context.Request["Difficult"].SafeToString());
                ht.Add("Status", context.Request["Status"]);
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                jsonModel = common.AddCreateNameForData(subqservice.GetPage(ht, ispage), ispage);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }
        #endregion
        #region 获取客观试题
        /// <summary>
        /// 获取客观试题
        /// </summary>
        /// <param name="context"></p
        private void GetExamObjQList(HttpContext context)
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("MajorId", context.Request["MajorID"] ?? "");
                ht.Add("KlpointID", context.Request["KlpointID"] ?? "");
                ht.Add("Type", context.Request["Type"].SafeToString().Equals("0") || context.Request["Type"].SafeToString().Equals("") ? "" : context.Request["Type"].SafeToString());
                ht.Add("Title", context.Request["Title"] ?? "");
                ht.Add("ID", context.Request["ID"] ?? "");
                //简单、单选、多选、判断题
                ht.Add("QTypeName", context.Request["QTypeName"] ?? "");
                bool ispage = true;
                if (!string.IsNullOrEmpty(HttpContext.Current.Request["IsPage"]))
                {
                    ispage = false;
                }
                ht.Add("Difficult", context.Request["Difficult"].SafeToString().Equals("0") || context.Request["Difficult"].SafeToString().Equals("") ? "" : context.Request["Difficult"].SafeToString());
                ht.Add("Status", context.Request["Status"]);
                ht.Add("PageIndex", context.Request["PageIndex"].SafeToString());
                ht.Add("PageSize", context.Request["PageSize"].SafeToString());
                jsonModel = common.AddCreateNameForData(objqservice.GetPage(ht, ispage), ispage);
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog(ex.Message);
            }
        }

        #endregion
        #endregion

        #region 修改启用或禁用状态
        /// <summary>
        /// 修改启用或禁用状态
        /// </summary>
        private void ChangeQuestionStatus(HttpContext context)
        {
            try
            {
                string status = context.Request["Status"].SafeToString();
                string qtype = context.Request["Qtype"].SafeToString();
                string quesID = context.Request["QuesID"].SafeToString();
                if (!string.IsNullOrEmpty(status) && !string.IsNullOrEmpty(quesID))
                {
                    if (qtype.Equals("2"))
                    {
                        Exam_SubQuestion subquestion = (Exam_SubQuestion)(subqservice.GetEntityById(Convert.ToInt32(quesID)).retData);
                        subquestion.Status = Convert.ToInt32(status);
                        jsonModel = subqservice.Update(subquestion);

                    }
                    else
                    {
                        Exam_ObjQuestion objquestion = objqservice.GetEntityById(Convert.ToInt32(quesID)).retData as Exam_ObjQuestion;
                        objquestion.Status = Convert.ToInt32(status);
                        jsonModel = objqservice.Update(objquestion);
                    }
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 1,
                        errMsg = "修改失败！",
                        retData = ""
                    };
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_ExamQManager_试题管理修改试题状态|||" + ex.Message);
                jsonModel = new JsonModel()
                {
                    errNum = 1,
                    errMsg = "修改失败！",
                    retData = ""
                };
            }
        }
        /// <summary>
        /// 编辑试题
        /// </summary>
        private void EditExamQuestion(HttpContext context)
        {
            try
            {
                //获取参数
                string type = context.Request["Type"] == null ? "0" : context.Request["Type"].SafeToString();
                string QID = context.Request["QID"] == null ? "0" : context.Request["QID"].SafeToString();
                string oldtype = context.Request["oldtype"] == null ? "0" : context.Request["oldtype"].SafeToString();
                if (!string.IsNullOrEmpty(QID))
                {
                    int qid = int.Parse(QID);
                    //获取试题类型
                    string Qtype = string.Empty;
                    string Qoldtype = string.Empty;
                    string template = string.Empty;

                    int typeid = int.Parse(type);
                    int oldtypeid = int.Parse(oldtype);
                    Exam_QuestionType typeitem = QustionTypeBll.GetEntityById(typeid).retData as Exam_QuestionType;
                    Exam_QuestionType oldtypeitem = QustionTypeBll.GetEntityById(oldtypeid).retData as Exam_QuestionType;
                    if (typeitem != null)
                    {
                        Qtype = typeitem.QType.SafeToString();
                    }
                    if (oldtypeitem != null)
                    {
                        Qoldtype = oldtypeitem.QType.SafeToString();
                    }

                    //判断1主观/2客观试题
                    if (Qtype.Equals("2"))
                    {
                        //判断是新增还是修改（当前类型是否和修改之前的类型一样）
                        bool one = Qtype.Equals(Qoldtype);
                        if (one)
                        {
                            EditSubjQuestion(qid, type, oldtype, context, "1");
                        }
                        else
                        {
                            EditSubjQuestion(qid, type, oldtype, context, "2");
                        }
                    }
                    else
                    {
                        //判断是新增还是修改（当前类型是否和修改之前的类型一样）
                        bool one = Qtype.Equals(Qoldtype);
                        if (one)
                        {
                            EditObjQuestion(qid, type, template, oldtype, context, "1");
                        }
                        else { EditObjQuestion(qid, type, template, oldtype, context, "2"); }
                    }
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_EditExamQuestion_修改试题|||" + ex.Message);
            }
        }

        #region 修改主客观题
        /// <summary>
        /// 客观题修改
        /// </summary>
        /// <param name="list"></param>
        /// <param name="typeid"></param>
        private void EditObjQuestion(int id, string typeid, string template, string oldtype, HttpContext context, string isupdete)
        {
            //JsonModel resultjson = new JsonModel();
            try
            {
                //获取参数
                string question = context.Request["Question"];
                string answer = context.Request["Answer"];
                string OptionA = context.Request["OptionA"];
                string OptionB = context.Request["OptionB"];
                string OptionC = context.Request["OptionC"];
                string OptionD = context.Request["OptionD"];
                string OptionE = context.Request["OptionE"];
                string OptionF = context.Request["OptionF"];
                string difficulty = context.Request["Difficulty"];
                string Catagory = context.Request["Catagory"];
                string Score = context.Request["Score"];
                string Klpoint = context.Request["Klpoint"].SafeToString();
                string Status = context.Request["Status"];
                string Analysis = context.Request["Analysis"];

                string isshowanalysis = context.Request["isshowanalysis"].SafeToString();
                if (!string.IsNullOrEmpty(question) && !string.IsNullOrEmpty(answer) && (template == "3" || (template != "3" && !string.IsNullOrEmpty(OptionA))) && !string.IsNullOrEmpty(Status) && !string.IsNullOrEmpty(Catagory))
                {
                    string Title = context.Request["Title"];
                    Exam_ObjQuestion item = new Exam_ObjQuestion();
                    if (isupdete == "1")
                    {
                        item = objqservice.GetEntityById(id).retData as Exam_ObjQuestion;//修改题
                    }
                    item.Content = question;
                    item.Type = int.Parse(typeid);
                    item.Difficulty = int.Parse(difficulty);
                    item.Content = question;
                    item.OptionA = OptionA;
                    item.OptionB = OptionB;
                    item.OptionC = OptionC;
                    item.OptionD = OptionD;
                    item.OptionE = OptionE;
                    item.OptionF = OptionF;
                    if (!string.IsNullOrEmpty(Catagory))
                    {
                        item.Catagory = Catagory;
                        item.Klpoint = Klpoint == "" ? 0 : Convert.ToInt32(Klpoint);
                    }
                    else
                    {
                        item.Catagory = "0";
                        item.Klpoint = 0;
                    }

                    item.Answer = answer;
                    item.Score = int.Parse(Score);
                    item.Status = int.Parse(Status);
                    item.Analysis = Analysis;
                    item.IsShowAnalysis = int.Parse(isshowanalysis);
                    if (isupdete == "1")
                    {
                        jsonModel = objqservice.Update(item);//修改题
                    }
                    else
                    {
                        subqservice.Delete(id);//删除原来的题
                        jsonModel = objqservice.Add(item);//新增新的题
                    }
                }
                else
                {
                    jsonModel.errNum = 1;
                    jsonModel.errMsg = "0|保存失败(参数不正确)！";
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_EditExamQuestion_修改试题|||" + ex.Message);
                jsonModel.errNum = 1;
                jsonModel.errMsg = "0|保存失败！";
            }
        }
        /// <summary>
        /// 主观题修改
        /// </summary>
        /// <param name="list"></param>
        /// <param name="typeid"></param>
        private void EditSubjQuestion(int id, string typeid, string oldtype, HttpContext context, string isupdete)
        {
            try
            {
                //获取参数
                string question = context.Request["Question"];
                string canswer = context.Request["CAnswer"];
                string difficulty = context.Request["Difficulty"];
                string Catagory = context.Request["Catagory"];
                string Score = context.Request["Score"];
                string Klpoint = context.Request["Klpoint"].SafeToString();
                string Status = context.Request["Status"];
                string Analysis = context.Request["Analysis"];

                string isshowanalysis = context.Request["isshowanalysis"].SafeToString();
                if (!string.IsNullOrEmpty(question) && !string.IsNullOrEmpty(Status) && !string.IsNullOrEmpty(Catagory))
                {
                    Exam_SubQuestion item = new Exam_SubQuestion();
                    if (isupdete == "1")
                    {
                        item = subqservice.GetEntityById(id).retData as Exam_SubQuestion;//修改题
                    }
                    item.Type = int.Parse(typeid);
                    item.Difficulty = int.Parse(difficulty);
                    item.Content = question;
                    if (!string.IsNullOrEmpty(Catagory))
                    {
                        item.Klpoint = Klpoint == "" ? 0 : Convert.ToInt32(Klpoint);
                        item.Catagory = Catagory;
                    }
                    else
                    {
                        item.Catagory = "0";
                        item.Klpoint = 0;
                    }
                    item.Answer = canswer;
                    item.Score = int.Parse(Score);
                    item.Status = int.Parse(Status);
                    item.Analysis = Analysis;
                    item.IsShowAnalysis = int.Parse(isshowanalysis);

                    if (isupdete == "1")
                    {
                        jsonModel = subqservice.Update(item);//修改题
                    }
                    else
                    {
                        objqservice.Delete(id);//删除原来的题
                        jsonModel = subqservice.Add(item);//新增新的题
                    }
                }
                else
                {
                    jsonModel.errNum = 1;
                    jsonModel.errMsg = "0|保存失败(参数不正确)！";
                }
            }
            catch (Exception ex)
            {

                LogService.WriteErrorLog("ES_wp_EditExamQuestion_修改试题|||" + ex.Message);
                jsonModel.errNum = 1;
                jsonModel.errMsg = "0|保存失败！";
            }
        }
        #endregion

        #endregion

        #region 删除试题
        /// <summary>
        /// 删除试题（主管、客观）
        /// </summary>
        /// <param name="context"></param>
        private void DelQuestion(HttpContext context)
        {
            try
            {
                string DelID = context.Request["DelID"].SafeToString();
                string Qtype = context.Request["Qtype"].SafeToString();
                if (Qtype.Equals("2"))
                {
                    LogService.WriteLog("删除ID为" + DelID + "主观试题");
                    jsonModel = subqservice.Delete(int.Parse(DelID));
                }
                else
                {
                    LogService.WriteLog("删除ID为" + DelID + "客观试题");
                    jsonModel = objqservice.Delete(int.Parse(DelID));
                }
            }
            catch (Exception ex)
            {
                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog("DelQuestion_删除试题|||" + ex.Message);
            }
        }
        #endregion

        #region 获取所有试题（暂未使用
        /*
        private void GetQuestion(HttpContext context)
        {
            try
            {
                string ID = context.Request["ID"].SafeToString();
                string Qtype = context.Request["Qtype"].SafeToString();
                JsonModel model = new JsonModel();
                string[] columns = new string[] { 
                        "ID", "Type", "Typeshow", "Template", "QType", 
                        "Analysis", "IsShowAnalysis", "IsShowAnalysisShow",
                        "Difficulty","DifficultyShow" ,"Status","StatusShow","CreateUID","CreateTime","Klpoint","Catagory","Answer","Score", 
                    "OptionA", "OptionB", "OptionC", "OptionD", "OptionE", "OptionF","Question"};
                DataTable newdt = CreateDataTable(columns);              
               

                DataRow dr = newdt.NewRow();
                if (Qtype.Equals("2"))
                {
                    model = subqservice.GetEntityById(int.Parse(ID));
                    if (model.retData != null)
                    {
                        Exam_SubQuestion subquestion = model.retData as Exam_SubQuestion;
                        dr["Analysis"] = subquestion.Analysis;
                        dr["Answer"] = subquestion.Answer;
                        dr["CreateUID"] = subquestion.CreateUID;
                        dr["Question"] = subquestion.Content;
                        dr["CreateTime"] = subquestion.CreateTime;
                        dr["Difficulty"] = subquestion.Difficulty;
                        dr["ID"] = subquestion.ID;
                        dr["IsShowAnalysis"] = subquestion.IsShowAnalysis;
                        dr["Klpoint"] = subquestion.Klpoint;
                        dr["Score"] = subquestion.Score;
                        dr["Status"] = subquestion.Status;
                        dr["Type"] = subquestion.Type;
                        dr["Catagory"] = subquestion.Catagory;
                    }
                }
                else
                {
                    model = objqservice.GetEntityById(int.Parse(ID));
                    if (model.retData != null)
                    {
                        Exam_ObjQuestion objquestion = model.retData as Exam_ObjQuestion;
                        dr["Analysis"] = objquestion.Analysis;
                        dr["Answer"] = objquestion.Answer;
                        dr["CreateUID"] = objquestion.CreateUID;
                        dr["Question"] = objquestion.Content;
                        dr["CreateTime"] = objquestion.CreateTime;
                        dr["Difficulty"] = objquestion.Difficulty;
                        dr["ID"] = objquestion.ID;
                        dr["IsShowAnalysis"] = objquestion.IsShowAnalysis;
                        dr["Klpoint"] = objquestion.Klpoint;
                        dr["Score"] = objquestion.Score;
                        dr["Status"] = objquestion.Status;
                        dr["Type"] = objquestion.Type;
                        dr["OptionA"] = objquestion.OptionA;
                        dr["OptionB"] = objquestion.OptionB;
                        dr["OptionC"] = objquestion.OptionC;
                        dr["OptionD"] = objquestion.OptionD;
                        dr["OptionE"] = objquestion.OptionE;
                        dr["OptionF"] = objquestion.OptionF;
                        dr["Catagory"] = objquestion.Catagory;
                    }
                }

                if (model.retData != null)
                {

                    int typeid = int.Parse(dr["Type"].SafeToString("0"));
                    JsonModel typemodel = QustionTypeBll.GetEntityById(typeid);
                    dr["QType"] = "2";
                    if (typemodel.retData != null)
                    {
                        Exam_QuestionType typedt = typemodel.retData as Exam_QuestionType;
                        dr["Typeshow"] = typedt.Name;
                        dr["QType"] = typedt.QType;
                    }
                    dr["IsShowAnalysisShow"] = dr["IsShowAnalysis"].SafeToString().Equals("1") ? "显示" : "不显示";
                    dr["StatusShow"] = dr["Status"].SafeToString().Equals("1") ? "启用" : "禁用";
                    dr["DifficultyShow"] = dr["Difficulty"].SafeToString().Equals("1") ? "简单" : dr["Difficulty"].SafeToString().Equals("2") ? "中等" : "困难";
                    newdt.Rows.Add(dr);
                }

                BLLCommon common = new BLLCommon();
                List<Dictionary<string, object>> list = common.DataTableToList(newdt);
                jsonModel = new JsonModel()
                {
                    errNum = model.errNum,
                    retData = list,
                    errMsg = model.errMsg
                };

            }
            catch (Exception ex)
            {

                jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                LogService.WriteErrorLog("GetQuestion_获取试题|||" + ex.Message);
            }
        }*/
        #endregion
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}