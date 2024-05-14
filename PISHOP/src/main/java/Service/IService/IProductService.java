package Service.IService;

import Model.ProductModel;
import Model.UserModel;
import paging.IPageble;

import java.util.List;

public interface IProductService {

    List<ProductModel> findAll(IPageble pageble);

    ProductModel save(ProductModel product, IPageble pageble, UserModel user);

    ProductModel findOne(int id);

    List<ProductModel> findByCateIDAndBrandID(IPageble pageble, List<Integer> cateID, List<Integer> brandID);

    Integer getTotalItem();

    ProductModel update(ProductModel updateProduct, UserModel user);

    void delete(Integer[] id);

    void disableProduct(Integer id);

    void enableProduct(Integer id);

    int countItem();

//    boolean checkUserExist(String userName);
}
