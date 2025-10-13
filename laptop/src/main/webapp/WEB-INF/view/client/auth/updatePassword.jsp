<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Đặt lại mật khẩu</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
            <style>
                body {
                    background: linear-gradient(135deg, #74b9ff, #a29bfe);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .card {
                    border: none;
                    border-radius: 20px;
                    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
                    animation: fadeIn 0.6s ease-in-out;
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(10px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .form-label {
                    font-weight: 500;
                }

                .btn-primary {
                    border-radius: 30px;
                    padding: 10px 0;
                    font-weight: 600;
                    letter-spacing: 0.5px;
                }

                .input-group-text {
                    background-color: #fff;
                    border-right: none;
                }

                .form-control {
                    border-left: none;
                }

                .form-control:focus {
                    box-shadow: none;
                    border-color: #74b9ff;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <div class="card p-4" style="max-width: 420px; margin: auto;">
                    <h3 class="text-center text-primary mb-3">
                        <i class="bi bi-shield-lock"></i> Đặt lại mật khẩu
                    </h3>
                    <p class="text-muted text-center mb-4">Nhập mật khẩu mới cho tài khoản của bạn</p>

                    <form:form action="${pageContext.request.contextPath}/update-password" method="post">
                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu mới</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                                <input type="password" name="password" id="password" class="form-control" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="confirm" class="form-label">Xác nhận mật khẩu</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-check2-circle"></i></span>
                                <input type="password" id="confirm" class="form-control" required>
                            </div>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-arrow-repeat me-1"></i> Cập nhật mật khẩu
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>

            <script>
                document.querySelector("form").addEventListener("submit", e => {
                    const p1 = document.getElementById("password").value.trim();
                    const p2 = document.getElementById("confirm").value.trim();
                    if (p1 !== p2) {
                        e.preventDefault();
                        alert("❌ Mật khẩu xác nhận không khớp!");
                    } else if (p1.length < 6) {
                        e.preventDefault();
                        alert("⚠️ Mật khẩu phải có ít nhất 6 ký tự!");
                    }
                });
            </script>
        </body>

        </html>