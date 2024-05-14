package DAO;


import DAO.IDAO.IProductDAO;
import Mapper.ProductMapper;
import Mapper.UserMapper;
import Model.ProductModel;
import Model.UserModel;
import org.apache.commons.lang.StringUtils;
import paging.IPageble;

import java.util.List;

public class ProductDAO extends AbstractDAO<ProductModel> implements IProductDAO {


    @Override
    public List<ProductModel> findAll(IPageble pageble) {
        StringBuilder sql = new StringBuilder("select p.*, b.brandName, c.cateName ");
        sql.append("from products as p ");
        sql.append("inner join brands b on p.brandID = b.brandID ");
        sql.append("inner join categories c on p.cateID = c.cateID ");  
        if (pageble.getSorter() != null && StringUtils.isNotBlank(pageble.getSorter().getSortName()) && StringUtils.isNotBlank(pageble.getSorter().getSortBy())) {
            sql.append(" ORDER BY " + pageble.getSorter().getSortName() + " " + pageble.getSorter().getSortBy() + "");
        }
        if (pageble.getOffset() != null && pageble.getLimit() != null) {
            sql.append(" LIMIT " + pageble.getOffset() + ", " + pageble.getLimit() + "");
        }
        return query(sql.toString(), new ProductMapper());
    }

    @Override
    public Integer save(ProductModel product) {
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO products ");
        sql.append("(productName, productPrice, productQuantity, brandID,");
        sql.append("cateID, productDescription, productStatus, createBy, createdDate, modifiedBy, modifiedDate) ");
        sql.append("VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        return insert(sql.toString(), product.getName(), product.getPrice(), product.getQuantity(), product.getBrandID(), product.getCateID(),
                product.getDescription(), product.getStatus(), product.getCreatedBy(), product.getCreatedDate(), product.getModifiedBy(), product.getModifiedDate());
    }

    @Override
    public ProductModel findOne(int id) {
        StringBuilder sql = new StringBuilder("select p.*, b.brandName, c.cateName  ");
        sql.append("from products as p ");
        sql.append("inner join brands b on p.brandID = b.brandID ");
        sql.append("inner join categories c on p.cateID = c.cateID ");
        sql.append("where p.productID = ? ");
        List<ProductModel> product = query(sql.toString(), new ProductMapper(), id);
        if (product.isEmpty()) {
            return null;
        } else {
            return product.get(0);
        }
    }

    @Override
    public void update(ProductModel updateProduct) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE products SET ");
        sql.append("productName = ?, productPrice = ?, productQuantity = ?, brandID = ?,");
        sql.append("cateID = ?, productDescription = ?, productStatus = ?,createBy = ?, createdDate = ?, modifiedBy = ?, modifiedDate = ? ");
        sql.append("WHERE productID = ?");

        update(sql.toString(), updateProduct.getName(), updateProduct.getPrice(), updateProduct.getQuantity(), updateProduct.getBrandID()
                , updateProduct.getCateID(), updateProduct.getDescription(), updateProduct.getStatus()
                , updateProduct.getCreatedBy(), updateProduct.getCreatedDate(), updateProduct.getModifiedBy(), updateProduct.getModifiedDate()
                , updateProduct.getId());
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM products WHERE productID = ?";
        delete(sql, id);
    }

    @Override
    public void disableProduct(Integer id) {
        String sql = "UPDATE products SET productStatus = 0 WHERE productID = ?";
        update(sql, id);
    }

    @Override
    public void enableProduct(Integer id) {
        String sql = "UPDATE products SET productStatus = 1 WHERE productID = ?";
        update(sql, id);
    }

    @Override
    public Integer getTotalItem() {
        String sql = "SELECT count(*) FROM products";
        return count(sql);
    }

    @Override
    public boolean checkProductExist(String productName) {
        String sql = "SELECT * FROM products WHERE productName = ?";
        List<UserModel> userModels = query(sql, new UserMapper(), productName);
        if (userModels.isEmpty()) {
            return true;
        } else {
            return false;
        }
    }


    @Override
    public List<ProductModel> findByCateIDAndBrandID(IPageble pageble, Integer cateID, Integer brandID) {
        StringBuilder sql = new StringBuilder("select p.*, b.brandName, c.cateName  ");
        sql.append("from products as p ");
        sql.append("inner join brands b on p.brandID = b.brandID ");
        sql.append("inner join categories c on p.cateID = c.cateID ");
        if (brandID != null && cateID != null) {
            sql.append(" WHERE p.CateID = ? AND p.BrandID = ?");
            if (pageble.getSorter() != null && StringUtils.isNotBlank(pageble.getSorter().getSortName()) && StringUtils.isNotBlank(pageble.getSorter().getSortBy())) {
                sql.append(" ORDER BY ").append(pageble.getSorter().getSortName()).append(" ").append(pageble.getSorter().getSortBy());
            }
            return query(sql.toString(), new ProductMapper(), cateID, brandID);
        } else if (brandID == null && cateID != null) {
            sql.append(" WHERE p.CateID = ?");
            if (pageble.getSorter() != null && StringUtils.isNotBlank(pageble.getSorter().getSortName()) && StringUtils.isNotBlank(pageble.getSorter().getSortBy())) {
                sql.append(" ORDER BY ").append(pageble.getSorter().getSortName()).append(" ").append(pageble.getSorter().getSortBy());
            }
            return query(sql.toString(), new ProductMapper(), cateID);
        } else {
            sql.append(" WHERE p.BrandID = ?");
            if (pageble.getSorter() != null && StringUtils.isNotBlank(pageble.getSorter().getSortName()) && StringUtils.isNotBlank(pageble.getSorter().getSortBy())) {
                sql.append(" ORDER BY ").append(pageble.getSorter().getSortName()).append(" ").append(pageble.getSorter().getSortBy());
            }
            return query(sql.toString(), new ProductMapper(), brandID);
        }

    }

}
