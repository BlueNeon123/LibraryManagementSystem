<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lms.model.Sach" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Thông Tin Sách</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-warning text-dark fw-bold">
                        <h4 class="mb-0">CẬP NHẬT THÔNG TIN SÁCH</h4>
                    </div>
                    <div class="card-body">
                        <% 
                            // Nhận cuốn sách từ Controller gửi sang
                            Sach s = (Sach) request.getAttribute("sach"); 
                            if(s != null) {
                        %>
                        <form action="${pageContext.request.contextPath}/quan-ly-sach" method="POST" enctype="multipart/form-data">
                        <div class="mb-3">
					        <label class="form-label fw-bold">Hình ảnh bìa (Mới)</label>
					        <input type="file" name="fileHinhAnh" class="form-control" accept="image/*">
					    </div>
                            <input type="hidden" name="action" value="capnhat">
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Mã ISBN</label>
                                <input type="text" name="maSach" class="form-control bg-light" value="<%= s.getMaSach() %>" readonly>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-bold">Tên Sách</label>
                                <input type="text" name="tenSach" class="form-control" value="<%= s.getTenSach() %>" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Thể Loại</label>
                                <input type="text" name="theLoai" class="form-control" value="<%= s.getTheLoai() %>" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Tác Giả</label>
                                <input type="text" name="tacGia" class="form-control" value="<%= s.getTacGia() %>" required>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/quan-ly-sach" class="btn btn-secondary">Quay lại</a>
                                <button type="submit" class="btn btn-success">Lưu Thay Đổi</button>
                            </div>
                        </form>
                        <% } else { %>
                            <div class="text-center">
                                <p class="text-danger fw-bold">Không tìm thấy thông tin cuốn sách này!</p>
                                <a href="${pageContext.request.contextPath}/quan-ly-sach" class="btn btn-secondary w-100">Quay lại danh sách</a>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>