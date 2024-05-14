package Service.IService;

import Model.ProductImageModel;

import java.util.List;

public interface IProductImageService {

    List<ProductImageModel> findAll();

    ProductImageModel findById(int id);
}
