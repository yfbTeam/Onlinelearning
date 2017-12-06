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
    public partial class Resources_OpenService : BaseService<Resources_Open>, IResources_OpenService
    {
        public int Del(string ID)
        {
            Resources_OpenDal dal = new Resources_OpenDal();
            return dal.Del(ID);

        }
    }
}
