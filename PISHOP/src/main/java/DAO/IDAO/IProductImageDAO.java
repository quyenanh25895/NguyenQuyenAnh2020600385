package DAO.IDAO;

import Model.ProductImageModel;

import java.util.List;

public interface IProductImageDAO  extends IGenericDAO<ProductImageModel> {

    List<ProductImageModel> findAll();


}
