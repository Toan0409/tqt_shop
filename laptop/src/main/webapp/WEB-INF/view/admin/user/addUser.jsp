<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <meta content="width=device-width, initial-scale=1.0" name="viewport">
                <title>T-Shop | Thêm khách hàng</title>

                <!-- Favicons -->
                <link href="/assets/img/logo.png" rel="icon">

                <!-- Bootstrap -->
                <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
                <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
                <link href="/assets/css/style.css" rel="stylesheet">

                <!-- jQuery để preview ảnh -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        $("#imageFile").change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL).fadeIn();
                        });
                    });
                </script>
            </head>

            <body>
                <jsp:include page="/WEB-INF/view/admin/layout/header.jsp" />
                <jsp:include page="/WEB-INF/view/admin/layout/sidebar.jsp" />

                <main id="main" class="main">
                    <div class="pagetitle">
                        <h1>Thêm khách hàng</h1>
                        <nav>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                                <li class="breadcrumb-item"><a href="/admin/user">Khách hàng</a></li>
                                <li class="breadcrumb-item active">Thêm mới</li>
                            </ol>
                        </nav>
                    </div>

                    <section class="section">
                        <div class="card shadow-sm border-0">
                            <div class="card-body p-4">
                                <h5 class="card-title mb-3">Nhập thông tin khách hàng</h5>
                                <hr>

                                <form:form modelAttribute="newUser" method="post"
                                    action="${pageContext.request.contextPath}/admin/user/add"
                                    enctype="multipart/form-data" class="row g-3">


                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Họ và tên</label>
                                        <form:input path="fullName" cssClass="form-control" required="required" />
                                    </div>


                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Email</label>
                                        <form:input path="email" cssClass="form-control" required="required" />
                                    </div>


                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Mật khẩu</label>
                                        <form:password path="password" cssClass="form-control" required="required" />
                                    </div>


                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Số điện thoại</label>
                                        <form:input path="phoneNumber" cssClass="form-control" />
                                    </div>


                                    <div class="col-md-12">
                                        <label class="form-label fw-bold">Địa chỉ</label>
                                        <form:input path="address" cssClass="form-control" />
                                    </div>


                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Vai trò</label>
                                        <form:select path="role.id" cssClass="form-select" required="required">
                                            <form:option value="" label="-- Chọn vai trò --" />
                                            <form:options items="${roles}" itemValue="id" itemLabel="name" />
                                        </form:select>
                                    </div>


                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Ảnh đại diện</label>
                                        <input type="file" id="imageFile" name="image" class="form-control"
                                            accept=".jpg,.jpeg,.png" />
                                        <div class="mt-2 text-center">
                                            <img id="avatarPreview" src="#" alt="Ảnh xem trước"
                                                style="max-height: 180px; display:none;"
                                                class="img-thumbnail shadow-sm" />
                                        </div>
                                    </div>


                                    <div class="col-12 d-flex justify-content-end gap-2 mt-4">
                                        <a href="${pageContext.request.contextPath}/admin/user"
                                            class="btn btn-secondary">
                                            <i class="bi bi-arrow-left-circle"></i> Quay lại
                                        </a>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-save"></i> Lưu khách hàng
                                        </button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </section>
                </main>

                <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>