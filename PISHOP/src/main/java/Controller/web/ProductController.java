package Controller.web;

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
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/product-shop", "/product-detail"})
public class ProductController extends HttpServlet {

    @Inject
    private IProductService productService;

    @Inject
    private IBrandService brandService;

    @Inject
    private ICategoryService categoryService;

    @Inject
    private IColorService colorService;

    @Inject
    private ICapacityService capacityService;

    @Inject
    private IImageService imageService;

    @Inject
    private ICommentService commentService;

    @Inject
    private IBannerService bannerService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ProductModel productModels = FormUtil.toModel(ProductModel.class, req);
        CategoryModel cateModels = FormUtil.toModel(CategoryModel.class, req);
        BrandModel brandModels = FormUtil.toModel(BrandModel.class, req);
        ImageModel imageModels = FormUtil.toModel(ImageModel.class, req);
        BannerModel bannerModels = FormUtil.toModel(BannerModel.class, req);
        String view;
        String type = req.getParameter("type");

        if (type.equals((SystemConstant.LIST))) {

            int maxPageItem = Integer.parseInt(req.getParameter("maxPageItem"));
            String[] cateIDs = req.getParameterValues("cateID");
            String[] brandIDs = req.getParameterValues("brandID");

            List<Integer> cateIDsList = new ArrayList<>();
            if (cateIDs != null) {
                for (String cate : cateIDs) {
                    try {
                        int id = Integer.parseInt(cate.trim());
                        cateIDsList.add(id);
                    } catch (NumberFormatException e) {
                        System.out.println(e.getMessage());
                    }
                }
            }

            List<Integer> brandIDsList = new ArrayList<>();
            if (brandIDs != null) {
                for (String brand : brandIDs) {
                    try {
                        int id = Integer.parseInt(brand.trim());
                        brandIDsList.add(id);

                    } catch (NumberFormatException e) {
                        System.out.println(e.getMessage());
                    }
                }
            }

            if (!cateIDsList.isEmpty() || !brandIDsList.isEmpty()) {
                IPageble pageable = new PageRequest(productModels.getPage(), productModels.getMaxPageItem(),
                        new Sorter(productModels.getSortName(), productModels.getSortBy()));

                productModels.setListResult(productService.findByCateIDAndBrandID(pageable, cateIDsList, brandIDsList));
                productModels.setTotalItem(productModels.getListResult().size());
                productModels.setTotalPage((int) Math.ceil((double) productModels.getTotalItem() / maxPageItem));

                CategoryModel cateIDModel = new CategoryModel();
                cateIDModel.setListResult(categoryService.findByCateID(cateIDsList));
                req.setAttribute("cateID", cateIDModel);

                BrandModel brandIDModel = new BrandModel();
                brandIDModel.setListResult(brandService.findByBrandID(brandIDsList));
                req.setAttribute("brandID", brandIDModel);

            } else {
                IPageble pageable = new PageRequest();

                productModels.setListResult(productService.findAll(pageable));
                productModels.setTotalItem(productService.getTotalItem());
                productModels.setTotalPage((int) Math.ceil((double) productModels.getTotalItem() / productModels.getMaxPageItem()));


            }
            imageModels.setListResult(imageService.findAll());
            view = "/views/web/ShopProduct.jsp";

        } else if (type.equals((SystemConstant.DETAIL))) {
            ProductModel productModel = FormUtil.toModel(ProductModel.class, req);
            ColorModel colorModel = FormUtil.toModel(ColorModel.class, req);
            CapacityModel capacityModel = FormUtil.toModel(CapacityModel.class, req);
            CommentModel commentModel = FormUtil.toModel(CommentModel.class, req);
            int id = Integer.parseInt(req.getParameter("productID"));

            productModel = productService.findOne(id);
            colorModel.setListResult(colorService.findByProductID(id));
            capacityModel.setListResult(capacityService.findByProductID(id));
            imageModels.setListResult(imageService.findByProductId(id));
            commentModel.setListResult(commentService.findByProductID(id));

            req.setAttribute("colors", colorModel);
            req.setAttribute("capacities", capacityModel);
            req.setAttribute("product", productModel);
            req.setAttribute("comments", commentModel);
            view = "/views/web/Detail.jsp";
        } else {
            view = "/views/web/ShopProduct.jsp";
        }

        MessageUtil.showMessage(req);
        cateModels.setListResult(categoryService.findAll());
        brandModels.setListResult(brandService.findAll());
        bannerModels.setListResult(bannerService.findAll(new PageRequest()));

        req.setAttribute("categories", cateModels);
        req.setAttribute("brands", brandModels);
        req.setAttribute("products", productModels);
        req.setAttribute("images", imageModels);
        req.setAttribute("banners", bannerModels);
        RequestDispatcher rd = req.getRequestDispatcher(view);
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
