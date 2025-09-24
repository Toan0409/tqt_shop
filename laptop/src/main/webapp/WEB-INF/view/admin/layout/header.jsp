<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!-- ======= Header ======= -->
        <header id="header" class="header fixed-top d-flex align-items-center">

            <div class="d-flex align-items-center justify-content-between">
                <a href="/admin/dashboard" class="logo d-flex align-items-center">
                    <img src="/assets/img/logo.png" alt="">
                    <span class="d-none d-lg-block">T-Shop</span>
                </a>
                <i class="bi bi-list toggle-sidebar-btn"></i>
            </div><!-- End Logo -->

            <div class="search-bar">
                <form class="search-form d-flex align-items-center" method="POST" action="#">
                    <input type="text" name="query" placeholder="Search" title="Enter search keyword">
                    <button type="submit" title="Search"><i class="bi bi-search"></i></button>
                </form>
            </div><!-- End Search Bar -->

            <nav class="header-nav ms-auto">
                <ul class="d-flex align-items-center">

                    <li class="nav-item d-block d-lg-none">
                        <a class="nav-link nav-icon search-bar-toggle " href="#">
                            <i class="bi bi-search"></i>
                        </a>
                    </li><!-- End Search Icon-->



                    <li class="nav-item dropdown">

                        <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                            <i class="bi bi-bell"></i>
                            <span class="badge bg-primary badge-number">4</span>
                        </a><!-- End Notification Icon -->

                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
                            <li class="dropdown-header">
                                Bạn có 4 thông báo mới
                                <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">Xem tất cả</span></a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="notification-item">
                                <i class="bi bi-exclamation-circle text-warning"></i>
                                <div>
                                    <h4>Cảnh báo đăng nhập</h4>
                                    <p>Phát hiện tài khoản đăng nhập ở nơi khác</p>
                                    <p>2 phút trước</p>
                                </div>
                            </li>

                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="notification-item">
                                <i class="bi bi-x-circle text-danger"></i>
                                <div>
                                    <h4>Đặt hàng không thành công</h4>
                                    <p>Vui lòng điền đầy đủ thông tin đơn hàng</p>
                                    <p>1 hr. ago</p>
                                </div>
                            </li>

                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="notification-item">
                                <i class="bi bi-check-circle text-success"></i>
                                <div>
                                    <h4>Thông báo 3</h4>
                                    <p>Nội dung thông báo 3</p>
                                    <p>2 hrs. ago</p>
                                </div>
                            </li>

                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="notification-item">
                                <i class="bi bi-info-circle text-primary"></i>
                                <div>
                                    <h4>Thông báo 4 </h4>
                                    <p>Nội dung thông báo 4</p>
                                    <p>4 hrs. ago</p>
                                </div>
                            </li>

                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li class="dropdown-footer">
                                <a href="#">Hiển thị tất cả thông báo</a>
                            </li>

                        </ul><!-- End Notification Dropdown Items -->

                    </li><!-- End Notification Nav -->

                    <li class="nav-item dropdown">

                        <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                            <i class="bi bi-chat-left-text"></i>
                            <span class="badge bg-success badge-number">3</span>
                        </a><!-- End Messages Icon -->

                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow messages">
                            <li class="dropdown-header">
                                Bạn có 3 tin nhắn mới
                                <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">Xem tất cả</span></a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="message-item">
                                <a href="#">
                                    <img src="/assets/img/user1.png" alt="" class="rounded-circle">
                                    <div>
                                        <h4>Vũ Tùng Dương</h4>
                                        <p>Thêm đơn hàng #2024245676</p>
                                        <p>Vừa xong</p>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="message-item">
                                <a href="#">
                                    <img src="/assets/img/user2.jpg" alt="" class="rounded-circle">
                                    <div>
                                        <h4>Trần Quốc Toàn</h4>
                                        <p>Thêm đơn hàng #202423445</p>
                                        <p>6 phút trước</p>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="message-item">
                                <a href="#">
                                    <img src="/assets/img/user3.jpg" alt="" class="rounded-circle">
                                    <div>
                                        <h4>Lê Võ Khôi Nguyên</h4>
                                        <p>Thêm đơn hàng #202423346</p>
                                        <p>8 phút trước</p>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li class="dropdown-footer">
                                <a href="#">Hiển thị tất cả tin nhắn</a>
                            </li>

                        </ul><!-- End Messages Dropdown Items -->

                    </li><!-- End Messages Nav -->

                    <li class="nav-item dropdown pe-3">

                        <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#"
                            data-bs-toggle="dropdown">
                            <img src="/assets/img/user1.png" alt="Profile" class="rounded-circle">
                            <span class="d-none d-md-block dropdown-toggle ps-2">
                                <c:out value="${pageContext.request.userPrincipal.name}" />
                            </span>
                        </a><!-- End Profile Image Icon -->

                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">


                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="/admin">
                                    <i class="bi bi-person"></i>
                                    <span>Hồ sơ của tôi</span>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="/admin">
                                    <i class="bi bi-gear"></i>
                                    <span>Cài đặt</span>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>



                            <li>
                                <form action="/logout" method="post">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button class="dropdown-item d-flex align-items-center">
                                        <i class="bi bi-box-arrow-right"></i>
                                        <span>Đăng xuất</span>
                                    </button>
                                </form>
                            </li>

                        </ul><!-- End Profile Dropdown Items -->
                    </li><!-- End Profile Nav -->

                </ul>
            </nav><!-- End Icons Navigation -->

        </header><!-- End Header -->