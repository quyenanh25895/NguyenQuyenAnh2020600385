package DAO;

import DAO.IDAO.IColorDAO;
import Mapper.ColorMapper;
import Mapper.ProductColorMapper;
import Mapper.UserMapper;
import Model.ColorModel;
import Model.ProductColorModel;
import Model.UserModel;

import java.util.List;

public class ColorDAO extends AbstractDAO<ColorModel> implements IColorDAO {

    @Override
    public List<ColorModel> findAll() {
        String sql = "SELECT * FROM colors";
        return query(sql, new ColorMapper());
    }

    @Override
    public List<ColorModel> findByProductID(Integer productID) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * ");
        sql.append("FROM products p ");
        sql.append("JOIN product_colors pc ON p.productID = pc.productID ");
        sql.append("JOIN colors c ON pc.colorID = c.colorID ");
        sql.append("WHERE p.productID = ?");
        return query(sql.toString(), new ColorMapper(), productID);
    }

    @Override
    public void insertProductColors(Integer productID, Integer colorID) {
        String sql = "INSERT INTO product_colors (productID, colorID) VALUES (?,?)";
        insert(sql, productID, colorID);
    }

    @Override
    public void deleteProductColors(Integer productID, Integer colorID) {
        String sql = "DELETE FROM product_colors WHERE productID = ? AND colorID = ?";
        delete(sql, productID, colorID);
    }

    @Override
    public boolean checkExit(String colorCode) {
        String sql = "SELECT * FROM colors WHERE colorCode = ?";
        List<UserModel> userModels = query(sql, new UserMapper(), colorCode);
        if (userModels.isEmpty()) {
            return true;
        } else {
            return false;
        }
    }


    @Override
    public Integer save(ColorModel saveColor) {
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO colors (colorCode) VALUES (?)");
        return insert(sql.toString(), saveColor.getColorCode());
    }

    @Override
    public ColorModel findOne(int id) {
        return null;
    }

    @Override
    public void update(ColorModel updateColor) {
        String sql = "UPDATE colors SET colorCode = ? WHERE colorID = ?";
        update(sql, updateColor.getColorCode(), updateColor.getId());
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM product_colors WHERE productID = ?";
        delete(sql, id);
    }

    @Override
    public Integer getTotalItem() {
        return 0;
    }

    @Override
    public boolean checkProductColor(Integer productId, Integer colorId) {
        String sql = "SELECT * FROM product_colors WHERE productID = ? AND colorID = ?";
        List<ProductColorModel> list = query(sql, new ProductColorMapper(), productId, colorId);
        if (list.isEmpty()) {
            return true;
        } else {
            return false;
        }
    }

    public static void main(String[] args) {
        ColorDAO dao = new ColorDAO();
        List<ColorModel> list = dao.findByProductID(2);
        for (ColorModel cm : list) {
            System.out.println(cm.getColorCode());
        }
    }


}
