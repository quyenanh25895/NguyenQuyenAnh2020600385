package DAO;

import DAO.IDAO.ICommentDAO;
import Mapper.CommentMapper;
import Model.CommentModel;
import org.apache.commons.lang.StringUtils;
import paging.IPageble;

import java.util.List;

public class CommentDAO extends AbstractDAO<CommentModel> implements ICommentDAO {
    @Override
    public List<CommentModel> findAll(IPageble pageble) {
        StringBuilder sql = new StringBuilder();
        sql.append("select c.*, u.username, pro.productName");
        sql.append(" from comments c");
        sql.append(" inner join users u on c.userID = u.userID");
        sql.append(" inner join products pro on c.productID = pro.productID");
        if (pageble.getSorter() != null && StringUtils.isNotBlank(pageble.getSorter().getSortName()) && StringUtils.isNotBlank(pageble.getSorter().getSortBy())) {
            sql.append(" ORDER BY " + pageble.getSorter().getSortName() + " " + pageble.getSorter().getSortBy() + "");
        }
        if (pageble.getOffset() != null && pageble.getLimit() != null) {
            sql.append(" LIMIT " + pageble.getOffset() + ", " + pageble.getLimit() + "");
        }
        return query(sql.toString(), new CommentMapper());
    }

    @Override
    public CommentModel findOne(int id) {
        StringBuilder sql = new StringBuilder();
        sql.append("select c.*, u.username, pro.productName");
        sql.append(" from comments c");
        sql.append(" inner join users u on c.userID = u.userID");
        sql.append(" inner join products pro on c.productID = pro.productID");
        sql.append(" where c.commentID = ?");
        List<CommentModel> comments = query(sql.toString(), new CommentMapper(), id);
        if (!comments.isEmpty()) {
            return comments.get(0);
        }
        return null;
    }

    @Override
    public List<CommentModel> findByUserID(int id) {
        StringBuilder sql = new StringBuilder();
        sql.append("select c.*, u.username, pro.productName");
        sql.append(" from comments c");
        sql.append(" inner join users u on c.userID = u.userID");
        sql.append(" inner join products pro on c.productID = pro.productID");
        sql.append(" where c.userID = ?");
        return query(sql.toString(), new CommentMapper(), id);
    }

    @Override
    public List<CommentModel> findByProductID(int id) {
        StringBuilder sql = new StringBuilder();
        sql.append("select c.*, u.username, pro.productName");
        sql.append(" from comments c");
        sql.append(" inner join users u on c.userID = u.userID");
        sql.append(" inner join products pro on c.productID = pro.productID");
        sql.append(" where c.productID = ?");
        return query(sql.toString(), new CommentMapper(), id);
    }

    @Override
    public Integer save(CommentModel cmt) {
        StringBuilder sql = new StringBuilder();
        sql.append("insert into comments(content, userID, productID,");
        sql.append("createBy, createdDate) ");
        sql.append("values(?, ?, ?, ?, ?)");
        return insert(sql.toString(), cmt.getContent(), cmt.getUserID(), cmt.getProductID(),
                cmt.getCreatedBy(), cmt.getCreatedDate());
    }

    @Override
    public void update(CommentModel cmt) {
        StringBuilder sql = new StringBuilder();
        sql.append("update comments set ");
        sql.append("content = ?, ");
        sql.append("where commentID = ?");
        update(sql.toString(), cmt.getContent(), cmt.getId());
    }

    @Override
    public void delete(int id) {

    }

    @Override
    public void disable(Integer id) {
        String sql = "UPDATE comments SET status = 0 WHERE commentID = ?";
        update(sql, id);
    }

    @Override
    public void enable(Integer id) {
        String sql = "UPDATE comments SET status = 1 WHERE commentID = ?";
        update(sql, id);
    }

    @Override
    public Integer countItem() {
        String sql = "select count(*) from comments";
        return count(sql);
    }
}
