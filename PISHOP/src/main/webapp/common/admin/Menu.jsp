<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<div id="sidebar" class="sidebar responsive ace-save-state" style="width: 200px !important;">
    <script type="text/javascript">
        try {
            ace.settings.loadState('sidebar')
        } catch (e) {
        }
    </script>



    <div class="sidebar-shortcuts">
        <div class="sidebar-shortcuts-large">
            <button class="btn btn-success">
                <i class="ace-icon fa fa-signal"></i>
            </button>

            <button class="btn btn-info">
                <i class="ace-icon fa fa-pencil"></i>
            </button>

            <button class="btn btn-warning">
                <i class="ace-icon fa fa-users"></i>
            </button>

            <button class="btn btn-danger">
                <i class="ace-icon fa fa-cogs"></i>
            </button>
        </div>

        <div class="sidebar-shortcuts-mini">
            <span class="btn btn-success"></span>

            <span class="btn btn-info"></span>

            <span class="btn btn-warning"></span>

            <span class="btn btn-danger"></span>
        </div>
    </div>

    <ul class="nav nav-list">
        <li>
            <a href="<c:url value="/admin-user?type=list&page=1&maxPageItem=5&sortName=userID&sortBy=asc"/>">
                <i class="menu-icon fa fa-user"></i>
                <span class="menu-text"></span>
                Danh sách người dùng

            </a>
        </li>
        <li>
            <a href="<c:url value="/admin-product?type=list&page=1&maxPageItem=5&sortName=productID&sortBy=asc"/>">
                <i class="menu-icon fa fa-product-hunt"></i>
                <span class="menu-text"></span>
                Danh sách sản phẩm

            </a>
        </li>
        <li>
            <a href="<c:url value="/admin-cart?type=list&page=1&maxPageItem=5&sortBy=asc"/>">
                <i class="menu-icon fa fa-shopping-cart"></i>
                <span class="menu-text"></span>
                Danh sách đơn hàng

            </a>
        </li>
        <li>
            <a href="<c:url value="/admin-comment?type=list&page=1&maxPageItem=5&sortBy=asc"/>">
                <i class="menu-icon fa fa-comment"></i>
                <span class="menu-text"></span>
                Danh sách bình luận

            </a>
        </li>
        <li>
            <a href="<c:url value="/admin-properties?type=colorcapacity&page=1&maxPageItem=5&sortBy=asc"/>">
                <i class="menu-icon fa fa-edit"></i>
                <span class="menu-text"></span>
                Màu sắc &amp; Dung lượng
            </a>
        </li>

        <li>
            <a href="<c:url value="/admin-properties?type=brandcategory&page=1&maxPageItem=5&sortBy=asc"/>">
                <i class="menu-icon fa fa-edit"></i>
                <span class="menu-text"></span>
                Thương hiệu &amp; Danh mục
            </a>
        </li>
    </ul>
</div>