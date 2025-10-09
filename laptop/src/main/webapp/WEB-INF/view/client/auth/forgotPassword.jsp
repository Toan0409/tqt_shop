<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Quên mật khẩu - T-Shop</title>
                <link href="/assets/img/logo.png" rel="icon">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <style>
                    body {
                        background-color: #f8f9fa;
                    }

                    .forgot-container {
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
                <div class="container-fluid forgot-container d-flex align-items-center justify-content-center">
                    <div class="row w-75 shadow-lg">
                        <!-- Banner bên trái -->
                        <div class="col-md-6 d-none d-md-block banner"></div>

                        <!-- Form bên phải -->
                        <div class="col-md-6 bg-white p-5 form-card">
                            <h3 class="mb-4 text-center text-primary">Quên mật khẩu</h3>

                            <c:if test="${not empty message}">
                                <div class="alert alert-info">${message}</div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>

                            <form:form action="${pageContext.request.contextPath}/forgot-password" method="post">
                                <!-- Email -->
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" id="email" name="email" class="form-control"
                                        placeholder="Nhập email của bạn" required>
                                </div>

                                <!-- Nút gửi -->
                                <div class="d-grid mb-3">
                                    <button type="submit" class="btn btn-primary">Gửi liên kết đặt lại mật khẩu</button>
                                </div>

                                <!-- Liên kết điều hướng -->
                                <p class="text-center mb-0">
                                    <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
                                        Quay lại đăng nhập
                                    </a>
                                </p>
                            </form:form>
                        </div>
                    </div>
                </div>
            </body>

            </html>