package Controller.admin;

import Constants.SystemConstant;
import Model.CommentModel;
import Service.IService.ICommentService;
import Sort.Sorter;
import Utils.FormUtil;
import Utils.MessageUtil;
import paging.IPageble;
import paging.PageRequest;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(urlPatterns = {"/admin-comment"})
public class CommentController extends HttpServlet {

    @Inject
    private ICommentService commentService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CommentModel model = FormUtil.toModel(CommentModel.class, req);
        String view = "";

        if (model != null) {
            if (model.getType().equals(SystemConstant.LIST)) {
                IPageble pageble = new PageRequest(model.getPage(), model.getMaxPageItem(),
                        new Sorter(model.getSortName(), model.getSortBy()));

                model.setListResult(commentService.findAll(pageble));
                model.setTotalItem(commentService.countItem());
                model.setTotalPage((int) Math.ceil((double) model.getTotalItem() / model.getMaxPageItem()));
                view = "views/admin/comment/ListComment.jsp";
            } else if (model.getType().equals(SystemConstant.EDIT)) {
                model = commentService.findOne(model.getId());
                view = "views/admin/comment/EditComment.jsp";
            }
        }
        MessageUtil.showMessage(req);
        req.setAttribute(SystemConstant.MODEL, model);
        RequestDispatcher rd = req.getRequestDispatcher(view);
        rd.forward(req, resp);

    }
}
