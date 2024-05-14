package DAO.IDAO;

import Model.ImageModel;

import java.util.List;

public interface IImageDAO extends IGenericDAO<ImageModel> {

    List<ImageModel> findAll();

    ImageModel findById(int id);

    List<ImageModel> findByProductID(Integer productID);

    Integer save(ImageModel image);

    void update(ImageModel image);

    void delete(int id);

}
