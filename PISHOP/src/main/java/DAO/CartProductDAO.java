package DAO;

import DAO.IDAO.ICartProductDAO;
import Mapper.CartProductMapper;
import Model.CartProductModel;
import Model.ProductModel;
import org.apache.commons.lang.StringUtils;
import paging.IPageble;

import java.util.List;

public class CartProductDAO extends AbstractDAO<CartProductModel> implements ICartProductDAO {
    @Override
    public List<CartProductModel> findAll(IPageble pageble) {
        StringBuilder sql = new StringBuilder();
        sql.append("select * from cart_products");
        if (pageble.getSorter() != null && StringUtils.isNotBlank(pageble.getSorter().getSortName()) && StringUtils.isNotBlank(pageble.getSorter().getSortBy())) {
            sql.append(" ORDER BY " + pageble.getSorter().getSortName() + " " + pageble.getSorter().getSortBy() + "");
        }
        if (pageble.getOffset() != null && pageble.getLimit() != null) {
            sql.append(" LIMIT " + pageble.getOffset() + ", " + pageble.getLimit() + "");
        }
        return query(sql.toString(), new CartProductMapper());

    }

    @Override
    public List<CartProductModel> findJoin(IPageble pageble) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT c.userID, cp.* ");
        sql.append(" FROM carts c");
        sql.append(" INNER JOIN cart_products cp ON c.cartID = cp.cartID");
        if (pageble.getSorter() != null && StringUtils.isNotBlank(pageble.getSorter().getSortName()) && StringUtils.isNotBlank(pageble.getSorter().getSortBy())) {
            sql.append(" ORDER BY " + pageble.getSorter().getSortName() + " " + pageble.getSorter().getSortBy() + "");
        }
        if (pageble.getOffset() != null && pageble.getLimit() != null) {
            sql.append(" LIMIT " + pageble.getOffset() + ", " + pageble.getLimit() + "");
        }
        return query(sql.toString(), new CartProductMapper());
    }

    @Override
    public Integer save(CartProductModel saveCartProduct) {
        String sql = "INSERT INTO cart_products(cartID, productID, quantity, price, cartCode) VALUES (?,?,?,?, ?)";
        return insert(sql, saveCartProduct.getCartID(), saveCartProduct.getProductID(),
                saveCartProduct.getQuantity(), saveCartProduct.getPrice(), saveCartProduct.getCartCode());
    }

    @Override
    public Integer saveProductToCart(Integer cartID, ProductModel productModel) {
        StringBuilder sql = new StringBuilder();
        sql.append("insert into cart_products ");
        sql.append("(cartID, productID, quantity, price, colorID, capacityID, status, cartCode) ");
        sql.append("values (?, ?, ?, ?, ?, ?, ?, ?)");
        Integer[] colorID = productModel.getColorIDs();
        Integer[] capacityID = productModel.getCapacityIDs();
        return insert(sql.toString(), cartID, productModel.getId(),
                productModel.getQuantity(), productModel.getPrice(), colorID[0], capacityID[0], 0, 0);
    }

    @Override
    public CartProductModel findOne(int id) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT c.userID, cp.* ");
        sql.append(" FROM carts c");
        sql.append(" INNER JOIN cart_products cp ON c.cartID = cp.cartID");
        sql.append(" WHERE cartproductID = ?");
        List<CartProductModel> list = query(sql.toString(), new CartProductMapper(), id);
        if (!list.isEmpty()) {
            return list.get(0);
        } else {
            return null;
        }
    }

    @Override
    public void update(CartProductModel updateCartProduct) {

    }

    @Override
    public void submitCartProduct(Integer id, Integer status, Integer cartCode) {
        String sql = "UPDATE cart_products SET status = ?, cartCode = ? WHERE cartproductID = ?";
        update(sql, status, cartCode, id);
    }

    @Override
    public void denyCartProduct(Integer id) {
        String sql = "UPDATE cart_products SET status = 0 WHERE cartproductID = ?";
        update(sql, id);
    }

    @Override
    public void submitOrder(Integer id) {
        String sql = "UPDATE cart_products SET status = 2 WHERE cartproductID = ?";
        update(sql, id);
    }

    @Override
    public void vnpayDeny(Integer mdh) {
        String sql = "UPDATE cart_products SET status = 0, cartCode = 0 WHERE cartCode = ?";
        update(sql, mdh);

    }

    @Override
    public void confirmOrder(Integer id) {
        String sql = "UPDATE cart_products SET status = 3, cartCode = 0 WHERE cartproductID = ?";
        update(sql, id);
    }

    @Override
    public void backOrder(Integer id) {
        String sql = "UPDATE cart_products SET status = 4 WHERE cartproductID = ?";
        update(sql, id);
    }

    @Override
    public void confirmBackOrder(Integer id) {
        String sql = "UPDATE cart_products SET status = 5 WHERE cartproductID = ?";
        update(sql, id);
    }

    @Override
    public void delete(int id) {
        String sql = "delete from cart_products where cartproductID = ?";
        delete(sql, id);
    }

    @Override
    public Integer getTotalItem() {
        String sql = "SELECT count(*) from cart_products";
        return count(sql);
    }

    @Override
    public List<CartProductModel> findByCartID(Integer cartID, IPageble pageble) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT c.userID, cp.* ");
        sql.append(" FROM carts c");
        sql.append(" INNER JOIN cart_products cp ON c.cartID = cp.cartID ");
        sql.append(" WHERE c.cartID = ? ");
        if (pageble.getSorter() != null && StringUtils.isNotBlank(pageble.getSorter().getSortName()) && StringUtils.isNotBlank(pageble.getSorter().getSortBy())) {
            sql.append(" ORDER BY cp." + pageble.getSorter().getSortName() + " " + pageble.getSorter().getSortBy() + "");
        }
        if (pageble.getOffset() != null && pageble.getLimit() != null) {
            sql.append(" LIMIT " + pageble.getOffset() + ", " + pageble.getLimit() + "");
        }

        return query(sql.toString(), new CartProductMapper(), cartID);
    }

    @Override
    public void deleteByProductID(Integer productID) {
        String sql = "DELETE FROM cart_products WHERE productID = ?";
        delete(sql, productID);
    }


}
