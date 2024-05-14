<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:url var="APIUserUrl" value="/api-admin-user"/>
<c:url var="UserUrl" value="/admin-user"/>
<html>
<head>
    <title>Title</title>

    <link href="<c:url value='/assets/css/style2.css' />" rel="stylesheet" type="text/css" media="all"/>
</head>

<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">

            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="<c:url value="admin-home"/> ">Trang chủ</a>
                </li>
                <li class="active">Chỉnh sửa bài viết</li>
            </ul><!-- /.breadcrumb -->

        </div>
        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                    <c:if test="${not empty messageResponse}">
                        <div class="alert alert-${alert}">
                                ${messageResponse}
                        </div>
                    </c:if>

                    <form id="formSubmit">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Họ và tên</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="fullName" name="fullName"
                                       value="${model.fullName}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Email</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="email" name="email" value="${model.email}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Số điện thoại</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber"
                                       value="${model.phoneNumber}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Địa chỉ</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="address" name="address"
                                       value="${model.address}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Giới tính</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="gender" name="gender">
                                    <option value="">Chọn giới tính</option>
                                    <c:choose>
                                        <c:when test="${model.gender == 1}">
                                            <option value="1" selected>Nam</option>
                                            <option value="0">Nữ</option>
                                        </c:when>
                                        <c:when test="${model.gender == 0}">
                                            <option value="1">Nam</option>
                                            <option value="0" selected>Nữ</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="1">Nam</option>
                                            <option value="0">Nữ</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </div>
                        </div>
                        <br>
                        <br>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Tài khoản</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="userName" name="userName"
                                       value="${model.userName}"/>
                            </div>
                        </div>
                        <br/>
                        <br>
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Mật khẩu</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="password" name="password"
                                       value="${model.password}"/>
                            </div>
                        </div>
                        <br/>
                        <br>


                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Role</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="roleId" name="roleId">
                                    <c:if test="${empty model.roleId}">
                                        <option value="">Chọn Role</option>
                                        <c:forEach var="role" items="${roles.listResult}">
                                            <option value="${role.id}">${role.name}</option>
                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${not empty model.roleId}">
                                        <option value="">Chọn Role</option>
                                        <c:forEach var="role" items="${roles.listResult}">
                                            <option value="${role.id}"
                                                    <c:if test="${role.id == model.roleId}">selected="selected"</c:if>>
                                                    ${role.name}
                                            </option>
                                        </c:forEach>
                                    </c:if>
                                </select>
                            </div>
                        </div>
                        <input type="hidden" class="form-control" id="createdBy" name="createdBy"
                               value="${model.id}">


                        <div class="form-group">
                            <div class="col-sm-12">
                                <c:if test="${not empty model.id}">
                                    <input type="button" class="btn btn-white btn-warning btn-bold"
                                           value="Cập nhật bài viết" id="btnAddOrUpdateNew"/>
                                </c:if>
                                <c:if test="${empty model.id}">
                                    <input type="button" class="btn btn-white btn-warning btn-bold"
                                           value="Thêm bài viết" id="btnAddOrUpdateNew"/>
                                </c:if>

                                <input type="button" class="btn btn-white btn-warning btn-bold"
                                       value="Quay lại" id="btnBack"/>
                            </div>
                        </div>
                        <input type="hidden" value="${model.id}" id="id" name="id"/>
                        <input type="hidden" value="${model.status}" id="status" name="status"/>
                        <input type="hidden" value="edit" id="type" name="type"/>
                        <input type="hidden" value="${model.roleName}" id="roleName" name="roleName"/>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
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

    var currentPage = ${model.page};

    $('#btnAddOrUpdateNew').click(function (e) {
        e.preventDefault();
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

    $("#btnBack").click(function (e) {
        e.preventDefault();
        window.location.href = "${UserUrl}?type=list&maxPageItem=5&page=" + currentPage;
    })

    function addUser(data) {
        $.ajax({
            url: '${APIUserUrl}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${UserUrl}?type=edit&id=" + result.id + "&message=insert_success";
            },
            error: function (error) {
                window.location.href = "${UserUrl}?type=list&maxPageItem=2&page=" + currentPage + "&message=error_system";
            }
        });
    }

    function updateUser(data) {
        $.ajax({
            url: '${APIUserUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${UserUrl}?type=edit&id=" + result.id + "&message=update_success";
            },
            error: function (error) {
                window.location.href = "${UserUrl}?type=list&maxPageItem=2&page=" + currentPage + "&message=error_system";
            }
        });
    }
</script>


</body>

</html>