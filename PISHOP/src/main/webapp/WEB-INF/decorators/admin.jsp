<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title><sitemesh:write property="Trang chủ"/></title>

    <link rel="stylesheet" href="<c:url value='/template/admin/assets/css/bootstrap.min.css' />"/>
    <link rel="stylesheet" href="<c:url value='/template/admin/font-awesome/4.5.0/css/font-awesome.min.css' />"/>
    <link rel="stylesheet" href="<c:url value='/template/admin/assets/css/ace.min.css' />" class="ace-main-stylesheet"
          id="main-ace-style"/>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script src="<c:url value='/template/admin/assets/js/ace-extra.min.js' />"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="<c:url value='/template/paging/jquery.twbsPagination.js' />"></script>
    <%--	<script src="<c:url value='/ckeditor/ckeditor.js' />"></script>--%>

    <!-- Include jQuery Validate plugin -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>

    <style>
        .hidden {
            display: none;
        }

        #confirmationBox {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border: 1px solid #ccc;
        }

        .confirmationContent {
            text-align: center;
        }

        .confirmationContent button {
            margin: 5px;
        }


        /* Tăng kích thước của checkbox */
        .custom-control-input[type="checkbox"] {
            width: 1.2em;
            height: 1.2em;
        }

        .custom-control-label {
            padding-right: 20px;
        }

        /* Tăng kích thước của label điều khiển tùy chỉnh */
        .custom-control-label::before {
            width: 1.6em; /* Tùy chỉnh kích thước chiều rộng */
            height: 1.6em; /* Tùy chỉnh kích thước chiều cao */
            padding-right: 20px;
        }


        label.error {
            color: red;
        }

        .checkbox-wrapper-23 *,
        .checkbox-wrapper-23 *:after,
        .checkbox-wrapper-23 *:before {
            box-sizing: border-box;
        }

        .checkbox-wrapper-23 input {
            position: absolute;
            opacity: 0;
        }

        .checkbox-wrapper-23 input:checked + label svg path {
            stroke-dashoffset: 0;
        }

        .checkbox-wrapper-23 input:focus + label {
            transform: scale(1.03);
        }

        .checkbox-wrapper-23 input + label {
            display: block;
            border: 2px solid #333;
            width: var(--size);
            height: var(--size);
            border-radius: 6px;
            cursor: pointer;
            transition: all .2s ease;
        }

        .checkbox-wrapper-23 input + label:active {
            transform: scale(1.05);
            border-radius: 12px;
        }

        .checkbox-wrapper-23 input + label svg {
            pointer-events: none;
            padding: 5%;
        }

        .checkbox-wrapper-23 input + label svg path {
            fill: none;
            stroke: #333;
            stroke-width: 4px;
            stroke-linecap: round;
            stroke-linejoin: round;
            stroke-dasharray: 100;
            stroke-dashoffset: 101;
            transition: all 250ms cubic-bezier(1, 0, .37, .91);
        }

        .sidebar+.main-content{
            margin-left: 200px !important;
        }
    </style>
    <%--    <script src="<c:url value='/ckeditor/ckeditor.js' />"></script>--%>
</head>


<body class="no-skin">
<!-- header -->
<%@ include file="/common/admin/Header.jsp" %>
<!-- header -->

<div class="main-container" id="main-container">
    <script type="text/javascript">
        try {
            ace.settings.check('main-container', 'fixed')
        } catch (e) {
        }
    </script>

    <!-- header -->
    <%@ include file="/common/admin/Menu.jsp" %>
    <!-- header -->

    <sitemesh:write property="body"/>


    <!-- footer -->
    <%@ include file="/common/admin/Footer.jsp" %>
    <!-- footer -->

    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse display">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>
</div>

<script src="<c:url value='/template/admin/assets/js/bootstrap.min.js' />"></script>
<script src="<c:url value='/template/admin/assets/js/jquery-ui.custom.min.js' />"></script>
<script src="<c:url value='/template/admin/assets/js/jquery.ui.touch-punch.min.js' />"></script>
<script src="<c:url value='/template/admin/assets/js/jquery.easypiechart.min.js' />"></script>
<script src="<c:url value='/template/admin/assets/js/jquery.sparkline.min.js' />"></script>
<script src="<c:url value='/template/admin/assets/js/jquery.flot.min.js' />"></script>
<script src="<c:url value='/template/admin/assets/js/jquery.flot.pie.min.js' />"></script>
<script src="<c:url value='/template/admin/assets/js/jquery.flot.resize.min.js' />"></script>
<script src="<c:url value='/template/admin/assets/js/ace-elements.min.js' />"></script>
<script src="<c:url value='/template/admin/assets/js/ace.min.js' />"></script>
<script src="<c:url value='/template/admin/assets/js/bootstrap.min.js'/>"></script>

<!-- page specific plugin scripts -->
<script src="<c:url value='/template/admin/assets/js/jquery-ui.min.js'/>"></script>

</body>
</html>