<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>

<head>
    <title>Title</title>
    <style>
        .category-container {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            overflow: hidden;
            padding: 0 0 0 0;
            border-radius: 1rem;
        }

        .category-container .navbar-nav {
            overflow-x: auto;
            max-height: 500px;
        }

        .category-container .nav-item.nav-link {
            height: 50px;
            display: flex;
            align-items: center;
        }

        .carousel-container {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            padding: 0 0 0 0;
            border-radius: 1rem;
        }
        .carousel-inner{
            padding: 0 0 0 0;
            border-radius: 1rem;
        }

        .carousel-item img {
            height: 100%;
            object-fit: cover;
        }

        .carousel-control-prev,
        .carousel-control-next {
            width: 5%;
        }
    </style>
</head>
</head>

<body>
<!-- Navbar Start -->
<div class="container-fluid mb-5">
    <div class="row border-top px-xl-5">
        <div class="col-lg-2 d-none d-lg-block overflow-scroll category-container" >
            <a class="btn shadow-none d-flex align-items-center justify-content-center bg-primary text-white w-100"
               data-toggle="collapse" href="#navbar-vertical"
               style="height: 65px; margin-top: -1px; padding: 0 30px; ">
                <h3 style=""  class="m-0">Danh mục</h3>
            </a>
            <nav class="collapse show navbar navbar-vertical navbar-light align-items-start p-0 border border-top-0 border-bottom-0"
                 id="navbar-vertical">
                <div class="navbar-nav w-100 " style="overflow-x: auto; max-height: 500px; height: 410px;">
                    <c:forEach items="${categories.listResult}" var="cate">
                        <a href="<c:url value="/product-shop?type=list&cateID=${cate.id}&cateIDs=${cate.id}&page=1&maxPageItem=3&sortName=productID&sortBy=asc"/>"
                           class="nav-item nav-link d-flex align-items-center h-100 " style="height: 50px; max-height: 100px"
                           >${cate.cateName}</a>
                    </c:forEach>
                </div>
            </nav>
        </div>

        <div class="col-lg-9 carousel-container ml-auto">
            <div id="header-carousel" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach items="${banners.listResult}" var="banner" varStatus="loop">
                        <c:if test="${loop.first}">
                            <div class="carousel-item active" style="height: 475px;">
                                <img class="img-fluid"
                                     src="${banner.bannerLink}" alt="Image">
                            </div>
                        </c:if>
                        <c:if test="${!loop.first}">
                            <div class="carousel-item" style="height: 475px;">
                                <img class="img-fluid"
                                     src="${banner.bannerLink}" alt="Image">
                            </div>
                        </c:if>
                    </c:forEach>
                </div>

                <a class="carousel-control-prev" href="#header-carousel" data-slide="prev">

                </a>
                <a class="carousel-control-next" href="#header-carousel" data-slide="next">

                </a>
            </div>
        </div>
    </div>
</div>

<!-- Navbar End -->
</body>

</html>