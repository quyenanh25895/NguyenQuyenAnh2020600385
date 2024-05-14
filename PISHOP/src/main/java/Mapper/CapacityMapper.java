package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.CapacityModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CapacityMapper implements ROWMapper<CapacityModel> {
    @Override
    public CapacityModel mapRow(ResultSet resultSet) {
        try {
            CapacityModel capacityModel = new CapacityModel();
            capacityModel.setId(resultSet.getInt("capacityID"));
            capacityModel.setCapacityValue(resultSet.getLong("capacityValue"));
            return capacityModel;
        }catch (SQLException e) {
            return null;
        }
    }

}
