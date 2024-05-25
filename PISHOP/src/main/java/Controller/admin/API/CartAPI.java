package Controller.admin.API;

import Model.CartModel;
import Model.CartProductModel;
import Model.ProductModel;
import Model.UserModel;
import Payments.Configs;
import Service.IService.ICartProductService;
import Service.IService.ICartService;
import Utils.HttpUtil;
import Utils.SessionUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import paging.PageRequest;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/api-cart"})
public class CartAPI extends HttpServlet {

    @Inject
    private ICartService cartService;

    @Inject
    private ICartProductService cartProductService;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();

        ProductModel productModel = HttpUtil.Of(req.getReader()).toModel(ProductModel.class);
        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");

        CartModel cartModel = cartService.findByUserID(user.getId());
        CartProductModel cartProductModel = new CartProductModel();

        cartProductService.saveProductToCart(cartModel.getId(), productModel);

        cartProductModel.setListResult(cartProductService.findByCartId(cartModel.getId(), new PageRequest()));
        mapper.writeValue(resp.getOutputStream(), productModel);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();

        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
        CartProductModel submitProductModel = HttpUtil.Of(req.getReader()).toModel(CartProductModel.class);
        Integer status = submitProductModel.getStatus();
        if (user.getRoleId() == 1) {
            if (status != null) {
                if (status == 1 || status == 6) {
                    cartProductService.submitOrder(submitProductModel.getId());
                } else if (status == 4) {
                    cartProductService.confirmBackOrder(submitProductModel.getId());
                }
            }
        } else {
            if (status != null) {
                if (status == 0) {
                    if (submitProductModel.getType().equals("off")) {
                        cartProductService.submitProductToCart(submitProductModel.getIds(), 1, Integer.valueOf(Configs.mdh));
                    } else if (submitProductModel.getType().equals("onl")) {
                        cartProductService.vnpayCode(Integer.valueOf(Configs.mdh), submitProductModel.getIds());
                    }
                } else if (status == 1) {
                    cartProductService.denyProductFromCart(submitProductModel.getIds());
                } else if (status == 2) {
                    cartProductService.confirmOrder(submitProductModel.getId());
                } else if (status == 3) {
                    cartProductService.backOrder(submitProductModel.getId());
                }
            }
        }
        mapper.writeValue(resp.getOutputStream(), submitProductModel);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();
        CartProductModel deleteProductModel = HttpUtil.Of(req.getReader()).toModel(CartProductModel.class);

        cartProductService.deleteProductFromCart(deleteProductModel.getIds());
        mapper.writeValue(resp.getOutputStream(), deleteProductModel);
    }
}
