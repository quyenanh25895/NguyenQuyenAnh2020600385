package DAO;

import DAO.IDAO.IBrandDAO;
import Mapper.BrandMapper;
import Mapper.UserMapper;
import Model.BrandModel;
import Model.UserModel;

import java.util.List;

public class BrandDAO extends AbstractDAO<BrandModel> implements IBrandDAO {

    @Override
    public List<BrandModel> findAll() {
        String sql = "select * from brands";

        return query(sql, new BrandMapper());
    }

    @Override
    public Integer save(BrandModel saveBrand) {
        String sql = "insert into brands(brandName, brandStatus) values(?, ?)";
        return insert(sql, saveBrand.getBrandName(), 1);
    }

    @Override
    public BrandModel findOne(int id) {
        String sql = "select * from brands where brandID = ?";
        List<BrandModel> brands = query(sql, new BrandMapper(), id);
        if (!brands.isEmpty()) {
            return brands.get(0);
        } else {
            return null;
        }
    }

    @Override
    public void update(BrandModel updateBrand) {
        String sql = "update brands set brandName = ? where brandID = ?";
    }

    @Override
    public void delete(int id) {

    }

    @Override
    public Integer getTotalItem() {
        return 0;
    }

    @Override
    public boolean checkExist(String brandName) {
        String sql = "SELECT * FROM brands WHERE brandName = ?";
        List<UserModel> userModels = query(sql, new UserMapper(), brandName);
        if (userModels.isEmpty()) {
            return true;
        } else {
            return false;
        }
    }

    public static void main(String[] args) {
        IBrandDAO brandDAO = new BrandDAO();
        List<BrandModel> brands = brandDAO.findAll();
        for (BrandModel brand : brands) {
            System.out.println(brand.getId() + " " + brand.getBrandName());
        }

    }
}
