package DAO;

import DAO.IDAO.IProductInformationDAO;
import Mapper.ProductInformationMapper;
import Model.ProductInformationModel;

import java.util.ArrayList;
import java.util.List;

public class ProductInformationDAO extends AbstractDAO<ProductInformationModel> implements IProductInformationDAO {
    @Override
    public List<ProductInformationModel> findAll() {
        String sql = "select * from productinfo";
        return query(sql, new ProductInformationMapper());
    }

    @Override
    public ProductInformationModel findOne(int id) {
        String sql = "select * from productinfo where infoID = ?";
        List<ProductInformationModel> productInformationModels = query(sql, new ProductInformationMapper(), id);
        if (productInformationModels != null) {
            return productInformationModels.get(0);
        } else {
            return null;
        }
    }

    public static void main(String[] args) {
        ProductInformationDAO dao = new ProductInformationDAO();
//        List<ProductInformationModel> productInformationModel = new ArrayList<>();
//        productInformationModel = dao.findAll();
        ProductInformationModel p = dao.findOne(60);
    }
}
