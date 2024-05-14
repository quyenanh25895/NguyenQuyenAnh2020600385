<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>

<head>
    <title>Title</title>
</head>

<body>
<!-- Navbar Start -->
<div class="container-fluid mb-5">

    <div class="row border-top px-xl-5">
        <div class="col-lg-3 d-none d-lg-block">
            <a class="btn shadow-none d-flex align-items-center justify-content-between bg-primary text-white w-100"
               data-toggle="collapse" href="#navbar-vertical"
               style="height: 65px; margin-top: -1px; padding: 0 30px;">
                <h3 style="padding-top: 10px !important;" class="m-0">Categories</h3>
                <%--                <i class="fa fa-angle-down text-dark"></i>--%>
            </a>
            <nav class="collapse show navbar navbar-vertical navbar-light align-items-start p-0 border border-top-0 border-bottom-0"
                 id="navbar-vertical">
                <div class="navbar-nav w-100 overflow-hidden" style="height: 410px">
                    <c:forEach items="${categories.listResult}" var="cate">
                        <a href="<c:url value="/product-shop?type=list&cateID=${cate.id}&cateIDs=${cate.id}&page=1&maxPageItem=3&sortName=productID&sortBy=asc"/>"
                           class="nav-item nav-link">${cate.cateName}</a>
                    </c:forEach>

                </div>
            </nav>
        </div>

        <div class="col-lg-9">
            <div id="header-carousel" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach items="${banners.listResult}" var="banner" varStatus="loop">
                        <c:if test="${loop.first}">
                            <div class="carousel-item active" style="height: 410px;">
                                <img class="img-fluid"
                                     src="${banner.bannerLink}" alt="Image">
                            </div>
                        </c:if>
                        <c:if test="${!loop.first}">
                            <div class="carousel-item" style="height: 410px;">
                                <img class="img-fluid"
                                     src="${banner.bannerLink}" alt="Image">
                            </div>
                        </c:if>
                    </c:forEach>


                </div>

                <a class="carousel-control-prev" href="#header-carousel" data-slide="prev">
                    <div class="btn btn-dark" style="width: 45px; height: 45px;">
                        <span class="carousel-control-prev-icon mb-n2"></span>
                    </div>
                </a>
                <a class="carousel-control-next" href="#header-carousel" data-slide="next">
                    <div class="btn btn-dark" style="width: 45px; height: 45px;">
                        <span class="carousel-control-next-icon mb-n2"></span>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- Navbar End -->
</body>

</html>