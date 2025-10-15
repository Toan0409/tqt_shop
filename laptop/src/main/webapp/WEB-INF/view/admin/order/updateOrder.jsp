<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">

                    <title>Quản lý đơn hàng</title>
                    <meta content="" name="description">
                    <meta content="" name="keywords">

                    <!-- Favicons -->
                    <link href="/assets/img/breadlogo.png" rel="icon">
                    <link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

                    <!-- Google Fonts -->
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                        rel="stylesheet" />
                    <link href="https://fonts.gstatic.com" rel="preconnect">
                    <link
                        href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
                        rel="stylesheet">

                    <!-- Vendor CSS Files -->
                    <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
                    <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
                    <link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
                    <link href="/assets/vendor/quill/quill.snow.css" rel="stylesheet">
                    <link href="/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
                    <link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
                    <link href="/assets/vendor/simple-datatables/style.css" rel="stylesheet">

                    <!-- Template Main CSS File -->
                    <link href="/assets/css/style.css" rel="stylesheet">

                    <style>
                        body {
                            font-family: Arial, sans-serif;
                            margin: 20px;
                            padding: 20px;
                            background-color: #f8f9fa;
                        }

                        .container {
                            max-width: 1600px;
                            margin: auto;
                            background: white;
                            padding: 20px;
                            border-radius: 8px;
                            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                        }
                    </style>

                    <!-- =======================================================
  * Template Name: NiceAdmin
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Updated: Apr 20 2024 with Bootstrap v5.3.3
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
                </head>

                <body>
                    <jsp:include page="/WEB-INF/view/admin/layout/header.jsp" />

                    <main class="container-fluid px-4 mt-4">
                        <h2 class="page-title mb-3"><i class="fa-solid fa-box-open me-2"></i>Cập nhật đơn hàng</h2>

                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="/admin/order">Quản lý đơn hàng</a></li>
                            <li class="breadcrumb-item active">Cập nhật</li>
                        </ol>

                        <div class="row justify-content-center">
                            <div class="col-lg-7 col-md-9">
                                <div class="card">
                                    <div class="card-header">
                                        <i class="fa-solid fa-pen-to-square me-2"></i>Thông tin đơn hàng
                                    </div>
                                    <div class="card-body p-4">

                                        <form:form method="post" action="/admin/order/update" modelAttribute="newOrder"
                                            enctype="multipart/form-data">
                                            <form:hidden path="orderId" />

                                            <div class="alert alert-summary mb-4">
                                                <div><strong>Mã đơn hàng:</strong> ${newOrder.orderId}</div>
                                                <div><strong>Tổng tiền:</strong>
                                                    <fmt:formatNumber value="${newOrder.totalPrice}" type="number" /> đ
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Người đặt hàng:</label>
                                                <form:input path="user.fullName" class="form-control" disabled="true" />
                                            </div>

                                            <div class="mb-4">
                                                <label class="form-label">Trạng thái đơn hàng:</label>
                                                <form:select path="status" class="form-select">
                                                    <form:option value="Chờ xác nhận">Chờ xác nhận</form:option>
                                                    <form:option value="Chờ thanh toán">Chờ thanh toán</form:option>
                                                    <form:option value="Đã thanh toán">Đã thanh toán</form:option>
                                                    <form:option value="Đã hủy">Đã hủy</form:option>
                                                </form:select>
                                            </div>

                                            <div class="text-end">
                                                <a href="/admin/order" class="btn btn-secondary me-2">
                                                    <i class="fa-solid fa-arrow-left"></i> Quay lại
                                                </a>
                                                <button type="submit" class="btn btn-warning">
                                                    <i class="fa-solid fa-rotate-right"></i> Cập nhật
                                                </button>
                                            </div>
                                        </form:form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>

                </body>


                <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
                        class="bi bi-arrow-up-short"></i></a>

                <!-- Vendor JS Files -->
                <script src="/assets/vendor/apexcharts/apexcharts.min.js"></script>
                <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                <script src="/assets/vendor/chart.js/chart.umd.js"></script>
                <script src="/assets/vendor/echarts/echarts.min.js"></script>
                <script src="/assets/vendor/quill/quill.js"></script>
                <script src="/assets/vendor/simple-datatables/simple-datatables.js"></script>
                <script src="/assets/vendor/tinymce/tinymce.min.js"></script>
                <script src="/assets/vendor/php-email-form/validate.js"></script>

                <!-- Template Main JS File -->
                <script src="/assets/js/main.js"></script>

                </body>

                </html>