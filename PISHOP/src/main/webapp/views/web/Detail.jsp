<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:url var="APICartUrl" value="/api-cart"/>
<c:url var="APICommentUrl" value="/api-comment"/>
<c:url var="ProductUrl" value="/product-shop"/>
<c:url var="DetailUrl" value="/product-detail"/>
<html>

<head>
    <title>Title</title>
</head>

<body>
<!-- Shop Detail Start -->
<div class="container-fluid py-5">
    <div class="row px-xl-5">
        <div class="col-lg-3 pb-3" style="max-height: 400px">
            <div id="product-carousel" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner border">
                    <c:forEach items="${images.listResult}" var="image" varStatus="loop">
                        <c:if test="${loop.first}">
                            <div class="carousel-item active">
                                <img style="max-height: 400px; width: auto !important;" class="w-100 h-100" src="${image.imageLink}" alt="Image">
                            </div>
                        </c:if>
                        <c:if test="${!loop.first}">
                            <div class="carousel-item">
                                <img class="w-100 h-100" src="${image.imageLink}" alt="Image">
                            </div>
                        </c:if>
                    </c:forEach>

                </div>

                <a class="carousel-control-prev" href="#product-carousel" data-slide="prev">
                    <i class="fa fa-2x fa-angle-left text-dark"></i>
                </a>
                <a class="carousel-control-next" href="#product-carousel" data-slide="next">
                    <i class="fa fa-2x fa-angle-right text-dark"></i>
                </a>
            </div>

        </div>

        <div class="col-lg-7 pb-5">
            <form id="formSubmit">
                <h3 class="font-weight-semi-bold">${product.name}</h3>
                <input type="hidden" name="id" value="${product.id}">
                <h3 class="font-weight-semi-bold mb-4">$ ${product.price * 0.9}</h3>
                <input type="hidden" name="price" value="${product.price * 0.9}">
                <div class="d-flex mb-3">
                    <p class="text-dark font-weight-medium mb-0 mr-3">Số lượng:</p>
                    <p class="">${product.quantity}</p>
                </div>

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

                <div class="d-flex mb-4">
                    <p class="text-dark font-weight-medium mb-0 mr-3">Colors:</p>
                    <c:forEach items="${colors.listResult}" var="color">
                        <div class="custom-control custom-radio custom-control-inline">
                            <input type="radio" class="custom-control-input" id="color-${color.id}" name="colorID"
                                   value="${color.id}">
                            <label class="custom-control-label" for="color-${color.id}">${color.colorCode}</label>
                        </div>
                    </c:forEach>
                </div>

                <div class="d-flex align-items-center mb-4 pt-2">
                    <div class="input-group quantity mr-3" style="width: 130px;">
                        <label for="quantity-input">Nhập số lượng: </label>
                        <input type="text" class="form-control bg-secondary text-center" id="quantity-input"
                               name="quantity">
                    </div>
                </div>
                <div class="d-flex align-items-center mb-4 pt-2">
                    <c:if test="${not empty USERMODEL}">
                        <button id="btnAddToCart" class="btn btn-primary px-3">
                            <i class="fa fa-shopping-cart mr-1"></i>
                            Add To Cart
                        </button>
                    </c:if>
                    <c:if test="${empty USERMODEL}">
                        <input type="button" id="btnLogin" class="btn btn-primary px-3" value="Đăng nhập ngay"
                               onclick="redirectToLogin()"/>

                    </c:if>
                </div>
            </form>
        </div>

    </div>
</div>

<div class="row px-xl-5">
    <div class="col">
        <div class="nav nav-tabs justify-content-center border-secondary mb-4">
            <a class="nav-item nav-link active" data-toggle="tab" href="#tab-pane-1">Mô tả</a>
            <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-2">Thông tin sản phẩm</a>
            <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-3">Bình luận</a>
        </div>

        <div class="tab-content">
            <div class="tab-pane fade show active" id="tab-pane-1">
                <h4 class="mb-3">Product Description</h4>
                <p>${product.description}</p>
            </div>


            <div class="tab-pane fade" id="tab-pane-2">
                <h4 class="mb-3">Additional Information</h4>
                <p>Eos no lorem eirmod diam diam, eos elitr et gubergren diam sea. Consetetur vero aliquyam
                    invidunt
                    duo dolores et duo sit. Vero diam ea vero et dolore rebum, dolor rebum eirmod consetetur
                    invidunt sed sed et, lorem duo et eos elitr, sadipscing kasd ipsum rebum diam. Dolore
                    diam stet
                    rebum sed tempor kasd eirmod. Takimata kasd ipsum accusam sadipscing, eos dolores sit no
                    ut diam
                    consetetur duo justo est, sit sanctus diam tempor aliquyam eirmod nonumy rebum dolor
                    accusam,
                    ipsum kasd eos consetetur at sit rebum, diam kasd invidunt tempor lorem, ipsum lorem
                    elitr
                    sanctus eirmod takimata dolor ea invidunt.</p>
                <div class="row">
                    <div class="col-md-6">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item px-0">
                                Sit erat duo lorem duo ea consetetur, et eirmod takimata.
                            </li>
                            <li class="list-group-item px-0">
                                Amet kasd gubergren sit sanctus et lorem eos sadipscing at.
                            </li>
                            <li class="list-group-item px-0">
                                Duo amet accusam eirmod nonumy stet et et stet eirmod.
                            </li>
                            <li class="list-group-item px-0">
                                Takimata ea clita labore amet ipsum erat justo voluptua. Nonumy.
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item px-0">
                                Sit erat duo lorem duo ea consetetur, et eirmod takimata.
                            </li>
                            <li class="list-group-item px-0">
                                Amet kasd gubergren sit sanctus et lorem eos sadipscing at.
                            </li>
                            <li class="list-group-item px-0">
                                Duo amet accusam eirmod nonumy stet et et stet eirmod.
                            </li>
                            <li class="list-group-item px-0">
                                Takimata ea clita labore amet ipsum erat justo voluptua. Nonumy.
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="tab-pane-3">

                <div class="row">
                    <div class="col-md-6">
                        <h4 class="mb-4">Bình luận</h4>
                        <c:forEach items="${comments.listResult}" var="comment">
                            <c:if test="${comment.status == 1}">
                                <div class="media mb-4">
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

    function redirectToLogin() {
        window.location.href = "<c:url value='/login?action=login' />";
    }

    $(document).ready(function () {
        // Ẩn nút "Add to Cart" khi trang được tải lần đầu
        $('#btnAddToCart').prop('disabled', true);

        var allChecked = false;
        var quantityChecked = false;

        // Bắt sự kiện khi có thay đổi trạng thái của ô radio color hoặc capacity
        $('input[type="radio"]').change(function () {
            // Kiểm tra xem tất cả các ô radio color hoặc capacity đã được chọn chưa
            allChecked = $('input[name="colorID"]:checked').length > 0 && $('input[name="capacityID"]:checked').length > 0;

            // Gọi hàm kiểm tra và cập nhật trạng thái của nút "Add to Cart"
            updateAddToCartButtonState();
        });

        // Bắt sự kiện khi có thay đổi số lượng nhập vào
        $('#quantity-input').on('input', function () {
            var quantity = parseInt($('#quantity-input').val(), 10);

            // Lấy số lượng sản phẩm sẵn có từ dữ liệu trên trang
            var availableQuantity = parseInt('${product.quantity}', 10);

            // Kiểm tra xem số lượng nhập vào có hợp lệ không
            quantityChecked = availableQuantity >= quantity && quantity > 0;

            // Gọi hàm kiểm tra và cập nhật trạng thái của nút "Add to Cart"
            updateAddToCartButtonState();
        });

        // Hàm kiểm tra và cập nhật trạng thái của nút "Add to Cart"
        function updateAddToCartButtonState() {
            if (allChecked && quantityChecked) {
                $('#btnAddToCart').prop('disabled', false);
            } else {
                $('#btnAddToCart').prop('disabled', true);
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

            // Gán các danh sách đã lấy vào đối tượng data
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
                    window.location.href = "${DetailUrl}?type=detail&productID=" + result.id + "&message=insert_success&alert=success";
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

</body>


</html>