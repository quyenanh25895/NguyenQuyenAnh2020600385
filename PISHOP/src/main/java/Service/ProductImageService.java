package Service;

import DAO.IDAO.IProductImageDAO;
import Model.ProductImageModel;
import Service.IService.IProductImageService;

import javax.inject.Inject;
import java.util.List;

public class ProductImageService implements IProductImageService {

    @Inject
    private IProductImageDAO productImageDAO;

    @Override
    public List<ProductImageModel> findAll() {
        return productImageDAO.findAll();
    }

    @Override
    public ProductImageModel findById(int id) {
        return null;
    }
}
