package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.StaticalModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class StaticalMapper implements ROWMapper<StaticalModel> {

    @Override
    public StaticalModel mapRow(ResultSet resultSet) {
        try {
            StaticalModel stat = new StaticalModel();

            // Kiểm tra từng cột và gán giá trị nếu tìm thấy
            if (columnExists(resultSet, "createdDate")) {
                stat.setCreatedDate(resultSet.getTimestamp("createdDate"));
            }
            if (columnExists(resultSet, "quantity")) {
                stat.setQuantity(resultSet.getInt("quantity"));
            }
            if (columnExists(resultSet, "price")) {
                stat.setPrice(resultSet.getLong("price"));
            }
            if (columnExists(resultSet, "cateID")) {
                stat.setCateID(resultSet.getInt("cateID"));
            }
            if (columnExists(resultSet, "brandID")) {
                stat.setBrandID(resultSet.getInt("brandID"));
            }
            if (columnExists(resultSet, "productID")) {
                stat.setProductID(resultSet.getInt("productID"));
            }
            if (columnExists(resultSet, "productName")) {
                stat.setProductName(resultSet.getString("productName"));
            }
            if (columnExists(resultSet, "userID")) {
                stat.setUserID(resultSet.getInt("userID"));
            }
            if (columnExists(resultSet, "userName")) {
                stat.setUserName(resultSet.getString("userName"));
            }
            return stat;
        } catch (SQLException e) {
            return null; // Xử lý lỗi nếu có
        }
    }

    // Phương thức để kiểm tra xem một cột có tồn tại trong ResultSet không
    private boolean columnExists(ResultSet resultSet, String columnName) throws SQLException {
        try {
            resultSet.findColumn(columnName); // Thử tìm cột trong ResultSet
            return true; // Trả về true nếu tìm thấy
        } catch (SQLException e) {
            return false; // Trả về false nếu không tìm thấy hoặc xảy ra lỗi
        }
    }

}
