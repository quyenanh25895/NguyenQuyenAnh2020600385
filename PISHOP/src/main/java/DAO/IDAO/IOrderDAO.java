package DAO.IDAO;

import Model.OrderModel;
import paging.IPageble;

import java.util.List;

public interface IOrderDAO extends IGenericDAO<OrderModel> {

    List<OrderModel> findAll(IPageble pageble);

    Integer save(OrderModel save);

    OrderModel findOne(int id);

    void update(OrderModel update);

    void submitOrder(Integer id);

    void backOrder(Integer id);

    void delete(int id);

    Integer getTotalItem();

}
