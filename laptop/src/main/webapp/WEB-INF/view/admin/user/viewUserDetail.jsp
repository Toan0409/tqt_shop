<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta content="width=device-width, initial-scale=1.0" name="viewport">

            <title>T-Shop | Chi tiết khách hàng</title>
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
                    <h1>Chi tiết khách hàng</h1>
                </div>

                <section class="section profile">
                    <div class="row">
                        <!-- Thông tin khách hàng -->
                        <div class="col-xl-4">
                            <div class="card">
                                <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
                                    <img src="${pageContext.request.contextPath}/resources/images/avatar/${user.avatar}"
                                        alt="Avatar" class="rounded-circle" width="150" height="150">
                                    <h2>${user.fullName}</h2>
                                    <h6 class="text-muted">${user.role.name}</h6>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-8">
                            <div class="card">
                                <div class="card-body pt-3">
                                    <h5 class="card-title">Thông tin cá nhân</h5>
                                    <div class="row">
                                        <div class="col-lg-3 col-md-4 label">ID</div>
                                        <div class="col-lg-9 col-md-8">${user.id}</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3 col-md-4 label">Email</div>
                                        <div class="col-lg-9 col-md-8">${user.email}</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3 col-md-4 label">Số điện thoại</div>
                                        <div class="col-lg-9 col-md-8">
                                            <c:choose>
                                                <c:when test="${user.phoneNumber != null}">
                                                    ${user.phoneNumber}
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-3 col-md-4 label">Địa chỉ</div>
                                        <div class="col-lg-9 col-md-8">
                                            <c:out value="${user.address != null ? user.address : '-'}" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Danh sách đơn hàng -->
                    <div class="row mt-4">
                        <div class="col-xl-12">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Danh sách đơn hàng</h5>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Mã đơn</th>
                                                <th>Ngày tạo</th>
                                                <th>Trạng thái</th>
                                                <th>Tổng tiền</th>
                                                <th>Chi tiết</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:if test="${empty user.orders}">
                                                <tr>
                                                    <td colspan="6" class="text-center">Khách hàng chưa có đơn hàng nào
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </main>

            <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
            <script src="/assets/js/main.js"></script>
        </body>

        </html>