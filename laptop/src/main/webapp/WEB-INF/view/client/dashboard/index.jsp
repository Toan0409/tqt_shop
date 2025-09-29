<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <meta content="width=device-width, initial-scale=1.0" name="viewport">

                <title>T-Shop | Trang chủ</title>
                <link href="/assets/img/logo.png" rel="icon">
                <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
                <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
                <link href="/assets/css/style.css" rel="stylesheet">
                <style>
                    .hero {
                        height: 480px;
                        background-size: cover;
                        background-position: center;
                        position: relative;
                        border-radius: 1rem;
                        overflow: hidden;
                    }

                    .hero::after {
                        content: "";
                        position: absolute;
                        inset: 0;
                        background: rgba(0, 0, 0, 0.45);
                    }

                    .hero-content {
                        position: relative;
                        z-index: 2;
                        color: #fff;
                    }

                    .product-card {
                        transition: transform 0.2s ease, box-shadow 0.2s ease;
                    }

                    .product-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
                    }

                    .product-card img {
                        object-fit: cover;
                        height: 190px;
                        border-top-left-radius: .75rem;
                        border-top-right-radius: .75rem;
                    }

                    .price {
                        color: #e63946;
                        font-weight: bold;
                        font-size: 1rem;
                    }

                    .brand-badge {
                        width: 90px;
                        height: 60px;
                        object-fit: contain;
                        filter: grayscale(20%);
                        transition: filter 0.2s;
                    }

                    .brand-badge:hover {
                        filter: none;
                    }

                    footer {
                        background: #222;
                        color: #ccc;
                    }

                    footer a {
                        color: #aaa;
                        text-decoration: none;
                    }

                    footer a:hover {
                        color: #fff;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/WEB-INF/view/client/layout/header.jsp" />

                <!-- Hero Banner -->
                <header class="container mt-4">
                    <div class="hero shadow"
                        style="background-image: url('${pageContext.request.contextPath}/assets/img/banner.png');">
                        <div class="d-flex h-100 align-items-center ps-5">
                            <div class="hero-content">
                                <h1 class="display-5 fw-bold">Khuyến mãi lớn tháng này</h1>
                                <p class="lead mb-3">Giảm đến <strong>30%</strong> cho laptop chọn lọc. Mua ngay!</p>
                                <a href="${pageContext.request.contextPath}/products?filter=promo"
                                    class="btn btn-primary btn-lg">
                                    Xem ngay <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </header>

                <!-- Sản phẩm mới -->
                <section class="container mt-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3 class="fw-bold">Sản phẩm mới</h3>
                        <a href="${pageContext.request.contextPath}/products?tab=new" class="text-decoration-none">Xem
                            tất
                            cả</a>
                    </div>
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                        <c:forEach var="p" items="${newProducts}">
                            <div class="col">
                                <div class="card product-card h-100 border-0 shadow-sm rounded-3">
                                    <img src="${pageContext.request.contextPath}/images/products/${p.image}"
                                        class="card-img-top" alt="${p.name}">
                                    <div class="card-body d-flex flex-column">
                                        <h6 class="card-title text-truncate">
                                            <a href="/product/${p.id}">${p.name}</a>
                                        </h6>
                                        <p style="font-size: 14px;">${p.shortDesc}</p>
                                        <p class="price mb-2">
                                            <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" /> đ
                                        </p>
                                        <div class="mt-auto d-flex gap-2">
                                            <form
                                                action="${pageContext.request.contextPath}/add-product-to-cart/${p.id}"
                                                method="post" class="d-inline">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <input type="hidden" name="productId" value="${p.id}" />
                                                <button type="submit" class="btn btn-sm btn-success">
                                                    <i class="bi bi-cart-plus"></i> Thêm
                                                </button>
                                            </form>
                                            <a href="${pageContext.request.contextPath}/product/${p.id}"
                                                class="btn btn-outline-primary btn-sm">
                                                Chi tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>

                <!-- Sản phẩm bán chạy -->
                <!-- <section class="container mt-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3 class="fw-bold">Sản phẩm bán chạy</h3>
                        <a href="${pageContext.request.contextPath}/products?tab=best" class="text-decoration-none">Xem
                            tất
                            cả</a>
                    </div>
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                        <c:forEach var="p" items="${bestSellers}">
                            <div class="col">
                                <div class="card product-card h-100 border-0 shadow-sm rounded-3">
                                    <img src="${pageContext.request.contextPath}/resources/images/products/${p.image}"
                                        class="card-img-top" alt="${p.name}">
                                    <div class="card-body d-flex flex-column">
                                        <h6 class="card-title text-truncate">${p.name}</h6>
                                        <p class="price mb-2">${p.price} đ</p>
                                        <div class="mt-auto d-flex gap-2">
                                            <form action="${pageContext.request.contextPath}/cart/add" method="post"
                                                class="d-inline">
                                                <input type="hidden" name="productId" value="${p.id}" />
                                                <button type="submit" class="btn btn-sm btn-success">
                                                    <i class="bi bi-cart-plus"></i> Thêm
                                                </button>
                                            </form>
                                            <a href="${pageContext.request.contextPath}/product/${p.id}"
                                                class="btn btn-outline-primary btn-sm">
                                                Chi tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section> -->

                <!-- Theo hãng -->
                <!-- <section class="container mt-5 mb-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3 class="fw-bold">Theo hãng</h3>
                        <a href="${pageContext.request.contextPath}/brands" class="text-decoration-none">Xem tất cả</a>
                    </div>
                    <div class="row g-3">
                        <c:forEach var="b" items="${brands}">
                            <div class="col-4 col-sm-3 col-md-2 text-center">
                                <a href="${pageContext.request.contextPath}/products?brand=${b.code}"
                                    class="d-block p-2 border rounded bg-white shadow-sm h-100 text-decoration-none">
                                    <img src="${pageContext.request.contextPath}/resources/images/brands/${b.logo}"
                                        class="brand-badge mb-2" alt="${b.name}">
                                    <div class="small text-truncate">${b.name}</div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </section> -->

                <jsp:include page="/WEB-INF/view/client/layout/footer.jsp" />

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>