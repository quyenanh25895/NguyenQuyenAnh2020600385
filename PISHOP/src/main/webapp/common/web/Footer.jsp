<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>

<head>
    <title>Title</title>
    <!-- Start of LiveChat (www.livechat.com) code -->
    <script>
        window.__lc = window.__lc || {};
        window.__lc.license = 17978004;
        window.__lc.integration_name = "manual_channels";
        ;(function (n, t, c) {
            function i(n) {
                return e._h ? e._h.apply(null, n) : e._q.push(n)
            }

            var e = {
                _q: [], _h: null, _v: "2.0", on: function () {
                    i(["on", c.call(arguments)])
                }, once: function () {
                    i(["once", c.call(arguments)])
                }, off: function () {
                    i(["off", c.call(arguments)])
                }, get: function () {
                    if (!e._h) throw new Error("[LiveChatWidget] You can't use getters before load.");
                    return i(["get", c.call(arguments)])
                }, call: function () {
                    i(["call", c.call(arguments)])
                }, init: function () {
                    var n = t.createElement("script");
                    n.async = !0, n.type = "text/javascript", n.src = "https://cdn.livechatinc.com/tracking.js", t.head.appendChild(n)
                }
            };
            !n.__lc.asyncInit && e.init(), n.LiveChatWidget = n.LiveChatWidget || e
        }(window, document, [].slice))
    </script>
    <noscript>
        <a href="https://www.livechat.com/chat-with/17978004/" rel="nofollow">Chat with us</a>, powered by <a
            href="https://www.livechat.com/?welcome" rel="noopener nofollow" target="_blank">LiveChat</a>
    </noscript>
    <!-- End of LiveChat code -->

</head>

<body>
<!-- Footer Start -->
<div class="container-fluid bg-secondary text-dark mt-5 pt-5">
    <div class="row px-xl-5 pt-5">
        <div class="col-lg-4 col-md-4 mb-5 pr-3 pr-xl-5">
            <a href="<c:url value='/home'/>" class="text-decoration-none">
                <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="#" class="img-fluid"
                     style="max-height: 70px;">
            </a>
            <p>
                PIIIIIIIIIIIIIIIIII
            </p>
            <p class="mb-2">
                <i class="fa fa-map-marker-alt text-primary mr-3"></i>HaUI
            </p>
            <p class="mb-2">
                <i class="fa fa-envelope text-primary mr-3"></i>pishop@gmail.com
            </p>
            <p class="mb-0">
                <i class="fa fa-phone-alt text-primary mr-3"></i>0327******
            </p>
        </div>
        <div class="col-lg-8 col-md-8">
            <div class="row">
                <div class="col-lg-6 col-md-6 mb-5">
                    <h5 class="font-weight-bold text-dark mb-4">Quick Links</h5>
                    <div class="d-flex flex-column justify-content-start">
                        <a class="text-dark mb-2" href="<c:url value='/home'/>"><i
                                class="fa fa-angle-right mr-2"></i>Home</a>
                        <a class="text-dark mb-2"
                           href="<c:url value='/product-shop?type=list&page=1&maxPageItem=8&sortName=productID&sortBy=asc'/>"><i
                                class="fa fa-angle-right mr-2"></i>Our
                            Shop</a>
                        <c:if test="${not empty USERMODEL}">
                            <a class="text-dark mb-2" href="<c:url value='/cart?type=cart'/>"><i
                                    class="fa fa-angle-right mr-2"></i>Shopping Cart</a>
                        </c:if>
                        <a class="text-dark" href="#"><i class="fa fa-angle-right mr-2"></i>Contact Us</a>
                    </div>
                </div>

                <div class="col-lg-6 col-md-6 mb-5">
                    <h5 class="font-weight-bold text-dark mb-4">Newsletter</h5>
                    <form action="">
                        <div class="form-group">
                            <input type="text" class="form-control border-0 py-4" placeholder="Your Name"
                                   required="required"/>
                        </div>
                        <div class="form-group">
                            <input type="email" class="form-control border-0 py-4" placeholder="Your Email"
                                   required="required"/>
                        </div>
                        <div>
                            <button class="btn btn-primary btn-block border-0 py-3" type="submit">
                                Subscribe Now
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer End -->

</body>

</html>