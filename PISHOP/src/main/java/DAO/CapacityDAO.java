package DAO;

import DAO.IDAO.ICapcityDAO;
import Mapper.CapacityMapper;
import Mapper.ProductColorMapper;
import Mapper.UserMapper;
import Model.CapacityModel;
import Model.ProductColorModel;
import Model.UserModel;

import java.util.List;

public class CapacityDAO extends AbstractDAO<CapacityModel> implements ICapcityDAO {
    @Override
    public List<CapacityModel> findAll() {
        String sql = "select * from capacities";
        return query(sql, new CapacityMapper());
    }

    @Override
    public boolean checkProductCapacity(Integer productId, Integer capacityID) {
        String sql = "SELECT * FROM product_capacities WHERE productID = ? AND capacityID = ?";
        List<ProductColorModel> list = query(sql, new ProductColorMapper(), productId, capacityID);
        if (list.isEmpty()) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    public List<CapacityModel> findByProductID(Integer productID) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * ");
        sql.append("FROM products p ");
        sql.append("JOIN product_capacities pc ON p.productID = pc.productID ");
        sql.append("JOIN capacities c ON pc.capacityID = c.capacityID ");
        sql.append("WHERE p.productID = ?");
        return query(sql.toString(), new CapacityMapper(), productID);
    }

    @Override
    public void insertProductCapacity(Integer productID, Integer capacityID) {
        String sql = "INSERT INTO product_capacities (productID, capacityID) VALUES (?,?)";
        insert(sql, productID, capacityID);
    }

    @Override
    public Integer save(CapacityModel saveCapacity) {
        String sql = "INSERT INTO capacities (capacityValue) VALUES (?)";
        return insert(sql, saveCapacity.getCapacityValue());
    }

    @Override
    public CapacityModel findOne(int id) {
        return null;
    }

    @Override
    public void update(CapacityModel updateCapacity) {
        String sql = "UPDATE capacities SET capacityValue = ? WHERE capacityID = ?";
        update(sql, updateCapacity.getCapacityValue(), updateCapacity.getId());
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM product_capacities WHERE productID = ?";
        delete(sql, id);
    }

    @Override
    public Integer getTotalItem() {
        return 0;
    }

    @Override
    public void deleteProductCapacity(Integer productID, Integer capacityID) {
        String sql = "DELETE FROM product_capacities WHERE productID = ? AND capacityID = ?";
        delete(sql, productID, capacityID);
    }

    @Override
    public boolean checkExit(Long capacityValue) {
        String sql = "SELECT * FROM capacities WHERE capacityValue = ?";
        List<UserModel> userModels = query(sql, new UserMapper(), capacityValue);
        if (userModels.isEmpty()) {
            return true;
        } else {
            return false;
        }
    }


    public static void main(String[] args) {
        List<CapacityModel> list = new CapacityDAO().findAll();
        for (CapacityModel c : list) {
            System.out.println(c.getId() + " " + c.getCapacityValue());
        }
    }
}
