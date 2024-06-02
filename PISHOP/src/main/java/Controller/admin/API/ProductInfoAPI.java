package Controller.admin.API;

import Model.ProductInformationModel;
import Model.ProductModel;
import Model.UserModel;
import Service.IService.IProductInformationService;
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

@WebServlet(urlPatterns = {"/api-admin-productInfo"})
public class ProductInfoAPI extends HttpServlet {

    @Inject
    private IProductInformationService productInformationService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        ObjectMapper mapper = new ObjectMapper();

        ProductInformationModel update = HttpUtil.Of(req.getReader()).toModel(ProductInformationModel.class);
        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
        productInformationService.update(update);
        update = productInformationService.findOne(update.getProductID());
        mapper.writeValue(resp.getOutputStream(), update);
    }
}
