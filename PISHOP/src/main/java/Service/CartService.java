package Service;

import DAO.IDAO.ICartDAO;
import Model.CartModel;
import Model.CartProductModel;
import Model.UserModel;
import Service.IService.ICartService;
import paging.IPageble;

import javax.inject.Inject;
import java.util.List;

public class CartService implements ICartService {

    @Inject
    private ICartDAO cartDAO;

    @Override
    public List<CartModel> findAll() {
        return cartDAO.findAll();
    }



    @Override
    public CartModel findByUserID(Integer id) {
        return cartDAO.findByUserID(id);
    }

    @Override
    public Integer save(UserModel userModel) {
        return cartDAO.save(userModel);
    }

    @Override
    public CartModel update(CartModel updateCart) {
        return null;
    }

    @Override
    public void delete(Integer[] id) {

    }

    @Override
    public int countItem() {
        return 0;
    }
}
