<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Hệ Thống Thư Viện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .sidebar { min-height: 100vh; background-color: #2c3e50; width: 250px; position: fixed; }
        .content-area { margin-left: 250px; padding: 20px; }
        .card-stat { border-radius: 15px; border: none; transition: 0.3s; color: white; }
        .card-stat:hover { transform: translateY(-5px); }
    </style>
</head>
<body class="bg-light">
    <div class="sidebar shadow text-white">
        <h4 class="p-4 text-center border-bottom">THỦ THƯ</h4>
        <nav class="mt-3">
            <a href="dashboard" class="p-3 d-block text-white bg-primary text-decoration-none">Dashboard</a>
            <a href="quan-ly-sach" class="p-3 d-block text-white text-decoration-none">Quản lý Sách</a>
            <a href="quan-ly-nguoi-dung" class="p-3 d-block text-white text-decoration-none">Quản lý Người dùng</a>
        </nav>
    </div>

    <div class="content-area">
        <h2 class="fw-bold mb-4">Chào mừng trở lại, Admin!</h2>
        
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card card-stat bg-primary p-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase">Tổng số Sách</h6>
                            <h2 class="fw-bold mb-0">${tongSach}</h2>
                        </div>
                        <i class="bi bi-book-half fs-1"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card card-stat bg-success p-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase">Thành viên</h6>
                            <h2 class="fw-bold mb-0">${tongUser}</h2>
                        </div>
                        <i class="bi bi-people-fill fs-1"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card card-stat bg-danger p-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase">Thẻ bị khóa</h6>
                            <h2 class="fw-bold mb-0">${userBiKhoa}</h2>
                        </div>
                        <i class="bi bi-lock-fill fs-1"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-5 p-5 bg-white rounded shadow-sm text-center">
            <h4>Hệ thống đã sẵn sàng phục vụ độc giả!</h4>
            <p class="text-muted">Hôm nay là ngày 12 tháng 03 năm 2026</p>
        </div>
    </div>
</body>
</html>