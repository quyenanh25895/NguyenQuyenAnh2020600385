package DAO;

import DAO.IDAO.ICartDAO;
import Mapper.CartMapper;
import Mapper.CartProductMapper;
import Model.CartModel;
import Model.CartProductModel;
import Model.UserModel;
import org.apache.commons.lang.StringUtils;
import paging.IPageble;

import java.util.List;

public class CartDAO extends AbstractDAO<CartModel> implements ICartDAO {
    @Override
    public List<CartModel> findAll() {
        String sql = "select * from carts";
        return query(sql, new CartMapper());
    }



    @Override
    public Integer save(UserModel user) {
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO carts (userID, createBy, modifiedBy)");
        sql.append(" VALUES (?, ?, ?)");
        return insert(sql.toString(), user.getId(), user.getUserName(), user.getUserName());
    }


    @Override
    public CartModel findOne(int id) {
        return null;
    }

    @Override
    public void update(CartModel updateCart) {

    }

    @Override
    public void delete(int id) {

    }

    @Override
    public Integer getTotalItem() {
        return 0;
    }

    @Override
    public CartModel findByUserID(Integer userID) {
        String sql = "select * from carts where userID = ?";
        List<CartModel> carts = query(sql, new CartMapper(), userID);
        if (carts != null && !carts.isEmpty()) {
            return carts.get(0);
        }
        return null;

    }

    public static void main(String[] args) {
        CartDAO cartDAO = new CartDAO();

        System.out.println(cartDAO.findAll());
        System.out.println(cartDAO.findByUserID(49));

    }
}
