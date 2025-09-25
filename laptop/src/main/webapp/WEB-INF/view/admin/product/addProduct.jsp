<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <meta content="width=device-width, initial-scale=1.0" name="viewport">
                <title>T-Shop | Thêm sản phẩm</title>
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
                        <h1>Thêm sản phẩm mới</h1>
                    </div>

                    <section class="section">
                        <div class="card">
                            <div class="card-body p-4">
                                <form:form modelAttribute="product" method="post"
                                    action="${pageContext.request.contextPath}/admin/product/add"
                                    enctype="multipart/form-data">

                                    <!-- Tên sản phẩm -->
                                    <div class="mb-3">
                                        <label class="form-label">Tên sản phẩm</label>
                                        <form:input path="name" cssClass="form-control" placeholder="Nhập tên sản phẩm"
                                            required="true" />
                                    </div>

                                    <!-- Giá -->
                                    <div class="mb-3">
                                        <label class="form-label">Giá (VNĐ)</label>
                                        <form:input path="price" type="number" cssClass="form-control"
                                            placeholder="Nhập giá" required="true" />
                                    </div>

                                    <!-- Ảnh -->
                                    <div class="mb-3">
                                        <label class="form-label">Ảnh sản phẩm</label>
                                        <input type="file" name="imageFile" class="form-control" accept="image/*"
                                            required>
                                    </div>

                                    <!-- Mô tả ngắn -->
                                    <div class="mb-3">
                                        <label class="form-label">Mô tả ngắn</label>
                                        <form:textarea path="shortDesc" cssClass="form-control" rows="2"
                                            placeholder="Mô tả ngắn" />
                                    </div>

                                    <!-- Mô tả chi tiết -->
                                    <div class="mb-3">
                                        <label class="form-label">Mô tả chi tiết</label>
                                        <form:textarea path="detailDesc" cssClass="form-control" rows="4"
                                            placeholder="Mô tả chi tiết" />
                                    </div>

                                    <!-- Số lượng -->
                                    <div class="mb-3">
                                        <label class="form-label">Số lượng</label>
                                        <form:input path="quantity" type="number" cssClass="form-control"
                                            required="true" />
                                    </div>

                                    <!-- Đã bán -->
                                    <div class="mb-3">
                                        <label class="form-label">Đã bán</label>
                                        <form:input path="sold" type="number" cssClass="form-control" value="0" />
                                    </div>

                                    <!-- Nhà sản xuất -->
                                    <div class="mb-3">
                                        <label class="form-label">Hãng sản xuất</label>
                                        <form:input path="factory" cssClass="form-control"
                                            placeholder="VD: Dell, Asus, Lenovo" />
                                    </div>

                                    <!-- Đối tượng sử dụng -->
                                    <div class="mb-3">
                                        <label class="form-label">Đối tượng</label>
                                        <form:input path="target" cssClass="form-control"
                                            placeholder="VD: Học sinh, Sinh viên, Gaming" />
                                    </div>

                                    <div class="text-end">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-save"></i> Lưu sản phẩm
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/product"
                                            class="btn btn-secondary">
                                            <i class="bi bi-arrow-left"></i> Quay lại
                                        </a>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </section>
                </main>

                <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                <script src="/assets/js/main.js"></script>
            </body>

            </html>