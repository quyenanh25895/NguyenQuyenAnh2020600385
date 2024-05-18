<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title><sitemesh:write property="title"/></title>

    <!-- css -->
    <link href="<c:url value='/template/web/bootstrap/css/bootstrap.min.css' />" rel="stylesheet" type="text/css"
          media="all"/>
    <link href="<c:url value='/template/web/css/style.css' />" rel="stylesheet" type="text/css" media="all"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Home.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/5981eab0fc.js" crossorigin="anonymous"></script>
    <style>
        .article img {
            height: 250px;
            max-width: 350px;
            margin-right: 20px;
        }

        .article {
            max-height: 500px; /* Giới hạn chiều cao của mỗi ô */
            overflow: hidden; /* Ẩn nội dung dư thừa */
        }
    </style>
</head>
<body>
<!-- header -->
<%@ include file="/common/web/TopMenu.jsp" %>

<sitemesh:write property="body"/>

<!-- footer -->
<%@ include file="/common/web/Footer.jsp" %>
<!-- footer -->

<script type="text/javascript" src="<c:url value='/template/web/jquery/jquery.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/template/web/bootstrap/js/bootstrap.bundle.min.js' />"></script>
<script src="<c:url value='/template/paging/jquery.twbsPagination.js'/>"></script>
</body>
</html>