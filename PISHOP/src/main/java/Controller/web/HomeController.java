package Controller.web;

import Model.*;
import Service.CartService;
import Service.IService.*;
import Sort.Sorter;
import Utils.FormUtil;
import Utils.PasswordUtil;
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

@WebServlet(urlPatterns = {"/home", "/login", "/logout", "/signup", "/contact"})
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
    private ICartProductService cartProductService;

    @Inject
    private IBannerService bannerService;

    @Inject
    private ICartService cartService;

    ResourceBundle resourceBundle = ResourceBundle.getBundle("message");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("login")) {
            String alert = request.getParameter("alert");
            String message = request.getParameter("message");
            String productID = request.getParameter("productID");

            if (message != null && alert != null) {
                request.setAttribute("message", resourceBundle.getString(message));
                request.setAttribute("alert", alert);
            }
            request.setAttribute("productID", productID);
            RequestDispatcher rd = request.getRequestDispatcher("/views/Login.jsp");
            rd.forward(request, response);

        } else if (action != null && action.equals("logout")) {
            SessionUtil.getInstance().removeValue(request, "USERMODEL");
            SessionUtil.getInstance().removeValue(request, "cartItem");
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

        } else if (action != null && action.equals("contact")) {
            RequestDispatcher rd = request.getRequestDispatcher("/views/web/Contact.jsp");
            rd.forward(request, response);
        } else {
            CategoryModel cateModels = FormUtil.toModel(CategoryModel.class, request);
            ProductModel productModels = FormUtil.toModel(ProductModel.class, request);
            ImageModel imageModels = FormUtil.toModel(ImageModel.class, request);
            BannerModel bannerModel = FormUtil.toModel(BannerModel.class, request);
            IPageble pageble = new PageRequest();


            cateModels.setListResult(categoryService.findAll());
            productModels.setListResult(productService.findAll(new PageRequest(1, productService.countItem(), new Sorter("cateID", "ASC"))));
            imageModels.setListResult(imageService.findAll());
            bannerModel.setListResult(bannerService.findAll(pageble));
            UserModel user = (UserModel) SessionUtil.getInstance().getValue(request, "USERMODEL");
            if (user != null) {
                CartModel cartModel = cartService.findByUserID(user.getId());
                Integer cartItem = cartProductService.countProduct(cartModel.getId());
                request.setAttribute("cartItem", cartItem);
            }

            request.setAttribute("type", "home");
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
            model.setPassword(PasswordUtil.encryptPassword(model.getPassword()));
            model = userService.findByUserNameAndPasswordAndStatus(model.getUserName(), model.getPassword());

            if (model != null && model.getStatus() == 1) {
                SessionUtil.getInstance().putValue(request, "USERMODEL", model);


                if (model.getRoleName().equals("USER")) {
                    String productID = request.getParameter("productID");
                    if (!productID.isBlank() && !productID.isEmpty()) {
                        response.sendRedirect(request.getContextPath() + "/product-detail?type=detail&productID=" + productID);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/home");
                    }
                } else if (model.getRoleName().equals("ADMIN")) {
                    response.sendRedirect(request.getContextPath() + "/admin-home");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/login?action=login&message=username_password_invalid&alert=danger");
            }
        }
    }

}
