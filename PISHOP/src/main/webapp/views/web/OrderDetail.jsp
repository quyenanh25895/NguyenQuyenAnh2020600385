<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:url var="APICartUrl" value="/api-cart"/>
<c:url var="APICommentUrl" value="/api-comment"/>
<c:url var="ProductUrl" value="/product-shop"/>
<c:url var="DetailUrl" value="/product-detail"/>
<c:url var="CartUrl" value="/cart"/>
<html>

<head>
    <title>Thông Tin Chi Tiết</title>
</head>

<body>
<!-- Shop Detail Start -->
<div class="container-fluid py-5" style="">
    <div class="row px-xl-5">
        <div class="col-lg-4 col-md-4 col-sm-4">

        </div>
        <div class="col-lg-4 col-md-4 col-sm-4">

        </div>
        <div class="col-lg-4 col-md-4 col-sm-4">

        </div>
    </div>
    <br>
    <br>

    <div class="row px-xl-5">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="row">
                <div class="col-lg-5 col-md-5 col-sm-5">
                    <div id="product-carousel" class="carousel slide" data-ride="carousel" style="">
                        <div class="row">
                            <div class="col-lg-12 col-md-12 col-sm-12 justify-content-center">
                                <div class="row justify-content-center align-items-center">
                                    <div class="col-lg-2 col-md-2 col-sm-2">
                                        <a class="carousel-control-prev" href="#product-carousel" data-slide="prev">
                                            <i class="fa fa-2x fa-angle-left text-dark"></i>
                                        </a>
                                    </div>
                                    <div class="col-lg-8 col-md-8 col-sm-8">
                                        <div class="carousel-inner border" style="max-width: 400px">
                                            <c:forEach items="${imageModel.listResult}" var="image" varStatus="loop">
                                                <c:if test="${cartProductModel.productID == image.productID}">
                                                    <c:if test="${loop.first}">
                                                        <div class="carousel-item active ">
                                                            <img style="height: auto!important;max-height: 400px; width: auto; !important;"
                                                                 class="h-100 w-100"
                                                                 src="${image.imageLink}" alt="Image">
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${!loop.first}">
                                                        <div class="carousel-item">
                                                            <img class="h-100 w-100"
                                                                 style="height: auto!important;max-height: 400px; width: auto; !important;"
                                                                 src="${image.imageLink}" alt="Image">
                                                        </div>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-2">
                                        <a class="carousel-control-next" href="#product-carousel" data-slide="next">
                                            <i class="fa fa-2x fa-angle-right text-dark"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 col-md-4 col-sm-4">
                    <form id="formSubmit">
                        <h3 class="font-weight-semi-bold">${productModel.name}</h3>
                        <h3><fmt:formatNumber
                                value="${cartProductModel.price * cartProductModel.quantity - cartProductModel.price * cartProductModel.quantity * cartProductModel.discount/100 }"
                                type="number"/> VND</h3>
                        <div class="d-flex mb-3">
                            <p class="text-dark font-weight-medium mb-0 mr-3">Số lượng: ${cartProductModel.quantity}</p>
                        </div>
                        <div class="d-flex mb-3">
                            <p class="text-dark font-weight-medium mb-0 mr-3">Người nhận: ${USERMODEL.fullName}</p>
                        </div>
                        <div class="d-flex mb-3">
                            <p class="text-dark font-weight-medium mb-0 mr-3">Địa chỉ: ${USERMODEL.address}</p>
                        </div>
                        <div class="d-flex mb-3">
                            <p class="text-dark font-weight-medium mb-0 mr-3">Số điện thoại: ${USERMODEL.phoneNumber}</p>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    $('.nav-link').on('shown.bs.tab', function (e) {
        var targetDetail = $(e.target).attr('href'); // Lấy href của tab đang được chọn
        localStorage.setItem('activeTab', targetDetail); // Lưu vào localStorage
    });

    $(document).ready(function () {
        var activeTab = localStorage.getItem('activeTab'); // Lấy tab được lưu trong localStorage
        if (activeTab) {
            $('.nav-link[href="' + activeTab + '"]').tab('show'); // Hiển thị tab tương ứng
        }
    });

    $(document).ready(function () {


        $('#btnComment').click(function (e) {
            e.preventDefault();
            var data = {};
            var formData = $('#commentForm').serializeArray();

            // Lặp qua formData để lấy các giá trị của các checkbox với tên tương ứng
            $.each(formData, function (i, v) {
                data["" + v.name + ""] = v.value;
            });
            // Gán các danh sách đã lấy vào đối tượng data
            addToComment(data);

        });

        function addToComment(data) {
            $.ajax({
                url: '${APICommentUrl}',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    window.location.href = "${DetailUrl}?type=detail&productID=" + result.productID + "&message=insert_success&alert=success";
                },
                error: function (error) {
                    if (error.status === 409) {
                        window.location.href = "${ProductUrl}?type=list&message=error_system&maxPageItem=8";
                    } else {
                        window.location.href = "${ProductUrl}?type=list&message=error_system&maxPageItem=8";
                    }
                }
            });
        }

    });

</script>

<script>

    var numberInputs = document.getElementById("quantity-input");
    numberInputs.addEventListener('input', function () {
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    $("#soldOut").click(function (e) {
        e.preventDefault();
    })

    function redirectToLogin() {
        window.location.href = "<c:url value='/login?action=login&productID=${product.id}' />";
    }

    $(document).ready(function () {

        $('#btnAddToCart').prop('disabled', true);

        var allChecked = false;
        var quantityChecked = false;

        // Bắt sự kiện khi có thay đổi trạng thái của ô radio color hoặc capacity
        $('input[type="radio"]').change(function () {
            allChecked = $('input[name="colorID"]:checked').length > 0 && $('input[name="capacityID"]:checked').length > 0;
            updateAddToCartButtonState();
        });

        $('#quantity-input').on('input', function () {
            var quantity = parseInt($('#quantity-input').val(), 10);
            var availableQuantity = parseInt('${product.quantity}', 10);
            quantityChecked = availableQuantity >= quantity && quantity > 0;
            updateAddToCartButtonState();
        });

        // Hàm kiểm tra và cập nhật trạng thái của nút "Add to Cart"
        function updateAddToCartButtonState() {
            if (${product.cateID == 4 || product.cateID == 5}) {
                if (allChecked && quantityChecked) {
                    $('#btnAddToCart').prop('disabled', false);
                } else {
                    $('#btnAddToCart').prop('disabled', true);
                }
            } else {
                if (quantityChecked) {
                    $('#btnAddToCart').prop('disabled', false);
                } else {
                    $('#btnAddToCart').prop('disabled', true);
                }
            }
        }

        $('#btnAddToCart').click(function (e) {
            e.preventDefault();
            var data = {};
            var formData = $('#formSubmit').serializeArray();
            var selectedColors = [];
            var selectedCapacities = [];

            // Lặp qua formData để lấy các giá trị của các checkbox với tên tương ứng
            $.each(formData, function (i, v) {
                if (v.name === "colorID") {
                    selectedColors.push(v.value);
                } else if (v.name === "capacityID") {
                    selectedCapacities.push(v.value);
                } else {
                    data["" + v.name + ""] = v.value;
                }
            });

            if (selectedColors.length === 0) {
                selectedColors.push(0);
            }
            if (selectedCapacities.length === 0) {
                selectedCapacities.push(0);
            }
            data["colorIDs"] = selectedColors;
            data["capacityIDs"] = selectedCapacities;
            addToCart(data);

        });

        function addToCart(data) {
            $.ajax({
                url: '${APICartUrl}',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {
                    window.location.href = "${CartUrl}?type=cart&message=order_success";
                },
                error: function (error) {
                    window.location.href = "${DetailUrl}?type=detail&message=order_error";

                }
            });
        }
    });


</script>

</body>


</html>