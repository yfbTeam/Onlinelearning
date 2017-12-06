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
    public partial class Order_UserOrderService : BaseService<Order_UserOrder>, IOrder_UserOrderService
    {
        Order_UserOrderDal dal = new Order_UserOrderDal();
        public int SureOrder(string CreateUID)
        {
            return dal.SureOrder(CreateUID);
        }
    }
}
