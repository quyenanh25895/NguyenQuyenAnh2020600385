package Service.IService;

import Model.CategoryModel;

import java.util.List;

public interface ICategoryService {
    List<CategoryModel> findAll();

    CategoryModel findOne(int id);

    List<CategoryModel> findByCateID(List<Integer> cateID);

    Integer save(CategoryModel saveCate);

    void update(CategoryModel updateCate);

    void delete(Integer[] id);

    int countItem();

    boolean checkExist(String cateName);
}
