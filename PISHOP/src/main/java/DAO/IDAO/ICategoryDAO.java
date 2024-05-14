package DAO.IDAO;

import Model.CategoryModel;

import java.util.List;

public interface ICategoryDAO extends IGenericDAO<CategoryModel> {
    List<CategoryModel> findAll();

    Integer save(CategoryModel saveCate);

    CategoryModel findOne(int id);

    void update(CategoryModel updateCate);

    void delete(int id);

    Integer getTotalItem();

    boolean checkExist(String cateName);
}
