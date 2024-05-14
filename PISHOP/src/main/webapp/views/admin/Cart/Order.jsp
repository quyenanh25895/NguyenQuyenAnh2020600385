<%@include file="/common/taglib.jsp" %>
<c:url var="APICartUrl" value="/api-cart"/>
<c:url var="APIOrderUrl" value="/api-order"/>
<c:url var="CartUrl" value="/admin-cart"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE>
<html>
<head>
    <title>Danh sách bài viết</title>

</head>

<body>
<div class="main-content">
    <form action="<c:url value='/admin-cart'/>" id="formSubmit" method="get">
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
                                           href='<c:url value="/admin-cart?type=edit"/>'>
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
                                            <th>User</th>
                                            <th>Image</th>
                                            <th>Products</th>
                                            <th>Color</th>
                                            <th>Capacity</th>
                                            <th>Quantity</th>
                                            <th>Total</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                            <th>Submit</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${cartProducts.listResult}" var="cartProduct">
                                            <c:forEach items="${products.listResult}" var="product">
                                                <c:if test="${cartProduct.productID == product.id}">
                                                    <tr>
                                                        <td class="align-middle">
                                                            <c:forEach items="${users.listResult}" var="user">
                                                                <c:if test="${cartProduct.userID == user.id}">
                                                                    ${user.userName}
                                                                </c:if>
                                                            </c:forEach>
                                                        </td>

                                                        <td class="align-middle">

                                                            <c:set var="firstImageDisplayed" value="false"/>
                                                            <c:forEach items="${images.listResult}" var="image">
                                                                <c:if test="${!firstImageDisplayed && product.id == image.productID}">
                                                                    <img class="w-20 h-20"
                                                                         style="height: 50px; width: auto"
                                                                         src="${image.imageLink}" alt="Image">
                                                                    <c:set var="firstImageDisplayed"
                                                                           value="true"/>
                                                                </c:if>
                                                            </c:forEach>
                                                        </td>

                                                        <td class="align-middle">
                                                                ${product.name}
                                                        </td>

                                                        <td class="align-middle">
                                                            <c:forEach items="${colors.listResult}" var="color">
                                                                <c:if test="${cartProduct.colorID == color.id}">

                                                                    ${color.colorCode}

                                                                </c:if>
                                                            </c:forEach>
                                                        </td>

                                                        <td class="align-middle">
                                                            <c:forEach items="${capacities.listResult}" var="capacity">
                                                                <c:if test="${cartProduct.capacityID == capacity.id}">

                                                                    ${capacity.capacityValue}

                                                                </c:if>
                                                            </c:forEach>
                                                        </td>

                                                        <td class="align-middle">
                                                                ${cartProduct.quantity}
                                                        </td>
                                                        <td class="align-middle">
                                                                ${cartProduct.price * 0.9 * cartProduct.quantity}
                                                        </td>

                                                        <td class="align-middle">
                                                            <c:if test="${cartProduct.status == 0}">
                                                                <div style="background-color: #1da0f2; color: black; padding: 5px; border-radius: 5px; text-align: center;">
                                                                    Chờ đặt hàng
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${cartProduct.status == 1}">
                                                                <div style="background-color: yellow; color: black; padding: 5px; border-radius: 5px; text-align: center;">
                                                                    Chờ xác nhận
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${cartProduct.status == 2}">
                                                                <div style="background-color: lawngreen; color: black; padding: 5px; border-radius: 5px; text-align: center;">
                                                                    Đang giao hàng
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${cartProduct.status == 3}">
                                                                <div style="background-color: palevioletred; color: black; padding: 5px; border-radius: 5px; text-align: center;">
                                                                    Đơn hàng đã được giao
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${cartProduct.status == 4}">
                                                                <div style="background-color: red; color: black; padding: 5px; border-radius: 5px; text-align: center;">
                                                                    Chờ xác nhận trả hàng
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${cartProduct.status == 5}">
                                                                <div style="background-color: red; color: black; padding: 5px; border-radius: 5px; text-align: center;">
                                                                    Đã hoàn tiền
                                                                </div>
                                                            </c:if>
                                                        </td>


                                                        <td class="align-middle">
                                                            <div class="checkbox-wrapper-23">
                                                                <input type="checkbox" name="cartproductID"
                                                                       value="${cartProduct.id}"
                                                                       id="checkbox_${cartProduct.id}"
                                                                       class="check-23"/>
                                                                <label for="checkbox_${cartProduct.id}"
                                                                       style="--size: 30px">
                                                                    <svg viewBox="0,0,50,50">
                                                                        <path d="M5 30 L 20 45 L 45 5"></path>
                                                                    </svg>
                                                                </label>
                                                            </div>
                                                        </td>
                                                        <td class="align-middle">
                                                            <c:if test="${cartProduct.status == 1}">
                                                                <button class="btn btn-sm btn-primary btn-edit btnSubmit"
                                                                        data-cartid="${cartProduct.id}"
                                                                        data-status="${cartProduct.status}"
                                                                        data-productid="${cartProduct.productID}"
                                                                        data-price="${cartProduct.price}"
                                                                        data-quantity="${cartProduct.quantity}"
                                                                        data-userid="${cartProduct.userID}">
                                                                    Xác nhận đặt hàng
                                                                </button>
                                                            </c:if>

                                                            <c:if test="${cartProduct.status == 4}">
                                                                <button class="btn btn-sm btn-primary btn-edit btnBackOrder"
                                                                        data-cartid="${cartProduct.id}"
                                                                        data-status="${cartProduct.status}"
                                                                        data-productid="${cartProduct.productID}"
                                                                        data-price="${cartProduct.price}"
                                                                        data-quantity="${cartProduct.quantity}"
                                                                        data-userid="${cartProduct.userID}">
                                                                    Xác nhận trả hàng
                                                                </button>
                                                            </c:if>
                                                        </td>

                                                    </tr>
                                                </c:if>
                                            </c:forEach>
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

    var totalPages = ${cartProducts.totalPage};
    var currentPage = ${cartProducts.page};
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
                    // $('#sortName').val('productID');
                    $('#sortBy').val('asc');
                    $('#type').val('list');
                    $('#formSubmit').submit();
                }
            }
        });
    });

    $(".btnSubmit").click(function (e) {
        e.preventDefault();
        var cartID = $(this).data("cartid");
        var status = $(this).data("status");
        var userID = $(this).data("userid");
        var productID = $(this).data("productid");
        var price = $(this).data("price");
        var quantity = $(this).data("quantity");
        submitCart(cartID, status, userID, productID, quantity, price);

    });

    $(".btnBackOrder").click(function (e) {
        e.preventDefault();
        var cartID = $(this).data("cartid");
        var status = $(this).data("status");
        var userID = $(this).data("userid");
        var productID = $(this).data("productid");
        var price = $(this).data("price");
        var quantity = $(this).data("quantity");
        submitBackCart(cartID, status, userID, productID, quantity, price);
    });


    function submitCart(cartID, status, userID, productID, quantity, price) {
        var data = {
            id: cartID,
            status: status,
        }

        $.ajax({
            url: '${APICartUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                // Thực hiện hàm createOrder sau khi yêu cầu AJAX hoàn thành
                createOrder(cartID, status, userID, productID, quantity, price);
                // Sau đó chuyển hướng trang web
                window.location.href = "${CartUrl}?type=list&maxPageItem=5&page=" + currentPage + "&message=delete_success";
            },
            error: function (error) {
                window.location.href = "${CartUrl}?type=list&maxPageItem=5&page=1&message=error_system";
            }
        });
    }

    function submitBackCart(cartID, status, userID, productID, quantity, price) {
        var data = {
            id: cartID,
            status: status,
            quantity: quantity
        }

        $.ajax({
            url: '${APICartUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                submitBackOrder(cartID, status, userID, productID, quantity, price)
                window.location.href = "${CartUrl}?type=list&maxPageItem=5&page=1&message=delete_success";
            },
            error: function (error) {
                window.location.href = "${CartUrl}?type=list&maxPageItem=5&page=1&message=error_system";
            }
        });
    }


    function createOrder(cartID, status, userID, productID, quantity, price) {
        var data = {
            userID: userID,
            productID: productID,
            quantity: quantity,
            price: price,
            status: status,
            cartProductID: cartID
        }

        $.ajax({
            url: '${APIOrderUrl}',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                window.location.href = "${CartUrl}?type=list&maxPageItem=5&page=" + currentPage + "&message=delete_success";
            },
            error: function (error) {
                window.location.href = "${CartUrl}?type=list&maxPageItem=5&page=1&message=error_system";
            }
        });
    }

    function submitBackOrder(cartID, status, userID, productID, quantity, price) {
        var data = {
            userID: userID,
            productID: productID,
            quantity: quantity,
            price: price,
            status: status,
            cartProductID: cartID
        }

        $.ajax({
            url: '${APIOrderUrl}',
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                window.location.href = "${CartUrl}?type=list&maxPageItem=5&page=" + currentPage + "&message=delete_success";
            },
            error: function (error) {
                window.location.href = "${CartUrl}?type=list&maxPageItem=5&page=1&message=error_system";
            }
        });
    }


    $("#btnDelete").click(function () {
        var data = {};
        var ids = $('tbody input[type=checkbox]:checked').map(function () {
            return $(this).val();
        }).get();
        data['ids'] = ids;
        deleteCart(data);
    });

    function deleteCart(data) {
        $.ajax({
            url: '${APICartUrl}',
            type: 'DELETE',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                window.location.href = "${CartUrl}?type=list&maxPageItem=6&page=1&message=delete_success";
            },
            error: function (error) {
                window.location.href = "${CartUrl}?type=list&maxPageItem=6&page=1&message=error_system";
            }
        });
    }
</script>


</body>

</html>