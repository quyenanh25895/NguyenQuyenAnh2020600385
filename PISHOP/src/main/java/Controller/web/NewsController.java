package Controller.web;

import Model.CartModel;
import Model.UserModel;
import Service.IService.*;
import Utils.SessionUtil;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ResourceBundle;

@WebServlet(urlPatterns = {"/news"})
public class NewsController extends HttpServlet {
    @Inject
    private IProductService productService;

    @Inject
    private ICategoryService categoryService;

    @Inject
    private IUserService userService;

    @Inject
    private IImageService imageService;

    @Inject
    private ICartProductService cartProductService;

    @Inject
    private IBannerService bannerService;

    @Inject
    private ICartService cartService;

    ResourceBundle resourceBundle = ResourceBundle.getBundle("message");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("type", "news");
        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
        if (user != null) {
            CartModel cartModel = cartService.findByUserID(user.getId());
            Integer cartItem = cartProductService.countProduct(cartModel.getId());
            req.setAttribute("cartItem", cartItem);
        }
        RequestDispatcher rd = req.getRequestDispatcher("/common/News.jsp");
        rd.forward(req, resp);
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
