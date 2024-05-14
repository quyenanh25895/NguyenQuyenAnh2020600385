package Controller.web;

import Model.*;
import Service.IService.*;
import Sort.Sorter;
import Utils.FormUtil;
import Utils.SessionUtil;
import paging.IPageble;
import paging.PageRequest;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    @Inject
    private IProductService productService;

    @Inject
    private IColorService colorService;

    @Inject
    private ICapacityService capacityService;

    @Inject
    private ICartService cartService;

    @Inject
    private ICartProductService cartProductService;

    @Inject
    private IImageService imageService;

    @Inject
    private IProductImageService productImageService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
        CartProductModel cartProductModel = FormUtil.toModel(CartProductModel.class, req);
        ImageModel imageModels = FormUtil.toModel(ImageModel.class, req);
        CapacityModel capacityModel = new CapacityModel();
        ColorModel colorModel = new ColorModel();
        ProductModel productModel = FormUtil.toModel(ProductModel.class, req);
        CartModel cartModel = cartService.findByUserID(user.getId());
        String type = req.getParameter("type");
        String view = "";
        if (type.equals("cart")) {
            IPageble pageble = new PageRequest(1, cartProductService.countItem(), new Sorter("createdDate", "DESC"));
            cartProductModel.setListResult(cartProductService.findByCartId(cartModel.getId(), pageble));
            view = "/views/web/Cart.jsp";
        } else if (type.equals("checkout")) {
            IPageble pageble = new PageRequest(1, cartProductService.countItem(), new Sorter("createdDate", "DESC"));
            cartProductModel.setListResult(cartProductService.findByCartProductID(cartProductModel.getIds(), pageble));
            view = "/views/web/Checkout.jsp";
        }

        colorModel.setListResult(colorService.findAll());

        capacityModel.setListResult(capacityService.findAll());

        productModel.setListResult(productService.findAll(new PageRequest()));

        imageModels.setListResult(imageService.findAll());

        req.setAttribute("cartProducts", cartProductModel);
        req.setAttribute("products", productModel);
        req.setAttribute("colors", colorModel);
        req.setAttribute("capacities", capacityModel);
        req.setAttribute("images", imageModels);
        req.getRequestDispatcher(view).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
