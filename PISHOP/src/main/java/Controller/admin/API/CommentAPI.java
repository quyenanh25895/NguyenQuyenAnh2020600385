package Controller.admin.API;

import Model.CommentModel;
import Model.UserModel;
import Service.IService.ICommentService;
import Utils.HttpUtil;
import Utils.SessionUtil;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/api-admin-comment"})
public class CommentAPI extends HttpServlet {

    @Inject
    private ICommentService commentService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        CommentModel commentModel = HttpUtil.Of(req.getReader()).toModel(CommentModel.class);
        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
        if (commentModel.getType().equals("enable")) {
            commentService.enable(commentModel.getId());
        }else if(commentModel.getType().equals("disable")) {
            commentService.disable(commentModel.getId());
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }


}
