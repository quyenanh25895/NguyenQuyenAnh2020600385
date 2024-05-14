package Controller.admin;

import Model.*;
import Service.IService.IBrandService;
import Service.IService.ICapacityService;
import Service.IService.ICategoryService;
import Service.IService.IColorService;
import Utils.FormUtil;
import Utils.MessageUtil;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(urlPatterns = {"/admin-properties"})
public class PropertiesController  extends HttpServlet {

    @Inject
    private IColorService colorService;

    @Inject
    private ICapacityService capacityService;

    @Inject
    private IBrandService brandService;

    @Inject
    private ICategoryService categoryService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserModel userModel = FormUtil.toModel(UserModel.class, req);
        String view ="";
        if (userModel != null) {
            if (userModel.getType().equalsIgnoreCase("colorcapacity")) {
                ColorModel colorModel = new ColorModel();
                colorModel.setListResult(colorService.findAll());

                CapacityModel capacityModel = new CapacityModel();
                capacityModel.setListResult(capacityService.findAll());

                req.setAttribute("colors", colorModel);
                req.setAttribute("capacities", capacityModel);
                view ="views/admin/Properties/ColorCapacity.jsp";
            } else if (userModel.getType().equalsIgnoreCase("brandcategory")){
                BrandModel brandModel = new BrandModel();
                CategoryModel categoryModel = new CategoryModel();

                brandModel.setListResult(brandService.findAll());
                categoryModel.setListResult(categoryService.findAll());

                req.setAttribute("brands", brandModel);
                req.setAttribute("categories", categoryModel);
                view ="views/admin/Properties/BrandCategory.jsp";
            }
        }
        MessageUtil.showMessage(req);
        req.getRequestDispatcher(view).forward(req, resp);
    }
}
