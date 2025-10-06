<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <title>Đặt hàng không thành công | T-shop</title>
                <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
                <link href="/assets/css/main.css" rel="stylesheet">
                <style>
                    .fail-icon {
                        font-size: 64px;
                        color: #dc3545;
                    }

                    .fail-card {
                        max-width: 820px;
                        margin: 0 auto;
                    }

                    .small-note {
                        font-size: .95rem;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/WEB-INF/view/client/layout/header.jsp" />

                <main class="main py-5">
                    <div class="container">
                        <div class="card shadow-sm fail-card">
                            <div class="card-body text-center py-5">
                                <div class="mb-4">
                                    <i class="fa-solid fa-circle-xmark fail-icon"></i>
                                </div>
                                <h2 class="mb-2">Đặt hàng không thành công</h2>
                                <p class="text-muted mb-3">Rất tiếc — đã xảy ra lỗi khi xử lý đơn hàng của bạn.</p>

                                <div class="mb-3">
                                    <c:choose>
                                        <c:when test="${not empty errorMessage}">
                                            <div class="alert alert-warning" role="alert">${errorMessage}</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-warning" role="alert">Lỗi trong quá trình thanh toán
                                                hoặc kết nối với cổng thanh toán.</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- If we have partial order or cart info, show summary -->
                                <c:if test="${not empty cartDetails}">
                                    <div class="mb-4 text-start mx-auto" style="max-width:700px;">
                                        <h6 class="mb-2">Sản phẩm trong giỏ:</h6>
                                        <ul class="list-group">
                                            <c:forEach var="item" items="${cartDetails}">
                                                <li
                                                    class="list-group-item d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <strong>${item.product.name}</strong><br />
                                                        <small class="text-muted">Số lượng: ${item.quantity}</small>
                                                    </div>
                                                    <span>
                                                        <fmt:formatNumber value="${item.price * item.quantity}"
                                                            type="number" /> đ
                                                    </span>
                                                </li>
                                            </c:forEach>
                                            <li class="list-group-item d-flex justify-content-between">
                                                <strong>Tổng tạm tính</strong>
                                                <strong>
                                                    <fmt:formatNumber value="${totalPrice}" type="number" /> đ
                                                </strong>
                                            </li>
                                        </ul>
                                    </div>
                                </c:if>

                                <div class="d-flex justify-content-center gap-3">
                                    <a href="/cart" class="btn btn-secondary">Quay lại giỏ hàng</a>
                                    <a href="/checkout" class="btn btn-primary">Thử thanh toán lại</a>
                                    <a href="/contact" class="btn btn-outline-dark">Yêu cầu hỗ trợ</a>
                                </div>

                                <div class="mt-4 small-note text-muted">
                                    <p class="mb-1">Nếu bạn đã bị trừ tiền từ thẻ/bank nhưng đơn hàng thất bại, hãy liên
                                        hệ chúng tôi kèm thông tin giao dịch để được kiểm tra.</p>
                                    <p class="mb-0">Mẹo: thử chọn phương thức thanh toán khác hoặc chờ vài phút rồi thử
                                        lại.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>

                <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                <script src="/assets/js/main.js"></script>
            </body>

            </html>