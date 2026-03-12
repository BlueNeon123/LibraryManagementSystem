<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Nhận Trả Sách</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { min-height: 100vh; background-color: #2c3e50; width: 250px; position: fixed; }
        .content-area { margin-left: 250px; padding: 20px; }
        .sidebar a { color: #ecf0f1; text-decoration: none; padding: 15px 20px; display: block; }
        .sidebar a:hover, .sidebar a.active { background-color: #1abc9c; }
    </style>
</head>
<body>
    <div class="sidebar shadow text-white">
        <h4 class="p-4 text-center border-bottom">THỦ THƯ</h4>
        <nav class="mt-3">
            <a href="dashboard">Dashboard</a>
            <a href="quan-ly-sach">Quản lý Sách</a>
            <a href="quan-ly-muon-tra">Cấp Phiếu Mượn</a>
            <a href="quan-ly-tra-sach" class="active">Nhận Trả Sách</a>
        </nav>
    </div>

    <div class="content-area">
        <h3 class="fw-bold text-primary mb-4">NHẬN TRẢ SÁCH</h3>

        <% String status = request.getParameter("status");
           String tien = request.getParameter("tien");
           if ("success".equals(status)) { %>
            <div class="alert alert-success fw-bold"><i class="bi bi-check-circle"></i> Trả sách thành công! Sách đã được đưa lại vào kho.</div>
        <% } else if ("phat".equals(status)) { %>
            <div class="alert alert-warning fw-bold fs-5 text-danger"><i class="bi bi-exclamation-triangle"></i> CẢNH BÁO TRỄ HẠN! Thu tiền phạt: <%= tien %> VNĐ.</div>
        <% } else if ("error".equals(status)) { %>
            <div class="alert alert-danger fw-bold"><i class="bi bi-x-circle"></i> Lỗi! Không tìm thấy dữ liệu đang mượn của mã vạch này.</div>
        <% } %>

        <div class="bg-white p-4 rounded shadow-sm w-50 mt-4">
            <form action="quan-ly-tra-sach" method="POST">
                <input type="hidden" name="action" value="traSach">
                
                <div class="mb-4">
                    <label class="form-label fw-bold">Quét Mã Vạch (Mã Bản Sao)</label>
                    <input type="text" class="form-control form-control-lg text-center fw-bold text-primary" name="maVach" required placeholder="Nhập mã vạch cuốn sách">
                </div>
                
                <button type="submit" class="btn btn-warning w-100 fw-bold fs-5 text-dark">XÁC NHẬN TRẢ SÁCH</button>
            </form>
        </div>
    </div>
</body>
</html>