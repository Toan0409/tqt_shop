<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="utf-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <link href="/assets/img/logo.png" rel="icon">
                    <link href="/assets/img/logo.png" rel="apple-touch-icon">
                    <title>Xác nhận thanh toán | T-shop</title>

                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                        rel="stylesheet" />
                    <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
                    <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
                    <link href="/assets/css/main.css" rel="stylesheet">
                </head>

                <body>
                    <jsp:include page="/WEB-INF/view/client/layout/header.jsp" />

                    <main class="main">
                        <div class="container py-5">
                            <!-- Breadcrumb -->
                            <nav aria-label="breadcrumb" class="mb-4">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>

                                    <li class="breadcrumb-item active">Xác nhận thanh toán</li>
                                </ol>
                            </nav>

                            <!-- Cart Table -->
                            <div class="card shadow-sm mb-5">
                                <div class="card-header bg-light">
                                    <h5 class="mb-0">Sản phẩm trong giỏ hàng</h5>
                                </div>
                                <div class="card-body table-responsive">
                                    <table class="table align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Sản phẩm</th>
                                                <th>Tên</th>
                                                <th>Giá</th>
                                                <th>Số lượng</th>
                                                <th>Thành tiền</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:if test="${empty cartDetails}">
                                                <tr>
                                                    <td colspan="5" class="text-center text-muted py-4">
                                                        Không có sản phẩm trong giỏ hàng
                                                    </td>
                                                </tr>
                                            </c:if>
                                            <c:forEach var="cartDetail" items="${cartDetails}">
                                                <tr>
                                                    <td>
                                                        <img src="/images/products/${cartDetail.product.image}"
                                                            class="img-thumbnail" style="width:70px; height:70px;">
                                                    </td>
                                                    <td>${cartDetail.product.name}</td>
                                                    <td>
                                                        <fmt:formatNumber value="${cartDetail.price}" type="number" /> đ
                                                    </td>
                                                    <td>${cartDetail.quantity}</td>
                                                    <td>
                                                        <fmt:formatNumber
                                                            value="${cartDetail.price * cartDetail.quantity}"
                                                            type="number" /> đ
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Checkout Form -->
                            <c:if test="${not empty cartDetails}">
                                <form:form action="/start-vnpay-payment" method="post" modelAttribute="cart">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <input type="hidden" name="totalPrice" value="${totalPrice}" />

                                    <div class="row g-4">
                                        <!-- Receiver Info -->
                                        <div class="col-md-6">
                                            <div class="card shadow-sm h-100">
                                                <div class="card-header bg-light">
                                                    <h5 class="mb-0">Thông tin người nhận</h5>
                                                </div>
                                                <div class="card-body">
                                                    <div class="mb-3">
                                                        <label class="form-label">Tên người nhận</label>
                                                        <input type="text" class="form-control" name="receiverName"
                                                            required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Địa chỉ</label>
                                                        <input type="text" class="form-control" name="receiverAddress"
                                                            required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Số điện thoại</label>
                                                        <input type="tel" class="form-control" name="receiverPhone"
                                                            required>
                                                    </div>
                                                    <a href="/cart" class="text-decoration-none">
                                                        <i class="fas fa-arrow-left me-1"></i> Quay lại giỏ hàng
                                                    </a>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Payment Info -->
                                        <div class="col-md-6">
                                            <div class="card shadow-sm h-100">
                                                <div class="card-header bg-light">
                                                    <h5 class="mb-0">Thông tin thanh toán</h5>
                                                </div>
                                                <div class="card-body">
                                                    <div class="mb-3 d-flex justify-content-between">
                                                        <span>Phí vận chuyển</span>
                                                        <strong>0 đ</strong>
                                                    </div>

                                                    <div class="mb-4">
                                                        <label class="form-label">Hình thức thanh toán</label>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio"
                                                                id="paymentVNPay" name="paymentMethod" value="vnpay"
                                                                checked>
                                                            <label class="form-check-label"
                                                                for="paymentVNPay">VNPay</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" id="paymentCOD"
                                                                name="paymentMethod" value="cod">
                                                            <label class="form-check-label" for="paymentCOD">Thanh toán
                                                                khi nhận hàng (COD)</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div
                                                    class="card-footer bg-white border-top d-flex justify-content-between align-items-center">
                                                    <h5 class="mb-0">Tổng cộng:</h5>
                                                    <h5 class="text-primary mb-0">
                                                        <fmt:formatNumber value="${totalPrice}" type="number" /> đ
                                                    </h5>
                                                </div>
                                            </div>
                                            <div class="text-end mt-3">
                                                <button type="submit" class="btn btn-primary px-4 py-2 rounded-pill">
                                                    Xác nhận thanh toán
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
                            </c:if>
                        </div>
                    </main>
                    <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

                    <script src="/assets/vendor/quill/quill.js"></script>
                    <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>
                    <script src="/assets/vendor/tinymce/tinymce.min.js"></script>
                    <script src="/assets/vendor/php-email-form/validate.js"></script>

                    <script src="/assets_client/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script src="/assets/js/main.js"></script>
                </body>

                </html>