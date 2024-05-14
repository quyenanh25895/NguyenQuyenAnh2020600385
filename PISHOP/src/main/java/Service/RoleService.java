package Service;

import DAO.IDAO.IRoleDAO;
import DAO.RoleDAO;
import Model.RoleModel;
import Service.IService.IRoleService;

import javax.inject.Inject;
import java.util.List;

public class RoleService implements IRoleService {


    @Inject
    private IRoleDAO roleDAO;


    @Override
    public List<RoleModel> findAll() {
        return roleDAO.findAll();
    }

    @Override
    public RoleModel findOne(int id) {
        return null;
    }

    @Override
    public RoleModel save(RoleModel saveRole) {
        return null;
    }

    @Override
    public RoleModel update(RoleModel updateRole) {
        return null;
    }

    @Override
    public void delete(Integer[] id) {

    }

    @Override
    public int countItem() {
        return 0;
    }

    @Override
    public boolean checkUserExist(String userName) {
        return false;
    }

    public static void main(String[] args) {
        IRoleDAO roleDAO = new RoleDAO();
        List<RoleModel> roles = roleDAO.findAll();
        for (RoleModel role : roles) {
            System.out.println(role.getId() + " " + role.getName() + " " + role.getCode());
        }
    }
}
