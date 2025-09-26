<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">

                <title>Đăng ký tài khoản</title>
                <link href="/assets/img/logo.png" rel="icon">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <style>
                    body {
                        background-color: #f8f9fa;
                    }

                    .register-container {
                        min-height: 100vh;
                    }

                    .banner {
                        background: url('${pageContext.request.contextPath}/assets/img/logo.png') no-repeat center center;
                        background-size: cover;
                        border-radius: 1rem 0 0 1rem;
                    }

                    .form-card {
                        border-radius: 0 1rem 1rem 0;
                    }
                </style>
            </head>

            <body>
                <div class="container-fluid register-container d-flex align-items-center justify-content-center">
                    <div class="row w-75 shadow-lg">
                        <!-- Banner bên trái -->
                        <div class="col-md-6 d-none d-md-block banner"></div>

                        <!-- Form bên phải -->
                        <div class="col-md-6 bg-white p-5 form-card">
                            <h3 class="mb-4 text-center text-primary">Tạo tài khoản mới</h3>

                            <form:form method="post" modelAttribute="registerUser"
                                action="${pageContext.request.contextPath}/register">

                                <div class="mb-3">
                                    <label for="fullName" class="form-label">Họ và tên</label>
                                    <form:input path="fullName" class="form-control" id="fullName"
                                        placeholder="Nhập họ và tên" />
                                    <form:errors path="fullName" cssClass="text-danger" />
                                </div>

                                <!-- Email -->
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <form:input path="email" type="email" class="form-control" id="email"
                                        placeholder="Nhập email" />
                                    <form:errors path="email" cssClass="text-danger" />
                                </div>

                                <!-- Mật khẩu -->
                                <div class="mb-3">
                                    <label for="password" class="form-label">Mật khẩu</label>
                                    <form:password path="password" class="form-control" id="password"
                                        placeholder="Tối thiểu 6 ký tự" />
                                    <form:errors path="password" cssClass="text-danger" />
                                </div>

                                <!-- Xác nhận mật khẩu -->
                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                                    <form:password path="confirmPassword" class="form-control" id="confirmPassword"
                                        placeholder="Nhập lại mật khẩu" />
                                    <form:errors path="confirmPassword" cssClass="text-danger" />
                                </div>


                                <!-- Số điện thoại -->
                                <div class="mb-3">
                                    <label for="phoneNumber" class="form-label">Số điện thoại</label>
                                    <form:input path="phoneNumber" class="form-control" id="phoneNumber"
                                        placeholder="Nhập số điện thoại" />
                                    <form:errors path="phoneNumber" cssClass="text-danger" />
                                </div>

                                <!-- Nút đăng ký -->
                                <div class="d-grid mb-3">
                                    <button type="submit" class="btn btn-primary">Đăng ký</button>
                                </div>

                                <p class="text-center">
                                    Đã có tài khoản? <a href="${pageContext.request.contextPath}/login"
                                        class="text-decoration-none">Đăng nhập</a>
                                </p>
                            </form:form>
                        </div>
                    </div>
                </div>
            </body>

            </html>