package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.UserModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserMapper implements ROWMapper<UserModel> {
    @Override
    public UserModel mapRow(ResultSet resultSet) {
        try {
            UserModel user = new UserModel();
            user.setId(resultSet.getInt("userID"));
            user.setFullName(resultSet.getString("userFullname"));
            user.setEmail(resultSet.getString("email"));
            user.setPhoneNumber(resultSet.getString("userPhonenumer"));
            user.setAddress(resultSet.getString("userAddress"));
            user.setGender(resultSet.getInt("userGender"));
            user.setUserName(resultSet.getString("username"));
            user.setPassword(resultSet.getString("password"));
            user.setRoleId(resultSet.getInt("roleID"));
            user.setStatus(resultSet.getInt("status"));
            user.setCreatedBy(resultSet.getString("createBy"));
            user.setCreatedDate(resultSet.getTimestamp("createdDate"));
            try {
                user.setRoleName(resultSet.getString("roleName"));
            } catch (Exception e) {
                System.out.print(e.getMessage());
            }
            if (resultSet.getTimestamp("modifiedDate") != null) {
                user.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
            }
            if (resultSet.getString("modifiedBy") != null) {
                user.setModifiedBy(resultSet.getString("modifiedBy"));
            }
            return user;
        } catch (SQLException e) {
            return null;
        }
    }
}
