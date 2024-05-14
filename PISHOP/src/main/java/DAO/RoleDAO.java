package DAO;

import DAO.IDAO.IRoleDAO;
import Mapper.RoleMapper;
import Model.RoleModel;

import java.util.List;

public class RoleDAO extends AbstractDAO<RoleModel> implements IRoleDAO {

    @Override
    public List<RoleModel> findAll() {
        String sql = "select * from roles";
        return query(sql, new RoleMapper());
    }

    @Override
    public Integer save(RoleModel saveRole) {
        return 0;
    }

    @Override
    public RoleModel findOne(int id) {
        return null;
    }

    @Override
    public void update(RoleModel updateRole) {

    }

    @Override
    public void delete(int id) {

    }

    @Override
    public Integer getTotalItem() {
        return 0;
    }


}
