package Service.IService;

import Model.CommentModel;
import Model.UserModel;
import paging.IPageble;

import java.util.List;

public interface ICommentService {
    List<CommentModel> findAll(IPageble pageble);

    CommentModel findOne(int id);

    List<CommentModel> findByUserID(int id);

    List<CommentModel> findByProductID(int id);

    Integer save(CommentModel save, UserModel user);

    void update(CommentModel update);

    void delete(Integer[] id);

    void disable(Integer id);

    void enable(Integer id);

    int countItem();

}
