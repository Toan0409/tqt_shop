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
                                <li class="nav-item active"><a class="nav-link"
                                        href="${pageContext.request.contextPath}/cart">Giỏ
                                        hàng</a></li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="userMenu" role="button"
                                        data-bs-toggle="dropdown">
                                        <i class="bi bi-person-circle me-1"></i>
                                        ${sessionScope.fullName}
                                    </a>
                                    <ul
                                        class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile shadow-lg border-0 rounded-3">
                                        <!-- Avatar + thông tin -->
                                        <li class="dropdown-header text-center">
                                            <img src="/images/avatar/${sessionScope.avatar}" alt="Avatar"
                                                class="rounded-circle mb-2"
                                                style="width: 70px; height: 70px; object-fit: cover;">
                                            <h6 class="mb-0">
                                                <c:out value="${sessionScope.fullName}" />
                                            </h6>
                                            <small class="text-muted">
                                                <c:out value="${sessionScope.role}" />
                                            </small>
                                        </li>

                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>

                                        <!-- Hồ sơ -->
                                        <li>
                                            <a class="dropdown-item d-flex align-items-center" href="/admin">
                                                <i class="bi bi-person me-2"></i>
                                                <span>Hồ sơ của tôi</span>
                                            </a>
                                        </li>

                                        <!-- Cài đặt -->
                                        <li>
                                            <a class="dropdown-item d-flex align-items-center" href="/admin">
                                                <i class="bi bi-gear me-2"></i>
                                                <span>Cài đặt</span>
                                            </a>
                                        </li>

                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>

                                        <!-- Đăng xuất -->
                                        <li>
                                            <form action="/logout" method="post" class="m-0">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <button class="dropdown-item d-flex align-items-center">
                                                    <i class="bi bi-box-arrow-right me-2"></i>
                                                    <span>Đăng xuất</span>
                                                </button>
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