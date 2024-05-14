package DAO.IDAO;

import Model.RoleModel;

import java.util.List;

public interface IRoleDAO extends IGenericDAO<RoleModel> {

    List<RoleModel> findAll();
    Integer save(RoleModel saveRole);
    RoleModel findOne(int id);
    void update(RoleModel updateRole);
    void delete(int id);
    Integer getTotalItem ();
}
