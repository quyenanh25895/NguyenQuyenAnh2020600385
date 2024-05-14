package Service;

import DAO.IDAO.IOrderDAO;
import Model.OrderModel;
import Model.UserModel;
import Service.IService.IOrderService;
import paging.PageRequest;

import javax.inject.Inject;
import java.sql.Timestamp;
import java.util.List;

public class OrderService implements IOrderService {

    @Inject
    private IOrderDAO orderDAO;

    @Override
    public List<OrderModel> findAll() {
        return orderDAO.findAll(new PageRequest());
    }

    @Override
    public OrderModel findByUserID(Integer id) {
        return null;
    }

    @Override
    public Integer save(OrderModel save, UserModel user) {
        save.setCreatedBy(user.getUserName());
        save.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        save.setModifiedBy(user.getUserName());
        save.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        return orderDAO.save(save);
    }

    @Override
    public void update(OrderModel update, UserModel user) {
        OrderModel oldOrder = orderDAO.findOne(update.getId());
        update.setCreatedBy(oldOrder.getCreatedBy());
        update.setCreatedDate(oldOrder.getCreatedDate());
        update.setModifiedBy(user.getUserName());
        update.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        orderDAO.update(update);
    }

    @Override
    public void delete(Integer[] id) {

    }

    @Override
    public void submitOrder(Integer id) {
        orderDAO.submitOrder(id);
    }

    @Override
    public void backOrder(Integer id) {
        orderDAO.backOrder(id);
    }

    @Override
    public int countItem() {
        return 0;
    }
}
