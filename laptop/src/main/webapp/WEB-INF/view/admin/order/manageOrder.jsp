<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <meta content="width=device-width, initial-scale=1.0" name="viewport">

                <title>T-Shop | Quản lý đơn hàng</title>
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
                        <h1>Quản lý đơn hàng</h1>
                        <form class="d-flex" method="get" action="/admin/orders/search">
                            <input type="text" class="form-control me-2" name="keyword"
                                placeholder="Tìm theo tên người nhận...">
                            <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i> Tìm kiếm</button>
                        </form>
                    </div>

                    <section class="section mt-4">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">Danh sách đơn hàng</h5>

                                <div class="table-responsive">
                                    <table class="table table-striped align-middle">
                                        <thead class="table-dark">
                                            <tr>
                                                <th scope="col">Mã đơn</th>
                                                <th scope="col">Người nhận</th>
                                                <th scope="col">SĐT</th>
                                                <th scope="col">Địa chỉ</th>
                                                <th scope="col">Tổng tiền</th>
                                                <th scope="col">Trạng thái</th>
                                                <th scope="col" class="text-center">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${orders}">
                                                <tr>
                                                    <td>${order.orderId}</td>
                                                    <td>${order.receiverName}</td>
                                                    <td>${order.receiverPhone}</td>
                                                    <td>${order.receiverAddress}</td>
                                                    <td><strong>
                                                            <fmt:formatNumber value="${order.totalPrice}" />đ
                                                        </strong></td>
                                                    <td class="address-column">${order.status}</td>
                                                    <td class="text-center">
                                                        <a href="/admin/orders/detail/${order.orderId}"
                                                            class="btn btn-sm btn-info text-white">
                                                            <i class="bi bi-eye"></i> Xem
                                                        </a>
                                                        <a href="/admin/orders/edit/${order.orderId}"
                                                            class="btn btn-sm btn-warning">
                                                            <i class="bi bi-pencil"></i> Sửa
                                                        </a>
                                                        <a href="/admin/orders/delete/${order.orderId}"
                                                            onclick="return confirm('Bạn có chắc muốn xóa đơn hàng này không?')"
                                                            class="btn btn-sm btn-danger">
                                                            <i class="bi bi-trash"></i> Xóa
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>

                                            <c:if test="${empty orders}">
                                                <tr>
                                                    <td colspan="7" class="text-center text-muted">Không có đơn hàng
                                                        nào!
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </section>
                </main>

                <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                <script src="/assets/js/main.js"></script>

            </body>

            </html>