package Controller.admin;

import Constants.SystemConstant;
import Model.*;
import Service.IService.*;
import Sort.Sorter;
import Utils.FormUtil;
import Utils.MessageUtil;
import paging.IPageble;
import paging.PageRequest;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/admin-product"})
public class ProductController extends HttpServlet {
    @Inject
    private IProductService productService;

    @Inject
    private ICategoryService categoryService;

    @Inject
    private IColorService colorService;

    @Inject
    private IBrandService brandService;

    @Inject
    private ICapacityService capacityService;

    @Inject
    private IImageService imageService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductModel model = FormUtil.toModel(ProductModel.class, req);
        CategoryModel cateModels = FormUtil.toModel(CategoryModel.class, req);
        BrandModel brandModels = FormUtil.toModel(BrandModel.class, req);
        ColorModel colorModels = FormUtil.toModel(ColorModel.class, req);
        CapacityModel capacityModels = FormUtil.toModel(CapacityModel.class, req);
        ImageModel imageModels = FormUtil.toModel(ImageModel.class, req);

        colorModels.setListResult(colorService.findAll());
        capacityModels.setListResult(capacityService.findAll());
        cateModels.setListResult(categoryService.findAll());
        brandModels.setListResult(brandService.findAll());
        imageModels.setListResult(imageService.findAll());
        String view = "";

        if (model.getType().equals(SystemConstant.EDIT)) {
            Integer page = 1;
            if (model.getId() != null) {

                if (model.getPage() !=null){
                    page = model.getPage();
                }
                model = productService.findOne(model.getId());
                model.setPage(page);
                ColorModel productcolorModels = FormUtil.toModel(ColorModel.class, req);
                CapacityModel productcapacityModels = FormUtil.toModel(CapacityModel.class, req);
                productcolorModels.setListResult(colorService.findByProductID(model.getId()));
                productcapacityModels.setListResult(capacityService.findByProductID(model.getId()));
                req.setAttribute("productcolors", productcolorModels);
                req.setAttribute("productcapacities", productcapacityModels);

            }
            model.setPage(page);
            view = "/views/admin/Product/EditProduct.jsp";

        }else if(model.getType().equals(SystemConstant.LIST)){

            IPageble pageble = new PageRequest(model.getPage(), model.getMaxPageItem(),
                    new Sorter(model.getSortName(), model.getSortBy()));
            model.setListResult(productService.findAll(pageble));
            model.setTotalItem(productService.countItem());
            model.setTotalPage((int) Math.ceil((double) model.getTotalItem() / model.getMaxPageItem()));
            view = "/views/admin/Product/ListProduct.jsp";
        }

        MessageUtil.showMessage(req);
        req.setAttribute("colors", colorModels);
        req.setAttribute("capacities", capacityModels);
        req.setAttribute("brands",brandModels);
        req.setAttribute("cate", cateModels);
        req.setAttribute("images", imageModels);
        req.setAttribute(SystemConstant.MODEL, model);
        RequestDispatcher rd = req.getRequestDispatcher(view);
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
