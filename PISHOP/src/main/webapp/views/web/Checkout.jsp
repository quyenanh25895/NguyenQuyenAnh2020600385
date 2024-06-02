<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:url var="APIUrl" value="/api-cart"/>
<c:url var="CartUrl" value="/cart"/>
<c:url var="vnpayUrl" value="/vnpay"/>
<html>
<head>
    <title>Mua Hàng</title>
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
                                                            <fmt:formatNumber
                                                                    value="${cartProduct.price * cartProduct.quantity}"
                                                                    type="number"/> VND

                                                        </td>

                                                        <input type="hidden" name="cartproductID"
                                                               id="checkbox_${cartProduct.id}"
                                                               value="${cartProduct.id}">
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
                                    <div class="input-group">
                                        <input type="text" class="form-control p-4" name="couponCode" id="couponCode"
                                               placeholder="Coupon Code">
                                    </div>
                                    <br>
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
                                                               value="${cartProduct.quantity * cartProduct.price - (cartProduct.quantity * cartProduct.price * (cartProduct.discount/100))}"/>
                                                        <c:set var="totalPrice" value="${totalPrice + subtotal}"/>
                                                    </c:if>
                                                </c:forEach>
                                            </c:forEach>

                                            <h6 class="font-weight-medium"><fmt:formatNumber value="${totalPrice}"
                                                                                             type="number"/> VND</h6>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <h6 class="font-weight-medium">Shipping</h6>
                                            <c:set var="shipping" value="${totalPrice * 0.1}"/>
                                            <h6 class="font-weight-medium"><fmt:formatNumber value="${shipping}"
                                                                                             type="number"/> VND</h6>
                                        </div>
                                        <select class="form-control" id="role" name="role">
                                            <option value="">Chọn phuơng thức thanh toán</option>
                                            <option value="off">Thanh toán khi nhận hàng</option>
                                            <option value="onl">Thanh toán online</option>
                                        </select>
                                    </div>
                                    <div class="card-footer border-secondary bg-transparent">
                                        <div class="d-flex justify-content-between mt-2">
                                            <h5 class="font-weight-bold">Total</h5>
                                            <h5 class="font-weight-bold"> <fmt:formatNumber value="${totalPrice + shipping}"
                                                                                            type="number"/> VND </h5>
                                            <input type="hidden" name="price" value="${totalPrice + shipping}">
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

        $("#btnSubmitCart").click(function (e) {
            e.preventDefault();
            var data = {};
            var formData = $('#checkOutForm').serializeArray();
            var ids = [];
            $.each(formData, function (i, v) {
                    if (v.name === "cartproductID") {
                        ids.push(v.value);
                    } else if (v.name === "price") {
                        data["price"] = v.value;
                    } else if (v.name === "role") {
                        data["type"] = v.value;
                    } else if (v.name === "couponCode") {
                        data["couponCode"] = v.value;
                    }
                }
            );
            data["ids"] = ids;
            data['status'] = 0
            if (data["type"] === "onl") {
                vnpaySubmit(data);
            } else if (data["type"] === "off") {
                submitCart(data);
            }
        });

        function submitCart(data) {
            $.ajax({
                url: '${APIUrl}',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (result) {
                    console.log(result);
                    window.location.href = "${CartUrl}?type=cart&message=pay_success";
                },
                error: function (error) {
                    window.location.href = "${CartUrl}?type=cart&message=order_error";
                }
            });
        }

        function vnpaySubmit(data) {
            $.ajax({
                url: '${APIUrl}',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (result) {
                    var data2 = {
                        price: data["price"],
                        type: data["type"],
                        orderCode: result.cartCode,
                        discount: result.discount
                    }
                    vnpay(data2)
                    console.log(result);
                },
            });
        }

        function vnpay(data) {

            $.ajax({
                type: "POST",
                url: '${vnpayUrl}',
                contentType: 'application/json',
                dataType: 'JSON',
                data: JSON.stringify(data),
                success: function (x) {
                    if (x.code === '00') {
                        if (window.vnpay) {
                            vnpay.open({width: 768, height: 600, url: x.data});
                        } else {
                            location.href = x.data;
                        }
                        return false;
                    } else {
                        alert(x.Message);
                    }

                },
            });
            return false;
        }

    });


</script>
</body>

</html>