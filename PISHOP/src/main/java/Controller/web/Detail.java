package Controller.web;

import Model.*;
import Service.IService.*;
import Utils.FormUtil;
import Utils.SessionUtil;
import paging.PageRequest;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;


@WebServlet(urlPatterns = "/order-detail")
public class Detail extends HttpServlet {

    @Inject
    private IProductService productService;

    @Inject
    private IBrandService brandService;

    @Inject
    private ICategoryService categoryService;

    @Inject
    private IColorService colorService;

    @Inject
    private ICapacityService capacityService;

    @Inject
    private IImageService imageService;

    @Inject
    private ICommentService commentService;

    @Inject
    private IBannerService bannerService;


    @Inject
    private ICartProductService cartProductService;

    @Inject
    private ICartService cartService;

    @Inject
    private IProductInformationService productInformationService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
        ColorModel colorModel = FormUtil.toModel(ColorModel.class, req);
        CapacityModel capacityModel = FormUtil.toModel(CapacityModel.class, req);
        CartProductModel cartProductModel = FormUtil.toModel(CartProductModel.class, req);
        ImageModel imageModel = FormUtil.toModel(ImageModel.class, req);
        ProductModel productModel = FormUtil.toModel(ProductModel.class, req);
        int id = Integer.parseInt(req.getParameter("cartproductID"));
        Integer[] ids = new Integer[1];
        ids[0] = id;
        cartProductModel.setListResult(cartProductService.findByCartProductID(ids, new PageRequest()));
        colorModel.setListResult(colorService.findAll());
        capacityModel.setListResult(capacityService.findAll());
        imageModel.setListResult(imageService.findByProductId(cartProductModel.getListResult().get(0).getProductID()));
        productModel = productService.findOne(cartProductModel.getListResult().get(0).getProductID());

        req.setAttribute("colorModel", colorModel);
        req.setAttribute("capacityModel", capacityModel);
        req.setAttribute("imageModel", imageModel);
        req.setAttribute("productModel", productModel);
        req.setAttribute("cartProductModel", cartProductModel.getListResult().get(0));

        req.getRequestDispatcher("views/web/OrderDetail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doDelete(req, resp);
    }
}
