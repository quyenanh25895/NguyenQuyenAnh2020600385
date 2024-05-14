package Controller.admin;

import Constants.SystemConstant;
import Model.RoleModel;
import Model.UserModel;
import Service.IService.IRoleService;
import Service.IService.IUserService;
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

@WebServlet(urlPatterns = {"/admin-user"})
public class UserController extends HttpServlet {

    @Inject
    private IUserService userService;

    @Inject
    private IRoleService roleService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        UserModel model = FormUtil.toModel(UserModel.class, req);
        RoleModel roles = FormUtil.toModel(RoleModel.class, req);
        String view = "";

        if (model.getType().equals(SystemConstant.EDIT)) {
            roles.setListResult(roleService.findAll());
            if (model.getId() != null) {
                Integer page = 1;
                if (model.getPage() !=null){
                    page = model.getPage();
                }
                model = userService.findOne(model.getId());
                model.setPage(page);

            }
            req.setAttribute("roles", roles);
            view = "/views/admin/User/EditUser.jsp";

        }else if(model.getType().equals(SystemConstant.LIST)) {
            IPageble pageble = new PageRequest(model.getPage(), model.getMaxPageItem(),
                    new Sorter(model.getSortName(), model.getSortBy()));

            model.setListResult(userService.findAll(pageble));
            model.setTotalItem(userService.countItem());
            model.setTotalPage((int) Math.ceil((double) model.getTotalItem() / model.getMaxPageItem()));
            view = "/views/admin/User/ListUser.jsp";
        }

        MessageUtil.showMessage(req);
        req.setAttribute(SystemConstant.MODEL, model);
        RequestDispatcher rd = req.getRequestDispatcher(view);
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
