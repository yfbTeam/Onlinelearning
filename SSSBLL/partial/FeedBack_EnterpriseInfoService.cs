using SSSDAL;
using SSSIBLL;
using SSSModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSBLL
{
    public partial class FeedBack_EnterpriseInfoService : BaseService<FeedBack_EnterpriseInfo>, IFeedBack_EnterpriseInfoService
    {
        FeedBack_EnterpriseInfoDal dal = new FeedBack_EnterpriseInfoDal();
        #region 添加企业
        /// <summary>
        /// 添加企业
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public string AddEnterprise(FeedBack_EnterpriseInfo entity, string Job)
        {
            return dal.AddEnterprise(entity, Job);
        }
        #endregion
    }
}
