<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Thanh toán VietQR | T-Shop</title>
            <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body>
            <jsp:include page="/WEB-INF/view/client/layout/header.jsp" />

            <div class="container py-5 text-center">
                <h3 class="mb-4 text-primary">Thanh toán đơn hàng #${orderId}</h3>
                <p>Quét mã QR bằng ứng dụng ngân hàng để thanh toán:</p>

                <img src="${qrUrl}" alt="QR VietQR" width="300" class="rounded shadow my-3" />

                <h5 class="mt-3 text-danger">
                    Số tiền:
                    <fmt:formatNumber value="${totalPrice}" type="number" /> đ
                </h5>

                <p class="text-muted">Nội dung chuyển khoản: <strong>ThanhToanDonHang${orderId}</strong></p>

                <div class="mt-4">
                    <a href="/" class="btn btn-success px-4">Về trang chủ</a>
                </div>
            </div>

            <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>