package Controller.admin.API;

import Model.ProductModel;
import Model.UserModel;
import Service.IService.*;
import Sort.Sorter;
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

@WebServlet(urlPatterns = "/api-admin-product")
public class ProductAPI extends HttpServlet {

    @Inject
    private IProductService productService;

    @Inject
    private IColorService colorService;

    @Inject
    private ICapacityService capacityService;

    @Inject
    private ICartProductService cartProductService;

    @Inject
    private IImageService imageService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();

        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");

        ProductModel productModel = HttpUtil.Of(req.getReader()).toModel(ProductModel.class);

        imageService.save(productModel, user);
        IPageble pageble = new PageRequest(productModel.getPage(), productModel.getMaxPageItem(),
                new Sorter(productModel.getSortName(), productModel.getSortBy()));
        Integer[] colorID = productModel.getColorIDs();
        Integer[] capacityID = productModel.getCapacityIDs();

        productModel = productService.save(productModel, pageble, user);

        colorService.insertProductColors(productModel.getId(), colorID);
        capacityService.insertProductCapacity(productModel.getId(), capacityID);

        mapper.writeValue(resp.getOutputStream(), productModel);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();

        ProductModel updateProductModel = HttpUtil.Of(req.getReader()).toModel(ProductModel.class);
        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");

        if (updateProductModel.getType().equalsIgnoreCase("enable")) {
            productService.enableProduct(updateProductModel.getId());
        } else if (updateProductModel.getType().equalsIgnoreCase("disable")) {
            productService.disableProduct(updateProductModel.getId());
        } else {
            imageService.update(updateProductModel, user);
            colorService.insertProductColors(updateProductModel.getId(), updateProductModel.getColorIDs());
            capacityService.insertProductCapacity(updateProductModel.getId(), updateProductModel.getCapacityIDs());
            updateProductModel = productService.update(updateProductModel, user);

        }
        mapper.writeValue(resp.getOutputStream(), updateProductModel);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();
        ProductModel deleteProductModel = HttpUtil.Of(req.getReader()).toModel(ProductModel.class);
        colorService.deleteProductColors(deleteProductModel.getIds());
        capacityService.deleteAllProductCapacities(deleteProductModel.getIds());
        cartProductService.deleteByProductID(deleteProductModel.getIds());
        productService.delete(deleteProductModel.getIds());
        mapper.writeValue(resp.getOutputStream(), deleteProductModel);
    }


}
