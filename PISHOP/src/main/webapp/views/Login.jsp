<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

</head>

<body>
<section class="ftco-section">
    <div class="container">
        <c:if test="${not empty message}">
            <div class="alert alert-${alert}">
                    ${message}
            </div>
        </c:if>

        <div class="row justify-content-center">
            <div class="col-md-12 col-lg-10">
                <div class="wrap d-md-flex">
                    <div class="img" style="background-image: url(
                    <c:url value="/assets/img/pikaso_texttoimage_3d-model-banner-for-smartphone-webshop-with-logo-P.jpeg"/> );">
                    </div>
                    <div class="login-wrap p-4 p-md-5">
                        <div class="d-flex">
                            <div class="w-100">
                                <h3 class="mb-4">Sign In</h3>
                            </div>
                            <div class="w-100">
                                <p class="social-media d-flex justify-content-end">
                                    <a href="#"
                                       class="social-icon d-flex align-items-center justify-content-center"><span
                                            class="fa fa-facebook"></span></a>
                                    <a href="#"
                                       class="social-icon d-flex align-items-center justify-content-center"><span
                                            class="fa fa-twitter"></span></a>
                                </p>
                            </div>
                        </div>

                        <form action="<c:url value='/login'/>" id="formLogin" method="post">
                            <div class="form-group mb-3">
                                <label class="label" for="userName">Username</label>
                                <input type="text" class="form-control" id="userName" name="userName"
                                       placeholder="Tên đăng nhập">
                            </div>

                            <div class="form-group mb-3">
                                <label class="label" for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="Mật khẩu">
                            </div>
                            <input type="hidden" value="login" name="action"/>

                            <div class="form-group">
                                <button type="submit" class="form-control btn btn-primary rounded submit px-3">
                                    Sign In
                                </button>
                            </div>

                            <div class="form-group d-md-flex">
                                <div class="w-50 text-left">
                                    <label class="checkbox-wrap checkbox-primary mb-0">Remember Me
                                        <input type="checkbox" checked>
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <div class="w-50 text-md-right">
                                    <a href="#">Forgot Password</a>
                                </div>
                            </div>
                            <p>Not a member?
                                <a id="signupLink" class="text-center" data-toggle="tab"
                                   href="<c:url value="/signup?action=signup" /> ">Sign Up</a>
                            </p>
                        </form>


                    </div>
                </div>
            </div>
        </div>
    </div>
</section>


<script>
    $(document).ready(function () {
        $("#signupLink").click(function (event) {
            // Ngăn chặn hành vi mặc định của thẻ <a> (tải lại trang)
            event.preventDefault();
            // Chuyển hướng người dùng đến trang đăng ký
            window.location.href = $(this).attr("href");
        });
    });
</script>
</body>

</html>