<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hệ thống Thư viện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body class="bg-secondary bg-opacity-10">

    <div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
        <div class="card shadow-lg p-4 rounded-4" style="width: 100%; max-width: 400px; border: none;">
            
            <div class="text-center mb-4">
                <h2 class="fw-bold text-primary">THƯ VIỆN SỐ</h2>
                <p class="text-muted">Vui lòng đăng nhập để tiếp tục</p>
            </div>

            <% 
                String error = request.getParameter("error");
                if (error != null) { 
            %>
                <div class="alert alert-danger text-center py-2 shadow-sm" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <% 
                        if ("locked".equals(error)) { 
                            out.print("Tài khoản đã bị khóa. Liên hệ Admin!");
                        } else {
                            out.print("Sai email hoặc mật khẩu!");
                        }
                    %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/dang-nhap" method="POST">
                <div class="mb-3">
                    <label class="form-label small fw-bold text-secondary">Email</label>
                    <input type="email" class="form-control" name="email" placeholder="Ví dụ: admin@truong.edu.vn" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold text-secondary">Mật khẩu</label>
                    <input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold shadow-sm">
                    <i class="bi bi-box-arrow-in-right me-2"></i>ĐĂNG NHẬP
                </button>
            </form>
            
            <div class="text-center mt-4">
                <span class="text-muted small">Chưa có tài khoản?</span> 
                <a href="${pageContext.request.contextPath}/dang-ky" class="text-decoration-none fw-bold small">Đăng ký ngay</a>
            </div>

        </div>
    </div>

</body>
</html>