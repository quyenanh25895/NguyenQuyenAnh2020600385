package DAO.IDAO;

import Model.BrandModel;

import java.util.List;

public interface IBrandDAO extends IGenericDAO<BrandModel> {
    List<BrandModel> findAll();

    Integer save(BrandModel saveBrand);

    BrandModel findOne(int id);

    void update(BrandModel updateBrand);

    void delete(int id);

    Integer getTotalItem();

    boolean checkExist(String brandName);

}
