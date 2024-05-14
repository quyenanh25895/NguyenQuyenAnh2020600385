package Controller.admin.API;

import Constants.SystemConstant;
import Model.UserModel;
import Service.IService.ICartService;
import Service.IService.IUserService;
import Sort.Sorter;
import Utils.FormUtil;
import Utils.HttpUtil;
import Utils.SessionUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import paging.IPageble;
import paging.PageRequest;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/api-admin-user"})
public class UserAPI extends HttpServlet {

    @Inject
    private IUserService userService;

    @Inject
    private ICartService cartService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();

        UserModel userModel = FormUtil.toModel(UserModel.class, req);
        IPageble pageble = new PageRequest();
        userModel.setListResult(userService.findAll(pageble));

        String jsonUserList = mapper.writeValueAsString(userModel.getListResult());
        resp.getWriter().write(jsonUserList);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();
        UserModel userModel = HttpUtil.Of(req.getReader()).toModel(UserModel.class);

        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");

        if (!userService.checkUserExist(userModel.getUserName())) {
            resp.setStatus(HttpServletResponse.SC_CONFLICT);
            mapper.writeValue(resp.getOutputStream(), "User already exists");

        } else {
            if (user != null) {
                IPageble pageble = new PageRequest(userModel.getPage(), userModel.getMaxPageItem(),
                        new Sorter(userModel.getSortName(), userModel.getSortBy()));
                userModel = userService.save(userModel, pageble, user);
                mapper.writeValue(resp.getOutputStream(), userModel);
                Integer i = cartService.save(userModel);
            } else {
                IPageble pageble = new PageRequest(userModel.getPage(), userModel.getMaxPageItem(),
                        new Sorter(userModel.getSortName(), userModel.getSortBy()));
                userModel = userService.save(userModel, pageble, userModel);
                mapper.writeValue(resp.getOutputStream(), userModel);
                Integer i = cartService.save(userModel);
            }
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");

        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");

        ObjectMapper mapper = new ObjectMapper();
        UserModel updateUser = HttpUtil.Of(req.getReader()).toModel(UserModel.class);
        if (updateUser.getId() != null && updateUser.getType().equals(SystemConstant.LIST)) {
            if (updateUser.getStatus() == 1) {
                userService.disableUser(updateUser.getId());
            } else if(updateUser.getStatus() == 0){
                userService.enableUser(updateUser.getId());
            }
        } else if(updateUser.getId() != null && updateUser.getType().equals(SystemConstant.EDIT)) {
            updateUser = userService.update(updateUser, user);
        }
        mapper.writeValue(resp.getOutputStream(), updateUser);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();
        UserModel deleteUser = HttpUtil.Of(req.getReader()).toModel(UserModel.class);
        userService.delete(deleteUser.getIds());
        mapper.writeValue(resp.getOutputStream(), deleteUser);
    }
}
