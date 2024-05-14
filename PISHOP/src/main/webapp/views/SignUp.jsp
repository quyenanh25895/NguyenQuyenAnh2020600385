<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:url var="APIUrl" value="/api-admin-user"/>
<c:url var="UserUrl" value="/admin-user"/>
<c:url var="LoginUrl" value="/login"/>
<c:url var="SignupUrl" value="/signup"/>
<html>
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
                    <h2 class="form-title">Sign up</h2>

                    <form class="register-form" id="formSubmit">
                        <div class="form-group">
                            <input type="text" class="form-control" id="fullName" name="fullName" value=""
                                   placeholder="Tên người dùng">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" id="email" name="email" value=""
                                   placeholder="Email">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value=""
                                   placeholder="Số điện thoại">
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" id="address" name="address" value=""
                                   placeholder="Địa chỉ">
                        </div>
                        <div class="form-group">
                            <select class="form-control" id="gender" name="gender">
                                <option value="">Chọn giới tính</option>
                                <option value="1">Nam</option>
                                <option value="0">Nữ</option>
                            </select>

                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" id="userName" name="userName"
                                   placeholder="Tên đăng nhập">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="Mật khẩu">
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" id="repassword"
                                   placeholder="Nhập lại mật khẩu">
                        </div>

                        <input type="hidden" class="form-control" id="roleId" name="roleId"
                               value="2">

                        <input type="hidden" class="form-control" id="createdBy" name="createdBy"
                               value="Admin">

<%--                        <div class="form-group">--%>
<%--                            <input type="checkbox" name="agree-term" id="agree-term" class="agree-term"/>--%>
<%--                            <label for="agree-term" class="label-agree-term"><span><span></span></span>I agree all--%>
<%--                                statements in <a href="#" class="term-service">Terms of service</a></label>--%>
<%--                        </div>--%>

                        <div class="form-group form-button">
                            <input type="submit" name="btnAddOrUpdateUser" id="btnAddOrUpdateUser" class="form-submit"
                                   value="Đăng Ký"/>
                        </div>
                        <input type="hidden" value="${model.id}" id="id" name="id"/>
                    </form>
                </div>

                <div class="signup-image" style="border-radius: 20px">
                    <figure>
                        <img src="<c:url value="/assets/img/pikaso_texttoimage_3d-model-banner-for-smartphone-webshop-with-logo-P.jpeg" /> " alt="sing up image">
                    </figure>
                    <a id="LoginLink" href="<c:url value="/login?action=login" />" class="signup-image-link">
                        Bạn đã có tài khoản? Đăng nhập ngay
                    </a>
                </div>
            </div>
        </div>
    </section>

</div>

<%--Script--%>
<script>

    $("#formSubmit").validate({
        rules: {
            userName: {
                required: true,
                minlength: 6 // Tối thiểu 6 ký tự
            },
            password: {
                required: true,
                minlength: 6 // Tối thiểu 6 ký tự
            }
        },
        messages: {
            userName: {
                required: "Vui lòng nhập tên đăng nhập",
                minlength: "Tên đăng nhập phải có ít nhất 6 ký tự"
            },
            password: {
                required: "Vui lòng nhập mật khẩu",
                minlength: "Mật khẩu phải có ít nhất 6 ký tự"
            }
        }
    });



    $(document).ready(function () {
        $("#LoginLink").click(function (event) {
            // Ngăn chặn hành vi mặc định của thẻ <a> (tải lại trang)
            event.preventDefault();
            window.location.href = $(this).attr("href");
        });


        $('#btnAddOrUpdateUser').click(function (e) {
            e.preventDefault();

            // Kiểm tra tên người dùng
            var username = $('#userName').val();
            if (username.length < 6) {
                document.getElementById('userName').setCustomValidity("Tên người dùng phải có ít nhất 6 ký tự.");
                return;
            } else {
                document.getElementById('userName').setCustomValidity("");
            }

            // Kiểm tra mật khẩu
            var password = $('#password').val();
            var strength = checkPasswordStrength(password);
            if (strength < 3) {
                alert("Mật khẩu không đủ mạnh.");
                return;
            }

            // Nếu không có lỗi, tiếp tục xử lý đăng ký người dùng
            var data = {};
            var formData = $('#formSubmit').serializeArray();
            $.each(formData, function (i, v) {
                data["" + v.name + ""] = v.value;
            });

            var id = $('#id').val();
            if (id === "") {
                addUser(data);
            } else {
                updateUser(data);
            }
        });

        function checkPasswordStrength(password) {
            var strength = 0;

            // If password contains both lower and uppercase characters, increase strength value.
            if (password.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) strength += 1;

            // If it has numbers and characters, increase strength value.
            if (password.match(/([a-zA-Z])/) && password.match(/([0-9])/)) strength += 1;

            // If it has one special character, increase strength value.
            if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1;

            // If it has two special characters, increase strength value.
            if (password.match(/(.*[!,%,&,@,#,$,^,*,?,_,~].*[!,%,&,@,#,$,^,*,?,_,~])/)) strength += 1;

            // If password is longer than 8, increase strength value.
            if (password.length > 8) strength += 1;

            return strength;
        }

        function addUser(data) {
            $.ajax({
                url: '${APIUrl}',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    window.location.href = "${LoginUrl}?action=login&message=insert_success&alert=success";
                },
                error: function (error) {
                    if (error.status === 409) {
                        window.location.href = "${SignupUrl}?action=signup&message=error_system&alert=danger";
                    } else {
                        window.location.href = "${SignupUrl}?action=signup&message=error_system&alert=danger";
                    }
                }
            });
        }

        function updateUser(data) {
            $.ajax({
                url: '${APIUrl}',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    window.location.href = "${UserUrl}?type=edit&id=" + result.id + "&message=update_success";
                },
                error: function (error) {
                    window.location.href = "${UserUrl}?type=edit&message=error_system";
                }
            });
        }
    });

</script>

</body>

</html>