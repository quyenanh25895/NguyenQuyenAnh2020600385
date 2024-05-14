package Service;

import DAO.CategoryDAO;
import DAO.IDAO.ICategoryDAO;
import Model.CategoryModel;
import Service.IService.ICategoryService;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.List;

public class CategoryService implements ICategoryService {

    @Inject
    private ICategoryDAO categoryDAO;

    @Override
    public List<CategoryModel> findAll() {
        return categoryDAO.findAll();
    }

    @Override
    public CategoryModel findOne(int id) {
        return categoryDAO.findOne(id);
    }

    @Override
    public List<CategoryModel> findByCateID(List<Integer> cateID) {
        List<CategoryModel> categoryModels = new ArrayList<>();
        for (Integer id : cateID) {
            categoryModels.add(categoryDAO.findOne(id));
        }
        return categoryModels;
    }

    @Override
    public Integer save(CategoryModel saveCate) {
        return categoryDAO.save(saveCate);
    }

    @Override
    public void update(CategoryModel updateCate) {
        categoryDAO.update(updateCate);
    }

    @Override
    public void delete(Integer[] id) {

    }

    @Override
    public int countItem() {
        return 0;
    }

    @Override
    public boolean checkExist(String cateName) {
        return categoryDAO.checkExist(cateName);
    }

    public static void main(String[] args) {
        ICategoryDAO categoryDAO = new CategoryDAO();
        CategoryModel category = new CategoryModel();
        category.setListResult(categoryDAO.findAll());
        for (CategoryModel c : category.getListResult()) {
            System.out.println(c.getId() + " " + c.getCateName());
        }
    }
}
