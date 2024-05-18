package DAO.IDAO;


import Model.CartProductModel;
import Model.ProductModel;
import paging.IPageble;

import java.util.List;

public interface ICartProductDAO extends IGenericDAO<CartProductModel> {

    List<CartProductModel> findAll(IPageble pageble);

    List<CartProductModel> findJoin(IPageble pageble);

    Integer save(CartProductModel saveCartProduct);

    Integer saveProductToCart(Integer cartID, ProductModel productModel);

    CartProductModel findOne(int id);

    void update(CartProductModel updateCartProduct);

    void submitCartProduct(Integer id, Integer status) ;

    void denyCartProduct(Integer id);

    void confirmOrder(Integer id);

    void backOrder(Integer id);

    void confirmBackOrder(Integer id);

    void delete(int id);

    Integer getTotalItem();

    List<CartProductModel> findByCartID(Integer cartID, IPageble pageble);

    void deleteByProductID(Integer productID);

    void submitOrder(Integer id);


}
