<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:url var="APIUrl" value="/api-admin-user"/>
<c:url var="UserUrl" value="/admin-user"/>
<c:url var="LoginUrl" value="/login"/>
<c:url var="SignupUrl" value="/signup"/>
<html>
<head>
    <title>Đăng Ký</title>

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

                    <form class="register-form" id="formSubmit" novalidate>
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

                        <input type="hidden" class="form-control" id="status" name="status"
                               value="1">

                        <input type="hidden" class="form-control" id="createdBy" name="createdBy"
                               value="">

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
    $(document).ready(function () {
        // Custom method for strong password
        $.validator.addMethod("strongPassword", function(value, element) {
            return this.optional(element)
                || /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/.test(value);
        }, "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt");

        var validation = $("#formSubmit").validate({
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
                },
                repassword: {
                    required: true,
                    equalTo: "#password"
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
                },
                repassword: {
                    required: "Vui lòng nhập lại mật khẩu",
                    equalTo: "Mật khẩu nhập lại không khớp"
                }
            },
        });
    });


    $(document).ready(function () {
        $("#LoginLink").click(function (event) {
            // Ngăn chặn hành vi mặc định của thẻ <a> (tải lại trang)
            event.preventDefault();
            window.location.href = $(this).attr("href");
        });

        $('#btnAddOrUpdateUser').click(function (e) {
            e.preventDefault();
            // Nếu không có lỗi, tiếp tục xử lý đăng ký người dùng
            if ($("#formSubmit").valid()) {
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
            }
        });

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