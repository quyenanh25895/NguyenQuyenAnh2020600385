package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.ProductModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductMapper implements ROWMapper<ProductModel> {


    @Override
    public ProductModel mapRow(ResultSet resultSet) {
        try {
            ProductModel product = new ProductModel();
            product.setId(resultSet.getInt("productID"));
            product.setName(resultSet.getString("productName"));
            product.setPrice(resultSet.getLong("productPrice"));
            product.setQuantity(resultSet.getInt("productQuantity"));
            product.setBrandID(resultSet.getInt("brandID"));
            product.setCateID(resultSet.getInt("cateID"));
            product.setDescription(resultSet.getString("productDescription"));
            product.setStatus(resultSet.getInt("productStatus"));
            product.setCreatedDate(resultSet.getTimestamp("createdDate"));
            try {
                product.setBrandName(resultSet.getString("brandName"));
                product.setCateName(resultSet.getString("cateName"));
            }catch (SQLException e){
                throw new SQLException(e.getMessage());
            }



            product.setCreatedBy(resultSet.getString("createBy"));
            if (resultSet.getTimestamp("modifiedDate") != null) {
                product.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
            }
            if (resultSet.getString("modifiedBy") != null) {
                product.setModifiedBy(resultSet.getString("modifiedBy"));
            }


            return product;
        } catch (SQLException e) {
            return null;
        }
    }
}
