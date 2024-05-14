package Service.IService;

import Model.CartModel;
import Model.UserModel;

import java.util.List;

public interface ICartService {

    List<CartModel> findAll();

    CartModel findByUserID(Integer id);

    Integer save(UserModel userModel);

    CartModel update(CartModel updateCart);

    void delete(Integer[] id);

    int countItem();


}
