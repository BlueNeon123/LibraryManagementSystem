<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập Kho Bản Sao - Thư Viện</title>
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
            <a href="${pageContext.request.contextPath}/dashboard"><i class="bi bi-house-door me-2"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/quan-ly-sach"><i class="bi bi-book me-2"></i> Quản lý Sách</a>
            <a href="${pageContext.request.contextPath}/quan-ly-nguoi-dung"><i class="bi bi-people me-2"></i> Quản lý Người dùng</a>
            <a href="${pageContext.request.contextPath}/nhap-kho" class="active"><i class="bi bi-box-seam me-2"></i> Nhập Kho</a>
            <a href="${pageContext.request.contextPath}/quan-ly-muon-tra"><i class="bi bi-arrow-right-circle me-2"></i> Cấp Phiếu Mượn</a>
            <a href="${pageContext.request.contextPath}/quan-ly-tra-sach"><i class="bi bi-arrow-return-left me-2"></i> Nhận Trả & Phạt</a>
        </nav>
    </div>

    <div class="content-area">
        <header class="topbar d-flex justify-content-between align-items-center">
            <h5 class="m-0 fw-bold text-secondary">Hệ Thống Quản Lý Thư Viện</h5>
            <div class="d-flex align-items-center">
                <span class="me-3 fw-bold"><i class="bi bi-person-circle"></i> Xin chào, Admin!</span>
                <a href="index.html" class="btn btn-outline-danger btn-sm"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
            </div>
        </header>

        <h3 class="mb-4 fw-bold text-primary"><i class="bi bi-box-seam me-2"></i>Nhập Kho Bản Sao Sách</h3>
        
        <div class="row">
            <div class="col-md-4">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-primary text-white border-0 py-3">
                        <h5 class="mb-0 fw-bold">Quét / Nhập Mã Vạch</h5>
                    </div>
                    <div class="card-body p-4 bg-white">
                        <form>
                            <div class="mb-3">
                                <label class="form-label fw-bold">Chọn Đầu Sách (Sách gốc)</label>
                                <select class="form-select">
                                    <option>Clean Code (978-604-1-09)</option>
                                    <option>Nhà Giả Kim (978-604-2-11)</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold">Mã Vạch</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light"><i class="bi bi-upc-scan"></i></span>
                                    <input type="text" class="form-control" placeholder="VD: BSS-001" required>
                                </div>
                                <small class="text-muted">Nhấn Enter sau khi quét máy để lưu nhanh.</small>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-bold">Trạng Thái Ban Đầu</label>
                                <select class="form-select">
                                    <option value="SAN_SANG">Sẵn Sàng Cho Mượn</option>
                                    <option value="DANG_BAO_TRI">Cần Dán Tem / Tu Bổ</option>
                                </select>
                            </div>
                            <button type="button" class="btn btn-primary w-100 py-2 fw-bold"><i class="bi bi-save me-2"></i>Thêm Vào Kho</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white border-bottom-0 py-3">
                        <h5 class="mb-0 fw-bold text-secondary">Bản Sao Vừa Thêm Gần Đây</h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4">Mã Vạch</th>
                                        <th>Tên Sách</th>
                                        <th>Trạng Thái</th>
                                        <th class="text-center">Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="ps-4 fw-bold text-primary">BSS-001</td>
                                        <td>Clean Code</td>
                                        <td><span class="badge rounded-pill bg-success px-3">Sẵn sàng</span></td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="ps-4 fw-bold text-primary">BSS-002</td>
                                        <td>Clean Code</td>
                                        <td><span class="badge rounded-pill bg-success px-3">Sẵn sàng</span></td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>