<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:url var="APIProductUrl" value="/api-admin-productInfo"/>
<c:url var="ProductUrl" value="/admin-product"/>
<html>
<head>
    <title>Chi tiết sản phẩm</title>

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
                <li class="active">Chi tiết sản phẩm</li>
            </ul><!-- /.breadcrumb -->

        </div>
        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                    <c:if test="${not empty messageResponse}">
                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                Swal.fire({
                                    title: 'Thông báo',
                                    text: "${messageResponse}",
                                    icon: '${alert}',
                                    confirmButtonText: 'OK'
                                });
                            });
                        </script>
                    </c:if>

                    <form id="formSubmit">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Tên sản phẩm</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="name" value="${model.name}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Năm sản xuất</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="timeManufacture" name="timeManufacture"
                                       value="${productInformation.timeManufacture}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Xuất sứ</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="country" name="country"
                                       value="${productInformation.country}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>


                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Dung lượng pin</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="pinValue" name="pinValue"
                                       value="${productInformation.pinValue}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Kích thước màn hình</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="display" name="display"
                                       value="${productInformation.display}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Độ phân giải màn hình</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="resolution" name="resolution"
                                       value="${productInformation.resolution}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Vi xử lý</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="chipset" name="chipset"
                                       value="${productInformation.chipset}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <div class="col-sm-12">
                                <c:if test="${not empty productInformation.id}">
                                    <input type="button" class="btn btn-white btn-warning btn-bold"
                                           value="Cập nhật" id="btnAddOrUpdateNew"/>
                                </c:if>
                                <c:if test="${empty productInformation.id}">
                                    <input type="button" class="btn btn-white btn-warning btn-bold"
                                           value="Thêm mới" id="btnAddOrUpdateNew"/>
                                </c:if>
                                <input type="button" class="btn btn-white btn-warning btn-bold"
                                       value="Quay lại" id="btnBack"/>
                            </div>
                        </div>
                        <input type="hidden" value="${productInformation.id}" id="id" name="id"/>
                        <input type="hidden" value="${productInformation.productID}" id="productID" name="productID"/>
                        <input type="hidden" value="edit" id="type" name="type"/>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    var currentPage = ${model.page};

    $('#btnAddOrUpdateNew').click(function (e) {
        e.preventDefault();
        var data = {};
        var formData = $('#formSubmit').serializeArray();
        var selectedColors = [];
        var selectedCapacities = [];
        var imagePaths = [];
        var ids = [];

        // Lặp qua formData để lấy các giá trị của các checkbox với tên tương ứng
        $.each(formData, function (i, v) {
                if (v.name === "name") {
                    return true;
                } else {
                    data["" + v.name + ""] = v.value;
                }
            }
        );
        var id = $('#id').val();
        if (id === "") {
            addNew(data);
        } else {
            updateNew(data);
        }
    });

    $("#btnBack").click(function (e) {
        e.preventDefault();
        window.location.href = "${ProductUrl}?type=list&maxPageItem=5&page=" + currentPage;
    })

    function updateNew(data) {
        $.ajax({
            url: '${APIProductUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${ProductUrl}?type=information&id=" + result.id + "&message=update_success";
            },
            error: function (error) {
                window.location.href = "${ProductUrl}?type=list&maxPageItem=2&page=" + currentPage + "&message=error_system";
            }
        });
    }
</script>


</body>

</html>