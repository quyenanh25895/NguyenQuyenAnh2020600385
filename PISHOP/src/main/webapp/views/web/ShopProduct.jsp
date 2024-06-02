<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="ProductShopUrl" value="/product-shop"/>
<c:url var="ProUrl" value="/admin-product"/>

<html>

<head>
    <title>Sản Phẩm</title>
    <link rel="stylesheet" href="<c:url value="/assets/css/Home.css"/>">
</head>

<body>
<div class="container-fluid pt-5">
    <div class="row px-xl-5">
        <!-- Shop Sidebar Start -->
        <div class="col-lg-3 col-md-12">

            <form id="submitCateIDAndBrandID"
                  action="<c:url value="/product-shop?type=list&page=1&maxPageItem=8"/>" method="GET">
                <!-- Price Start -->
                <div class="border-bottom mb-4 pb-4">
                    <h5 class="font-weight-semi-bold mb-4">Thương hiệu sản phẩm </h5>
                    <c:forEach items="${brands.listResult}" var="brands">
                        <c:set var="checked" value="false"/>

                        <c:forEach items="${brandID.listResult}" var="brand">
                            <c:if test="${brand.id == brands.id}">
                                <c:set var="checked" value="true"/>
                            </c:if>
                        </c:forEach>

                        <div class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                            <input type="checkbox" class="custom-control-input"
                                   <c:if test="${checked}">checked="checked"</c:if>
                                   name="brandID" id="brand-${brands.id}" value="${brands.id}">

                            <label class="custom-control-label"
                                   for="brand-${brands.id}">${brands.brandName}</label>
                        </div>

                    </c:forEach>
                </div>

                <div class="border-bottom mb-4 pb-4">
                    <h5 class="font-weight-semi-bold mb-4">Danh mục sản phẩm</h5>
                    <c:forEach items="${categories.listResult}" var="categories">

                        <c:set var="checked" value="false"/>
                        <c:forEach items="${cateID.listResult}" var="cate">
                            <c:if test="${cate.id == categories.id}">
                                <c:set var="checked" value="true"/>
                            </c:if>
                        </c:forEach>
                        <div class="custom-control custom-checkbox d-flex align-items-center justify-content-between mb-3">
                            <input type="checkbox" class="custom-control-input"
                                   <c:if test="${checked}">checked="checked"</c:if>
                                   name="cateID" id="category-${categories.id}" value="${categories.id}">
                            <label class="custom-control-label"
                                   for="category-${categories.id}">${categories.cateName}</label>
                        </div>

                    </c:forEach>
                    <input type="hidden" name="type" value="${products.type}">
                    <input type="hidden" name="page" value="${products.page}">
                    <input type="hidden" name="maxPageItem" value="${products.maxPageItem}">
                    <input type="hidden" name="sortBy" value="asc">

                </div>
                <!-- PropertiesAPI End -->
                <input id="searchByCateAndBrand" type="button" class="btn btn-primary" value="Lọc sản phẩm"></input>
            </form>

        </div>

        <div class="col-lg-9 col-md-12">
            <div class="row pb-3">
                <div class="col-12 pb-1">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <form action="">
                            <div class="input-group">
                                <input id="searchProduct" type="text" class="form-control"
                                       placeholder="Tìm kiếm sản phẩm">
                                <div class="input-group-append">
                                    <input type="button" class="input-group-text bg-transparent text-primary"
                                           placeholder="<i class='fa fa-search' />"/>
                                </div>
                            </div>
                        </form>

                        <div class="dropdown ml-4" id="sortDropdown">
                            <button class="btn border" type="button" id="triggerId">
                                Sắp xếp
                            </button>
                            <div id="sortMenu" class="dropdown-menu dropdown-menu-right" aria-labelledby="triggerId">
                                <a id="SortByProductID" class="dropdown-item"
                                   href="">
                                    Sản phẩm mới nhất
                                </a>
                                <a id="SortByQuantity" class="dropdown-item" href="">
                                    Sắp xếp theo số lượng
                                </a>
                            </div>
                        </div>

                    </div>
                </div>
                <jsp:include page="/common/Products.jsp"/>
            </div>
        </div>


    </div>
</div>
<script>

    $(document).ready(function () {
        var limit = 12; // Số lượng sản phẩm ban đầu
        var totalProducts = ${products.listResult.size()}; // Tổng số sản phẩm
        var originalProducts = $('#productList .col-lg-2').clone(); // Sao chép danh sách sản phẩm ban đầu

        // Ẩn các sản phẩm vượt quá giới hạn hiển thị ban đầu
        $('#productList .col-lg-2').slice(limit).hide();

        // Xử lý sự kiện khi nhấn nút "Xem thêm sản phẩm"
        $('#loadMoreBtn').click(function () {
            console.log('Button clicked!');
            limit += 8; // Tăng giới hạn hiển thị lên 8 sản phẩm
            $('#productList .col-lg-2').slice(0, limit).fadeIn();

            // Ẩn nút "Xem thêm sản phẩm" nếu đã hiển thị hết tất cả sản phẩm
            if (limit >= totalProducts) {
                $('#loadMoreBtn').hide();
            }
        });

        // Xử lý sự kiện khi người dùng nhập vào ô tìm kiếm
        $('#searchProduct').on('input', function () {
            var limit = 12; // Số lượng sản phẩm ban đầu
            var totalProducts = ${products.listResult.size()}; // Tổng số sản phẩm
            var searchText = $(this).val().toLowerCase().trim(); // Lấy nội dung của ô tìm kiếm và chuyển thành chữ thường

            // Kiểm tra nếu ô tìm kiếm trống
            if (searchText === '') {
                // Hiển thị lại danh sách sản phẩm ban đầu và ẩn nút "Xem thêm"
                $('#productList').empty().append(originalProducts.clone()).find('.col-lg-2').slice(limit).hide();
                if (totalProducts > limit) {
                    $('#loadMoreBtn').show();
                }
                return; // Thoát khỏi sự kiện
            }

            // Hiển thị các sản phẩm phù hợp với từ khóa tìm kiếm
            $('#productList .col-lg-2').each(function () {
                var productName = $(this).find('h6').text().toLowerCase(); // Lấy tên của sản phẩm và chuyển thành chữ thường
                if (productName.indexOf(searchText) === -1) { // Nếu tên sản phẩm không chứa từ khóa tìm kiếm
                    $(this).hide(); // Ẩn sản phẩm đi
                } else {
                    $(this).show().fadeIn(); // Hiển thị sản phẩm
                }
            });

            // Ẩn nút "Xem thêm sản phẩm" khi có kết quả tìm kiếm
            $('#loadMoreBtn').hide();
        });
    });

    $('#triggerId').click(function (e) {
        e.preventDefault();
        var element = document.getElementById("sortMenu");
        if (element.style.display === "block") {
            element.style.display = "none";
        } else {
            element.style.display = "block";
        }
    });

    $("#searchByCateAndBrand").click(function (e) {
        e.preventDefault();
        var formData = $('#submitCateIDAndBrandID').serializeArray();
        var brandIDs = [];
        var cateIDs = [];

        $.each(formData, function (i, v) {
            if (v.name === "brandID") {
                brandIDs.push(v.value);
            } else if (v.name === "cateID") {
                cateIDs.push(v.value);
            }
        });
        window.location.href = "${ProductShopUrl}?type=list&cateID=" + cateIDs + "&brandID=" + brandIDs + "&page=1";
    })

    $('#SortByProductID').click(function (e) {
        e.preventDefault();
        var formData = $('#submitCateIDAndBrandID').serializeArray();
        var brandIDs = [];
        var cateIDs = [];

        $.each(formData, function (i, v) {
            if (v.name === "brandID") {
                brandIDs.push(v.value);
            } else if (v.name === "cateID") {
                cateIDs.push(v.value);
            }
        });
        window.location.href = "${ProductShopUrl}?type=list&cateID=" + cateIDs + "&brandID=" + brandIDs + "&page=1&sortName=productID&sortBy=desc";
    });

    $('#SortByQuantity').click(function (e) {
        e.preventDefault();
        var formData = $('#submitCateIDAndBrandID').serializeArray();
        brandIDs = [];
        cateIDs = [];

        $.each(formData, function (i, v) {
            if (v.name === "brandID") {
                brandIDs.push(v.value);
            } else if (v.name === "cateID") {
                cateIDs.push(v.value);
            }
        });
        window.location.href = "${ProductShopUrl}?type=list&cateID=" + cateIDs + "&brandID=" + brandIDs + "&page=1&sortName=productQuantity&sortBy=asc";
    });


</script>


</body>

</html>