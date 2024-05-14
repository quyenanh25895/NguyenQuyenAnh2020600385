package Controller.web;

import Model.*;
import Service.IService.*;
import Utils.FormUtil;
import Utils.SessionUtil;
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
import java.util.ResourceBundle;

@WebServlet(urlPatterns = {"/home", "/login", "/logout", "/signup"})
public class HomeController extends HttpServlet {

    @Inject
    private IProductService productService;

    @Inject
    private ICategoryService categoryService;

    @Inject
    private IUserService userService;

    @Inject
    private IImageService imageService;

    @Inject
    private IProductImageService productImageService;

    @Inject
    private IBannerService bannerService;

    ResourceBundle resourceBundle = ResourceBundle.getBundle("message");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("login")) {
            String alert = request.getParameter("alert");
            String message = request.getParameter("message");

            if (message != null && alert != null) {
                request.setAttribute("message", resourceBundle.getString(message));
                request.setAttribute("alert", alert);
            }
            RequestDispatcher rd = request.getRequestDispatcher("/views/Login.jsp");
            rd.forward(request, response);

        } else if (action != null && action.equals("logout")) {
            SessionUtil.getInstance().removeValue(request, "USERMODEL");
            response.sendRedirect(request.getContextPath() + "/home");

        } else if (action != null && action.equals("signup")) {
            String alert = request.getParameter("alert");
            String message = request.getParameter("message");

            if (message != null && alert != null) {
                request.setAttribute("message", resourceBundle.getString(message));
                request.setAttribute("alert", alert);
            }
            RequestDispatcher rd = request.getRequestDispatcher("/views/SignUp.jsp");
            rd.forward(request, response);

        } else {
            CategoryModel cateModels = FormUtil.toModel(CategoryModel.class, request);
            ProductModel productModels = FormUtil.toModel(ProductModel.class, request);
            ImageModel imageModels = FormUtil.toModel(ImageModel.class, request);
            BannerModel bannerModel = FormUtil.toModel(BannerModel.class, request);
            IPageble pageble = new PageRequest();

            cateModels.setListResult(categoryService.findAll());
            productModels.setListResult(productService.findAll(pageble));
            imageModels.setListResult(imageService.findAll());
            bannerModel.setListResult(bannerService.findAll(pageble));

            request.setAttribute("products", productModels);
            request.setAttribute("categories", cateModels);
            request.setAttribute("images", imageModels);
            request.setAttribute("banners", bannerModel);
            RequestDispatcher rd = request.getRequestDispatcher("/views/web/Home.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action != null && action.equals("login")) {
            UserModel model = FormUtil.toModel(UserModel.class, request);
            model = userService.findByUserNameAndPasswordAndStatus(model.getUserName(), model.getPassword());

            if (model != null && model.getStatus() == 1) {
                SessionUtil.getInstance().putValue(request, "USERMODEL", model);
                if (model.getRoleName().equals("USER")) {
                    response.sendRedirect(request.getContextPath() + "/home");
                } else if (model.getRoleName().equals("ADMIN")) {
                    response.sendRedirect(request.getContextPath() + "/admin-home");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/login?action=login&message=username_password_invalid&alert=danger");
            }
        }
    }

}
