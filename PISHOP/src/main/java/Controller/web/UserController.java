package Controller.web;

import Constants.SystemConstant;
import Model.EmailModel;
import Model.UserModel;
import Service.UserService;
import Utils.EmailUtil;
import Utils.FormUtil;
import Utils.MessageUtil;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Random;

@WebServlet(urlPatterns = "/user")
public class UserController extends HttpServlet {

    @Inject
    private UserService userService;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserModel model = FormUtil.toModel(UserModel.class, req);
        String view = "";
        String type = req.getParameter("type");

        if (type.equals("getcode")) {
            view = "/views/web/ForgotPassword.jsp";
        }

        if (model.getType().equals(SystemConstant.EDIT)) {
            view = "/views/SignUp.jsp";
        }

        MessageUtil.showMessage(req);
        req.setAttribute(SystemConstant.MODEL, model);
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
                    sb.append("<strong style=\"color: #009688;\">Your password is: ").append(code).append("</strong><br><br>");
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
        }


    }

}

