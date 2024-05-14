package Service.IService;

import Model.ImageModel;
import Model.ProductModel;
import Model.UserModel;

import java.util.List;

public interface IImageService {
    List<ImageModel> findAll();

    List<ImageModel> findByProductId(int id);

    void save(ProductModel productModel, UserModel userModel);

    void update(ProductModel productModel, UserModel userModel);

    void delete(Integer id);
}
