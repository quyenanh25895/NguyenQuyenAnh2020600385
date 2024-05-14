package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.CommentModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CommentMapper implements ROWMapper<CommentModel> {

    @Override
    public CommentModel mapRow(ResultSet resultSet) {
        try{
            CommentModel commentModel = new CommentModel();
            commentModel.setId(resultSet.getInt("commentID"));
            commentModel.setContent(resultSet.getString("content"));
            commentModel.setUserID(resultSet.getInt("userID"));
            commentModel.setProductID(resultSet.getInt("productID"));
            commentModel.setStatus(resultSet.getInt("status"));
            commentModel.setCreatedBy(resultSet.getString("createBy"));
            commentModel.setCreatedDate(resultSet.getTimestamp("createdDate"));
            try{
                commentModel.setUserName(resultSet.getString("username"));
                commentModel.setProductName(resultSet.getString("productName"));
            }catch (SQLException e){
                throw new RuntimeException(e);
            }
            if (resultSet.getTimestamp("modifiedDate") != null) {
                commentModel.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
            }
            if (resultSet.getString("modifiedBy") != null) {
                commentModel.setModifiedBy(resultSet.getString("modifiedBy"));
            }
            return commentModel;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
