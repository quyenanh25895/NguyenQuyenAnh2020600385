package DAO;

import DAO.IDAO.IStaticalDAO;
import Mapper.StaticalMapper;
import Model.StaticalModel;
import paging.IPageble;

import java.util.ArrayList;
import java.util.List;

public class StaticalDAO extends AbstractDAO<StaticalModel> implements IStaticalDAO {

    @Override
    public List<StaticalModel> countOrder(IPageble pageble) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT DATE(createdDate) AS createdDate, COUNT(orderID) AS quantity  ");
        sql.append("FROM orders ");
        sql.append("GROUP BY DATE(createdDate) ");
        sql.append("ORDER BY DATE(createdDate) ");
        return query(sql.toString(), new StaticalMapper(), pageble);

    }

    @Override
    public List<StaticalModel> getPriceByUserID() {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT u.userID, u.userName, COALESCE(SUM(o.quantity * o.price), 0) AS price ");
        sql.append("FROM users as u ");
        sql.append("LEFT JOIN orders AS o ON u.userID = o.userID ");
        sql.append("GROUP BY o.userID, u.userID ");
        return query(sql.toString(), new StaticalMapper());
    }

    @Override
    public List<StaticalModel> getTop10Product() {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT p.productID, p.productName, COALESCE(SUM(o.quantity), 0) AS quantity ");
        sql.append("FROM products AS p ");
        sql.append("LEFT JOIN orders AS o ON p.productID = o.productID ");
        sql.append("GROUP BY p.productID ");
        sql.append("ORDER BY quantity desc ");
        sql.append("LIMIT 0, 10");
        return query(sql.toString(), new StaticalMapper());
    }

    public static void main(String[] args) {
        StaticalDAO dao = new StaticalDAO();
        List<StaticalModel> list = dao.getTop10Product();
        System.out.println(list);
    }
}
