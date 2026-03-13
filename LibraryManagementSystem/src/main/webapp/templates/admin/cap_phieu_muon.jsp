<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cấp Phiếu Mượn Sách</title>
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
            <a href="${pageContext.request.contextPath}/dashboard" ><i class="bi bi-house-door me-2"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/quan-ly-sach"><i class="bi bi-book me-2"></i> Quản lý Sách</a>
            <a href="${pageContext.request.contextPath}/quan-ly-nguoi-dung"><i class="bi bi-people me-2"></i> Quản lý Người dùng</a>
            <a href="${pageContext.request.contextPath}/nhap-kho"><i class="bi bi-box-seam me-2"></i> Nhập Kho</a>
            <a href="${pageContext.request.contextPath}/quan-ly-muon-tra"class="active"><i class="bi bi-arrow-right-circle me-2"></i> Cấp Phiếu Mượn</a>
            <a href="${pageContext.request.contextPath}/quan-ly-tra-sach"><i class="bi bi-arrow-return-left me-2"></i> Nhận Trả & Phạt</a>
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