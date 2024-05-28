package Controller.admin;

import Model.OrderModel;
import Model.StaticalModel;
import Model.UserModel;
import Service.IService.IOrderService;
import Service.IService.IProductService;
import Service.IService.IStaticalService;
import Service.IService.IUserService;
import org.apache.catalina.User;
import paging.PageRequest;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/admin-statical"})
public class StatisticalController extends HttpServlet {

    @Inject
    private IOrderService orderService;

    @Inject
    private IUserService userService;

    @Inject
    private IProductService productService;

    @Inject
    private IStaticalService staticalService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer userCount = userService.countItem();
        Integer productCount = productService.countItem();

        StaticalModel createdDate = new StaticalModel();
        createdDate.setListResult(staticalService.countOrder(new PageRequest()));

        StaticalModel userStat = new StaticalModel();
        userStat.setListResult(staticalService.getPriceByUserID());

        StaticalModel top10 = new StaticalModel();
        top10.setListResult(staticalService.getTop10Product());

        req.setAttribute("staticalModel", createdDate);
        req.setAttribute("userStat", userStat);
        req.setAttribute("userCount", userCount);
        req.setAttribute("productCount", productCount);
        req.setAttribute("top10", top10);
        req.getRequestDispatcher("views/admin/Statical/Statical.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
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
