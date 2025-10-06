<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <title>Đặt hàng thành công | T-shop</title>
                <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
                <link href="/assets/css/main.css" rel="stylesheet">
                <style>
                    .order-card {
                        max-width: 900px;
                        margin: 0 auto;
                    }

                    .success-icon {
                        font-size: 64px;
                    }

                    .order-summary dt {
                        font-weight: 600;
                    }

                    .btn-round {
                        border-radius: 999px;
                        padding-left: 28px;
                        padding-right: 28px;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/WEB-INF/view/client/layout/header.jsp" />

                <main class="main py-5">
                    <div class="container">
                        <div class="card shadow-sm order-card">
                            <div class="card-body text-center py-5">
                                <div class="mb-4 text-success">
                                    <i class="fa-solid fa-circle-check success-icon"></i>
                                </div>
                                <h2 class="mb-2">Cảm ơn bạn — Đơn hàng đã được đặt!</h2>
                                <p class="text-muted mb-4">Chúng tôi đã nhận được đơn hàng của bạn. Vui lòng lưu các
                                    thông tin dưới đây để tham khảo.</p>

                                <!-- Order meta -->
                                <div class="row justify-content-center mb-4">
                                    <div class="col-md-10">
                                        <dl class="row order-summary">
                                            <dt class="col-sm-4">Mã đơn hàng:</dt>
                                            <dd class="col-sm-8"><strong>${orderId}</strong></dd>

                                            <dt class="col-sm-4">Tổng thanh toán:</dt>
                                            <dd class="col-sm-8">
                                                <fmt:formatNumber value="${totalPrice}" type="number" /> đ
                                            </dd>

                                            <dt class="col-sm-4">Người nhận:</dt>
                                            <dd class="col-sm-8">${receiverName} — ${receiverPhone}</dd>

                                            <dt class="col-sm-4">Địa chỉ giao hàng:</dt>
                                            <dd class="col-sm-8">${receiverAddress}</dd>

                                            <dt class="col-sm-4">Hình thức thanh toán:</dt>
                                            <dd class="col-sm-8">
                                                <c:choose>
                                                    <c:when test="${paymentMethod == 'cod'}">Thanh toán khi nhận hàng
                                                        (COD)</c:when>
                                                    <c:when test="${paymentMethod == 'vnpay'}">VNPay</c:when>
                                                    <c:otherwise>${paymentMethod}</c:otherwise>
                                                </c:choose>
                                            </dd>
                                        </dl>
                                    </div>
                                </div>

                                <!-- Actions -->
                                <div class="d-flex justify-content-center gap-3">
                                    <a href="/" class="btn btn-light btn-round">Tiếp tục mua sắm</a>

                                    <!-- nếu có link tracking hoặc xem chi tiết -->
                                    <c:if test="${not empty trackingUrl}">
                                        <a href="${trackingUrl}" class="btn btn-outline-primary btn-round">Theo dõi đơn
                                            hàng</a>
                                    </c:if>

                                    <a href="/orders/${orderId}" class="btn btn-primary btn-round">Xem chi tiết đơn
                                        hàng</a>
                                </div>

                                <!-- Tips -->
                                <div class="mt-4 text-muted small">
                                    <p class="mb-1">Bạn sẽ nhận email/Xác nhận SMS khi đơn hàng được xử lý.</p>
                                    <p class="mb-0">Cần hỗ trợ? <a href="/contact">Liên hệ chúng tôi</a> hoặc gọi
                                        <strong>1900-xxx-xxx</strong>.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>

                <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                <script src="/assets/js/main.js"></script>
            </body>

            </html>