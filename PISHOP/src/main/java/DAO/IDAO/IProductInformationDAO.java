package DAO.IDAO;

import Model.ProductInformationModel;

import java.util.List;

public interface IProductInformationDAO extends IGenericDAO<ProductInformationModel> {

    List<ProductInformationModel> findAll();

    ProductInformationModel findOne(int id);

    Integer save(Integer productID);

    void update(ProductInformationModel productInformationModel);
}
