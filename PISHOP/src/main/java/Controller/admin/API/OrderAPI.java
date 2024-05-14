package Controller.admin.API;

import Model.OrderModel;
import Model.UserModel;
import Service.IService.IOrderService;
import Utils.HttpUtil;
import Utils.SessionUtil;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/api-order"})
public class OrderAPI extends HttpServlet {

    @Inject
    private IOrderService orderService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();

        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");

        OrderModel orderModel = HttpUtil.Of(req.getReader()).toModel(OrderModel.class);
        orderService.save(orderModel, user);
        mapper.writeValue(resp.getOutputStream(), orderModel);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();

        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
        OrderModel orderModel = HttpUtil.Of(req.getReader()).toModel(OrderModel.class);
        orderService.backOrder(orderModel.getCartProductID());
        mapper.writeValue(resp.getOutputStream(), orderModel);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doDelete(req, resp);
    }
}
