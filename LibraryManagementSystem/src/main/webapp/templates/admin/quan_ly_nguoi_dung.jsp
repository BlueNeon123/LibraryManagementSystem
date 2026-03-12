<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.lms.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Người Dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background-color: #f8f9fa; }
        .sidebar { min-height: 100vh; background-color: #2c3e50; width: 250px; position: fixed; }
        .content-area { margin-left: 250px; padding: 20px; }
        .sidebar a { color: #ecf0f1; text-decoration: none; padding: 15px 20px; display: block; transition: 0.3s; }
        .sidebar a:hover { background-color: #1abc9c; }
    </style>
</head>
<body>
    <div class="sidebar shadow text-white">
        <h4 class="p-3 text-center border-bottom">THỦ THƯ</h4>
        <nav class="mt-3">
            <a href="dashboard"><i class="bi bi-house-door me-2"></i> Dashboard</a>
            <a href="quan-ly-sach"><i class="bi bi-book me-2"></i> Quản lý Sách</a>
            <a href="quan-ly-nguoi-dung" class="bg-primary"><i class="bi bi-people me-2"></i> Quản lý Người dùng</a>
            <a href="dang-xuat"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
        </nav>
    </div>

    <div class="content-area">
        <h3 class="fw-bold text-primary mb-4"><i class="bi bi-people-fill me-2"></i>Danh Sách Thành Viên</h3>
        
        <div class="table-responsive bg-white p-4 rounded shadow-sm">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Mã Số</th>
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
                        if(list != null) {
                            for(User u : list) {
                    %>
                    <tr>
                        <td class="fw-bold"><%= u.getUserId() %></td>
                        <td><%= u.getFullName() %></td>
                        <td><%= u.getEmail() %></td>
                        <td><span class="badge <%= u.getRole().equals("ADMIN") ? "bg-danger" : "bg-info" %>"><%= u.getRole() %></span></td>
                        <td>
                            <span class="badge <%= u.isActive() ? "bg-success" : "bg-secondary" %>">
                                <%= u.isActive() ? "Hoạt động" : "Bị khóa" %>
                            </span>
                        </td>
                        <td class="text-center">
                            <a href="quan-ly-nguoi-dung?action=toggle&id=<%= u.getUserId() %>" 
                               class="btn btn-sm <%= u.isActive() ? "btn-outline-warning" : "btn-outline-success" %>"
                               style="width: 110px;">
                               <i class="bi <%= u.isActive() ? "bi-lock-fill" : "bi-unlock-fill" %>"></i>
                               <%= u.isActive() ? "Khóa thẻ" : "Mở khóa" %>
                            </a>
                        </td>
                    </tr>
                    <%      }
                        } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>