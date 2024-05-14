package Controller.admin.API;

import Model.*;
import Service.IService.IBrandService;
import Service.IService.ICapacityService;
import Service.IService.ICategoryService;
import Service.IService.IColorService;
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

@WebServlet(urlPatterns = {"/api-admin-properties"})
public class PropertiesAPI extends HttpServlet {

    @Inject
    private IColorService colorService;

    @Inject
    private ICapacityService capacityService;

    @Inject
    private IBrandService brandService;

    @Inject
    private ICategoryService categoryService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
        ObjectMapper mapper = new ObjectMapper();

        String type = req.getParameter("type");
        if (type.equalsIgnoreCase("color")) {
            ColorModel colorModel = HttpUtil.Of(req.getReader()).toModel(ColorModel.class);
            if (!colorModel.getColorCode().isBlank() && !colorModel.getColorCode().isEmpty() && colorService.checkExist(colorModel.getColorCode())) {
                colorService.save(colorModel);
                mapper.writeValue(resp.getOutputStream(), colorModel);
            } else if(!colorService.checkExist(colorModel.getColorCode())){
                resp.setStatus(HttpServletResponse.SC_CONFLICT);
            }

        } else if (type.equalsIgnoreCase("capacity")) {
            CapacityModel capacityModel = HttpUtil.Of(req.getReader()).toModel(CapacityModel.class);
            if (capacityModel.getCapacityValue() != null && capacityModel.getCapacityValue() > 0 && capacityService.checkExist(capacityModel.getCapacityValue())) {
                capacityService.save(capacityModel);
                mapper.writeValue(resp.getOutputStream(), capacityModel);
            } else if(!capacityService.checkExist(capacityModel.getCapacityValue())){
                resp.setStatus(HttpServletResponse.SC_CONFLICT);
            }
        } else if (type.equalsIgnoreCase("brand")) {
            BrandModel brandModel = HttpUtil.Of(req.getReader()).toModel(BrandModel.class);
            if (!brandModel.getBrandName().isBlank() && !brandModel.getBrandName().isEmpty() && brandService.checkExist(brandModel.getBrandName())) {
                brandService.save(brandModel);
                mapper.writeValue(resp.getOutputStream(), brandModel);
            } else if(!brandService.checkExist(brandModel.getBrandName())){
                resp.setStatus(HttpServletResponse.SC_CONFLICT);
            }
        } else if (type.equalsIgnoreCase("category")) {
            CategoryModel categoryModel = HttpUtil.Of(req.getReader()).toModel(CategoryModel.class);
            if (categoryModel.getCateName() != null && !categoryModel.getCateName().isEmpty() && categoryService.checkExist(categoryModel.getCateName())) {
                categoryService.save(categoryModel);
                mapper.writeValue(resp.getOutputStream(), categoryModel);
            } else if(categoryService.checkExist(categoryModel.getCateName())){
                resp.setStatus(HttpServletResponse.SC_CONFLICT);
            }
        }

    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");
        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
        ObjectMapper mapper = new ObjectMapper();
        String type = req.getParameter("type");

        if (type.equalsIgnoreCase("color")) {
            ColorModel colorModel = HttpUtil.Of(req.getReader()).toModel(ColorModel.class);
            if (!colorModel.getColorCode().isBlank() && !colorModel.getColorCode().isEmpty() && colorService.checkExist(colorModel.getColorCode())) {
                colorService.update(colorModel);
                mapper.writeValue(resp.getOutputStream(), colorModel);
            } else if(!colorService.checkExist(colorModel.getColorCode())){
                resp.setStatus(HttpServletResponse.SC_CONFLICT);
            }

        } else if (type.equalsIgnoreCase("capacity")) {
            CapacityModel capacityModel = HttpUtil.Of(req.getReader()).toModel(CapacityModel.class);
            if (capacityModel.getCapacityValue() != null && capacityModel.getCapacityValue() > 0 && capacityService.checkExist(capacityModel.getCapacityValue())) {
                capacityService.update(capacityModel);
                mapper.writeValue(resp.getOutputStream(), capacityModel);
            } else if(!capacityService.checkExist(capacityModel.getCapacityValue())){
                resp.setStatus(HttpServletResponse.SC_CONFLICT);
            }
        } else if (type.equalsIgnoreCase("brand")) {
            BrandModel brandModel = HttpUtil.Of(req.getReader()).toModel(BrandModel.class);
            if (!brandModel.getBrandName().isBlank() && !brandModel.getBrandName().isEmpty() && brandService.checkExist(brandModel.getBrandName())) {
                brandService.update(brandModel);
                mapper.writeValue(resp.getOutputStream(), brandModel);
            } else if(!brandService.checkExist(brandModel.getBrandName())){
                resp.setStatus(HttpServletResponse.SC_CONFLICT);
            }
        } else if (type.equalsIgnoreCase("category")) {
            CategoryModel categoryModel = HttpUtil.Of(req.getReader()).toModel(CategoryModel.class);
            if (categoryModel.getCateName() != null && !categoryModel.getCateName().isEmpty() && categoryService.checkExist(categoryModel.getCateName())) {
                categoryService.update(categoryModel);
                mapper.writeValue(resp.getOutputStream(), categoryModel);
            } else if(categoryService.checkExist(categoryModel.getCateName())){
                resp.setStatus(HttpServletResponse.SC_CONFLICT);
            }
        }

    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doDelete(req, resp);
    }
}
