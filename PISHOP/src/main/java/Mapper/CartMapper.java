package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.CartModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CartMapper implements ROWMapper<CartModel> {
    @Override
    public CartModel mapRow(ResultSet resultSet) {
        try{
            CartModel cartModel = new CartModel();
            cartModel.setId(resultSet.getInt("cartID"));
            cartModel.setUserID(resultSet.getInt("userID"));
            cartModel.setCreatedDate(resultSet.getTimestamp("createdDate"));
            cartModel.setCreatedBy(resultSet.getString("createBy"));
            if (resultSet.getTimestamp("modifiedDate") != null) {
                cartModel.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
            }
            if (resultSet.getString("modifiedBy") != null) {
                cartModel.setModifiedBy(resultSet.getString("modifiedBy"));
            }
            return cartModel;
        }catch (SQLException e){
            return null;
        }


    }
}
