package Utils;

import javax.servlet.http.HttpServletRequest;

public class MessageUtil {

    public static void showMessage(HttpServletRequest request) {
        if (request.getParameter("message") != null) {
            String messageResponse = "";
            String alert = "";
            String message = request.getParameter("message");
            if (message.equals("insert_success")) {
                messageResponse = "Insert success";
                alert = "success";
            } else if (message.equals("update_success")) {
                messageResponse = "Update success";
                alert = "success";
            } else if (message.equals("delete_success")) {
                messageResponse = "Delete success";
                alert = "success";
            } else if (message.equals("error_system")) {
                messageResponse = "Error system";
                alert = "danger";
            } else if (message.equals("error_conflict")) {
                messageResponse = "Conflict";
                alert = "danger";
            } else if (message.equals("null_element")) {
                messageResponse = "Null";
                alert = "danger";
            } else if (message.equals("order_success")) {
                messageResponse = "Đặt hàng thành công";
                alert = "success";
            } else if (message.equals("order_error")) {
                messageResponse = "Đặt hàng không thành công";
                alert = "danger";
            } else if (message.equals("not_permission")) {
                messageResponse = "Không có quyền sử dụng";
                alert = "danger";
            } else if (message.equals("not_login")) {
                messageResponse = "Chưa đăng nhập";
                alert = "danger";
            }
            request.setAttribute("messageResponse", messageResponse);
            request.setAttribute("alert", alert);
        }
    }
}
