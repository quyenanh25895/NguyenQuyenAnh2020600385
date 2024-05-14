package DAO;

import DAO.IDAO.IImageDAO;
import Mapper.ImageMapper;
import Model.ImageModel;

import java.util.List;

public class ImageDAO extends AbstractDAO<ImageModel> implements IImageDAO {

    @Override
    public List<ImageModel> findAll() {
        String sql = "select * from images";
        return query(sql, new ImageMapper());
    }

    @Override
    public ImageModel findById(int id) {
        return null;
    }

    @Override
    public List<ImageModel> findByProductID(Integer productID) {
        String sql = "select * from images where productID = ?";
        return query(sql, new ImageMapper(), productID);
    }

    @Override
    public Integer save(ImageModel image) {
        StringBuilder sql = new StringBuilder();
        sql.append("insert into images ");
        sql.append("(imageLink, ProductName, productID, ");
        sql.append("createdDate, createBy, modifiedDate, modifiedBy)");
        sql.append("values(?, ?, ?, ?, ?, ?, ?)");
        return insert(sql.toString(), image.getImageLink(), image.getProductName(), image.getProductID(),
                image.getCreatedDate(), image.getCreatedBy(), image.getModifiedDate(), image.getModifiedBy());
    }

    @Override
    public void update(ImageModel image) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE images SET ");
        sql.append("imageLink = ?, ProductName = ?, productID = ?, ");
        sql.append("modifiedBy = ?, modifiedDate = ? ");
        sql.append("WHERE imageID = ?");
        update(sql.toString(), image.getImageLink(), image.getProductName(), image.getProductID(),
                image.getModifiedBy(), image.getModifiedDate(), image.getId());
    }

    @Override
    public void delete(int id) {

    }
}
