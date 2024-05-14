package Controller.web.API;

import Model.CommentModel;
import Model.UserModel;
import Service.IService.ICommentService;
import Utils.HttpUtil;
import Utils.SessionUtil;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/api-comment"})
public class CommentAPI extends HttpServlet {

    @Inject
    private ICommentService commentService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();

        CommentModel commentModel = HttpUtil.Of(req.getReader()).toModel(CommentModel.class);
        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
        commentService.save(commentModel, user);
        mapper.writeValue(resp.getOutputStream(), commentModel);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPut(req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doDelete(req, resp);
    }
}
