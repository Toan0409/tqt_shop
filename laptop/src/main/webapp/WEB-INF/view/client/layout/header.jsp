<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <div class="d-flex align-items-center justify-content-between">
                    <a href="/" class="logo d-flex align-items-center">
                        <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="">
                        <span class="d-none d-lg-block">T-Shop</span>
                    </a>
                </div><!-- End Logo -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navMenu">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="#">Sản phẩm mới</a></li>
                        <li class="nav-item"><a class="nav-link" href="#">Hãng</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/cart">Giỏ
                                hàng</a>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="/register">Đăng ký</a></li>
                        <li class="nav-item"><a class="nav-link" href="/login">Đăng nhập</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>