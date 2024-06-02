<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:url var="APIUserUrl" value="/api-user"/>
<c:url var="UserUrl" value="/user"/>
<c:url var="LoginUrl" value="/login"/>
<html>

<head>
    <title>Thông tin cá nhân</title>
</head>

<body>
<!-- Featured Start -->
<div class="container-fluid pt-5">
    <form id="userInformation">
        <div class="row justify-content-start align-items-center">
            <div class="col-lg-7 col-sm-7 col-md-7">
                <div class="row justify-content-end align-items-center">
                    <div class="col-lg-4 col-md-6 col-sm-8 text-left"
                         style="border-bottom: black solid 1px;margin-bottom: 5px">
                        <p style="margin-bottom: 0; margin-top: 10px">Họ và tên: ${USERMODEL.fullName} </p>
                    </div>
                </div>
                <div class="row justify-content-end align-items-center">
                    <div class="col-lg-4 col-md-6 col-sm-8 text-left"
                         style="border-bottom: black solid 1px;margin-bottom: 5px">
                        <c:if test="${USERMODEL.gender == 1}">
                            <p style="margin-bottom: 0; margin-top: 10px">Giới tính: Nam </p>
                        </c:if>
                        <c:if test="${USERMODEL.gender == 0}">
                            <p style="margin-bottom: 0; margin-top: 10px">Giới tính: Nữ </p>
                        </c:if>
                    </div>
                </div>
                <div class="row justify-content-end align-items-center">
                    <div class="col-lg-4 col-md-6 col-sm-8 text-left"
                         style="border-bottom: black solid 1px;margin-bottom: 5px">
                        <p style="margin-bottom: 0; margin-top: 10px">Email: ${USERMODEL.email} </p>
                    </div>
                </div>
                <div class="row justify-content-end align-items-center">
                    <div class="col-lg-4 col-md-6 col-sm-8 text-left"
                         style="border-bottom: black solid 1px;margin-bottom: 5px">
                        <p style="margin-bottom: 0; margin-top: 10px">Số điện thoại: ${USERMODEL.phoneNumber} </p>
                    </div>
                </div>
                <div class="row justify-content-end align-items-center">
                    <div class="col-lg-4 col-md-6 col-sm-8 text-left"
                         style="border-bottom: black solid 1px;margin-bottom: 5px">
                        <p style="margin-bottom: 0; margin-top: 10px">Địa chỉ: ${USERMODEL.address} </p>
                    </div>
                </div>
                <div class="row justify-content-end align-items-center">
                    <div class="col-lg-4 col-md-6 col-sm-8 text-left"
                         style="border-bottom: black solid 1px;margin-bottom: 5px">
                        <p style="margin-bottom: 0; margin-top: 10px">Tổng chi tiêu: ${staticalModel.price} VND</p>
                    </div>
                </div>
                <div class="row justify-content-end align-items-center">
                    <div class="col-lg-4 col-md-6 col-sm-8 text-left"
                         style="border-bottom: black solid 1px;margin-bottom: 5px">
                        <input type="button" id="changePassword" value="Đổi mật khẩu">
                    </div>
                </div>
            </div>
        </div>
    </form>

</div>


<script>
    $(document).ready(function () {
        localStorage.clear()

    });
    $("#changePassword").click(function (e) {
        e.preventDefault();
        window.location.href = "${UserUrl}?type=changepassword";
    })


</script>
</body>

</html>