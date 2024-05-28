<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:url var="ProductUrl" value="/product-shop"/>

<!DOCTYPE html>
<html>

<head>
    <title>Economic Website</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Home.css">

    <style>
        .product {
            display: flex;
            align-items: center;
            cursor: pointer;
            margin-bottom: 10px;
            padding: 8px 20px;
            height: 100px;
        }

        .product:hover {
            background-color: #ddd;
        }

        .product img {
            width: 50px;
            object-fit: cover;
            object-position: center;
            margin-right: 20px;
        }

        .product h4 {
            font-size: 15px;
            color: #333;
            margin-bottom: 15px;
            font-weight: 600;
        }

        #searchResults {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            z-index: 1000;
            width: 100%;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-height: 400px;
            overflow-y: auto;
        }

        .product:hover {
            background-color: #ddd;
        }

        .search-result-item {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .search-result-item:last-child {
            border-bottom: none;
        }

        .btn.border.text-white {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);;
        }
    </style>
</head>
<body>
<div class="fixed-top-margin" style="height: 160px"></div>
<!-- Topbar Start -->

<div class="container-fluid fixed-top text-center p-0" style="background-color: #c17a74">
    <div class="row py-3 px-xl-5 justify-content-end align-items-center">

        <div class="col-lg-1 col-sm-1 col-md-1 d-none d-lg-block p-0">
            <a href="<c:url value='/home'/>" class="text-decoration-none">
                <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="#" class="img-fluid"
                     style="max-height: 70px;">
            </a>
        </div>
        <div class="col-lg-5 col-md-5 col-sm-6 " style="padding-left: 30px; margin: 0 0 0 0!important;">
            <form action="${ProductUrl}" style="">
                <div class="input-group position-relative">
                    <input type="text" id="searchInput" class="form-control" placeholder="Search for products"
                           style="border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1)">
                    <div class="position-absolute search-results" id="searchResults"></div>
                    <input type="hidden" name="type" value="list">
                </div>
            </form>
        </div>

        <c:if test="${empty USERMODEL}">
            <div class="col-lg-6 col-md-6 col-sm-6 text-right p-0">
                <a href="<c:url value='/login?action=login'/>" class="btn border text-white mr-2">
                    Đăng Nhập
                </a>

                <a href="<c:url value='/signup?action=signup'/>" class="btn border text-white mr-4">
                    Đăng Ký
                </a>
            </div>
        </c:if>

        <c:if test="${not empty USERMODEL}">
            <div class="col-lg-6 col-md-7 col-sm-6 text-right p-0" style="padding-right:30px!important; ">
                <div class="row justify-content-end">

                    <div class="col-lg-12 col-md-12 col-sm-12">

                        <div class="dropdown">
                            <a href="https://maps.app.goo.gl/9BN6S5ixLnyPZTzY6" class="btn border text-white">
                                Địa chỉ
                                <i class="fas fa-location-arrow text-primary"></i>
                            </a>
                            <a href="<c:url value='/cart?type=cart'/>" class="btn border text-white">
                                <i class="fas fa-shopping-cart text-primary"></i>
                                <span class="badge">${cartItem}</span>
                            </a>
                            <button class="btn border text-white dropdown-toggle" type="button" id="user"
                                    aria-haspopup="true" aria-expanded="false">
                                <strong>Welcome </strong>${USERMODEL.fullName}
                            </button>
                            <div class="dropdown-menu dropdown-menu-right" id="userMenu" aria-labelledby="user">
                                <a href="<c:url value='/logout?action=logout'/>" class="dropdown-item">
                                    Đăng Xuất <i class="fas fa-sign-out"></i>
                                </a>
                                <a id="SortByQuantity" class="dropdown-item" href="">
                                    Sắp xếp theo số lượng
                                </a>
                                <a class="dropdown-item" href="#">
                                    Best Rating
                                </a>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </c:if>
    </div>


    <div class="col-lg-12 text-center align-items-center justify-content-center p-0">
        <nav class="navbar navbar-expand-lg navbar-light bg-light py-3" style=" padding-top: 0 !important;">
            <a href="#" class="navbar-brand d-block d-lg-none">
                <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="#" class="img-fluid"
                     style="max-height: 70px;">
            </a>
            <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-center" id="navbarCollapse">
                <ul class="navbar-nav menu-bar">
                    <li class="nav-item">
                        <a href="<c:url value='/home'/>" class="nav-link ${type == 'home' ? 'active' : ''}">
                            Trang chủ
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<c:url value='/product-shop?type=list&page=1&maxPageItem=8&sortName=productID&sortBy=asc'/>"
                           class="nav-link ${type == 'shop' ? 'active' : ''}">
                            Sản phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<c:url value='/news'/>" class="nav-link ${type == 'news' ? 'active' : ''}">
                            Tin tức
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link ${type == 'contact' ? 'active' : ''}">
                            Liên hệ
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
</div>

<script>

    $('#user').click(function (e) {
        e.preventDefault();
        var element = document.getElementById("userMenu");
        if (element.style.display === "block") {
            element.style.display = "none";
        } else {
            element.style.display = "block";
        }
    });
    var data = [];

    <c:forEach items="${products.listResult}" var="product">
    var jsonObj = {
        id: ${product.id},
        name: "${product.name}",
        price: ${product.price},
        quantity: ${product.quantity},
        brandID: ${product.brandID},
        brandName: "${product.brandName}",
        cateID: ${product.cateID},
        cateName: "${product.cateName}",
        description: "${product.description}",
        status: ${product.status},
        <c:set var="firstImageDisplayed" value="false" />
        <c:forEach items="${images.listResult}" var="image">
        <c:if test="${!firstImageDisplayed && product.id == image.productID}">
        imagePath: "${image.imageLink}"
        <c:set var="firstImageDisplayed" value="true" />
        </c:if>
        </c:forEach>

    };
    data.push(jsonObj);
    </c:forEach>

    const searchInput = document.getElementById('searchInput');
    const searchResults = document.getElementById('searchResults');


    searchInput.addEventListener('input', function () {
        const searchTerm = this.value.toLowerCase();
        const searchWords = searchTerm.split(/\s+/).filter(word => word.length > 0);

        // Lọc các sản phẩm chỉ cần chứa ít nhất một từ từ từ khóa tìm kiếm
        let filteredData = data.filter(item =>
            searchWords.some(word =>
                item.name.toLowerCase().includes(word) || item.brandName.toLowerCase().includes(word)
            )
        );

        // Tính toán số từ trùng khớp
        filteredData = filteredData.map(item => {
            const nameMatches = searchWords.filter(word => item.name.toLowerCase().includes(word)).length;
            const brandNameMatches = searchWords.filter(word => item.brandName.toLowerCase().includes(word)).length;
            const totalMatches = nameMatches + brandNameMatches;
            return {...item, matches: totalMatches};
        });

        // Sắp xếp theo số từ trùng khớp
        filteredData.sort((a, b) => b.matches - a.matches);

        if (searchTerm === '') {
            searchResults.style.display = 'none';
            searchResults.innerHTML = '';
        } else {
            searchResults.style.display = 'block';
            searchResults.innerHTML = '';

            filteredData.forEach(item => {
                var productDetailUrl = '<c:url value="/product-detail?type=detail&productID=" />' + item.id;
                const searchResultItem = document.createElement('a');
                searchResultItem.setAttribute("href", productDetailUrl);
                searchResultItem.setAttribute('class', 'product');

                if (item.quantity > 0) {
                    // Tạo chuỗi HTML với đường link
                    const htmlString =
                        '<img src="' + item.imagePath + '" alt="">' +
                        '<div class="product-detail">' +
                        '<h4>' +
                        '<a href="' + productDetailUrl + '?type=detail&productID=' + item.id + '">' +
                        item.name +
                        '</a>' +
                        '</h4>' +
                        '<p>$ ' + item.price + '</p>' +
                        '</div>';
                    searchResultItem.innerHTML = htmlString;
                    searchResults.appendChild(searchResultItem);
                }
            });
        }
    });


    document.addEventListener('click', function (event) {

        const isClickInsideSearchInput = document.getElementById('searchInput').contains(event.target);
        const searchResults = document.getElementById('searchResults');
        if (!isClickInsideSearchInput) {
            searchInput.value = "";
            searchResults.style.display = 'none';
            searchResults.innerHTML = '';
        }
    });


</script>


</body>

</html>