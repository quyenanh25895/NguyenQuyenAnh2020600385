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
        String sql = "select * from productinfo where productID = ?";
        List<ProductInformationModel> productInformationModels = query(sql, new ProductInformationMapper(), id);
        if (productInformationModels != null) {
            return productInformationModels.get(0);
        } else {
            return null;
        }
    }

    @Override
    public Integer save(Integer productID) {
        String sql = "insert into productInfo (productID) values (?)";
        return insert(sql, productID);
    }

    @Override
    public void update(ProductInformationModel productInformationModel) {
        StringBuilder sql = new StringBuilder();
        sql.append("update productInfo set timeManufacture = ?, country = ?, pinValue = ?, display = ?,  ");
        sql.append("resolution = ?, chipset = ? ");
        sql.append("where productID = ?");
        update(sql.toString(), productInformationModel.getTimeManufacture(), productInformationModel.getCountry(),
                productInformationModel.getPinValue(), productInformationModel.getDisplay(), productInformationModel.getResolution(),
                productInformationModel.getChipset(), productInformationModel.getProductID());
    }

    public static void main(String[] args) {
        ProductInformationDAO dao = new ProductInformationDAO();
//        List<ProductInformationModel> productInformationModel = new ArrayList<>();
//        productInformationModel = dao.findAll();
        ProductInformationModel p = dao.findOne(60);
    }
}
