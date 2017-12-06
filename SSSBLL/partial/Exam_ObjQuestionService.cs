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
    public partial class Exam_ObjQuestionService : BaseService<Exam_ObjQuestion>, IExam_ObjQuestionService
    {
        public JsonModel GetdataEQ(Hashtable ht, string where = "")
        {
            Exam_ObjQuestionDal Dal = new Exam_ObjQuestionDal();

            return GetJsonModelByDataTable(Dal.GetList(ht, where));
        }

    }
}
