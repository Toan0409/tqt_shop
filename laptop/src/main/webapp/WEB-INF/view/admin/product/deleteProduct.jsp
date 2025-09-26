<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <meta content="width=device-width, initial-scale=1.0" name="viewport">

                <title>T-Shop | Xóa sản phẩm</title>
                <link href="/assets/img/logo.png" rel="icon">
                <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
                <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
                <link href="/assets/css/style.css" rel="stylesheet">
            </head>

            <body>
                <jsp:include page="/WEB-INF/view/admin/layout/header.jsp" />
                <jsp:include page="/WEB-INF/view/admin/layout/sidebar.jsp" />

                <main id="main" class="main">
                    <div class="pagetitle">
                        <h1>Xóa sản phẩm</h1>
                    </div>

                    <section class="section">
                        <div class="card">
                            <div class="card-body p-4">

                                <h5>Bạn có chắc chắn muốn xóa sản phẩm này?</h5>

                                <!-- Thông tin sản phẩm -->
                                <div class="mt-3 mb-4 border rounded p-3 bg-light">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <c:if test="${not empty product.image}">
                                                <img src="${pageContext.request.contextPath}/resources/images/products/${product.image}"
                                                    alt="Ảnh sản phẩm" class="img-thumbnail" width="150">
                                            </c:if>
                                        </div>
                                        <div class="col-md-9">
                                            <p><strong>Tên:</strong> ${product.name}</p>
                                            <p><strong>Giá:</strong>
                                                <fmt:formatNumber value="${product.price}" type="number" /> VNĐ
                                            </p>
                                            <p><strong>Số lượng:</strong> ${product.quantity}</p>
                                            <p><strong>Đã bán:</strong> ${product.sold}</p>
                                            <p><strong>Hãng:</strong> ${product.factory}</p>
                                            <p><strong>Đối tượng:</strong> ${product.target}</p>
                                        </div>
                                    </div>
                                </div>

                                <!-- Form xác nhận -->
                                <form method="post"
                                    action="${pageContext.request.contextPath}/admin/product/delete/${product.id}">
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-danger">
                                            <i class="bi bi-trash"></i> Xóa sản phẩm
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/product"
                                            class="btn btn-secondary">
                                            <i class="bi bi-arrow-left"></i> Hủy
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </section>
                </main>

                <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                <script src="/assets/js/main.js"></script>
            </body>

            </html>