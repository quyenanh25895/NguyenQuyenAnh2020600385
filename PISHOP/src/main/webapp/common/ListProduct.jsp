<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="container-fluid pt-5">


    <c:forEach items="${categories.listResult}" var="cate">
        <c:set var="cateID" value="${cate.id}"/>
        <div class="row">
            <div class="col-lg-2 col-sm-2 col-md-2 text-center">
            </div>
            <div class="text-center mb-4 col-lg-8 col-sm-8 col-md-8">
                <h2 class="section-title px-5">
                <span class="px-2">
                        ${cate.cateName}
                </span>
                </h2>

            </div>
            <div class="col-lg-2 col-sm-2 col-md-2 text-center">
                <h5>
                    <a href="<c:url value="/product-shop?type=list&cateID=${cateID}&cateIDs=${cateID}&page=1&maxPageItem=3&sortName=productID&sortBy=asc"/>">Xem thêm</a>
                </h5>
            </div>
        </div>
        <div class="row px-xl-5 pb-3" id="productList">
            <c:set var="productCount" value="0"/>
            <c:forEach items="${products.listResult}" var="product">
                <c:if test="${cateID == product.cateID && product.status == 1 && product.quantity > 0 && productCount < 6}">
                    <div class="col-lg-2 col-md-6 col-sm-12 pb-1">
                        <div class="card product-item border-0 mb-4">
                            <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0"
                                 style="max-height: 200px; width: auto">
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
                                    <h6>$ ${product.price}</h6>
                                </div>
                            </div>
                            <div class="card-footer d-flex justify-content-center bg-light border">
                                <a href="<c:url value='/product-detail?type=detail&productID=${product.id}' />"
                                   class="btn btn-sm text-dark p-0">
                                    <i class="fas fa-eye text-primary mr-1"></i>View Detail</a>
                            </div>
                        </div>
                    </div>
                    <c:set var="productCount" value="${productCount + 1}"/>
                </c:if>
            </c:forEach>
        </div>
    </c:forEach>
</div>
