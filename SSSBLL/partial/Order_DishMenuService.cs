using SSSDAL;
using SSSIBLL;
using SSSModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SSSBLL
{
    public partial class Order_DishMenuService : BaseService<Order_DishMenu>, IOrder_DishMenuService
    {
        Order_DishMenuDal dal = new Order_DishMenuDal();
        public string OrderMenuAdd(string useDate, string ScaleID, string DishIDArry)
        {
            return dal.OrderMenuAdd(useDate, ScaleID, DishIDArry);
        }
    }
}
