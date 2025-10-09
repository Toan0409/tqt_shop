<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Đặt lại mật khẩu</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body class="bg-light">
            <div class="container d-flex justify-content-center align-items-center vh-100">
                <div class="card shadow p-4" style="max-width: 400px;">
                    <h4 class="text-center mb-4 text-primary">Đặt lại mật khẩu</h4>

                    <form:form action="${pageContext.request.contextPath}/update-password" method="post">
                        <div class="mb-3">
                            <label for="password" class="form-label">Mật khẩu mới</label>
                            <input type="password" name="password" id="password" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirm" class="form-label">Xác nhận mật khẩu</label>
                            <input type="password" id="confirm" class="form-control" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                        </div>
                    </form:form>
                </div>
            </div>
            <script>
                document.querySelector("form").addEventListener("submit", e => {
                    const p1 = document.getElementById("password").value;
                    const p2 = document.getElementById("confirm").value;
                    if (p1 !== p2) {
                        e.preventDefault();
                        alert("Mật khẩu xác nhận không khớp!");
                    }
                });
            </script>
        </body>

        </html>