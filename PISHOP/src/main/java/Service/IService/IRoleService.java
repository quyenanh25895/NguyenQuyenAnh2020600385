package Service.IService;


import Model.RoleModel;

import java.util.List;

public interface IRoleService {

    List<RoleModel> findAll();
    RoleModel findOne(int id);
    RoleModel save(RoleModel saveRole);
    RoleModel update(RoleModel updateRole);
    void delete(Integer[] id);
    int countItem();

    boolean checkUserExist(String userName);
}
