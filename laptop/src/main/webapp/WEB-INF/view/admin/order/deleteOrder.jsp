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

                    <body>
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Manage Order</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"> <a href="/admin">Dashboard </a></li>
                                    <li class="breadcrumb-item active"><a href="/admin/order"> Orders </a></li>
                                    <li class="breadcrumb-item active"> Delete ID = ${id}</li>
                                </ol>
                                <div class="container mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3> Delete order with ID = ${id}</h3>
                                            <hr />
                                            <div class="alert alert-danger">
                                                Bạn có chắc chắn muốn xóa đơn hàng này không? Hành động này sẽ không thể
                                                hoàn tác.
                                            </div>

                                            <form:form method="post" action="/admin/order/delete"
                                                modelAttribute="newOrder">
                                                <div class="mb-3" style="display: block;">
                                                    <label class="form-label">Id</label>
                                                    <form:input value="${orderId}" type="text" class="form-control"
                                                        path="orderId" />
                                                </div>
                                                <button class="btn btn-danger">Confirm</button>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>


                    </body>



                    </main><!-- End #main -->

                    <!-- ======= Footer ======= -->
                    <footer id="footer" class="footer">


                    </footer><!-- End Footer -->

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