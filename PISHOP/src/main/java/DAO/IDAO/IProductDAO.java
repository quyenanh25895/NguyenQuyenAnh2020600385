package DAO.IDAO;

import Model.ProductModel;
import paging.IPageble;

import java.util.List;

public interface IProductDAO extends IGenericDAO<ProductModel> {

    List<ProductModel> findAll(IPageble pageble);

    Integer save(ProductModel saveProduct);

    ProductModel findOne(int id);

    void update(ProductModel updateProduct);

    void delete(int id);

    void disableProduct(Integer id);

    void enableProduct(Integer id);

    Integer getTotalItem();

    boolean checkProductExist(String userName);

    List<ProductModel> findByCateIDAndBrandID(IPageble pageble, Integer cateID, Integer brandID);
}
