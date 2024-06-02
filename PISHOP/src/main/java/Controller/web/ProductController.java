package Controller.web;

import Constants.SystemConstant;
import Model.*;
import Service.IService.*;
import Sort.Sorter;
import Utils.FormUtil;
import Utils.MessageUtil;
import Utils.SessionUtil;
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
import java.util.*;

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

    @Inject
    private ICartProductService cartProductService;

    @Inject
    private ICartService cartService;

    @Inject
    private IProductInformationService productInformationService;

    @Inject
    private IUserService userService;

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
            int maxPageItem = productService.countItem();
            String cateIDs = req.getParameter("cateID");
            String brandIDs = req.getParameter("brandID");
            List<Integer> cateIDsList = new ArrayList<>();
            if (cateIDs != null && !cateIDs.isEmpty() && !cateIDs.isBlank()) {
                String[] cateID = cateIDs.split(",");
                for (String cate : cateID) {
                    try {
                        cateIDsList.add(Integer.parseInt(cate.trim()));
                    } catch (NumberFormatException e) {
                        System.out.println(e.getMessage());
                    }
                }
            }
            List<Integer> brandIDsList = new ArrayList<>();
            if (brandIDs != null && !brandIDs.isEmpty() && !brandIDs.isBlank()) {
                String[] brandID = brandIDs.split(",");
                for (String brand : brandID) {
                    try {
                        brandIDsList.add(Integer.parseInt(brand.trim()));
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
            }
            imageModels.setListResult(imageService.findAll());
            req.setAttribute("products", productModels);
            req.setAttribute("images", imageModels);
            view = "/views/web/ShopProduct.jsp";

        } else if (type.equals((SystemConstant.DETAIL))) {
            ColorModel colorModel = FormUtil.toModel(ColorModel.class, req);
            CapacityModel capacityModel = FormUtil.toModel(CapacityModel.class, req);
            CommentModel commentModel = FormUtil.toModel(CommentModel.class, req);
            int id = Integer.parseInt(req.getParameter("productID"));

            productModels = productService.findOne(id);
            colorModel.setListResult(colorService.findByProductID(id));
            capacityModel.setListResult(capacityService.findByProductID(id));
            imageModels.setListResult(imageService.findByProductId(id));
            commentModel.setListResult(commentService.findByProductID(id));

            List<ImageModel> otherImage = imageService.findAll();
            ImageModel imageModel = FormUtil.toModel(ImageModel.class, req);

            imageModel.setListResult(imageService.findAll());

            List<ProductModel> otherProduct = new ArrayList<>();
            otherProduct = productService.findByCateIDAndBrandID(new PageRequest(), Collections.singletonList(productModels.getCateID()), Collections.singletonList(null));

            Random random = new Random();
            List<ProductModel> showProduct = new ArrayList<>();

            ProductModel productModel = FormUtil.toModel(ProductModel.class, req);
            productModel.setListResult(productService.findByCateIDAndBrandID(new PageRequest(), Collections.singletonList(productModels.getCateID()), Collections.singletonList(null)));
            int firstRandomIndex;
            int secondRandomIndex;
            do {
                firstRandomIndex = random.nextInt(otherProduct.size());
                do {
                    secondRandomIndex = random.nextInt(otherProduct.size());
                } while (secondRandomIndex == firstRandomIndex);
            } while (id == firstRandomIndex || id == secondRandomIndex);

            showProduct.add(otherProduct.get(firstRandomIndex));
            showProduct.add(otherProduct.get(secondRandomIndex));
            showProduct.get(0).setListResult(showProduct);
            ProductInformationModel productInformationModel = FormUtil.toModel(ProductInformationModel.class, req);
            productInformationModel = productInformationService.findOne(id);
            UserModel userModel= new UserModel();
             userModel.setListResult(userService.findAll(new PageRequest()));
            req.setAttribute("productInformation", productInformationModel);
            req.setAttribute("image", imageModels);
            req.setAttribute("images", imageModel);
            req.setAttribute("colors", colorModel);
            req.setAttribute("capacities", capacityModel);
            req.setAttribute("product", productModels);
            req.setAttribute("products", productModel);
            req.setAttribute("comments", commentModel);
            req.setAttribute("otherProduct", showProduct.get(0));
            req.setAttribute("otherImage", otherImage);
            req.setAttribute("userModels", userModel);
            view = "/views/web/Detail.jsp";
        } else {
            req.setAttribute("products", productModels);
            req.setAttribute("images", imageModels);
            view = "/views/web/ShopProduct.jsp";
        }

        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");

        if (user != null) {

            CartModel cartModel = cartService.findByUserID(user.getId());
            Integer cartItem = cartProductService.countProduct(cartModel.getId());
            req.setAttribute("cartItem", cartItem);
        }

        MessageUtil.showMessage(req);
        cateModels.setListResult(categoryService.findAll());
        brandModels.setListResult(brandService.findAll());
        bannerModels.setListResult(bannerService.findAll(new PageRequest()));

        req.setAttribute("type", "shop");
        req.setAttribute("categories", cateModels);
        req.setAttribute("brands", brandModels);
        req.setAttribute("banners", bannerModels);

        RequestDispatcher rd = req.getRequestDispatcher(view);
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
