<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Đăng nhập - T-Shop</title>
                <link href="/assets/img/logo.png" rel="icon">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <style>
                    body {
                        background-color: #f8f9fa;
                    }

                    .login-container {
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
                <div class="container-fluid login-container d-flex align-items-center justify-content-center">
                    <div class="row w-75 shadow-lg">
                        <!-- Banner bên trái -->
                        <div class="col-md-6 d-none d-md-block banner"></div>

                        <!-- Form bên phải -->
                        <div class="col-md-6 bg-white p-5 form-card">
                            <h3 class="mb-4 text-center text-primary">Đăng nhập tài khoản</h3>

                            <form method="post" action="${pageContext.request.contextPath}/login"
                                modelAttribute="loginUser">
                                <c:if test="${param.error != null}">
                                    <div class="my-2" style="color: red;">Tài khoản hoặc mật khẩu không hợp lệ</div>
                                </c:if>
                                <!-- Email -->
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input name="username" type="email" class="form-control" id="email"
                                        placeholder="Nhập email" />

                                </div>

                                <!-- Mật khẩu -->
                                <div class="mb-3">
                                    <label for="password" class="form-label">Mật khẩu</label>
                                    <input type="password" name="password" class="form-control" id="password"
                                        placeholder="Nhập mật khẩu" />

                                </div>

                                <div>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                </div>

                                <!-- Nút đăng nhập -->
                                <div class="d-grid mb-3">
                                    <button type="submit" class="btn btn-primary">Đăng nhập</button>
                                </div>


                                <p class="text-center">
                                    Chưa có tài khoản?
                                    <a href="${pageContext.request.contextPath}/register" class="text-decoration-none">
                                        Đăng ký ngay
                                    </a>
                                </p>
                            </form>
                        </div>
                    </div>
                </div>
            </body>

            </html>