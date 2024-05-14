package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.CategoryModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CategoryMapper implements ROWMapper<CategoryModel> {

    @Override
    public CategoryModel mapRow(ResultSet resultSet) {
        try {
            CategoryModel category = new CategoryModel();
            category.setId(resultSet.getInt("cateID"));
            category.setCateName(resultSet.getString("cateName"));
            category.setCateStatus(resultSet.getInt("cateStatus"));

            category.setCreatedDate(resultSet.getTimestamp("createdDate"));
            category.setCreatedBy(resultSet.getString("createBy"));

            if (resultSet.getTimestamp("modifiedDate") != null) {
                category.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
            }
            if (resultSet.getString("modifiedBy") != null) {
                category.setModifiedBy(resultSet.getString("modifiedBy"));
            }
            return category;
        } catch (SQLException e) {
            return null;
        }
    }
}
