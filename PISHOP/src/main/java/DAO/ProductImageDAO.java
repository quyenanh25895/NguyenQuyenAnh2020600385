package DAO;

import DAO.IDAO.IProductImageDAO;
import Mapper.ProductImageMapper;
import Model.ProductImageModel;

import java.util.List;

public class ProductImageDAO extends AbstractDAO<ProductImageModel> implements IProductImageDAO {
    @Override
    public List<ProductImageModel> findAll() {
        String sql = "select * from product_images";
        return query(sql, new ProductImageMapper());
    }
}
