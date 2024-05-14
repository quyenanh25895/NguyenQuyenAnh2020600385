<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:url var="APIProductUrl" value="/api-admin-product"/>
<c:url var="ProductUrl" value="/admin-product"/>
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
                            <label class="col-sm-3 control-label no-padding-right">Tên sản phẩm</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="name" name="name" value="${model.name}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Giá</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="price" name="price" value="${model.price}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Số lượng</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="quantity" name="quantity"
                                       value="${model.quantity}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Danh mục</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="cateID" name="cateID">

                                    <c:if test="${empty model.cateID}">
                                        <option value="">Chọn danh mục</option>
                                        <c:forEach var="cate" items="${cate.listResult}">
                                            <option value="${cate.id}">${cate.cateName}</option>
                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${not empty model.cateID}">
                                        <option value="">Chọn danh mục</option>

                                        <c:forEach items="${cate.listResult}" var="cates">
                                            <option value="${cates.id}"
                                                    <c:if test="${model.cateID == cates.id}">selected="selected"</c:if>>
                                                    ${cates.cateName}
                                            </option>
                                        </c:forEach>
                                    </c:if>

                                </select>
                            </div>
                        </div>
                        <br>
                        <br>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Thương hiệu</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="brandID" name="brandID">

                                    <c:if test="${empty model.brandID}">
                                        <option value="">Chọn danh mục</option>
                                        <c:forEach var="brands" items="${brands.listResult}">
                                            <option value="${brands.id}">${brands.brandName}</option>
                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${not empty model.brandID}">
                                        <option value="">Chọn danh mục</option>
                                        <c:forEach items="${brands.listResult}" var="brands">
                                            <option value="${brands.id}"
                                                    <c:if test="${model.brandID == brands.id}">
                                                        selected="selected"
                                                    </c:if>>
                                                    ${brands.brandName}
                                            </option>
                                        </c:forEach>

                                    </c:if>
                                </select>
                            </div>
                        </div>
                        <br>
                        <br>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Mô tả</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="description" name="description"
                                       value="${model.description}"/>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <c:forEach items="${images.listResult}" var="image" varStatus="loop">
                            <c:if test="${model.id == image.productID}">
                                <div class="form-group">
                                    <label for="imagePath${loop.index}" class="col-sm-3 control-label no-padding-right">Hình
                                        ảnh</label>

                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="imagePath${loop.index}"
                                               name="imagePath"
                                               value="${image.imageLink}"/>
                                        <input type="hidden" name="proimgID" value="${image.id}">
                                    </div>
                                    <div class="col-sm-1">
                                        <img src="${image.imageLink}" style="max-height: 50px; width: auto"
                                             alt="">
                                    </div>

                                </div>
                                <br>
                                <br>
                            </c:if>
                        </c:forEach>

                        <div class="form-group">
                            <label for="imagePath-new" class="col-sm-3 control-label no-padding-right">Thêm hình
                                ảnh</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="imagePath-new"
                                       name="imagePath"
                                       value="${image.imageLink}"/>
                            </div>
                        </div>
                        <br>
                        <br>


                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Màu sắc</label>
                            <div class="col-sm-9">
                                <c:forEach items="${colors.listResult}" var="color">

                                    <c:set var="checked" value="false"/>
                                    <c:forEach items="${productcolors.listResult}" var="procolor">
                                        <c:if test="${color.id == procolor.id}">
                                            <c:set var="checked" value="true"/>
                                        </c:if>
                                    </c:forEach>
                                    <input type="checkbox" class="custom-control-input" id="color-${color.id}"
                                           name="color" value="${color.id}"
                                           <c:if test="${checked}">checked="checked"</c:if>>
                                    <label class="custom-control-label"
                                           for="color-${color.id}">
                                            ${color.colorCode}

                                    </label>
                                </c:forEach>
                            </div>
                        </div>
                        <br>
                        <br>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Dung lượng</label>
                            <div class="col-sm-9">
                                <c:forEach items="${capacities.listResult}" var="cap">

                                    <c:set var="checked" value="false"/>
                                    <c:forEach items="${productcapacities.listResult}" var="procap">
                                        <c:if test="${cap.id == procap.id}">
                                            <c:set var="checked" value="true"/>
                                        </c:if>
                                    </c:forEach>

                                    <input type="checkbox" class="custom-control-input" id="cap-${cap.id}"
                                           name="capacity" value="${cap.id}"
                                           <c:if test="${checked}">checked="checked"</c:if>>
                                    <label class="custom-control-label"
                                           for="cap-${cap.id}">${cap.capacityValue}</label>
                                </c:forEach>
                            </div>
                        </div>
                        <br/>
                        <br/>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">Trạng thái</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="status" name="status">
                                    <c:if test="${not empty model.status}">
                                        <option value="">Trạng thái</option>
                                        <c:if test="${model.status == 1}">
                                            <option selected="selected" value="1">Active</option>
                                            <option value="0">Disable</option>
                                        </c:if>

                                        <c:if test="${model.status == 0}">
                                            <option value="1">Active</option>
                                            <option selected="selected" value="0">Disable</option>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${empty model.status}">
                                        <option value="">Trạng thái</option>
                                        <option value="1">Active</option>
                                        <option value="0">Disable</option>

                                    </c:if>

                                </select>
                            </div>
                        </div>
                        <br/>
                        <br/>

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
                if (v.name === "color") {
                    selectedColors.push(v.value);
                } else if (v.name === "capacity") {
                    selectedCapacities.push(v.value);
                } else if (v.name === "imagePath") {
                    imagePaths.push(v.value);
                } else if (v.name === "proimgID") {
                    ids.push(v.value);
                } else {
                    data["" + v.name + ""] = v.value;
                }
            }
        );

        // Gán các danh sách đã lấy vào đối tượng data
        data["colorIDs"] = selectedColors;
        data["capacityIDs"] = selectedCapacities;
        data["imagePaths"] = imagePaths;
        data["ids"] = ids;
        var id = $('#id').val();
        if (id === "") {
            addNew(data);
        } else {
            updateNew(data);
        }
    });

    $("#btnBack").click(function (e){
        e.preventDefault();
        window.location.href = "${ProductUrl}?type=list&maxPageItem=5&page=" + currentPage;
    })

    function addNew(data) {
        $.ajax({
            url: '${APIProductUrl}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${ProductUrl}?type=edit&id=" + result.id + "&message=insert_success";
            },
            error: function (error) {
                window.location.href = "${ProductUrl}?type=list&maxPageItem=2&page=" + currentPage + "&message=error_system";
            }
        });
    }

    function updateNew(data) {
        $.ajax({
            url: '${APIProductUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {
                window.location.href = "${ProductUrl}?type=edit&id=" + result.id + "&message=update_success";
            },
            error: function (error) {
                window.location.href = "${ProductUrl}?type=list&maxPageItem=2&page=" + currentPage + "&message=error_system";
            }
        });
    }
</script>


</body>

</html>