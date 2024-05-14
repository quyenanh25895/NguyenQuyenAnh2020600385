package DAO;

import DAO.IDAO.IOrderDAO;
import Mapper.OrderMapper;
import Model.OrderModel;
import paging.IPageble;

import java.util.List;

public class OrderDAO extends AbstractDAO<OrderModel> implements IOrderDAO {
    @Override
    public List<OrderModel> findAll(IPageble pageble) {
        String sql = "select * from orders";
        return query(sql, new OrderMapper());
    }

    @Override
    public Integer save(OrderModel save) {
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO orders ");
        sql.append("(userID, productID, quantity, price, status, cartProductID, ");
        sql.append("createBy, createdDate) ");
        sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        return insert(sql.toString(), save.getUserID(), save.getProductID(),
                save.getQuantity(), save.getPrice(), save.getStatus(), save.getCartProductID(),
                save.getCreatedBy(), save.getCreatedDate());
    }

    @Override
    public OrderModel findOne(int id) {
        String sql = "select * from orders where id = ?";
        List<OrderModel> orders = query(sql, new OrderMapper(), id);
        if (!orders.isEmpty()) {
            return orders.get(0);
        }
        return null;
    }

    @Override
    public void update(OrderModel update) {
        StringBuilder sql = new StringBuilder();
        sql.append("update orders ");
        sql.append("userID = ?, productID = ?, quantity = ?, price = ?, status = ?, cartProductID = ?, ");
        sql.append("createBy = ?, createdDate = ?, modifiedBy = ?, modifiedDate = ? ");
        sql.append("where orderID = ?");
        update(sql.toString(), update.getUserID(), update.getProductID(),
                update.getQuantity(), update.getPrice(), update.getStatus(), update.getCartProductID(),
                update.getCreatedBy(), update.getCreatedDate(), update.getModifiedBy(), update.getModifiedDate());
    }

    @Override
    public void submitOrder(Integer id) {
        String sql = "update orders set status = 1 where cartProductID = ?";
        update(sql, id);
    }

    @Override
    public void backOrder(Integer id) {
        String sql = "update orders set status = 0 where cartProductID = ?";
        update(sql, id);
    }

    @Override
    public void delete(int id) {

    }

    @Override
    public Integer getTotalItem() {
        return 0;
    }
}
