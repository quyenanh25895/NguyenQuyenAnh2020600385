package Controller.web;

import Constants.SystemConstant;
import Model.CartModel;
import Model.EmailModel;
import Model.StaticalModel;
import Model.UserModel;
import Service.IService.ICartProductService;
import Service.IService.ICartService;
import Service.IService.IStaticalService;
import Service.IService.IUserService;
import Service.UserService;
import Utils.EmailUtil;
import Utils.FormUtil;
import Utils.MessageUtil;
import Utils.SessionUtil;

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
import java.util.Objects;
import java.util.Random;

@WebServlet(urlPatterns = {"/user", "/information"})
public class UserController extends HttpServlet {

    @Inject
    private IUserService userService;

    @Inject
    private IStaticalService staticalService;

    @Inject
    private ICartProductService cartProductService;

    @Inject
    private ICartService cartService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserModel model = FormUtil.toModel(UserModel.class, req);
        UserModel user = (UserModel) SessionUtil.getInstance().getValue(req, "USERMODEL");
        String view = "";
        String type = req.getParameter("type");

        if (type.equals("getcode")) {
            req.setAttribute(SystemConstant.MODEL, model);
            view = "/views/web/ForgotPassword.jsp";
        } else if (type.equals("submitcode")) {
            String code = req.getParameter("code");
            if (userService.checkCode(code)) {
                String userName = req.getParameter("userName");
                String email = req.getParameter("email");
                model = userService.findByUserNameAndEmail(userName, email);
                req.setAttribute("model", model);
                view = "/views/web/ChangePassword.jsp";
            } else if (!userService.checkCode(code)) {
                view = "/views/web/ForgotPassword.jsp";
                req.setAttribute("message", "Đã quá thời gian sử dụng");
                req.setAttribute("alert", "danger");
            }

        } else if (type.equals("information")) {
            List<StaticalModel> staticalModels = new ArrayList<>();
            StaticalModel staticalModel = new StaticalModel();
            staticalModels = staticalService.getPriceByUserID();
            for (StaticalModel s : staticalModels) {
                if (Objects.equals(user.getId(), s.getUserID())) {
                    staticalModel = s;
                }
            }
            req.setAttribute("staticalModels", staticalModels);
            req.setAttribute("staticalModel", staticalModel);
            req.setAttribute(SystemConstant.MODEL, model);
            view = "views/web/UserInformation.jsp";
        }else if (type.equals("changepassword")){
            userService.saveCode(user, "12345678");
            req.setAttribute("model", user);
            view = "/views/web/ChangePassword.jsp";
        }
        if (user != null) {
            CartModel cartModel = cartService.findByUserID(user.getId());
            Integer cartItem = cartProductService.countProduct(cartModel.getId());
            req.setAttribute("cartItem", cartItem);
        }

        MessageUtil.showMessage(req);
        RequestDispatcher rd = req.getRequestDispatcher(view);
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserModel model = FormUtil.toModel(UserModel.class, req);
        String view = "";
        String type = model.getType();
        if (type.equals("getcode")) {
            model = userService.findByUserNameAndEmail(model.getUserName(), model.getEmail());
            if (model != null && model.getStatus() == 1) {
                Random random = new Random();
                // Tạo chuỗi ngẫu nhiên 8 số
                StringBuilder codeBuilder = new StringBuilder();
                for (int i = 0; i < 8; i++) {
                    // Sinh số ngẫu nhiên từ 0 đến 9 và thêm vào chuỗi
                    codeBuilder.append(random.nextInt(10));
                }
                String code = codeBuilder.toString();
                userService.saveCode(model, code);
                try {
                    EmailModel email = new EmailModel();
                    email.setTo(model.getEmail());
                    email.setSubject("Forgot Password Function");
                    StringBuilder sb = new StringBuilder();
                    sb.append("<div style=\"font-family: Arial, sans-serif; color: #333; font-size: 16px;\">");
                    sb.append("Dear ").append(model.getUserName()).append(",<br><br>");
                    sb.append("You have requested to reset your password.<br><br>");
                    sb.append("<strong style=\"color: #009688;\">Your Code is  : ").append(code).append("</strong><br><br>");
                    String path = "http://localhost:1409/PISHOP_war_exploded/user?type=submitcode&userName="
                            + model.getUserName() + "&email=" + model.getEmail() + "&code=" + code;
                    sb.append("<a href='" + path + "'>" + "Click" + "<a/>" + "<br>");
                    sb.append("Regards,<br>");
                    sb.append("Administrator");
                    sb.append("</div>");
                    email.setContent(sb.toString());
                    EmailUtil.send(email);
                    req.setAttribute("message", "Mật khẩu đã được gửi đến Email của bạn!");
                    req.setAttribute("alert", "success");
                } catch (Exception e) {
                    e.printStackTrace();
                }
                req.getRequestDispatcher("/views/web/ForgotPassword.jsp").forward(req, resp);
            }
        } else if (type.equals("submitcode")) {
            String userName = req.getParameter("userName");
            String email = req.getParameter("email");
            model = userService.findByUserNameAndEmail(userName, email);
            req.setAttribute("model", model);
            req.getRequestDispatcher("/views/web/ChangePassword.jsp").forward(req, resp);
        }


    }

}

