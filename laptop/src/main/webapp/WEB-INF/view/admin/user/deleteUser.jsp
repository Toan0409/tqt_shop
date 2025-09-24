<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta content="width=device-width, initial-scale=1.0" name="viewport">
            <title>T-Shop | Xoá khách hàng</title>
            <link href="/assets/img/logo.png" rel="icon">
            <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
            <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
            <link href="/assets/css/style.css" rel="stylesheet">
        </head>

        <body>
            <jsp:include page="/WEB-INF/view/admin/layout/header.jsp" />
            <jsp:include page="/WEB-INF/view/admin/layout/sidebar.jsp" />

            <main class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
                <div class="card shadow-lg w-50">
                    <div class="card-header bg-danger text-white d-flex align-items-center">
                        <i class="bi bi-exclamation-octagon-fill fs-4 me-2"></i>
                        <h5 class="mb-0">Xác nhận xoá người dùng</h5>
                    </div>
                    <div class="card-body">
                        <p class="fs-5 text-center mb-4">
                            Bạn có chắc chắn muốn xoá người dùng sau không?
                        </p>

                        <div class="table-responsive mb-4">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <th scope="row" style="width: 30%;">ID</th>
                                        <td>${user.id}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Tên</th>
                                        <td>${user.fullName}</td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Email</th>
                                        <td>${user.email}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <form action="${pageContext.request.contextPath}/admin/user/delete/${user.id}" method="post"
                            class="d-flex justify-content-center">
                            <input type="hidden" name="id" value="${user.id}">
                            <a href="${pageContext.request.contextPath}/admin/user" class="btn btn-secondary me-3 px-4">
                                <i class="bi bi-arrow-left"></i> Quay lại
                            </a>
                            <button type="submit" class="btn btn-danger px-4">
                                <i class="bi bi-trash"></i> Xoá
                            </button>
                        </form>
                    </div>
                </div>
            </main>

            <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
            <script src="/assets/js/main.js"></script>
        </body>

        </html>