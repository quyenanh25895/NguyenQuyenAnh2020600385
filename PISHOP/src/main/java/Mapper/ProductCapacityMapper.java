package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.ProductCapacityModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductCapacityMapper implements ROWMapper<ProductCapacityModel> {
    @Override
    public ProductCapacityModel mapRow(ResultSet resultSet) {
        try {
            ProductCapacityModel productCapacityModel = new ProductCapacityModel();
            productCapacityModel.setId(resultSet.getInt("procapID"));
            productCapacityModel.setProductID(resultSet.getInt("productID"));
            productCapacityModel.setCapacityID(resultSet.getInt("capacityID"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}
