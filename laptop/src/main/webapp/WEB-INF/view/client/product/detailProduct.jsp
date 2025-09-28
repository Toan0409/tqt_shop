<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1">

                <title>T-Shop | ${product.name}</title>
                <link href="/assets/img/logo.png" rel="icon">
                <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
                <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
                <link href="/assets/css/style.css" rel="stylesheet">
                <style>
                    /* Gallery */
                    .product-gallery img {
                        max-height: 400px;
                        object-fit: contain;
                    }

                    .thumbs img {
                        width: 60px;
                        height: 60px;
                        object-fit: contain;
                        border: 1px solid #ddd;
                        border-radius: .4rem;
                        cursor: pointer;
                    }

                    /* Price */
                    .price {
                        font-size: 1.6rem;
                        font-weight: 600;
                        color: #dc3545;
                    }

                    /* Buttons */
                    .btn-buy {
                        background: #0d6efd;
                        color: #fff;
                        border-radius: .4rem;
                    }

                    .btn-buy:hover {
                        background: #0b5ed7;
                    }

                    /* Table */
                    .specs-table td {
                        padding: .4rem .6rem;
                        border-top: 1px solid #f0f0f0;
                        font-size: 0.95rem;
                    }

                    /* Description */
                    .desc-box {
                        font-size: 0.95rem;
                        line-height: 1.6;
                    }

                    /* Related */
                    .related-card {
                        border: 1px solid #f1f1f1;
                        border-radius: .5rem;
                        transition: 0.2s;
                    }

                    .related-card:hover {
                        border-color: #0d6efd;
                        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
                    }

                    .related-card img {
                        height: 150px;
                        object-fit: cover;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/WEB-INF/view/client/layout/header.jsp" />

                <main class="container my-5">
                    <nav>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                            <li class="breadcrumb-item active">Chi tiết sản phẩm</li>
                        </ol>
                    </nav>
                    <div class="row g-4">
                        <!-- Gallery -->
                        <div class="col-md-6">
                            <div class="product-gallery text-center mb-3">
                                <img id="mainImage"
                                    src="${pageContext.request.contextPath}/images/products/${product.image}"
                                    alt="${product.name}" class="img-fluid rounded border">
                            </div>
                            <div class="d-flex justify-content-center gap-2 thumbs">
                                <img src="${pageContext.request.contextPath}/images/products/${product.image}"
                                    onclick="changeImage(this.src)" alt="thumb">
                            </div>
                        </div>

                        <!-- Info -->
                        <div class="col-md-6">
                            <h3 class="fw-semibold mb-3">${product.name}</h3>
                            <p class="price mb-3">
                                <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" /> đ
                            </p>
                            <p class="text-muted small mb-3">${product.shortDesc}</p>

                            <table class="table specs-table w-100 mb-3">
                                <tr>
                                    <td>Hãng</td>
                                    <td>${product.factory}</td>
                                </tr>
                                <tr>
                                    <td>Đối tượng</td>
                                    <td>${product.target}</td>
                                </tr>
                                <tr>
                                    <td>Tồn kho</td>
                                    <td>${product.quantity}</td>
                                </tr>
                                <tr>
                                    <td>Đã bán</td>
                                    <td>${product.sold}</td>
                                </tr>
                            </table>

                            <!-- Actions -->
                            <form action="${pageContext.request.contextPath}/cart/add" method="post"
                                class="d-flex gap-2 mb-4">
                                <input type="hidden" name="productId" value="${product.id}" />
                                <input type="number" name="quantity" value="1" min="1" max="${product.quantity}"
                                    class="form-control w-auto">
                                <button type="submit" class="btn btn-outline-success">
                                    <i class="bi bi-cart-plus"></i> Giỏ hàng
                                </button>
                                <a href="${pageContext.request.contextPath}/checkout?productId=${product.id}"
                                    class="btn btn-buy">Mua ngay</a>
                            </form>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="mt-5">
                        <h5 class="mb-3">Mô tả chi tiết</h5>
                        <div class="desc-box bg-white p-3 border rounded">
                            ${product.detailDesc}
                        </div>
                    </div>

                    <!-- Related -->
                    <div class="mt-5">
                        <h5 class="mb-3">Sản phẩm liên quan</h5>
                        <div class="row row-cols-2 row-cols-md-4 g-3">
                            <c:forEach var="p" items="${relatedProducts}">
                                <div class="col">
                                    <div class="card related-card h-100">
                                        <img src="${pageContext.request.contextPath}/resources/images/products/${p.image}"
                                            class="card-img-top" alt="${p.name}">
                                        <div class="card-body p-2">
                                            <h6 class="card-title text-truncate mb-1">${p.name}</h6>
                                            <p class="fw-bold text-danger small mb-2">${p.price} đ</p>
                                            <a href="${pageContext.request.contextPath}/product/${p.id}"
                                                class="btn btn-sm btn-outline-primary w-100">Xem</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </main>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    function changeImage(src) {
                        document.getElementById("mainImage").src = src;
                    }
                </script>
            </body>

            </html>