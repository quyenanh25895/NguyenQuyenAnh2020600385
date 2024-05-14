package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.ProductColorModel;

import java.sql.ResultSet;

public class ProductColorMapper implements ROWMapper<ProductColorModel> {
    @Override
    public ProductColorModel mapRow(ResultSet resultSet) {

        try{
            ProductColorModel productColorModel = new ProductColorModel();
            productColorModel.setId(resultSet.getInt("procolorID"));
            productColorModel.setProductID(resultSet.getInt("productID"));
            productColorModel.setColorID(resultSet.getInt("colorID"));
            return productColorModel;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
