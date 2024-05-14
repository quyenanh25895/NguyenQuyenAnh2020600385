package Controller.admin;

import Model.BannerModel;
import Service.IService.IBannerService;
import paging.PageRequest;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/admin-home")
public class HomeController extends HttpServlet {

    @Inject
    private IBannerService bannerService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        BannerModel bannerModel = new BannerModel();
        bannerModel.setListResult(bannerService.findAll(new PageRequest()));
        req.setAttribute("bannerModels", bannerModel);
        RequestDispatcher rd = req.getRequestDispatcher("/views/admin/home.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
