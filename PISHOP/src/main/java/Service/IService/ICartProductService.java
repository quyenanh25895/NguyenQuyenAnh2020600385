package Service.IService;

import Model.CartProductModel;
import Model.ProductModel;
import paging.IPageble;

import java.util.List;

public interface ICartProductService {

    List<CartProductModel> findAll(IPageble pageble);

    List<CartProductModel> findJoin(IPageble pageble);

    List<CartProductModel> findByCartId(Integer cartId, IPageble pageble);

    List<CartProductModel> findByCartProductID(Integer[] productId, IPageble pageble);

    List<ProductModel> findProductByCartId(Integer cartId);

    void saveProductToCart(Integer id, ProductModel productModel);

    void deleteProductFromCart(Integer[] id);

    void submitProductToCart(Integer[] ids, Integer status, Integer cartCode);

    void denyProductFromCart(Integer[] ids);

    void confirmOrder(Integer id);

    void backOrder(Integer id);

    void confirmBackOrder(Integer id);

    Integer countItem();

    void deleteByProductID(Integer[] productID);

    void submitOrder(Integer id);

    void vnpayCode(Integer mdh, Integer[] cartID);

    List<CartProductModel> findByCartCode(Integer cartCode);
}
