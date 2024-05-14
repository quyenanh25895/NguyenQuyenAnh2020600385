package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.ProductImageModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductImageMapper implements ROWMapper<ProductImageModel> {
    @Override
    public ProductImageModel mapRow(ResultSet resultSet) {
        try{
            ProductImageModel productImageModel = new ProductImageModel();
            productImageModel.setId(resultSet.getInt("proimgID"));
            productImageModel.setProductID(resultSet.getInt("productID"));
            productImageModel.setImageID(resultSet.getInt("imageID"));
            return productImageModel;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
