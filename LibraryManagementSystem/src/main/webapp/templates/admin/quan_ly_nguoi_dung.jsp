<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.lms.model.User" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Người Dùng - Thư Viện</title>
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
            <a href="${pageContext.request.contextPath}/quan-ly-nguoi-dung" class="active"><i class="bi bi-people me-2"></i> Quản lý Người dùng</a>
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

        <h3 class="mb-4 fw-bold text-primary"><i class="bi bi-people-fill me-2"></i>Danh Sách Thành Viên</h3>
        
        <div class="table-responsive bg-white p-4 rounded shadow-sm border-0">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3">Mã Số</th>
                        <th>Họ Tên</th>
                        <th>Email</th>
                        <th>Vai Trò</th>
                        <th>Trạng Thái</th>
                        <th class="text-center">Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<User> list = (List<User>) request.getAttribute("listUser");
                        if(list != null && !list.isEmpty()) {
                            for(User u : list) {
                    %>
                    <tr>
                        <td class="ps-3 fw-bold text-primary"><%= u.getUserId() %></td>
                        <td class="fw-bold"><%= u.getFullName() %></td>
                        <td><%= u.getEmail() %></td>
                        <td>
                            <span class="badge <%= "ADMIN".equalsIgnoreCase(u.getRole()) ? "bg-danger" : "bg-info" %>">
                                <%= u.getRole() %>
                            </span>
                        </td>
                        <td>
                            <span class="badge <%= u.isActive() ? "bg-success" : "bg-secondary" %> px-3 py-2">
                                <%= u.isActive() ? "Hoạt động" : "Bị khóa" %>
                            </span>
                        </td>
                        <td class="text-center">
                            <a href="${pageContext.request.contextPath}/quan-ly-nguoi-dung?action=toggle&id=<%= u.getUserId() %>" 
                               class="btn btn-sm <%= u.isActive() ? "btn-outline-warning" : "btn-outline-success" %> fw-bold"
                               style="width: 110px;">
                               <i class="bi <%= u.isActive() ? "bi-lock-fill" : "bi-unlock-fill" %>"></i>
                               <%= u.isActive() ? "Khóa thẻ" : "Mở khóa" %>
                            </a>
                        </td>
                    </tr>
                    <%      }
                        } else {
                    %>
                        <tr><td colspan="6" class="text-center text-danger py-4 fw-bold">Chưa có người dùng nào trong hệ thống!</td></tr>
                    <%  } %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>