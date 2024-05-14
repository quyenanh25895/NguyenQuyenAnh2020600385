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
            <div class="tab-content">
                <div class="tab-pane fade show active" id="tab-pane-1">
                    <form id="checkOutForm">
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
                                                                ${cartProduct.price * cartProduct.quantity}
                                                        </td>

                                                        <td class="align-middle">
                                                            <input type="hidden" name="cartproductID"
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
                                                               value="${cartProduct.quantity * cartProduct.price}"/>
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
                                            Xác nhận thanh toán
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
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
    $(document).ready(function () {

        $("#btnSubmitCart").click(function (e) {
            e.preventDefault();
            var data = {};
            var formData = $('#checkOutForm').serializeArray();
            var ids = [];
            $.each(formData, function (i, v) {
                    if (v.name === "cartproductID") {
                        ids.push(v.value);
                    }
                }
            );
            data["ids"] = ids;
            data['status'] = 0
            submitCart(data);
        });

        function submitCart(data) {
            $.ajax({
                url: '${APIUrl}',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (result) {
                    window.location.href = "${CartUrl}?type=cart";
                },
                error: function (error) {
                    window.location.href = "${CartUrl}?type=checkout";
                }
            });
        }

    });


</script>
</body>

</html>