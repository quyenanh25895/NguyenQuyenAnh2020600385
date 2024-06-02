package Service;

import DAO.IDAO.IProductInformationDAO;
import Model.ProductInformationModel;
import Service.IService.IProductInformationService;

import javax.inject.Inject;
import java.util.List;

public class ProductInformationService implements IProductInformationService {

    @Inject
    IProductInformationDAO productInformationDAO;

    @Override
    public List<ProductInformationModel> findAll() {
        return productInformationDAO.findAll();
    }

    @Override
    public ProductInformationModel findOne(int id) {
        return productInformationDAO.findOne(id);

    }

    @Override
    public Integer save(Integer productID) {
        return productInformationDAO.save(productID);
    }

    @Override
    public void update(ProductInformationModel productInformationModel) {
        productInformationDAO.update(productInformationModel);
    }
}
