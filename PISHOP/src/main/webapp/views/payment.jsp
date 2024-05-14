
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:url var="APIUrl" value="/api-vnpay"/>

<html>
<head>
    <title>Title</title>
</head>
<body>
    <input type="button" id="pay" value="ppppppppppppppppppppppppp"/>

<script>
    $("#pay").click(function (e){
        e.preventDefault();
        window.location.href = '${APIUrl}';
    });


</script>
</body>
</html>
