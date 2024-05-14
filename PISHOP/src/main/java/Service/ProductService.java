package Service;

import DAO.IDAO.IProductDAO;
import Model.ProductModel;
import Model.UserModel;
import Service.IService.IProductService;
import paging.IPageble;

import javax.inject.Inject;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ProductService implements IProductService {

    @Inject
    private IProductDAO productDAO;

    @Override
    public List<ProductModel> findAll(IPageble pageble) {
        return productDAO.findAll(pageble);
    }

    @Override
    public ProductModel save(ProductModel product, IPageble pageble, UserModel user) {
        product.setCreatedBy(user.getUserName());
        product.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        product.setModifiedBy(user.getUserName());
        product.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        int productID = productDAO.save(product);
        return productDAO.findOne(productID);
    }

    @Override
    public ProductModel findOne(int id) {
        return productDAO.findOne(id);
    }

    @Override
    public List<ProductModel> findByCateIDAndBrandID(IPageble pageble, List<Integer> cateID, List<Integer> brandID) {
        List<ProductModel> productModels = new ArrayList<>();
        if (!cateID.isEmpty() && !brandID.isEmpty()) {
            for (Integer cate : cateID) {
                for (Integer brand : brandID) {
                    List<ProductModel> p = productDAO.findByCateIDAndBrandID(pageble, cate, brand);
                    productModels.addAll(p);
                }
            }
        }
        if (!cateID.isEmpty() && brandID.isEmpty()) {
            for (Integer cate : cateID) {
                List<ProductModel> p = productDAO.findByCateIDAndBrandID(pageble, cate, null);
                productModels.addAll(p);
            }
        }
        if (cateID.isEmpty() && !brandID.isEmpty()) {

            for (Integer brand : brandID) {
                List<ProductModel> p = productDAO.findByCateIDAndBrandID(pageble, null, brand);
                productModels.addAll(p);
            }

        }
        return productModels;
    }

    @Override
    public Integer getTotalItem() {
        return productDAO.getTotalItem();
    }

    @Override
    public ProductModel update(ProductModel updateProduct, UserModel user) {
        ProductModel oldProduct = productDAO.findOne(updateProduct.getId());
        updateProduct.setCreatedBy(oldProduct.getCreatedBy());
        updateProduct.setCreatedDate(oldProduct.getCreatedDate());
        updateProduct.setModifiedBy(user.getUserName());
        updateProduct.setModifiedDate(new Timestamp(System.currentTimeMillis()));
        productDAO.update(updateProduct);
        return productDAO.findOne(updateProduct.getId());
    }

    @Override
    public void delete(Integer[] id) {
        for (Integer i : id) {
            productDAO.delete(i);
        }
    }

    @Override
    public void disableProduct(Integer id) {
        productDAO.disableProduct(id);
    }

    @Override
    public void enableProduct(Integer id) {
        productDAO.enableProduct(id);
    }

    @Override
    public int countItem() {
        return productDAO.getTotalItem();
    }

}
