package Service.IService;

import Model.OrderModel;
import Model.StaticalModel;
import Model.UserModel;
import paging.PageRequest;

import java.util.List;

public interface IOrderService {

    List<OrderModel> findAll();

    OrderModel findByUserID(Integer id);

    Integer save(OrderModel save, UserModel user);

    void update(OrderModel update, UserModel user);

    void delete(Integer[] id);

    void submitOrder(Integer id);

    void backOrder(Integer id);

    int countItem();


}
