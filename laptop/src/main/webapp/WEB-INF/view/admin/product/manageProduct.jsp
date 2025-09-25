<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <meta content="width=device-width, initial-scale=1.0" name="viewport">

                <title>T-Shop | Quản lý sản phẩm</title>
                <link href="/assets/img/logo.png" rel="icon">
                <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
                <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
                <link href="/assets/css/style.css" rel="stylesheet">
            </head>

            <body>
                <jsp:include page="/WEB-INF/view/admin/layout/header.jsp" />
                <jsp:include page="/WEB-INF/view/admin/layout/sidebar.jsp" />

                <main id="main" class="main">
                    <div class="pagetitle d-flex justify-content-between align-items-center">
                        <h1>Quản lý sản phẩm</h1>
                        <a href="${pageContext.request.contextPath}/admin/product/add" class="btn btn-primary">
                            <i class="bi bi-plus-circle"></i> Thêm sản phẩm
                        </a>
                    </div>

                    <section class="section mt-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Danh sách sản phẩm</h5>

                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover align-middle">
                                        <thead class="table-light text-center">
                                            <tr>
                                                <th>ID</th>
                                                <th>Ảnh</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Giá</th>
                                                <th>Số lượng</th>
                                                <th>Hãng</th>

                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="p" items="${products}">
                                                <tr>
                                                    <td class="text-center">${p.id}</td>
                                                    <td class="text-center">
                                                        <img src="${pageContext.request.contextPath}/resources/images/products/${p.image}"
                                                            alt="${p.name}" class="img-thumbnail"
                                                            style="width: 70px; height: 70px; object-fit: cover;">
                                                    </td>
                                                    <td>${p.name}</td>
                                                    <td class="text-end">
                                                        <fmt:formatNumber value="${p.price}" type="currency"
                                                            currencySymbol="₫" />
                                                    </td>
                                                    <td class="text-center">${p.quantity}</td>
                                                    <td>${p.factory}</td>

                                                    <td class="text-center">
                                                        <!-- Nút Xem chi tiết -->
                                                        <a href="${pageContext.request.contextPath}/admin/product/detail/${p.id}"
                                                            class="btn btn-sm btn-info text-white"><i
                                                                class="bi bi-eye"></i></a>
                                                        <!-- Nút Sửa -->
                                                        <a href="${pageContext.request.contextPath}/admin/product/edit/${p.id}"
                                                            class="btn btn-sm btn-warning"><i
                                                                class="bi bi-pencil"></i></a>
                                                        <!-- Nút Xóa -->
                                                        <a href="${pageContext.request.contextPath}/admin/product/delete/${p.id}"
                                                            class="btn btn-sm btn-danger"
                                                            onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                                            <i class="bi bi-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Phân trang -->
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage - 1}">&laquo;</a>
                                            </li>
                                        </c:if>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="?page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage + 1}">&raquo;</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </nav>

                            </div>
                        </div>
                    </section>
                </main>

                <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                <script src="/assets/js/main.js"></script>
            </body>

            </html>