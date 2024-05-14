package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.CartProductModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CartProductMapper implements ROWMapper<CartProductModel> {
    @Override
    public CartProductModel mapRow(ResultSet resultSet) {
        try{
            CartProductModel cartProductModel = new CartProductModel();
            cartProductModel.setId(resultSet.getInt("cartproductID"));
            cartProductModel.setCartID(resultSet.getInt("cartID"));
            cartProductModel.setProductID(resultSet.getInt("productID"));
            cartProductModel.setQuantity(resultSet.getInt("quantity"));
            cartProductModel.setPrice(resultSet.getDouble("price"));
            cartProductModel.setColorID(resultSet.getInt("colorID"));
            cartProductModel.setCapacityID(resultSet.getInt("capacityID"));
            cartProductModel.setStatus(resultSet.getInt("status"));
            cartProductModel.setUserID(resultSet.getInt("userID"));
            return cartProductModel;
        }catch (SQLException e){
            return null;
        }
    }
}
