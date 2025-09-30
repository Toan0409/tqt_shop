<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="utf-8">
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">
                    <title>Giỏ hàng | T-Shop</title>

                    <!-- Favicons -->
                    <link href="/assets/img/logo.png" rel="icon">
                    <link href="/assets/img/logo.png" rel="apple-touch-icon">

                    <!-- Google Fonts -->
                    <link href="https://fonts.gstatic.com" rel="preconnect">
                    <link
                        href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
                        rel="stylesheet">
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                        rel="stylesheet" />
                    <!-- Vendor CSS Files -->
                    <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
                    <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
                    <link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
                    <link href="/assets/vendor/quill/quill.snow.css" rel="stylesheet">
                    <link href="/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
                    <link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
                    <link href="/assets/vendor/simple-datatables/style.css" rel="stylesheet">

                    <!-- Template Main CSS File -->
                    <link href="/assets/css/style.css" rel="stylesheet">

                </head>

                <body>
                    <jsp:include page="/WEB-INF/view/client/layout/header.jsp" />

                    <main class="main">
                        <div class="container py-5">
                            <!-- Breadcrumb -->
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                                    <li class="breadcrumb-item active">Giỏ hàng</li>
                                </ol>
                            </nav>

                            <!-- Cart Table -->
                            <div class="table-responsive shadow-sm rounded">
                                <table class="table align-middle text-center">
                                    <thead class="table-light">
                                        <tr>
                                            <th scope="col">Sản phẩm</th>
                                            <th scope="col">Tên</th>
                                            <th scope="col">Giá</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Thành tiền</th>
                                            <th scope="col">Xử lý</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty cartDetails}">
                                            <tr>
                                                <td colspan="6" class="py-4 fs-5 text-muted">
                                                    <i class="bi bi-cart-x"></i> Giỏ hàng trống
                                                </td>
                                            </tr>
                                        </c:if>

                                        <c:forEach var="cartDetail" items="${cartDetails}" varStatus="status">
                                            <tr>
                                                <!-- Ảnh -->
                                                <td>
                                                    <img src="/images/products/${cartDetail.product.image}"
                                                        class="img-fluid rounded-circle"
                                                        style="width: 70px; height: 70px;" alt="">
                                                </td>

                                                <!-- Tên -->
                                                <td>${cartDetail.product.name}</td>

                                                <!-- Giá -->
                                                <td>
                                                    <fmt:formatNumber type="number" value="${cartDetail.price}" /> đ
                                                </td>

                                                <!-- Số lượng -->
                                                <td>
                                                    <div class="input-group input-group-sm justify-content-center"
                                                        style="max-width: 120px;">
                                                        <button class="btn btn-outline-secondary btn-minus"
                                                            type="button">
                                                            <i class="fa fa-minus"></i>
                                                        </button>
                                                        <input type="text" class="form-control text-center"
                                                            value="${cartDetail.quantity}"
                                                            data-cart-detail-id="${cartDetail.id}"
                                                            data-cart-detail-price="${cartDetail.price}"
                                                            data-cart-detail-index="${status.index}">
                                                        <button class="btn btn-outline-secondary btn-plus"
                                                            type="button">
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </div>
                                                </td>

                                                <!-- Thành tiền -->
                                                <td data-cart-detail-id="${cartDetail.id}">
                                                    <fmt:formatNumber type="number"
                                                        value="${cartDetail.price * cartDetail.quantity}" /> đ
                                                </td>

                                                <!-- Xóa -->
                                                <td>
                                                    <form method="post"
                                                        action="/delete-product-from-cart/${cartDetail.id}">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <button class="btn btn-sm btn-light border" title="Xóa">
                                                            <i class="fa fa-times text-danger"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- End Cart Table -->

                            <!-- Cart Summary -->
                            <c:if test="${not empty cartDetails}">
                                <div class="row mt-5">
                                    <div class="col-lg-6 ms-auto">
                                        <div class="card border-0 shadow-sm">
                                            <div class="card-body">
                                                <h5 class="card-title mb-3">Thông tin đơn hàng</h5>

                                                <div class="d-flex justify-content-between mb-2">
                                                    <span>Tạm tính:</span>
                                                    <strong data-cart-total-price="${totalPrice}">
                                                        <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                    </strong>
                                                </div>

                                                <div class="d-flex justify-content-between mb-2">
                                                    <span>Phí vận chuyển:</span>
                                                    <strong>0 đ</strong>
                                                </div>

                                                <hr>

                                                <div class="d-flex justify-content-between mb-3">
                                                    <span>Tổng cộng:</span>
                                                    <strong class="text-danger fs-5"
                                                        data-cart-total-price="${totalPrice}">
                                                        <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                    </strong>
                                                </div>

                                                <!-- Checkout form -->
                                                <form:form method="post" action="/confirm-checkout"
                                                    modelAttribute="cart">
                                                    <input type="hidden" name="${_csrf.parameterName}"
                                                        value="${_csrf.token}" />
                                                    <div style="display:none;">
                                                        <c:forEach var="cartDetail" items="${cart.cartDetails}"
                                                            varStatus="status">
                                                            <form:input type="hidden"
                                                                path="cartDetails[${status.index}].id"
                                                                value="${cartDetail.id}" />
                                                            <form:input type="hidden"
                                                                path="cartDetails[${status.index}].quantity"
                                                                value="${cartDetail.quantity}" />
                                                        </c:forEach>
                                                    </div>
                                                    <button class="btn btn-primary w-100 py-2">
                                                        <i class="bi bi-check2-circle me-1"></i> Xác nhận đặt hàng
                                                    </button>
                                                </form:form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </main>

                    <!-- Scripts -->
                    <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

                    <script src="/assets/vendor/quill/quill.js"></script>
                    <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>
                    <script src="/assets/vendor/tinymce/tinymce.min.js"></script>
                    <script src="/assets/vendor/php-email-form/validate.js"></script>


                    <!-- Template Main JS File -->
                    <script src="/assets/js/main.js"></script>

                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                    <script src="/assets/js/cart.js"></script>
                </body>

                </html>