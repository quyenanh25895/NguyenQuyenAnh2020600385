package DAO.IDAO;

import Model.CommentModel;
import paging.IPageble;

import java.util.List;

public interface ICommentDAO extends IGenericDAO<CommentModel> {

    List<CommentModel> findAll(IPageble pageble);

    CommentModel findOne(int id);

    List<CommentModel> findByUserID(int id);

    List<CommentModel> findByProductID(int id);

    Integer save(CommentModel cmt);

    void update(CommentModel cmt);

    void delete(int id);

    void disable(Integer id);

    void enable(Integer id);

    Integer countItem();

}
