<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>T-Shop | Chi tiết sản phẩm</title>
            <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
            <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
            <link href="/assets/css/style.css" rel="stylesheet">
        </head>

        <body>
            <jsp:include page="/WEB-INF/view/admin/layout/header.jsp" />
            <jsp:include page="/WEB-INF/view/admin/layout/sidebar.jsp" />

            <main id="main" class="main">
                <div class="pagetitle">
                    <h1>Chi tiết sản phẩm</h1>
                </div>

                <section class="section">
                    <div class="card shadow-sm">
                        <div class="card-body p-4">
                            <div class="row">
                                <!-- Hình ảnh -->
                                <div class="col-md-5 text-center">
                                    <img src="${pageContext.request.contextPath}/resources/images/products/${product.image}"
                                        class="img-fluid rounded border" alt="${product.name}" width="400">
                                </div>

                                <!-- Thông tin sản phẩm -->
                                <div class="col-md-7">
                                    <h3 class="fw-bold mb-3">${product.name}</h3>
                                    <h4 class="text-danger mb-3">
                                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" />
                                    </h4>

                                    <p><strong>Mô tả ngắn:</strong> ${product.shortDesc}</p>
                                    <p><strong>Mô tả chi tiết:</strong></p>
                                    <p class="text-muted">${product.detailDesc}</p>

                                    <div class="row mt-4">
                                        <div class="col-6">
                                            <p><i class="bi bi-box-seam"></i> <strong>Số lượng:</strong>
                                                ${product.quantity}</p>
                                            <p><i class="bi bi-cart-check"></i> <strong>Đã bán:</strong> ${product.sold}
                                            </p>
                                        </div>
                                        <div class="col-6">
                                            <p><i class="bi bi-building"></i> <strong>Hãng:</strong> ${product.factory}
                                            </p>
                                            <p><i class="bi bi-person-badge"></i> <strong>Đối tượng:</strong>
                                                ${product.target}</p>
                                        </div>
                                    </div>

                                    <div class="mt-4">
                                        <a href="${pageContext.request.contextPath}/admin/product"
                                            class="btn btn-secondary">
                                            <i class="bi bi-arrow-left"></i> Quay lại
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/product/edit/${product.id}"
                                            class="btn btn-warning">
                                            <i class="bi bi-pencil"></i> Sửa
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/product/delete/${product.id}"
                                            class="btn btn-danger">
                                            <i class="bi bi-trash"></i> Xóa
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </main>

            <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>