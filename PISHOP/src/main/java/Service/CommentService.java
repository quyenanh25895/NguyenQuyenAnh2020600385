package Service;

import DAO.IDAO.ICommentDAO;
import Model.CommentModel;
import Model.UserModel;
import Service.IService.ICommentService;
import paging.IPageble;

import javax.inject.Inject;
import java.sql.Timestamp;
import java.util.List;

public class CommentService implements ICommentService {
    @Inject
    private ICommentDAO commentDAO;

    @Override
    public List<CommentModel> findAll(IPageble pageble) {
        return commentDAO.findAll(pageble);
    }

    @Override
    public CommentModel findOne(int id) {
        return commentDAO.findOne(id);
    }

    @Override
    public List<CommentModel> findByUserID(int id) {
        return commentDAO.findByUserID(id);
    }

    @Override
    public List<CommentModel> findByProductID(int id) {
        return commentDAO.findByProductID(id);
    }

    @Override
    public Integer save(CommentModel save, UserModel user) {
        save.setCreatedBy(user.getUserName());
        save.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        return commentDAO.save(save);
    }

    @Override
    public void update(CommentModel update) {

    }

    @Override
    public void delete(Integer[] id) {

    }

    @Override
    public void disable(Integer id) {
        commentDAO.disable(id);
    }

    @Override
    public void enable(Integer id) {
        commentDAO.enable(id);
    }

    @Override
    public int countItem() {
        return commentDAO.countItem();
    }
}
