package DAO.IDAO;

import Model.UserModel;
import paging.IPageble;

import java.util.List;

public interface IUserDAO extends IGenericDAO<UserModel> {

    List<UserModel> findAll(IPageble pageble);

    UserModel findByUserNameAndPasswordAndStatus(String userName, String password);

    UserModel findOne(int id);

    Integer save(UserModel saveUser);

    void update(UserModel updateUser);

    void delete(int id);

    void disableUser(Integer id);

    void enableUser(Integer id);

    Integer countItem();

    boolean checkUserExist(String userName);
}
