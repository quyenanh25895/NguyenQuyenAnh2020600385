package Controller.admin.API;

import Model.*;
import Payments.Configs;
import Service.IService.ICartProductService;
import Service.IService.ICartService;
import Service.IService.ICouponService;
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

    @Inject
    private ICouponService couponService;


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
                    mapper.writeValue(resp.getOutputStream(), submitProductModel);
                } else if (status == 4) {
                    cartProductService.confirmBackOrder(submitProductModel.getId());
                    mapper.writeValue(resp.getOutputStream(), submitProductModel);
                }
            }

        } else {
            if (status != null) {
                if (status == 0) {
                    if (submitProductModel.getType().equals("off")) {
                        String code = submitProductModel.getCouponCode();
                        CouponModel couponModel = couponService.findByCode(code);
                        if (couponModel != null && couponModel.getQuantity() > 0) {
                            cartProductService.submitProductToCart(submitProductModel.getIds(), 1, Integer.valueOf(Configs.getRandomNumber(8)), couponModel.getDiscount());

                        } else if (couponModel == null) {
                            cartProductService.submitProductToCart(submitProductModel.getIds(), 1, Integer.valueOf(Configs.getRandomNumber(8)), 0);
                        }
                        mapper.writeValue(resp.getOutputStream(), submitProductModel);
                    } else if (submitProductModel.getType().equals("onl")) {
                        String code = submitProductModel.getCouponCode();
                        CouponModel couponModel = couponService.findByCode(code);
                        if (couponModel != null && couponModel.getQuantity() > 0) {
                            submitProductModel.setListResult(cartProductService.vnpayCode(Integer.valueOf(Configs.getRandomNumber(8)), submitProductModel.getIds(), couponModel.getDiscount()));
                            mapper.writeValue(resp.getOutputStream(), submitProductModel.getListResult().get(0));
                        }else if (couponModel == null) {
                            submitProductModel.setListResult(cartProductService.vnpayCode(Integer.valueOf(Configs.getRandomNumber(8)), submitProductModel.getIds(), 0));
                            mapper.writeValue(resp.getOutputStream(), submitProductModel.getListResult().get(0));
                        }

                    }
                } else if (status == 1) {
                    cartProductService.denyProductFromCart(submitProductModel.getIds());
                    submitProductModel.setListResult(cartProductService.findByCartProductID(submitProductModel.getIds(), new PageRequest()));
                    mapper.writeValue(resp.getOutputStream(), submitProductModel.getListResult().get(0));
                } else if (status == 2) {
                    cartProductService.confirmOrder(submitProductModel.getId());
                    mapper.writeValue(resp.getOutputStream(), submitProductModel);
                } else if (status == 3) {
                    cartProductService.backOrder(submitProductModel.getId());
                    mapper.writeValue(resp.getOutputStream(), submitProductModel);
                }

            }
        }

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
