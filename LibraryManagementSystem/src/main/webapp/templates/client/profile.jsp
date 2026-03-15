<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lms.model.User" %>
<%
    User u = (User) session.getAttribute("userLogin");
    if (u == null) {
        response.sendRedirect(request.getContextPath() + "/dang-nhap");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                
                <% if ("true".equals(request.getParameter("success"))) { %>
                    <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i> Cập nhật hồ sơ thành công!</div>
                <% } %>

                <div class="card shadow border-0 rounded-4">
                    <div class="card-header bg-primary text-white text-center py-4 rounded-top-4">
                        <div class="mb-2"><i class="bi bi-person-circle fs-1"></i></div>
                        <h4 class="fw-bold mb-0"><%= u.getFullName() %></h4>
                        <small>Mã tài khoản: <%= u.getUserId() %></small>
                    </div>
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/profile" method="POST">
                            <div class="mb-3">
                                <label class="form-label fw-bold small text-secondary">EMAIL (KHÔNG THỂ SỬA)</label>
                                <input type="text" class="form-control bg-light" value="<%= u.getEmail() %>" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold small text-secondary">HỌ VÀ TÊN</label>
                                <input type="text" name="fullName" class="form-control" value="<%= u.getFullName() %>" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold small text-secondary">ĐIỆN THOẠI</label>
                                <input type="text" name="phone" class="form-control" value="<%= u.getDienThoai() != null ? u.getDienThoai() : "" %>" placeholder="Chưa cập nhật số điện thoại">
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-bold small text-secondary">LỚP CHUYÊN NGÀNH</label>
                                <input type="text" name="classInfo" class="form-control" value="<%= u.getLop() != null ? u.getLop() : "" %>" placeholder="Ví dụ: K65 - Hệ thống thông tin">
                            </div>
                            
                            <hr class="my-4">
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary py-2 fw-bold shadow-sm">
                                    <i class="bi bi-save2 me-2"></i>Lưu thay đổi
                                    
                                </button>
                                <a href="${pageContext.request.contextPath}/lich-su-muon" class="btn btn-success py-2 fw-bold shadow-sm">
                                    <i class="bi bi-clock-history me-2"></i>Xem lịch sử mượn sách
                                </a>
                                
                                <a href="${pageContext.request.contextPath}/trang-chu" class="btn btn-outline-secondary">Quay lại trang chủ</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>