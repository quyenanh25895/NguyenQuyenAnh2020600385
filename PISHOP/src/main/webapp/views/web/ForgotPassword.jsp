<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <title>Title</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<div class="main-div">
    <section class="signup">
        <div class="container">
            <c:if test="${not empty message}">
                <div class="alert alert-${alert}">
                        ${message}
                </div>
            </c:if>
            <div class="signup-content" style="margin-top: 20px">
                <div class="signup-form">
                    <h2 class="form-title">Quên mật khẩu</h2>
                    <form action="<c:url value="/user" />" class="forgot-form" id="forgotForm" method="POST"
                          style="display: block">
                        <div class="form-group">
                            <input type="text" class="form-control" id="email" name="email" value=""
                                   placeholder="Email">
                        </div>

                        <div class="form-group">
                            <input type="text" class="form-control" id="userName" name="userName"
                                   placeholder="Tên đăng nhập">
                        </div>

                        <div class="form-group form-button">
                            <input type="submit" name="btnForgot" id="btnForgot" class="form-submit"
                                   value="Quên mật khẩu"/>
                        </div>
                        <input type="hidden" name="type" value="getcode">
                    </form>

                </div>
                <div class="signup-image" style="border-radius: 20px">
                    <figure>
                        <img src="<c:url value="/assets/img/pikaso_texttoimage_3d-model-banner-for-smartphone-webshop-with-logo-P.jpeg" /> "
                             alt="sing up image">
                    </figure>
                    <a id="LoginLink" href="<c:url value="/login?action=login" />" class="signup-image-link">
                        Bạn đã có tài khoản? Đăng nhập ngay
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS and jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>

    </script>

</div>
</body>

</html>