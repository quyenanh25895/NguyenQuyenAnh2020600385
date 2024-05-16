package Service.IService;

import Model.UserModel;
import paging.IPageble;

import java.util.List;

public interface IUserService {
    UserModel findByUserNameAndPasswordAndStatus(String userName, String password);

    UserModel findByUserNameAndEmail(String userName, String email);

    List<UserModel> findAll(IPageble pageble);

    UserModel findOne(int id);

    UserModel save(UserModel saveUser, IPageble pageble, UserModel user);

    UserModel update(UserModel updateUser, UserModel user);

    void delete(Integer[] id);

    void disableUser(Integer id);

    void enableUser(Integer id);

    int countItem();

    boolean checkUserExist(String userName);

    Integer saveCode(UserModel user, String code);

    boolean checkCode(String email);


}
