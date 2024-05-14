package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.RoleModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class RoleMapper implements ROWMapper<RoleModel>  {
    public RoleModel mapRow(ResultSet resultSet) {
        try {
            RoleModel role = new RoleModel();
            role.setId(resultSet.getInt("roleID"));
            role.setCode(resultSet.getString("roleCode"));
            role.setName(resultSet.getString("roleName"));
            return role;
        } catch (SQLException e) {
            return null;
        }
    }
}
