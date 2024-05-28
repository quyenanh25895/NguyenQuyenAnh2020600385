package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.ProductInformationModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductInformationMapper implements ROWMapper<ProductInformationModel> {
    @Override
    public ProductInformationModel mapRow(ResultSet resultSet) {
        try {
            ProductInformationModel productInfomationModel = new ProductInformationModel();
            productInfomationModel.setId(resultSet.getInt("infoID"));
            productInfomationModel.setProductID(resultSet.getInt("productID"));
            productInfomationModel.setTimeManufacture(resultSet.getInt("timeManufacture"));
            productInfomationModel.setCountry(resultSet.getString("country"));

            if (hasColumn(resultSet, "pinValue")) {
                int pinValue = resultSet.getInt("pinValue");
                productInfomationModel.setPinValue(pinValue != 0 ? pinValue : 0);
            }

            if (hasColumn(resultSet, "display")) {
                long display = resultSet.getLong("display");
                productInfomationModel.setDisplay(display != 0 ? display : 0L);
            }

            if (hasColumn(resultSet, "resolution")) {
                productInfomationModel.setResolution(resultSet.getString("resolution"));
            }

            if (hasColumn(resultSet, "chipset")) {
                productInfomationModel.setChipset(resultSet.getString("chipset"));
            }

            return productInfomationModel;
        } catch (SQLException e) {
            return null;
        }
    }

    private boolean hasColumn(ResultSet resultSet, String columnName) throws SQLException {
        try {
            resultSet.findColumn(columnName);
            return true;
        } catch (SQLException e) {
            return false;
        }
    }
}
