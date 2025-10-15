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

                    <main>
                        <div class="container-fluid px-4">
                            <h1 class="mt-4">Chi tiết đơn hàng</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"> <a href="/admin"> Trang chủ </a></li>
                                <li class="breadcrumb-item active"><a href="/admin/order"> Đơn hàng </a></li>
                                <li class="breadcrumb-item active"> Chi tiết ID = ${orderId}</li>
                            </ol>

                            <div class="container mt-5">
                                <div class="row">
                                    <div class="col-12 mx-auto">
                                        <div class="d-flex justify-content-between">
                                            <h3> Chi tiết đơn hàng có ID = ${orderId }</h3>
                                        </div>
                                        <hr />


                                        <div class="table-responsive">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">Sản phẩm</th>
                                                        <th scope="col">Tên</th>
                                                        <th scope="col">Giá cả</th>
                                                        <th scope="col">Số lượng</th>
                                                        <th scope="col">Thành tiền</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="orderDetail" items="${orderDetails}">
                                                        <tr>
                                                            <th scope="row">
                                                                <div class="d-flex align-items-center">
                                                                    <img src="/images/products/${orderDetail.product.image}"
                                                                        class="img-fluid me-5 rounded-circle"
                                                                        style="width: 80px; height: 80px;" alt="">
                                                                </div>
                                                            </th>
                                                            <td>
                                                                <p class="mb-0 mt-4">

                                                                    ${orderDetail.product.name}

                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p class="mb-0 mt-4">
                                                                    <fmt:formatNumber type="number"
                                                                        value="${orderDetail.price}" /> đ
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <div class="input-group quantity mt-4"
                                                                    style="width: 100px;">
                                                                    <input type="text"
                                                                        class="form-control form-control-sm text-center border-0"
                                                                        value="${orderDetail.quantity}">
                                                                </div>
                                                            </td>
                                                            <td>
                                                                <p class="mb-0 mt-4"
                                                                    data-order-detail-id="${orderDetail.id}">
                                                                    <fmt:formatNumber type="number"
                                                                        value="${orderDetail.price * orderDetail.quantity}" />
                                                                    đ
                                                                </p>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>

                                                </tbody>
                                            </table>
                                        </div>


                                        <a href="/admin/order" class="btn btn-success mt-2">Back</a>
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