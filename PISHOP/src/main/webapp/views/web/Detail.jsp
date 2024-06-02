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
                                            <c:forEach items="${image.listResult}" var="image" varStatus="loop">
                                                <c:if test="${product.id == image.productID}">
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
                        <h3 class="font-weight-semi-bold">${product.name}</h3>
                        <input type="hidden" name="id" value="${product.id}">
                        <h3><fmt:formatNumber value="${product.price}" type="number" /> VND</h3>
                        <input type="hidden" name="price" value="${product.price}">
                        <div class="d-flex mb-3">
                            <p class="text-dark font-weight-medium mb-0 mr-3">Số lượng:</p>
                            <p class="">${product.quantity}</p>
                        </div>

                        <c:if test="${product.cateID == 4 || product.cateID == 5}">
                            <div class="d-flex mb-3">
                                <p class="text-dark font-weight-medium mb-0 mr-3">Dung lượng:</p>
                                <c:forEach items="${capacities.listResult}" var="capacity">
                                    <div class="custom-control custom-radio custom-control-inline">
                                        <input type="radio" class="custom-control-input" id="capacity-${capacity.id}"
                                               name="capacityID" value="${capacity.id}">
                                        <label class="custom-control-label"
                                               for="capacity-${capacity.id}">${capacity.capacityValue}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                        <div class="d-flex mb-4">
                            <p class="text-dark font-weight-medium mb-0 mr-3">Colors:</p>
                            <c:forEach items="${colors.listResult}" var="color">
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" class="custom-control-input" id="color-${color.id}"
                                           name="colorID"
                                           value="${color.id}">
                                    <label class="custom-control-label"
                                           for="color-${color.id}">${color.colorCode}</label>
                                </div>
                            </c:forEach>
                        </div>


                        <div class="d-flex align-items-center mb-4 pt-2">
                            <div class="input-group quantity mr-3" style="width: 130px;">
                                <label id="quantityInput" for="quantity-input">Nhập số lượng: </label>
                                <input type="text" class="form-control bg-secondary text-center" id="quantity-input"
                                       name="quantity">
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-4 pt-2">
                            <c:if test="${not empty USERMODEL}">

                                <c:if test="${product.quantity > 0}">
                                    <button id="btnAddToCart" class="btn btn-primary px-3">
                                        <i class="fa fa-shopping-cart mr-1"></i>
                                        Thêm vào giỏ hàng
                                    </button>
                                </c:if>
                                <c:if test="${product.quantity == 0}">
                                    <button id="soldOut" class="btn btn-primary px-3">
                                        <i class="fa fa-shopping-cart mr-1"></i>
                                        Hết hàng
                                    </button>
                                </c:if>
                            </c:if>

                            <c:if test="${empty USERMODEL}">
                                <input type="button" id="btnLogin" class="btn btn-primary px-3" value="Đăng nhập ngay"
                                       onclick="redirectToLogin()"/>
                            </c:if>
                        </div>
                    </form>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-3 justify-content-center align-items-center">
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <th scope="row">Tên sản phẩm</th>
                            <td>${product.name}</td>
                        </tr>
                        <tr>
                            <th scope="row">Năm sản xuất</th>
                            <td>${productInformation.timeManufacture}</td>
                        </tr>
                        <tr>
                            <th scope="row">Xuất sứ</th>
                            <td>${productInformation.country}</td>
                        </tr>
                        <tr>
                            <th scope="row">Dung lượng pin</th>
                            <td>
                                <c:if test="${productInformation.pinValue != 0}">
                                    ${productInformation.pinValue}
                                </c:if>
                                <c:if test="${empty productInformation.pinValue || productInformation.pinValue == 0 }">
                                    Không có
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Kích thước màn hình</th>
                            <td>
                                <c:if test="${productInformation.display != 0}">
                                    ${productInformation.display} inches
                                </c:if>
                                <c:if test="${empty productInformation.display || productInformation.display == 0}">
                                    Không có
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Độ phâm giải</th>
                            <td>
                                <c:if test="${not empty productInformation.resolution}">
                                    ${productInformation.resolution}
                                </c:if>
                                <c:if test="${empty productInformation.resolution}">
                                    Không có
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Bộ xử lý</th>
                            <td>
                                <c:if test="${not empty productInformation.chipset}">
                                    ${productInformation.chipset}
                                </c:if>
                                <c:if test="${empty productInformation.chipset}">
                                    Không có
                                </c:if>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>

    <div class="row px-xl-5" style="margin-top: 30px">
        <c:forEach items="${categories.listResult}" var="cate">
            <c:if test="${cate.id == product.cateID}">
                <c:set var="cateID" value="${cate.id}"/>
                <div class="col-lg-2 col-sm-2 col-md-2 text-center">

                </div>
                <div class="text-center mb-4 col-lg-8 col-sm-8 col-md-8">
                    <h2 class="section-title px-5">
                            <span class="px-2">
                                    Sản phẩm khác
                            </span>
                    </h2>
                </div>
                <div class="col-lg-2 col-sm-2 col-md-2 text-center">
                    <h5>
                        <a href="<c:url value="/product-shop?type=list&cateID=${cateID}&cateIDs=${cateID}&page=1&maxPageItem=3&sortName=productID&sortBy=asc"/>">Xem
                            thêm</a>
                    </h5>
                </div>
                <div class="row px-xl-5 pb-3" id="productList">
                    <c:set var="productCount" value="0"/>
                    <c:forEach items="${products.listResult}" var="product">
                        <c:if test="${cateID == product.cateID && product.status == 1 && productCount < 6}">
                            <div class="col-lg-2 col-md-4 col-sm-6" style=" max-width: 300px">
                                <div class="card product-item mb-4"
                                     style="border: solid black 1px; border-radius: 30px; box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.1);">
                                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0"
                                         style="max-height: 200px; width: auto; border-top-left-radius: 30px; border-top-right-radius: 30px">
                                        <c:set var="firstImageDisplayed" value="false"/>
                                        <c:forEach items="${images.listResult}" var="image">
                                            <c:if test="${!firstImageDisplayed && product.id == image.productID}">
                                                <img class="img-fluid w-100" src="${image.imageLink}" alt="">
                                                <c:set var="firstImageDisplayed" value="true"/>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                                        <h6 class="text-truncate mb-3">${product.name}</h6>
                                        <div class="d-flex justify-content-center">
                                            <h6>${product.price} VND</h6>
                                        </div>
                                    </div>
                                    <div class="card-footer d-flex justify-content-center bg-light border"
                                         style="border-bottom-left-radius: 30px; border-bottom-right-radius: 30px">
                                        <c:if test="${product.quantity > 0}">
                                            <a href="<c:url value='/product-detail?type=detail&productID=${product.id}' />"
                                               class="btn btn-sm text-dark p-0">
                                                <i class="fas fa-eye text-primary mr-1"></i>
                                                Xem chi tiết
                                            </a>
                                        </c:if>
                                        <c:if test="${product.quantity == 0}">
                                            <a href="<c:url value='/product-detail?type=detail&productID=${product.id}' />"
                                               class="btn btn-sm text-dark p-0">
                                                <i class="fas fa-eye text-primary mr-1"></i>
                                                Hết hàng
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                            <c:set var="productCount" value="${productCount + 1}"/>
                        </c:if>
                    </c:forEach>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>

<div class="container-fluid py-5">
    <div class="row px-xl-5">
        <div class="col-md-6">
            <h4 class="mb-4">Bình luận</h4>
            <c:forEach items="${comments.listResult}" var="comment">
                <c:if test="${comment.status == 1}">
                    <div class="media mb-4">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/002/318/271/small_2x/user-profile-icon-free-vector.jpg"
                             alt="Image" class="img-fluid mr-3 mt-1"
                             style="width: 45px;">
                        <div class="media-body">
                                <c:forEach items="${userModels.listResult}" var="user">
                                    <c:if test="${user.id == comment.userID}">
                                        <h6>${user.fullName}
                                            <small>
                                                - <i>${comment.createdDate}</i>
                                            </small>
                                        </h6>
                                    </c:if>
                                </c:forEach>
                            <p>${comment.content}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${comment.status == 0 && comment.userID == USERMODEL.id}">
                    <div class="media mb-4 " style="opacity: 50%">
                        <img src="https://static.vecteezy.com/system/resources/thumbnails/002/318/271/small_2x/user-profile-icon-free-vector.jpg"
                             alt="Image" class="img-fluid mr-3 mt-1"
                             style="width: 45px;">
                        <div class="media-body">
                            <h6>John Doe
                                <small>
                                    - <i>${comment.createdDate}</i>
                                </small>
                            </h6>
                            <p>${comment.content}</p>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <div class="col-md-6">
            <h4 class="mb-4">Bình Luận</h4>
            <small>Để lại bình luận của bạn để giúp chúng tôi cải thiện hơn</small>
            <form id="commentForm">
                <div class="form-group">
                    <label for="message">Your Review *</label>
                    <textarea id="message" name="content" cols="30" rows="5"
                              class="form-control">
                                </textarea>
                </div>
                <input type="hidden" name="userID" value="${USERMODEL.id}">
                <input type="hidden" name="productID" value="${product.id}">

                <c:if test="${not empty USERMODEL}">
                    <div class="form-group mb-0">
                        <input type="button" id="btnComment" value="Đăng bình luận"
                               class="btn btn-primary px-3">
                    </div>
                </c:if>
            </form>
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