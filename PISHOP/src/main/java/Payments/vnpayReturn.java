package Payments;

import Model.*;
import Service.IService.*;
import Utils.FormUtil;
import Utils.MessageUtil;
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
import java.util.List;

@WebServlet("/vnpay_return")
public class vnpayReturn extends HttpServlet {

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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy các tham số trả về từ VNPAY
        String vnp_ResponseCode = req.getParameter("vnp_ResponseCode");
        String vnp_TxnRef = req.getParameter("vnp_TxnRef"); // Mã đơn hàng
        String cartID = req.getParameter("cartID");
        List<CartProductModel> cartProductModel = cartProductService.findByCartCode(Integer.parseInt(vnp_TxnRef));
        List<Integer> ids = new ArrayList<>();
        for (CartProductModel c : cartProductModel) {
            ids.add(c.getId());
        }
        if ("00".equals(vnp_ResponseCode)) {

            cartProductService.submitProductToCart(ids.toArray(new Integer[0]), 2, Integer.parseInt(vnp_TxnRef), cartProductModel.get(0).getDiscount());
            req.getRequestDispatcher("/cart?type=cart&message=insert_success&alert=success").forward(req, resp);

        } else {
            cartProductService.submitProductToCart(ids.toArray(new Integer[0]), 0, 0, 0);
            req.getRequestDispatcher("/cart?type=cart&message=insert_error&alert=danger").forward(req, resp);
        }
    }
}
