<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Thư Viện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background-color: #f8f9fa; overflow-x: hidden; }
        .sidebar { min-height: 100vh; background-color: #2c3e50; width: 250px; position: fixed; top: 0; left: 0; }
        .sidebar h4 { color: white; padding: 20px 0; margin: 0; text-align: center; border-bottom: 1px solid #34495e; }
        .sidebar a { color: #ecf0f1; text-decoration: none; padding: 15px 20px; display: block; transition: 0.3s; }
        .sidebar a:hover, .sidebar a.active { background-color: #1abc9c; border-left: 5px solid #16a085; }
        .content-area { margin-left: 250px; padding: 20px; width: calc(100% - 250px); }
        .topbar { background-color: white; padding: 15px 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); margin-bottom: 20px; }
    </style>
</head>
<body>

    <div class="sidebar text-white shadow">
        <h4><i class="bi bi-shield-lock"></i> THỦ THƯ</h4>
        <nav class="mt-3">
            <a href="${pageContext.request.contextPath}/dashboard" class="active"><i class="bi bi-house-door me-2"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/quan-ly-sach"><i class="bi bi-book me-2"></i> Quản lý Sách</a>
            <a href="${pageContext.request.contextPath}/quan-ly-nguoi-dung"><i class="bi bi-people me-2"></i> Quản lý Người dùng</a>
            <a href="${pageContext.request.contextPath}/nhap-kho"><i class="bi bi-box-seam me-2"></i> Nhập Kho</a>
            <a href="${pageContext.request.contextPath}/quan-ly-muon-tra"><i class="bi bi-arrow-right-circle me-2"></i> Cấp Phiếu Mượn</a>
            <a href="${pageContext.request.contextPath}/quan-ly-tra-sach"><i class="bi bi-arrow-return-left me-2"></i> Nhận Trả & Phạt</a>
        </nav>
    </div>

    <div class="content-area">
        
        <header class="topbar d-flex justify-content-between align-items-center">
            <h5 class="m-0 fw-bold text-secondary">Hệ Thống Quản Lý Thư Viện</h5>
            <div class="d-flex align-items-center">
                <span class="me-3 fw-bold"><i class="bi bi-person-circle"></i> Xin chào, Admin!</span>
                <a href="login.html" class="btn btn-outline-danger btn-sm"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
            </div>
        </header>

        <h3 class="mb-4 fw-bold text-primary"><i class="bi bi-bar-chart-fill me-2"></i>Thống Kê Tổng Quan</h3>
        
        <div class="row g-4">
            <div class="col-md-3">
                <div class="card text-white bg-primary border-0 shadow-sm h-100">
                    <div class="card-body">
                        <h6 class="card-title text-uppercase opacity-75">Sách Đang Mượn</h6>
                        <h1 class="display-5 fw-bold mb-0">
                            <%= request.getAttribute("dangMuon") != null ? request.getAttribute("dangMuon") : "0" %>
                        </h1>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-dark bg-warning border-0 shadow-sm h-100">
                    <div class="card-body">
                        <h6 class="card-title text-uppercase opacity-75">Tổng Thành Viên</h6>
                        <h1 class="display-5 fw-bold mb-0">
                            <%= request.getAttribute("tongUser") != null ? request.getAttribute("tongUser") : "0" %>
                        </h1>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-danger border-0 shadow-sm h-100">
                    <div class="card-body">
                        <h6 class="card-title text-uppercase opacity-75">Phiếu Trễ Hạn</h6>
                        <h1 class="display-5 fw-bold mb-0">0</h1> </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-success border-0 shadow-sm h-100">
                    <div class="card-body">
                        <h6 class="card-title text-uppercase opacity-75">Tổng Đầu Sách</h6>
                        <h1 class="display-5 fw-bold mb-0">
                            <%= request.getAttribute("tongSach") != null ? request.getAttribute("tongSach") : "0" %>
                        </h1>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>