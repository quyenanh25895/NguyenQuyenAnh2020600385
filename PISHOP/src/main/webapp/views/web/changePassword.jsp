<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:url var="APIUserUrl" value="/api-user"/>
<c:url var="UserUrl" value="/user"/>
<c:url var="LoginUrl" value="/login"/>
<head>
    <title>Title</title>
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
                    <form class="forgot-form" id="forgotForm" method="POST" novalidate>
                        <h3>${model.userName}</h3>
                        <div class="form-group">
                            <input type="text" class="form-control" name="password" value="" placeholder="Mật khẩu mới">
                        </div>
                        <input type="hidden" name="userName" value="${model.userName}">

                        <input type="hidden" name="fullName" value="${model.fullName}">

                        <input type="hidden" name="email" value="${model.email}">

                        <input type="hidden" name="phoneNumber" value="${model.phoneNumber}">

                        <input type="hidden" name="address" value="${model.address}">

                        <input type="hidden" name="gender" value="${model.gender}">

                        <input type="hidden" name="roleId" value="${model.roleId}">

                        <input type="hidden" name="status" value="${model.status}">

                        <input type="hidden" name="id" value="${model.id}">

                        <input type="hidden" name="type" value="submitcode">
                        <div class="form-group form-button">
                            <input type="button" name="btnForgot" id="btnForgot" class="form-submit"
                                   value="Quên mật khẩu"/>
                        </div>
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
    <script>
        $(document).ready(function () {
            // Custom method for strong password
            $.validator.addMethod("strongPassword", function (value, element) {
                return this.optional(element)
                    || /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/.test(value);
            }, "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt");

            var validation = $("#forgotForm").validate({
                rules: {
                    fullName: {
                        required: true,
                        minlength: 2
                    },
                    email: {
                        required: true,
                        email: true
                    },
                    phoneNumber: {
                        required: true,
                        digits: true,
                        minlength: 10,
                        maxlength: 11
                    },
                    userName: {
                        required: true,
                        minlength: 8
                    },
                    password: {
                        required: true,
                        strongPassword: true
                    }
                },
                messages: {
                    fullName: {
                        required: "Vui lòng nhập họ tên",
                        minlength: "Họ tên phải có ít nhất 2 ký tự"
                    },
                    email: {
                        required: "Vui lòng nhập email",
                        email: "Vui lòng nhập đúng định dạng email"
                    },
                    phoneNumber: {
                        required: "Vui lòng nhập số điện thoại",
                        digits: "Vui lòng nhập đúng định dạng số",
                        minlength: "Số điện thoại phải có ít nhất 10 số",
                        maxlength: "Số điện thoại không được quá 11 số"
                    },
                    userName: {
                        required: "Vui lòng nhập tên đăng nhập",
                        minlength: "Tên đăng nhập phải có ít nhất 8 ký tự"
                    },
                    password: {
                        required: "Vui lòng nhập mật khẩu",
                        strongPassword: "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt"
                    }
                },
            });
        });


        $("#btnForgot").click(function (e) {
            e.preventDefault();
            if ($("#forgotForm").valid()) {
                var data = {};
                var formData = $('#forgotForm').serializeArray();
                $.each(formData, function (i, v) {
                    data["" + v.name + ""] = v.value;
                });
                updateUser(data)
            }
        })

        function updateUser(data) {
            $.ajax({
                url: '${APIUserUrl}',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    window.location.href = "${LoginUrl}?action=login&message=update_success&alert=success";
                },
                error: function (error) {
                    window.location.href = "${UserUrl}?type=submitcode&message=error_system&alert=danger";
                }
            });
        }
    </script>

</div>
</body>

</html>