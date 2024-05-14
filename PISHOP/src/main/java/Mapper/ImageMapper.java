package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.ImageModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ImageMapper implements ROWMapper<ImageModel> {

    @Override
    public ImageModel mapRow(ResultSet resultSet) {
        try{
            ImageModel imageModel = new ImageModel();
            imageModel.setId(resultSet.getInt("ImageID"));
            imageModel.setImageLink(resultSet.getString("ImageLink"));
            imageModel.setProductName(resultSet.getString("ProductName"));
            imageModel.setProductID(resultSet.getInt("ProductID"));
            imageModel.setCreatedBy(resultSet.getString("createBy"));
            imageModel.setCreatedDate(resultSet.getTimestamp("createdDate"));

            if (resultSet.getTimestamp("modifiedDate") != null) {
                imageModel.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
            }
            if (resultSet.getString("modifiedBy") != null) {
                imageModel.setModifiedBy(resultSet.getString("modifiedBy"));
            }

            return imageModel;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
