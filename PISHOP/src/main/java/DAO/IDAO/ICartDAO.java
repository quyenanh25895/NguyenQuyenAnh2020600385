package DAO.IDAO;

import Model.CartModel;
import Model.UserModel;

import java.util.List;

public interface ICartDAO extends IGenericDAO<CartModel> {

    List<CartModel> findAll();

    Integer save(UserModel user);

    CartModel findOne(int id);

    void update(CartModel updateCart);

    void delete(int id);

    Integer getTotalItem();

//    boolean checkProductColor(Integer productId, Integer colorId);

    CartModel findByUserID(Integer userID);

}
