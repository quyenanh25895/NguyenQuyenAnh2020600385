<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:url var="APIUrl" value="/api-admin-properties"/>
<c:url var="ColorUrl" value="/admin-properties"/>
<html>
<head>
    <title>Thuộc tính</title>

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
            <c:if test="${not empty messageResponse}">
                <script>
                    document.addEventListener("DOMContentLoaded", function() {
                        Swal.fire({
                            title: 'Thông báo',
                            text: "${messageResponse}",
                            icon: '${alert}',
                            confirmButtonText: 'OK'
                        });
                    });
                </script>
            </c:if>
            <div class="row">
                <div class="col-lg-6 col-sm-6 col-xs-6">
                    <form id="colorForm">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"> Thêm thương hiệu mới: </label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" name="brandName" id="brandName-new"
                                       value=""/>
                            </div>
                            <div class="col-sm-1">
                                <input type="button" class="btn btn-no-border btn-success btn-brand-add" value="Thêm"/>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <br>

                        <c:forEach items="${brands.listResult}" var="brand">
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right">Thương hiệu: </label>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control" name="brandName" id="brandName-${brand.id}"
                                           value="${brand.brandName}"/>
                                </div>
                                <div class="col-sm-1">
                                    <input type="button" class="btn btn-no-border btn-success btn-brand-edit"
                                           data-id="${brand.id}"
                                           value="Sửa"/>
                                </div>
                                <div class="col-sm-1">
                                    <input type="button" class="btn btn-no-border btn-success btn-brand-delete"
                                           data-id="${brand.id}"
                                           data-type="brand"
                                           value="Xóa"/>
                                </div>
                            </div>
                            <br/>
                            <br/>
                        </c:forEach>


                    </form>
                </div>


                <div class="col-lg-6 col-sm-6 col-xs-6">
                    <form id="capacityForm">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"> Thêm danh mục mới: </label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" name="cateName" id="cateName-new"
                                       value="" placeholder="Nhập dung lượng"/>
                            </div>
                            <div class="col-sm-1">
                                <input type="button" class="btn btn-no-border btn-success btn-cate-add"
                                       value="Add"/>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <br>

                        <c:forEach items="${categories.listResult}" var="category">
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right">Danh mục: </label>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control" name="cateName" id="cateName-${category.id}"
                                           value="${category.cateName}"/>
                                </div>
                                <div class="col-sm-1">
                                    <input type="button" class="btn btn-no-border btn-success btn-cate-edit"
                                           data-id="${category.id}"
                                           value="Edit"/>
                                </div>
                                <div class="col-sm-1">
                                    <input type="button" class="btn btn-no-border btn-success btn-category-delete"
                                           data-id="${category.id}"
                                           data-type="category"
                                           value="Delete"/>
                                </div>
                            </div>
                            <br/>
                            <br/>
                        </c:forEach>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="confirmationBox" class="hidden">
    <div class="confirmationContent">
        <p>Bạn có chắc chắn muốn xóa?</p>
        <button id="confirmDelete">Xác nhận</button>
        <button id="cancelDelete">Hủy</button>
    </div>
</div>

<script>
    var numberInputs = document.getElementsByClassName('capacityValue');
    for (var i = 0; i < numberInputs.length; i++) {
        numberInputs[i].addEventListener('input', function () {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    }

    var id;
    var type;

    $('.btn-brand-delete').click(function (e) {
        e.preventDefault();
        id = $(this).data("id");
        type = $(this).data("type");
        document.getElementById("confirmationBox").classList.remove("hidden");

    });
    $('.btn-category-delete').click(function (e) {
        e.preventDefault();
        id = $(this).data("id");
        type = $(this).data("type");
        document.getElementById("confirmationBox").classList.remove("hidden");
    });

    document.getElementById("confirmDelete").addEventListener("click", function () {
        var url = "${APIUrl}?type=" + type;
        Delete(id, type, url);
        document.getElementById("confirmationBox").classList.add("hidden");
    });

    document.getElementById("cancelDelete").addEventListener("click", function () {
        document.getElementById("confirmationBox").classList.add("hidden");
    });

    function Delete(value, type, url) {
        var data = {};
        if (type === 'brand') {
            data = {
                id: value,
                type: type
            }
        } else if (type === 'category') {
            data = {
                id: value,
                type: type
            }
        }
        $.ajax({
            url: url,
            type: 'DELETE',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                window.location.href = "${ColorUrl}?type=brandcategory";
            },
            error: function (error) {
                window.location.href = "${ColorUrl}?type=brandcategory";
            }
        });
    }

</script>

<script>
    <c:forEach items="${brands.listResult}" var="brand">
    console.log("${brand.brandName}")
    </c:forEach>


    $(".btn-brand-edit").click(function (e) {
        e.preventDefault();
        var id = $(this).data("id");
        var brandName = $('#brandName-' + id).val();
        var type = "brand";
        var url = "${APIUrl}?type=brand";
        submitChange(id, brandName, type, url);
    });

    $(".btn-brand-add").click(function (e) {
        e.preventDefault();
        var brandName = $('#brandName-new').val();
        var type = 'brand';
        var url = "${APIUrl}?type=brand";
        submitAdd(brandName, type, url);
    });

    $(".btn-cate-add").click(function (e) {
        e.preventDefault();
        var cateName = $('#cateName-new').val();
        var type = 'category';
        var url = "${APIUrl}?type=category";
        submitAdd(cateName, type, url);
    });

    $(".btn-cate-edit").click(function (e) {
        e.preventDefault();
        var id = $(this).data("id");
        var cateName = $('#cateName-' + id).val();
        var type = "category";
        var url = "${APIUrl}?type=category";
        submitChange(id, cateName, type, url);
    });

    function submitChange(id, value, type, url) {
        var data = {};
        if (type === "brand") {
            data = {
                id: id,
                brandName: value,
            }
        } else if (type === "category") {
            data = {
                id: id,
                cateName: value,

            }
        }

        $.ajax({
            url: url,
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                window.location.href = "${ColorUrl}?type=brandcategory&message=insert_success";
            },
            error: function (error) {
                if (error.status === 409) {
                    window.location.href = "${ColorUrl}?type=brandcategory&&message=error_conflict";
                } else {
                    window.location.href = "${ColorUrl}?type=brandcategory&&message=null_element";
                }
            }
        });
    }

    function submitAdd(value, type, url) {
        var data = {};
        if (type === "brand") {
            data = {
                brandName: value,
            }
        } else if (type === "category") {
            data = {
                cateName: value,
            }
        }

        $.ajax({
            url: url,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                window.location.href = "${ColorUrl}?type=brandcategory&message=insert_success";
            },
            error: function (error) {
                if (error.status === 409) {
                    window.location.href = "${ColorUrl}?type=brandcategory&&message=error_conflict";
                } else {
                    window.location.href = "${ColorUrl}?type=brandcategory&&message=null_element";
                }
            }
        });
    }


</script>


</body>

</html>
