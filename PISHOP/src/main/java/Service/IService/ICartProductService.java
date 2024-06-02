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

    void submitProductToCart(Integer[] ids, Integer status, Integer cartCode, Integer discount);

    void denyProductFromCart(Integer[] ids);

    void confirmOrder(Integer id);

    void backOrder(Integer id);

    void confirmBackOrder(Integer id);

    Integer countItem();

    Integer countProduct(Integer id);

    void deleteByProductID(Integer[] productID);

    void submitOrder(Integer id);

    List<CartProductModel> vnpayCode(Integer mdh, Integer[] cartID, Integer discount);

    List<CartProductModel> findByCartCode(Integer cartCode);
}
