<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cấp Phiếu Mượn Sách</title>
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
            <a href="quan-ly-muon-tra" class="active">Cấp Phiếu Mượn</a>
        </nav>
    </div>

    <div class="content-area">
        <h3 class="fw-bold text-primary mb-4">CẤP PHIẾU MƯỢN SÁCH</h3>

        <% String status = request.getParameter("status");
           if ("success".equals(status)) { %>
            <div class="alert alert-success fw-bold"><i class="bi bi-check-circle"></i> Cấp phiếu mượn và cập nhật kho thành công!</div>
        <% } else if ("error".equals(status)) { %>
            <div class="alert alert-danger fw-bold"><i class="bi bi-x-circle"></i> Có lỗi xảy ra. Vui lòng kiểm tra lại Mã sách hoặc Mã độc giả.</div>
        <% } %>

        <div class="bg-white p-4 rounded shadow-sm w-50">
            <form action="quan-ly-muon-tra" method="POST">
                <input type="hidden" name="action" value="muonSach">
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Mã Người Dùng (Độc giả)</label>
                    <input type="text" class="form-control" name="maNguoiDung" required placeholder="Ví dụ: ND001">
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold">Mã Bản Sao (Mã vạch trên cuốn sách)</label>
                    <input type="text" class="form-control" name="maBanSao" required placeholder="Ví dụ: BSS-001">
                </div>
                
                <button type="submit" class="btn btn-primary w-100 fw-bold fs-5">XÁC NHẬN CHO MƯỢN</button>
            </form>
        </div>
    </div>
</body>
</html>