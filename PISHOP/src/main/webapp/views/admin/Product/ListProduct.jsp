<%@include file="/common/taglib.jsp" %>
<c:url var="APIProductUrl" value="/api-admin-product"/>
<c:url var="ProductUrl" value="/admin-product"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE>
<html>
<head>
    <title>Danh sách bài viết</title>
</head>

<body>
<div class="main-content">
    <form action="<c:url value='/admin-product'/>" id="formSubmit" method="get">
        <div class="main-content-inner">
            <div class="breadcrumbs ace-save-state" id="breadcrumbs">
                <ul class="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="<c:url value="/admin-home" /> ">Trang chủ</a>
                    </li>
                </ul>
                <!-- /.breadcrumb -->
            </div>

            <div class="page-content">
                <div class="row">
                    <div class="col-xs-12">
                        <c:if test="${not empty messageResponse}">
                            <div class="alert alert-${alert}">
                                    ${messageResponse}
                            </div>
                        </c:if>

                        <div class="widget-box table-filter">
                            <div class="table-btn-controls">
                                <div class="pull-right tableTools-container">
                                    <div class="dt-buttons btn-overlap btn-group">
                                        <a flag="info"
                                           class="dt-button buttons-colvis btn btn-white btn-primary btn-bold"
                                           data-toggle="tooltip" title='Thêm bài viết'
                                           href='<c:url value="/admin-product?type=edit"/>'>
												<span>
													<i class="fa fa-plus-circle bigger-110 purple"></i>
												</span>
                                        </a>

                                        <button id="btnDelete" type="button"
                                                class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
                                                data-toggle="tooltip" title='Xóa bài viết'>
												<span>
													<i class="fa fa-trash-o bigger-110 pink"></i>
												</span>
                                        </button>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                        <tr>
                                            <th><input type="checkbox" id="checkAll"></th>
                                            <th>Tên sản phẩm</th>
                                            <th>Thương hiệu</th>
                                            <th>Danh mục</th>
                                            <th>Thao tác</th>
                                            <th>Trạng thái</th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        <c:forEach var="item" items="${model.listResult}">
                                            <tr>
                                                <td class="align-middle">
                                                    <div class="checkbox-wrapper-23">
                                                        <input type="checkbox"
                                                               value="${item.id}" id="checkbox_${item.id}"
                                                               class="check-23"/>
                                                        <label for="checkbox_${item.id}" style="--size: 30px">
                                                            <svg viewBox="0,0,50,50">
                                                                <path d="M5 30 L 20 45 L 45 5"></path>
                                                            </svg>
                                                        </label>
                                                    </div>
                                                </td>

                                                <td class="align-middle">
                                                        ${item.name}
                                                </td>

                                                <td class="align-middle">
                                                        ${item.brandName}
                                                </td>

                                                <td class="align-middle">
                                                        ${item.cateName}
                                                </td>

                                                <td class="align-middle">

                                                    <a class="btn btn-sm btn-primary btn-edit edit-product-btn"
                                                       data-toggle="tooltip" title="Cập nhật bài viết"
                                                       data-id="${item.id}">
                                                        <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                                    </a>
                                                </td>

                                                <td class="align-middle">
                                                    <c:if test="${item.status == 0}">
                                                        <button class="btn btn-sm btn-danger btn-edit active-btn"
                                                                data-productid="${item.id}" data-status="0">
                                                            Active
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${item.status == 1}">
                                                        <button class="btn btn-sm btn-primary btn-edit disable-btn"
                                                                data-productid="${item.id}" data-status="1">
                                                            Disable
                                                        </button>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <ul class="pagination" id="pagination"></ul>
                                    <input type="hidden" value="" id="page" name="page"/>
                                    <input type="hidden" value="" id="maxPageItem" name="maxPageItem"/>
                                    <input type="hidden" value="" id="sortName" name="sortName"/>
                                    <input type="hidden" value="" id="sortBy" name="sortBy"/>
                                    <input type="hidden" value="" id="type" name="type"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<!-- /.main-content -->
<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse display">
    <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
</a>

<script>

    var totalPages = ${model.totalPage};
    var currentPage = ${model.page};
    var limit = 5;

    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            totalPages: totalPages,
            visiblePages: 10,
            startPage: currentPage,
            onPageClick: function (event, page) {
                if (currentPage !== page) {
                    $('#maxPageItem').val(limit);
                    $('#page').val(page);
                    $('#sortName').val('productID');
                    $('#sortBy').val('asc');
                    $('#type').val('list');
                    $('#formSubmit').submit();
                }
            }
        });
    });

    $(".edit-product-btn").click(function (event) {
        event.preventDefault();
        var id = $(this).data("id");
        window.location.href = "${ProductUrl}?type=edit&id=" + id + "&page=" + currentPage;
    });

    $(".active-btn").click(function (e) {
        e.preventDefault();
        var productID = $(this).data("productid");
        var status = $(this).data("status");
        var type = "enable";
        submitOrder(productID, status, type);
    });


    $(".disable-btn").click(function (e) {
        e.preventDefault();
        var productID = $(this).data("productid");
        var status = $(this).data("status");
        var type = "disable";
        submitOrder(productID, status, type);
    });

    function submitOrder(productID, currentStatus, type) {
        var data = {
            id: productID,
            status: currentStatus,
            type: type
        }

        $.ajax({
            url: '${APIProductUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                window.location.href = "${ProductUrl}?type=list&maxPageItem=5&page=" + currentPage + "&message=update_success";
            },
            error: function (error) {
                window.location.href = "${ProductUrl}?type=list&maxPageItem=5&page=" + currentPage + "&message=error_system";
            }
        });
    }

    $("#btnDelete").click(function () {
        var data = {};
        var ids = $('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        data['ids'] = ids;
        deleteNew(data);
    });

    function deleteNew(data) {
        $.ajax({
            url: '${APIProductUrl}',
            type: 'DELETE',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                window.location.href = "${ProductUrl}?type=list&maxPageItem=6&page=" + currentPage + "&message=delete_success";
            },
            error: function (error) {
                window.location.href = "${ProductUrl}?type=list&maxPageItem=6&page=" + currentPage + "&message=error_system";
            }
        });
    }
</script>


</body>

</html>