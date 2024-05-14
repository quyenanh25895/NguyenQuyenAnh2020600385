package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.BrandModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BrandMapper implements ROWMapper<BrandModel> {
    @Override
    public BrandModel mapRow(ResultSet resultSet) {
        try {
            BrandModel brandModel = new BrandModel();
            brandModel.setId(resultSet.getInt("brandID"));
            brandModel.setBrandName(resultSet.getString("brandName"));
            brandModel.setStatus(resultSet.getString("brandStatus"));
            return brandModel;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
