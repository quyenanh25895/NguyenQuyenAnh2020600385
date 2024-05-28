<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:url var="APIUrl" value="/api-admin-properties"/>
<c:url var="ColorUrl" value="/admin-properties"/>
<html>
<head>
    <title>Title</title>
    <link href="<c:url value='/assets/css/style2.css' />" rel="stylesheet" type="text/css" media="all"/>
</head>

<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>
            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="<c:url value="admin-home"/> ">Trang chủ</a>
                </li>
                <li class="active">Chỉnh sửa bài viết</li>
            </ul><!-- /.breadcrumb -->
        </div>

        <div class="page-content">
            <c:if test="${not empty messageResponse}">
                <div class="alert alert-${alert}">
                        ${messageResponse}
                </div>
            </c:if>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-12 justify-content-center align-items-center">
                    <h3>Số lượng đơn hàng</h3>
                    <canvas id="orderCount"></canvas>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-12 justify-content-center align-items-center">
                    <h3>Chi tiêu của mỗi người dùng</h3>
                    <canvas id="userPay"></canvas>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-12 justify-content-center align-items-center">
                    <h3>Top 10 sản phẩm bán chạy nhất</h3>
                    <canvas id="top10Product"></canvas>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-12 justify-content-center align-items-center">
                    <h3>Chi tiêu của mỗi người dùng</h3>
                    <canvas id="Chart"></canvas>
                </div>
            </div>
        </div>


    </div>
</div>
<script>
    const ctx = document.getElementById('orderCount').getContext('2d');
    const ctx1 = document.getElementById('userPay').getContext('2d');
    const ctx2 = document.getElementById('top10Product').getContext('2d');

    var labelsOrder = [];
    var orderData = [];
    <c:forEach items="${staticalModel.listResult}" var="statical">
    labelsOrder.push('${statical.createdDate}');
    orderData.push('${statical.quantity}');
    </c:forEach>


    var labelsUser = []
    var userData = [];
    <c:forEach items="${userStat.listResult}" var="statical">
    labelsUser.push('${statical.userName}');
    userData.push('${statical.price}');
    </c:forEach>


    var labelsTop10Product = [];
    var dataTop10Product = [];
    <c:forEach items="${top10.listResult}" var="statical">
    labelsTop10Product.push('${statical.productName}');
    dataTop10Product.push('${statical.quantity}');
    </c:forEach>

    createChart(ctx, labelsOrder, orderData, 'Số lượng sản phẩm bán ra');
    createChart(ctx1, labelsUser, userData, 'Chi tiêu của mỗi người dùng');
    createChart(ctx2, labelsTop10Product, dataTop10Product, 'Top 10 sản phẩm bán chạy nhất');

    function createChart(ctx, labels, data, label) {
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: label,
                    data: data,
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }
</script>


</body>

</html>
