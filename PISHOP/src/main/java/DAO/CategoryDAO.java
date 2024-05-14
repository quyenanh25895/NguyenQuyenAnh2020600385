package DAO;

import DAO.IDAO.ICategoryDAO;
import Mapper.CategoryMapper;
import Mapper.UserMapper;
import Model.CategoryModel;
import Model.UserModel;

import java.util.List;

public class CategoryDAO extends AbstractDAO<CategoryModel> implements ICategoryDAO {


    @Override
    public List<CategoryModel> findAll() {
        StringBuilder sql = new StringBuilder("SELECT * FROM categories");
        return query(sql.toString(), new CategoryMapper());
    }

    @Override
    public Integer save(CategoryModel saveCate) {
        String sql = "INSERT INTO categories (cateName, cateStatus) VALUES (?, ?)";
        return insert(sql, saveCate.getCateName(), 1);
    }

    @Override
    public CategoryModel findOne(int id) {
        String sql = "SELECT * FROM categories WHERE cateID = ?";
        List<CategoryModel> cate = query(sql, new CategoryMapper(), id);
        if (cate.isEmpty()) {
            return null;
        } else {
            return cate.get(0);
        }
    }

    @Override
    public void update(CategoryModel updateCate) {
        String sql = "UPDATE categories SET cateName = ? WHERE cateID = ?";
        update(sql, updateCate.getCateName(), updateCate.getId());
    }

    @Override
    public void delete(int id) {

    }

    @Override
    public Integer getTotalItem() {
        return null;
    }

    @Override
    public boolean checkExist(String cateName) {
        String sql = "SELECT * FROM categories WHERE cateName = ?";
        List<UserModel> userModels = query(sql, new UserMapper(), cateName);
        if (userModels.isEmpty()) {
            return true;
        } else {
            return false;
        }
    }
}
