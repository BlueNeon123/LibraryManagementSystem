<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.lms.model.Sach" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Danh Mục Sách</title>
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
            <a href="${pageContext.request.contextPath}/quan-ly-sach" class="active"><i class="bi bi-book me-2"></i> Quản lý Sách</a>
            <a href="${pageContext.request.contextPath}/quan-ly-nguoi-dung"><i class="bi bi-people me-2"></i> Quản lý Người dùng</a>
            <a href="${pageContext.request.contextPath}/nhap-kho"><i class="bi bi-box-seam me-2"></i> Nhập Kho</a>
            <a href="${pageContext.request.contextPath}/quan-ly-muon-tra"><i class="bi bi-arrow-right-circle me-2"></i> Cấp Phiếu Mượn</a>
            <a href="${pageContext.request.contextPath}/quan-ly-tra-sach"><i class="bi bi-arrow-return-left me-2"></i> Nhận Trả & Phạt</a>
        </nav>
    </div>

    <div class="content-area">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-primary">Danh Mục Sách</h3>
            
            <form action="${pageContext.request.contextPath}/quan-ly-sach" method="GET" class="d-flex gap-2 w-50">
                <input type="text" name="txtSearch" class="form-control" placeholder="Tìm tên sách..." value="${tuKhoaVuaTim}">
                <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i></button>
            </form>

            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalThemSach">+ Thêm Sách</button>
        </div>

        <div class="bg-white p-3 rounded shadow-sm">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th>Mã ISBN</th>
                        <th>Tên Sách</th>
                        <th>Thể Loại</th>
                        <th>Tác Giả</th>
                        <th class="text-center">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <% List<Sach> list = (List<Sach>) request.getAttribute("listSach");
                       if(list != null) { for(Sach s : list) { %>
                    <tr>
                        <td><%= s.getMaSach() %></td>
                        <td class="fw-bold"><%= s.getTenSach() %></td>
                        <td><%= s.getTheLoai() %></td>
                        <td><%= s.getTacGia() %></td>
                        <td class="text-center">
                            <a href="quan-ly-sach?action=sua&maSach=<%= s.getMaSach() %>" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                            <a href="quan-ly-sach?action=xoa&maSach=<%= s.getMaSach() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Xóa hả?')"><i class="bi bi-trash"></i></a>
                        </td>
                    </tr>
                    <% } } %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="modal fade" id="modalThemSach" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">Thêm Sách Mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="quan-ly-sach" method="POST" enctype="multipart/form-data">
                    <div class="modal-body">
                        <input type="hidden" name="action" value="them">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Mã sách (ISBN)</label>
                            <input type="text" class="form-control" name="maSach" required placeholder="VD: 978-03">
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tên sách</label>
                            <input type="text" class="form-control" name="tenSach" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Thể loại</label>
                            <input type="text" class="form-control" name="theLoai" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Tác giả</label>
                            <input type="text" class="form-control" name="tacGia" required>
                        </div>
                    </div>
                    <div class="mb-3">
                            <label class="form-label fw-bold">Tác giả</label>
                            <input type="text" class="form-control" name="tacGia" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Hình ảnh bìa</label>
                            <input type="file" name="fileHinhAnh" class="form-control" accept="image/*">
                        </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-success">Lưu Sách</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>