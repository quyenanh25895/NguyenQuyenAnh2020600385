<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ProductModel Start -->
<div class="container-fluid pt-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5"><span class="px-2">Trendy Products</span></h2>
    </div>

    <form action="<c:url value='/product-shop'/>" id="formSubmit" method="get">
        <div class="row px-xl-5 pb-3" id="productList">
            <c:forEach items="${products.listResult}" var="product" varStatus="loop">
                <c:if test="${product.status == 1 && product.quantity > 0}">
                    <div class="col-lg-2 col-md-6 col-sm-12 pb-1">
                        <div class="card product-item border-0 mb-4">
                            <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0"
                                 style="max-height: 200px; width: auto">
                                <c:set var="firstImageDisplayed" value="false" />
                                <c:forEach items="${images.listResult}" var="image">
                                    <c:if test="${!firstImageDisplayed && product.id == image.productID}">
                                        <img class="img-fluid w-100" src="${image.imageLink}"
                                             alt="">
                                        <c:set var="firstImageDisplayed" value="true" />
                                    </c:if>
                                </c:forEach>

                            </div>
                            <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                                <h6 class="text-truncate mb-3">${product.name}</h6>
                                <div class="d-flex justify-content-center">
                                    <h6>$ ${product.price * 0.9}</h6>
                                    <h6 class="text-muted ml-2">
                                        <del>$ ${product.price}</del>
                                    </h6>
                                </div>
                            </div>
                            <div class="card-footer d-flex justify-content-center bg-light border">
                                <a href="<c:url value="/product-detail?type=detail&productID=${product.id}" /> "
                                   class="btn btn-sm text-dark p-0">
                                    <i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </form>

    <!-- Button for loading more products -->
    <div class="text-center">
        <button id="loadMoreBtn" class="btn btn-primary">Xem thêm sản phẩm</button>
    </div>

</div>

<script>
    $(document).ready(function () {
        var limit = 12; // Số lượng sản phẩm ban đầu
        var totalProducts = ${products.listResult.size()}; // Tổng số sản phẩm

        // Ẩn các sản phẩm vượt quá giới hạn hiển thị ban đầu
        $('#productList .col-lg-2').slice(limit).hide();

        // Xử lý sự kiện khi nhấn nút "Xem thêm sản phẩm"
        $('#loadMoreBtn').click(function () {
            console.log('Button clicked!');
            limit += 12; // Tăng giới hạn hiển thị lên 8 sản phẩm

            // Hiển thị các sản phẩm mới
            $('#productList .col-lg-2:hidden').slice(0, 12).slideDown();

            // Ẩn nút "Xem thêm sản phẩm" nếu đã hiển thị hết tất cả sản phẩm
            if ($('#productList .col-lg-2:hidden').length === 0) {
                $('#loadMoreBtn').hide();
            }
        });
    });
</script>

