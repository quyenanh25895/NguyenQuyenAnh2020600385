package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.OrderModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class OrderMapper implements ROWMapper<OrderModel> {
    @Override
    public OrderModel mapRow(ResultSet resultSet) {

        try {
            OrderModel orderModel = new OrderModel();
            orderModel.setId(resultSet.getInt("orderID"));
            orderModel.setUserID(resultSet.getInt("userID"));
            orderModel.setProductID(resultSet.getInt("productID"));
            orderModel.setQuantity(resultSet.getInt("quantity"));
            orderModel.setPrice(resultSet.getDouble("price"));
            orderModel.setCartProductID(resultSet.getInt("cartProductID"));
            orderModel.setCreatedBy(resultSet.getString("createBy"));
            orderModel.setCreatedDate(resultSet.getTimestamp("createdDate"));
            if (resultSet.getTimestamp("modifiedDate") != null) {
                orderModel.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
            }
            if (resultSet.getString("modifiedBy") != null) {
                orderModel.setModifiedBy(resultSet.getString("modifiedBy"));
            }
            return orderModel;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
