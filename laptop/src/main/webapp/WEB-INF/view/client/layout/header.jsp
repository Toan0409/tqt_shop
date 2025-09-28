<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <header>
            <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
                <div class="container">

                    <!-- Logo -->
                    <a href="${pageContext.request.contextPath}/" class="navbar-brand d-flex align-items-center">
                        <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="Logo" height="40"
                            class="me-2">
                        <span class="fw-bold">T-Shop</span>
                    </a>

                    <!-- Nút toggle trên mobile -->
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <!-- Menu -->
                    <div class="collapse navbar-collapse" id="navMenu">
                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                            <li class="nav-item"><a class="nav-link" href="#">Sản phẩm</a></li>
                            <!-- <li class="nav-item"><a class="nav-link" href="#">Hãng</a></li> -->



                            <c:if test="${empty pageContext.request.userPrincipal}">
                                <li class="nav-item"><a class="nav-link"
                                        href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
                                <li class="nav-item"><a class="nav-link"
                                        href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                            </c:if>

                            <c:if test="${not empty pageContext.request.userPrincipal}">
                                <li class="nav-item"><a class="nav-link"
                                        href="${pageContext.request.contextPath}/cart">Giỏ
                                        hàng</a></li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="userMenu" role="button"
                                        data-bs-toggle="dropdown">
                                        <i class="bi bi-person-circle me-1"></i>
                                        ${pageContext.request.userPrincipal.name}
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userMenu">
                                        <li><a class="dropdown-item" href="#">Tài khoản của tôi</a></li>
                                        <li>
                                            <form action="${pageContext.request.contextPath}/logout" method="post"
                                                style="display:inline;">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <button type="submit" class="dropdown-item">Đăng xuất</button>
                                            </form>
                                        </li>
                                    </ul>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>