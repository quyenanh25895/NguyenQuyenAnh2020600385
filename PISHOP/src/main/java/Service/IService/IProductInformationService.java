package Service.IService;

import Model.ProductInformationModel;

import java.util.List;

public interface IProductInformationService {

    List<ProductInformationModel> findAll();

    ProductInformationModel findOne(int id);

    Integer save(Integer productID);

    void update(ProductInformationModel productInformationModel);
}
