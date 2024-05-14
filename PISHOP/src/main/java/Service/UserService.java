package Service;

import DAO.IDAO.IUserDAO;
import Model.UserModel;
import Service.IService.IUserService;
import paging.IPageble;

import javax.inject.Inject;
import java.sql.Timestamp;
import java.util.List;

public class UserService implements IUserService {
    @Inject
    private IUserDAO userDAO;

    @Override
    public UserModel findByUserNameAndPasswordAndStatus(String userName, String password) {
        return userDAO.findByUserNameAndPasswordAndStatus(userName, password);
    }

    @Override
    public List<UserModel> findAll(IPageble pageble) {
        return userDAO.findAll(pageble);
    }

    @Override
    public UserModel findOne(int id) {
        return userDAO.findOne(id);
    }

    @Override
    public UserModel save(UserModel saveUser, IPageble pageble, UserModel user) {

        if (userDAO.checkUserExist(saveUser.getUserName())) {
            saveUser.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            saveUser.setCreatedBy(user.getUserName());
            int userID = userDAO.save(saveUser);
            return userDAO.findOne(userID);
        } else {
            return null;
        }
    }

    @Override
    public UserModel update(UserModel updateUser, UserModel user) {
        UserModel oldUser = userDAO.findOne(updateUser.getId());
        updateUser.setCreatedDate(oldUser.getCreatedDate());
        updateUser.setCreatedBy(oldUser.getCreatedBy());
        updateUser.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        updateUser.setModifiedBy(user.getUserName());
        userDAO.update(updateUser);
        return userDAO.findOne(updateUser.getId());
    }

    @Override
    public void delete(Integer[] ids) {
        for (int id : ids) {
            userDAO.delete(id);
        }
    }

    @Override
    public void disableUser(Integer id) {
        userDAO.disableUser(id);
    }

    @Override
    public void enableUser(Integer id) {
        userDAO.enableUser(id);
    }

    @Override
    public int countItem() {
        return userDAO.countItem();
    }

    @Override
    public boolean checkUserExist(String userName) {
        return userDAO.checkUserExist(userName);
    }
}

