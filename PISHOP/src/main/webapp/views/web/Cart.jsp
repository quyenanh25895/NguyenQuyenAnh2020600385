<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:url var="APIUrl" value="/api-cart"/>
<c:url var="CartUrl" value="/cart"/>
<html>
<head>
    <title>Title</title>
</head>

<body>
<!-- Cart Start -->
<div class="container-fluid pt-5">
    <div class="row px-xl-5">
        <div class="col">
            <div class="nav nav-tabs justify-content-center border-secondary mb-4">
                <a class="nav-item nav-link active" data-toggle="tab" href="#tab-pane-1">Giỏ hàng</a>
                <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-2">Chờ xác nhận</a>
                <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-3">Giao hàng</a>
            </div>

            <div class="tab-content">
                <div class="tab-pane fade show active" id="tab-pane-1">
                    <form id="deleteForm">
                        <div class="row">
                            <div class="col-lg-9 table-responsive mb-5">
                                <table class="table table-bordered text-center mb-0">
                                    <thead class="bg-secondary text-dark">
                                    <tr>
                                        <th>Image</th>
                                        <th>Products</th>
                                        <th>Color</th>
                                        <th>Capacity</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                        <th>
                                            <button id="btnDelete" type="button"
                                                    class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
                                                    data-toggle="tooltip" title='Xóa sản phẩm khỏi giỏ hàng'>
												<span>
													<i class="fa fa-trash-o bigger-110 pink"></i>
												</span>
                                            </button>
                                        </th>
                                    </tr>
                                    </thead>

                                    <tbody class="align-middle">
                                    <c:forEach items="${cartProducts.listResult}" var="cartProduct">
                                        <c:if test="${cartProduct.status == 0}">
                                            <c:forEach items="${products.listResult}" var="product">
                                                <c:if test="${product.status == 1 && cartProduct.productID == product.id}">
                                                    <tr>
                                                        <td>
                                                            <c:set var="firstImageDisplayed" value="false"/>
                                                            <c:forEach items="${images.listResult}" var="image">
                                                                <c:if test="${!firstImageDisplayed && cartProduct.productID == image.productID}">
                                                                    <img class="w-20 h-20"
                                                                         style="height: 50px; width: auto"
                                                                         src="${image.imageLink}" alt="Image">
                                                                    <c:set var="firstImageDisplayed" value="true"/>
                                                                </c:if>
                                                            </c:forEach>
                                                        </td>


                                                        <td class="align-middle">
                                                                ${product.name}
                                                        </td>

                                                        <c:forEach items="${colors.listResult}" var="color">
                                                            <c:if test="${cartProduct.colorID == color.id}">
                                                                <td class="align-middle">
                                                                        ${color.colorCode}
                                                                </td>
                                                            </c:if>
                                                        </c:forEach>

                                                        <c:forEach items="${capacities.listResult}" var="capacity">
                                                            <c:if test="${cartProduct.capacityID == capacity.id}">
                                                                <td class="align-middle">
                                                                        ${capacity.capacityValue}
                                                                </td>
                                                            </c:if>
                                                        </c:forEach>

                                                        <td class="align-middle">
                                                                ${cartProduct.quantity}
                                                        </td>
                                                        <td class="align-middle">
                                                                ${cartProduct.price * 0.9 * cartProduct.quantity}
                                                        </td>

                                                        <td class="align-middle">
                                                            <input type="checkbox" name="cartproductID"
                                                                   id="checkbox_${cartProduct.id}"
                                                                   value="${cartProduct.id}">
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>

                                        </c:if>
                                    </c:forEach>

                                    </tbody>
                                </table>
                            </div>

                            <div class="col-lg-3">
                                <div class="card border-secondary mb-5">
                                    <div class="card-header bg-secondary border-0">
                                        <h4 class="font-weight-semi-bold m-0">Cart Summary</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between mb-3 pt-1">
                                            <h6 class="font-weight-medium">Subtotal</h6>
                                            <c:set var="totalPrice" value="0"/>
                                            <c:forEach items="${cartProducts.listResult}" var="cartProduct">
                                                <c:forEach items="${products.listResult}" var="product">
                                                    <c:if test="${cartProduct.status == 0 && cartProduct.productID == product.id && product.status == 1}">
                                                        <c:set var="subtotal"
                                                               value="${cartProduct.quantity * cartProduct.price * 0.9}"/>
                                                        <c:set var="totalPrice" value="${totalPrice + subtotal}"/>
                                                    </c:if>
                                                </c:forEach>
                                            </c:forEach>

                                            <h6 class="font-weight-medium">$ ${totalPrice}</h6>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <h6 class="font-weight-medium">Shipping</h6>
                                            <c:set var="shipping" value="${totalPrice * 0.1}"/>
                                            <h6 class="font-weight-medium">$ ${shipping}</h6>
                                        </div>
                                    </div>
                                    <div class="card-footer border-secondary bg-transparent">
                                        <div class="d-flex justify-content-between mt-2">
                                            <h5 class="font-weight-bold">Total</h5>
                                            <h5 class="font-weight-bold">$ ${totalPrice + shipping}</h5>
                                        </div>
                                        <button id="btnSubmitCart" class="btn btn-block btn-primary my-3 py-3">
                                            Proceed To Checkout
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
<<<<<<< HEAD
                        <input type="hidden" name="ids" id="ids" value="">
=======
>>>>>>> d41aab06937fef662f30a43b9d87c5561fd83e72
                    </form>
                </div>

                <div class="tab-pane fade" id="tab-pane-2">
                    <form id="submitForm">
                        <div class="row">
                            <div class="col-lg-9 table-responsive mb-5">
                                <table class="table table-bordered text-center mb-0">
                                    <thead class="bg-secondary text-dark">
                                    <tr>
                                        <th>Image</th>
                                        <th>Products</th>
                                        <th>Color</th>
                                        <th>Capacity</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                        <th>Status</th>
                                        <th>
                                            <button id="btnDenyCart" type="button"
                                                    class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
                                                    data-toggle="tooltip" title='Xóa sản phẩm khỏi giỏ hàng'>
												<span>
													<i class="fa fa-arrow-circle-o-left bigger-110 pink"></i>
												</span>
                                            </button>
                                        </th>
                                    </tr>
                                    </thead>

                                    <tbody class="align-middle">
                                    <c:forEach items="${cartProducts.listResult}" var="cartProduct">
                                        <c:if test="${cartProduct.status == 1}">
                                            <c:forEach items="${products.listResult}" var="product">
                                                <c:if test="${product.status == 1 && cartProduct.productID == product.id}">
                                                    <tr>

                                                        <td>
                                                            <c:set var="firstImageDisplayed" value="false"/>
                                                            <c:forEach items="${images.listResult}" var="image">
                                                                <c:if test="${!firstImageDisplayed && cartProduct.productID == image.productID}">
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

                                                        <c:forEach items="${colors.listResult}" var="color">
                                                            <c:if test="${cartProduct.colorID == color.id}">
                                                                <td class="align-middle">
                                                                        ${color.colorCode}
                                                                </td>
                                                            </c:if>
                                                        </c:forEach>

                                                        <c:forEach items="${capacities.listResult}" var="capacity">
                                                            <c:if test="${cartProduct.capacityID == capacity.id}">
                                                                <td class="align-middle">
                                                                        ${capacity.capacityValue}
                                                                </td>
                                                            </c:if>
                                                        </c:forEach>

                                                        <td class="align-middle">
                                                                ${cartProduct.quantity}
                                                        </td>
                                                        <td class="align-middle">
                                                                ${cartProduct.price * 0.9 * cartProduct.quantity}
                                                        </td>
                                                        <td class="align-middle">
                                                            <div style="background-color: yellow; color: black; padding: 5px; border-radius: 5px; text-align: center;">
                                                                Chờ xác nhận
                                                            </div>

                                                        </td>
                                                        <td class="align-middle">
                                                            <input type="checkbox" name="cartproductID"
                                                                   id="checkbox_${cartProduct.id}"
                                                                   value="${cartProduct.id}">
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>

                                    </tbody>
                                </table>
                            </div>

                            <div class="col-lg-3">
                                <div class="card border-secondary mb-5">
                                    <div class="card-header bg-secondary border-0">
                                        <h4 class="font-weight-semi-bold m-0">Cart Summary</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between mb-3 pt-1">
                                            <h6 class="font-weight-medium">Subtotal</h6>
                                            <c:set var="totalPrice" value="0"/>
                                            <c:forEach items="${cartProducts.listResult}" var="product">
                                                <c:if test="${product.status == 1}">
                                                    <c:set var="subtotal"
                                                           value="${product.quantity * product.price * 0.9}"/>
                                                    <c:set var="totalPrice" value="${totalPrice + subtotal}"/>
                                                </c:if>
                                            </c:forEach>

                                            <h6 class="font-weight-medium">$ ${totalPrice}</h6>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <h6 class="font-weight-medium">Shipping</h6>
                                            <c:set var="shipping" value="${totalPrice * 0.1}"/>
                                            <h6 class="font-weight-medium">$ ${shipping}</h6>
                                        </div>
                                    </div>
                                    <div class="card-footer border-secondary bg-transparent">
                                        <div class="d-flex justify-content-between mt-2">
                                            <h5 class="font-weight-bold">Total</h5>
                                            <h5 class="font-weight-bold">$ ${totalPrice + shipping}</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

<<<<<<< HEAD
=======

>>>>>>> d41aab06937fef662f30a43b9d87c5561fd83e72
                <div class="tab-pane fade" id="tab-pane-3">
                    <form id="formViewOrder">
                        <div class="row">
                            <div class="col-lg-12 table-responsive mb-5" style="overflow-x: auto; max-height: 500px;">
                                <table class="table table-bordered text-center mb-0" style="">
                                    <thead class="bg-secondary text-dark"
                                           style="position: sticky; top: 0; z-index: 200">
                                    <tr>
                                        <th>Image</th>
                                        <th>Products</th>
                                        <th>Color</th>
                                        <th>Capacity</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>

                                    <tbody class="align-middle" style="z-index: 1">
                                    <c:set var="cnt" value="0"/>
                                    <c:forEach items="${cartProducts.listResult}" var="cartProduct">
                                        <c:if test="${cartProduct.status == 2 || cartProduct.status == 3 || cartProduct.status == 4}">
                                            <c:forEach items="${products.listResult}" var="product">
                                                <c:if test="${cartProduct.productID == product.id}">
                                                    <c:set var="cnt" value="${cnt + 1}"/>
                                                    <tr class="hide">
                                                        <td class="align-middle">

                                                            <c:set var="firstImageDisplayed" value="false"/>
                                                            <c:forEach items="${images.listResult}" var="image">
                                                                <c:if test="${!firstImageDisplayed && product.id == image.productID}">
                                                                    <img class="w-20 h-20"
                                                                         style="height: 50px; width: auto"
                                                                         src="${image.imageLink}" alt="Image">
                                                                    <c:set var="firstImageDisplayed" value="true"/>
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
                                                            <c:if test="${cartProduct.status == 2}">
                                                                <div style="background-color: lawngreen; color: black; padding: 5px; border-radius: 5px; text-align: center;">
                                                                    Đang giao hàng
                                                                </div>
                                                            </c:if>

                                                            <c:if test="${cartProduct.status == 3}">
                                                                <div style="background-color: palevioletred; color: black; padding: 5px; border-radius: 5px; text-align: center;">
                                                                    Đã nhận hàng
                                                                </div>
                                                            </c:if>

                                                            <c:if test="${cartProduct.status == 4}">
                                                                <div style="background-color: red; color: black; padding: 5px; border-radius: 5px; text-align: center;">
                                                                    Chờ xác nhận trả hàng
                                                                </div>
                                                            </c:if>


                                                        </td>
                                                        <td>
                                                            <c:if test="${cartProduct.status == 2}">
                                                                <button class="btn btn-sm btn-primary btn-edit userSubmitOrderBtn"
                                                                        data-cartProductId="${cartProduct.id}"
                                                                        data-status="2">
                                                                    Đã nhận hàng
                                                                </button>
                                                            </c:if>

                                                            <c:if test="${cartProduct.status == 3}">
                                                                <button class="btn btn-sm btn-primary btn-edit userCartBackOrders"
                                                                        data-cartProductId="${cartProduct.id}"
                                                                        data-status="3">
                                                                    Trả hàng hoàn tiền
                                                                </button>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>

                                    </c:forEach>
                                    <input type="hidden" name="cnt" id="cnt" value="${cnt}">
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </form>
                    <div class="text-center">
                        <button id="loadMoreBtn" class="btn btn-primary">Xem thêm sản phẩm</button>
                    </div>
                </div>
            </div>
        </div>


    </div>
    <div class="row px-xl-5">
    </div>
</div>
<script>
    $(document).ready(function () {
        var limit = 5; // Số lượng dòng ban đầu
        var cnt = $('#cnt').val();
        var totalRows = $('#formViewOrder tbody tr').length;

        // Ẩn các dòng sau số lượng dòng ban đầu
        $('tbody .hide').slice(limit).hide();

        // Xử lý sự kiện khi nhấn nút "Xem thêm"
        $('#loadMoreBtn').click(function (e) {
            e.preventDefault();
            limit += 5;
            // Hiển thị thêm số lượng dòng mới
            $('tbody tr:hidden').slice(0, 5).slideDown();


            // Ẩn nút "Xem thêm" nếu đã hiển thị hết tất cả các dòng
            if ($('tbody tr:hidden').length === 0) {
                $('#loadMoreBtn').hide();
            }
        });

        if (cnt <= limit) {
            $('#loadMoreBtn').hide();
        }
    });

</script>


<script>

    $('.nav-link').on('shown.bs.tab', function (e) {
        var target = $(e.target).attr('href'); // Lấy href của tab đang được chọn
        localStorage.setItem('activeTab', target); // Lưu vào localStorage
    });

    $(document).ready(function () {
        var activeTab = localStorage.getItem('activeTab'); // Lấy tab được lưu trong localStorage
        if (activeTab) {
            $('.nav-link[href="' + activeTab + '"]').tab('show'); // Hiển thị tab tương ứng
        }
    });


    $(document).ready(function () {

        $('a[data-toggle="tab"]').click(function (e) {
            e.preventDefault();
            // Lấy href của tab được chọn
            var targetTab = $(this).attr("href");
            // Hủy chọn các checkbox trong tab hiện tại
            $(targetTab).find('input[type="checkbox"]').prop('checked', false);
        });

        $(".userSubmitOrderBtn").click(function (e) {
            e.preventDefault();
            var productID = $(this).data("cartproductid");
            var status = $(this).data("status");
            userSubmitOrder(productID, status);
        });

        $(".userCartBackOrders").click(function (e) {
            e.preventDefault();
            var productID = $(this).data("cartproductid");
            var status = $(this).data("status");
            userBackOrder(productID, status);
        });

        function userSubmitOrder(cartProductId, currentStatus) {
            var data = {
                id: cartProductId,
                status: currentStatus
            }
            $.ajax({
                url: '${APIUrl}',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (result) {
<<<<<<< HEAD
                    window.location.href = "${CartUrl}?type=cart";
                },
                error: function (error) {
                    window.location.href = "${CartUrl}?type=cart";
=======
                    window.location.href = "${CartUrl}";
                },
                error: function (error) {
                    window.location.href = "${CartUrl}";
>>>>>>> d41aab06937fef662f30a43b9d87c5561fd83e72
                }
            });
        }

        function userBackOrder(cartProductId, currentStatus) {
            var data = {
                id: cartProductId,
                status: currentStatus
            }

            $.ajax({
                url: '${APIUrl}',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (result) {
<<<<<<< HEAD
                    window.location.href = "${CartUrl}?type=cart";
                },
                error: function (error) {
                    window.location.href = "${CartUrl}?type=cart";
=======
                    window.location.href = "${CartUrl}";
                },
                error: function (error) {
                    window.location.href = "${CartUrl}";
>>>>>>> d41aab06937fef662f30a43b9d87c5561fd83e72
                }
            });
        }

        $("#btnDelete").click(function () {
            let data = {};
            let ids = $('tbody input[type=checkbox]:checked').map(function () {
                return $(this).val();
            }).get();
            data['ids'] = ids;
            console.log(data);
            deleteCartProduct(data);
        });

        function deleteCartProduct(data) {
            $.ajax({
                url: '${APIUrl}',
                type: 'DELETE',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (result) {
<<<<<<< HEAD
                    window.location.href = "${CartUrl}?type=cart";
                },
                error: function (error) {
                    window.location.href = "${CartUrl}?type=cart";
=======
                    window.location.href = "${CartUrl}";
                },
                error: function (error) {
                    window.location.href = "${CartUrl}";
>>>>>>> d41aab06937fef662f30a43b9d87c5561fd83e72
                }
            });
        }

        $("#btnDenyCart").click(function () {
            let data = {};
            let ids = $('tbody input[type=checkbox]:checked').map(function () {
                return $(this).val();
            }).get();
            data['ids'] = ids;
            data['status'] = 1
            console.log(data);
            denyCart(data);
        });

        function denyCart(data) {
            $.ajax({
                url: '${APIUrl}',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (result) {
<<<<<<< HEAD
                    window.location.href = "${CartUrl}?type=cart";
                },
                error: function (error) {
                    window.location.href = "${CartUrl}?type=cart";
=======
                    window.location.href = "${CartUrl}";
                },
                error: function (error) {
                    window.location.href = "${CartUrl}";
>>>>>>> d41aab06937fef662f30a43b9d87c5561fd83e72
                }
            });
        }

        $("#btnSubmitCart").click(function (e) {
            e.preventDefault();
            let data = {};
            let ids = $('tbody input[type=checkbox]:checked').map(function () {
                return $(this).val();
            }).get();
            data['ids'] = ids;
            data['status'] = 0
<<<<<<< HEAD
            $("#ids").val(JSON.stringify(ids));
            window.location.href = "${CartUrl}?type=checkout";
        });

=======
            submitCart(data);
        });

        function submitCart(data) {
            $.ajax({
                url: '${APIUrl}',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (result) {
                    window.location.href = "${CartUrl}";
                },
                error: function (error) {
                    window.location.href = "${CartUrl}";
                }
            });
        }

>>>>>>> d41aab06937fef662f30a43b9d87c5561fd83e72
    });


</script>
</body>

</html>