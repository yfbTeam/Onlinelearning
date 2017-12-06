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
    public partial class Exam_SubQuestionService : BaseService<Exam_SubQuestion>, IExam_SubQuestionService
    {
        public JsonModel GetdataES(Hashtable ht, string where = "")
        {
            Exam_SubQuestionDal Dal = new Exam_SubQuestionDal();
            return GetJsonModelByDataTable(Dal.GetList(ht, where));
        }
        public DataTable GetQRadom(string TableName, string QType, string Count)
        {
            Exam_SubQuestionDal Dal = new Exam_SubQuestionDal();
            return Dal.GetQRadom(TableName, QType, Count);
        }
    }
}
