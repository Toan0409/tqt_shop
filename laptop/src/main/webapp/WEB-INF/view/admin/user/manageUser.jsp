<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta content="width=device-width, initial-scale=1.0" name="viewport">

            <title>T-Shop | Quản lý khách hàng</title>
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
                    <h1>Quản Lý Khách Hàng</h1>
                </div>

                <section class="section">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <!-- Header with Add button -->
                            <div class="d-flex justify-content-between align-items-center mb-3 mt-3">
                                <h5 class="card-title mb-0">Danh sách khách hàng</h5>

                                <!-- Dropdown Add Button -->
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary dropdown-toggle"
                                        data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="bi bi-person-plus"></i> Thêm khách hàng
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <!-- Thêm thủ công -->
                                        <li>
                                            <a class="dropdown-item" href="/admin/user/add">
                                                <i class="bi bi-pencil-square"></i> Thêm thủ công
                                            </a>
                                        </li>

                                        <!-- Tải từ CSV -->
                                        <li>
                                            <form action="/admin/user/add-by-upload-csv" method="post"
                                                enctype="multipart/form-data" class="px-3 py-2">
                                                <label for="csvFile" class="form-label small mb-1 fw-bold">
                                                    Tải từ CSV
                                                </label>
                                                <input type="file" class="form-control form-control-sm mb-2"
                                                    id="csvFile" name="file" accept=".csv">
                                                <button type="submit" class="btn btn-sm btn-outline-primary w-100">
                                                    <i class="bi bi-upload"></i> Upload
                                                </button>
                                            </form>
                                        </li>

                                        <!-- Thêm bằng AI -->
                                        <li>
                                            <form action="/admin/user/add-random-ai" method="post" class="px-3 py-2">
                                                <button type="submit" class="btn btn-sm btn-outline-success w-100">
                                                    <i class="bi bi-robot"></i> Thêm AI
                                                </button>
                                            </form>
                                        </li>
                                    </ul>
                                </div>

                            </div>


                            <!-- Search form -->
                            <form class="row g-2 mb-3" method="get" action="/admin/user">
                                <div class="col-md-4">
                                    <input type="text" name="keyword" class="form-control"
                                        placeholder="Tìm kiếm khách hàng..." value="${param.keyword}">
                                </div>
                                <div class="col-md-auto">
                                    <button type="submit" class="btn btn-outline-success">
                                        <i class="bi bi-search"></i> Tìm kiếm
                                    </button>
                                </div>
                            </form>

                            <!-- Table -->
                            <div class="table-responsive">
                                <table class="table table-striped align-middle text-center">
                                    <thead class="table-dark">
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Tên Khách Hàng</th>
                                            <th scope="col">Email</th>
                                            <th scope="col">Số Điện Thoại</th>
                                            <th scope="col" style="min-width: 200px;">Địa Chỉ</th>
                                            <th scope="col">Hành Động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="user" items="${users1}">
                                            <tr>
                                                <td>${user.id}</td>
                                                <td>${user.fullName}</td>
                                                <td>${user.email}</td>
                                                <td>${user.phoneNumber}</td>
                                                <td class="text-truncate" style="max-width: 250px;">${user.address}</td>
                                                <td>
                                                    <a href="/admin/user/${user.id}"
                                                        class="btn btn-sm btn-info text-white" title="Xem chi tiết">
                                                        <i class="bi bi-eye"></i>
                                                    </a>
                                                    <a href="/admin/user/edit/${user.id}"
                                                        class="btn btn-sm btn-warning text-white" title="Chỉnh sửa">
                                                        <i class="bi bi-pencil-square"></i>
                                                    </a>
                                                    <a href="/admin/user/delete/${user.id}"
                                                        class="btn btn-sm btn-danger" title="Xoá">
                                                        <i class="bi bi-trash"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Pagination -->
                            <nav>
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage eq 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/user?page=${currentPage - 1}"
                                            aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:forEach begin="1" end="${totalPages}" var="page">
                                        <li class="page-item ${page eq currentPage ? 'active' : ''}">
                                            <a class="page-link" href="/admin/user?page=${page}">${page}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${currentPage eq totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="/admin/user?page=${currentPage + 1}"
                                            aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </section>
            </main>

            <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
            <script src="/assets/js/main.js"></script>
        </body>

        </html>