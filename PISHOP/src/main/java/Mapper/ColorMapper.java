package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.ColorModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ColorMapper implements ROWMapper<ColorModel> {
    @Override
    public ColorModel mapRow(ResultSet resultSet) {

        try {
            ColorModel color = new ColorModel();
            color.setId(resultSet.getInt("colorID"));
            color.setColorCode(resultSet.getString("colorCode"));
            return color;
        } catch (SQLException e) {
            return null;
        }
    }
}
