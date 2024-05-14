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
                <div class="col-lg-6 col-sm-6 col-xs-6">
                    <form id="colorForm">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"> Thêm màu mới: </label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" name="colorCode" id="colorCode-new"
                                       value=""/>
                            </div>
                            <div class="col-sm-1">
                                <input type="button" class="btn btn-no-border btn-success btn-color-add" value="Add"/>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <br>

                        <c:forEach items="${colors.listResult}" var="color">
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right">Màu: </label>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control" name="colorCode" id="colorCode-${color.id}"
                                           value="${color.colorCode}"/>
                                </div>
                                <div class="col-sm-1">
                                    <input type="button" class="btn btn-no-border btn-success btn-color-edit"
                                           data-id="${color.id}"
                                           data-colorcode="${color.colorCode}"
                                           value="Edit"/>
                                </div>
                                <div class="col-sm-1">
                                    <input type="button" class="btn btn-no-border btn-success btn-color-delete"
                                           data-id="${color.id}"
                                           data-type="color"
                                           value="Delete"/>
                                </div>
                            </div>
                            <br/>
                            <br/>
                        </c:forEach>


                    </form>
                </div>


                <div class="col-lg-6 col-sm-6 col-xs-6">
                    <form id="capacityForm">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"> Thêm dung lượng mới: </label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control capacityValue" name="capacityValue" id="capacityValue-new"
                                       value="" placeholder="Nhập dung lượng"/>
                            </div>
                            <div class="col-sm-1">
                                <input type="button" class="btn btn-no-border btn-success btn-capacity-add"
                                       value="Add"/>
                            </div>
                        </div>
                        <br/>
                        <br/>
                        <br>

                        <c:forEach items="${capacities.listResult}" var="capacity">
                            <div class="form-group">
                                <label class="col-sm-3 control-label no-padding-right">Dung lượng: </label>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control capacityValue" name="capacity" id="capacity-${capacity.id}"
                                           value="${capacity.capacityValue}"/>
                                </div>
                                <div class="col-sm-1">
                                    <input type="button" class="btn btn-no-border btn-success btn-capacity-edit"
                                           data-id="${capacity.id}"
                                           value="Edit"/>
                                </div>
                                <div class="col-sm-1">
                                    <input type="button" class="btn btn-no-border btn-success btn-capacity-delete"
                                           data-id="${capacity.id}"
                                           data-type="capacity"
                                           value="Delete"/>
                                </div>
                            </div>
                            <br/>
                            <br/>
                        </c:forEach>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="confirmationBox" class="hidden">
    <div class="confirmationContent">
        <p>Bạn có chắc chắn muốn xóa?</p>
        <button id="confirmDelete">Xác nhận</button>
        <button id="cancelDelete">Hủy</button>
    </div>
</div>

<script>

    // Lặp qua tất cả các ô input có class là 'numberInput' và gán sự kiện cho mỗi ô input
    var numberInputs = document.getElementsByClassName('capacityValue');
    for (var i = 0; i < numberInputs.length; i++) {
        numberInputs[i].addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    }


    var id;
    var type;

    $('.btn-capacity-delete').click(function (e){
        e.preventDefault();
        id = $(this).data("id");
        type = $(this).data("type");
        document.getElementById("confirmationBox").classList.remove("hidden");

    });
    $('.btn-color-delete').click(function (e){
        e.preventDefault();
        id = $(this).data("id");
        type = $(this).data("type");
        document.getElementById("confirmationBox").classList.remove("hidden");
    });

    document.getElementById("confirmDelete").addEventListener("click", function () {
        var url = "${APIUrl}?type=capacity";
        Delete(id, type, url);
        alert("Đã xóa!"); // Ví dụ: Hiển thị thông báo đã xóa
        document.getElementById("confirmationBox").classList.add("hidden");
    });

    document.getElementById("cancelDelete").addEventListener("click", function () {
        document.getElementById("confirmationBox").classList.add("hidden");
    });


    $(".btn-color-edit").click(function (e) {
        e.preventDefault();
        var id = $(this).data("id");
        var colorCode = $('#colorCode-' + id).val();
        var type = "color";
        var url = "${APIUrl}?type=color";
        submitChange(id, colorCode, type, url);
    });

    $(".btn-color-add").click(function (e) {
        e.preventDefault();
        var colorCode = $('#colorCode-new').val();
        var type = 'color';
        var url = "${APIUrl}?type=color";
        submitAdd(colorCode, type, url);
    });

    $(".btn-capacity-add").click(function (e) {
        e.preventDefault();
        var capacityValue = $('#capacityValue-new').val();
        var type = 'capacity';
        var url = "${APIUrl}?type=capacity";
        submitAdd(capacityValue, type, url);
    });

    $(".btn-capacity-edit").click(function (e) {
        e.preventDefault();
        var id = $(this).data("id");
        var capacityValue = $('#capacity-' + id).val();
        var type = "capacity";
        var url = "${APIUrl}?type=capacity";
        submitChange(id, capacityValue, type, url);
    });

    function submitChange(id, value, type, url) {
        var data = {};
        if (type === "color") {
            data = {
                id: id,
                colorCode: value,
            }
        } else if (type === "capacity") {
            data = {
                id: id,
                capacityValue: value,

            }
        }

        $.ajax({
            url: url,
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                window.location.href = "${ColorUrl}?type=colorcapacity";
            },
            error: function (error) {
                window.location.href = "${ColorUrl}?type=colorcapacity";
            }
        });
    }

    function submitAdd(value, type, url) {
        var data = {};
        if (type === 'color') {
            data = {
                colorCode: value
            }
        } else if (type === 'capacity') {
            data = {
                capacityValue: value
            }
        }


        $.ajax({
            url: url,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                window.location.href = "${ColorUrl}?type=colorcapacity";
            },
            error: function (error) {
                window.location.href = "${ColorUrl}?type=colorcapacity";
            }
        });
    }

    function Delete(value, type, url) {
        var data = {};
        if (type === 'color') {
            data = {
                id: value
            }
        } else if (type === 'capacity') {
            data = {
                id: value
            }
        }


        $.ajax({
            url: url,
            type: 'DELETE',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (result) {
                window.location.href = "${ColorUrl}?type=colorcapacity";
            },
            error: function (error) {
                window.location.href = "${ColorUrl}?type=colorcapacity";
            }
        });
    }


</script>


</body>

</html>
