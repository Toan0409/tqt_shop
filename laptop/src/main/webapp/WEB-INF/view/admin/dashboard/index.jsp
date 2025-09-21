<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">

                    <title>T-shop | Điện thoại, Laptop, Linh kiện</title>
                    <meta content="" name="description">
                    <meta content="" name="keywords">

                    <!-- Favicons -->
                    <link href="/assets/img/logo.png" rel="icon">
                    <link href="/assets/img/logo.png" rel="apple-touch-icon">

                    <!-- Google Fonts -->
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
                    <jsp:include page="/WEB-INF/view/admin/layout/sidebar.jsp" />

                    <main id="main" class="main">

                        <div class="pagetitle">
                            <h1>Doanh thu & Lợi nhuận</h1>
                            <nav>
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                                    <li class="breadcrumb-item active">Doanh thu & Lợi nhuận</li>
                                </ol>
                            </nav>
                        </div><!-- End Page Title -->

                        <section class="section dashboard">
                            <div class="row">

                                <!-- Left side columns -->
                                <div>
                                    <div class="row">

                                        <!-- Sales Card -->
                                        <div class="col-xxl-4 col-md-6">
                                            <div class="card info-card sales-card">
                                                <div class="card-body">
                                                    <h5 class="card-title"><a href="/admin/order">Đơn hàng</a></h5>

                                                    <div class="d-flex align-items-center">
                                                        <div
                                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                            <i class="bi bi-cart"></i>
                                                        </div>
                                                        <div class="ps-3">
                                                            <h6>${countOrders}</h6>

                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div><!-- End Sales Card -->

                                        <!-- Revenue Card -->
                                        <div class="col-xxl-4 col-md-6">
                                            <div class="card info-card revenue-card">
                                                <div class="card-body">
                                                    <h5 class="card-title"><a href="/admin/product">Doanh thu</a></h5>

                                                    <div class="d-flex align-items-center">
                                                        <div
                                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                            <i class="bi bi-currency-dollar"></i>
                                                        </div>
                                                        <div class="ps-3">
                                                            <h6>${countRevenues} VNĐ</h6>


                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div><!-- End Revenue Card -->

                                        <!-- Customers Card -->
                                        <div class="col-xxl-4 col-xl-12">
                                            <div class="card info-card customers-card">
                                                <div class="card-body">
                                                    <h5 class="card-title"><a href="/admin/user">Khách hàng</a></h5>

                                                    <div class="d-flex align-items-center">
                                                        <div
                                                            class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                            <i class="bi bi-people"></i>
                                                        </div>
                                                        <div class="ps-3">
                                                            <h6>${countUsers}</h6>


                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                        </div><!-- End Customers Card -->

                                        <!-- Reports -->
                                        <div class="col-12">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h5 class="card-title">Báo cáo</h5>

                                                    <!-- ApexCharts CDN -->
                                                    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

                                                    <div class="container mt-5">
                                                        <h3 class="text-center">Doanh thu theo sản phẩm</h3>
                                                        <div id="productRevenueChart"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <c:if test="${not empty productRevenues}">
                                            <script>
                                                document.addEventListener("DOMContentLoaded", function () {
                                                    var productNames = [
                                                        <c:forEach var="item" items="${productRevenues}" varStatus="loop">
                                                            "${item.productName}"<c:if test="${!loop.last}">,</c:if>
                                                        </c:forEach>
                                                    ];

                                                    var productRevenues = [
                                                        <c:forEach var="item" items="${productRevenues}" varStatus="loop">
                                                            ${item.totalRevenue}<c:if test="${!loop.last}">,</c:if>
                                                        </c:forEach>
                                                    ];

                                                    var options = {
                                                        chart: {
                                                            type: 'bar',
                                                            height: 400
                                                        },
                                                        series: [{
                                                            name: 'Doanh thu',
                                                            data: productRevenues
                                                        }],
                                                        xaxis: {
                                                            categories: productNames
                                                        },
                                                        dataLabels: {
                                                            formatter: function (val) {
                                                                return val.toLocaleString() + " đ";
                                                            }
                                                        },
                                                        tooltip: {
                                                            y: {
                                                                formatter: function (val) {
                                                                    return val.toLocaleString() + " đ";
                                                                }
                                                            }
                                                        }
                                                    };

                                                    var chart = new ApexCharts(document.querySelector("#productRevenueChart"), options);
                                                    chart.render();
                                                });
                                            </script>
                                        </c:if>

                                        <c:if test="${empty productRevenues}">
                                            <p class="text-center text-muted mt-4">Không có dữ liệu doanh thu để hiển
                                                thị.</p>
                                        </c:if>

                                    </div> <!-- End Card Body -->
                                </div> <!-- End Card -->
                            </div> <!-- End Column -->




                            <!-- Recent Sales -->
                            <div class="col-12">
                                <div class="card recent-sales overflow-auto">


                                    <div class="card-body">
                                        <h5 class="card-title">Đơn hàng gần đây </h5>

                                        <table class="table table-borderless datatable">
                                            <thead>
                                                <tr>
                                                    <th scope="col">#</th>
                                                    <th scope="col">Khách hàng</th>
                                                    <th scope="col">Số lượng</th>
                                                    <th scope="col">Giá</th>
                                                    <th scope="col">Trạng thái</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="order" items="${orders}">
                                                    <%-- Tính tổng số lượng sản phẩm trong đơn hàng này --%>
                                                        <c:set var="totalQuantity" value="0" />
                                                        <c:forEach var="item" items="${order.orderDetails}">
                                                            <c:set var="totalQuantity"
                                                                value="${totalQuantity + item.quantity}" />
                                                        </c:forEach>

                                                        <tr>
                                                            <th scope="row"><a href="#">${order.orderId}</a></th>
                                                            <td>${order.receiverName}</td>
                                                            <td>${totalQuantity}</td>
                                                            <td>
                                                                <fmt:formatNumber type="number"
                                                                    value="${order.totalPrice}" /> đ
                                                            </td>
                                                            <td><span class="badge bg-success">${order.status}</span>
                                                            </td>
                                                        </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>

                                    </div>

                                </div>
                            </div><!-- End Recent Sales -->

                            <!-- Top Selling -->
                            <div class="col-12">
                                <div class="card top-selling overflow-auto">



                                    <div class="card-body pb-0">
                                        <h5 class="card-title">Sản phẩm bán chạy </h5>

                                        <table class="table table-borderless">
                                            <thead>
                                                <tr>

                                                    <th scope="col">Sản phẩm</th>

                                                    <th scope="col">Đã bán</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="item" items="${bestSellers}">
                                                    <tr>

                                                        <td><a href="#"
                                                                class="text-primary fw-bold">${item.productName}</a>
                                                        </td>

                                                        <td class="fw-bold">${item.totalSold}</td>

                                                    </tr>
                                                </c:forEach>


                                            </tbody>
                                        </table>

                                    </div>

                                </div>
                            </div><!-- End Top Selling -->

                            </div>
                            </div><!-- End Left side columns -->







                            </div><!-- End Right side columns -->

                            </div>
                        </section>

                    </main><!-- End #main -->

                    <!-- ======= Footer ======= -->
                    <footer id="footer" class="footer">
                        <div class="copyright">
                            &copy; Copyright <strong><span>GoBread</span></strong>. All Rights Reserved
                        </div>

                    </footer><!-- End Footer -->

                    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
                            class="bi bi-arrow-up-short"></i></a>

                    <!-- Vendor JS Files -->
                    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
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