package Controller.admin;

import Model.*;
import Service.IService.*;
import Sort.Sorter;
import Utils.FormUtil;
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

@WebServlet(urlPatterns = {"/admin-cart"})
public class CartController extends HttpServlet {

    @Inject
    private IProductService productService;

    @Inject
    private IUserService userService;

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
//        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
        String view = "";

        CartModel model = FormUtil.toModel(CartModel.class, req);

        UserModel userModel = FormUtil.toModel(UserModel.class, req);
        userModel.setListResult(userService.findAll(new PageRequest()));

        ColorModel colorModel = new ColorModel();
        colorModel.setListResult(colorService.findAll());

        CapacityModel capacityModel = new CapacityModel();
        capacityModel.setListResult(capacityService.findAll());

        IPageble pageable = new PageRequest(model.getPage(), model.getMaxPageItem(),
                new Sorter(model.getSortName(), model.getSortBy()));

        ProductModel productModel = FormUtil.toModel(ProductModel.class, req);
        productModel.setListResult(productService.findAll(new PageRequest()));

        CartProductModel cartProductModel = FormUtil.toModel(CartProductModel.class, req);
        ImageModel imageModels = FormUtil.toModel(ImageModel.class, req);
        ProductImageModel productImageModels = FormUtil.toModel(ProductImageModel.class, req);

        cartProductModel.setListResult(cartProductService.findJoin(pageable));
        cartProductModel.setTotalItem(cartProductService.countItem());

        cartProductModel.setTotalPage((int) Math.ceil((double) cartProductModel.getTotalItem() / cartProductModel.getMaxPageItem()));

        imageModels.setListResult(imageService.findAll());
        productImageModels.setListResult(productImageService.findAll());

        view = "/views/admin/Cart/Order.jsp";
        req.setAttribute("users", userModel);
        req.setAttribute("cartProducts", cartProductModel);
        req.setAttribute("products", productModel);
        req.setAttribute("colors", colorModel);
        req.setAttribute("capacities", capacityModel);
        req.setAttribute("images", imageModels);
        req.setAttribute("productImages", productImageModels);
        RequestDispatcher rd = req.getRequestDispatcher(view);
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
