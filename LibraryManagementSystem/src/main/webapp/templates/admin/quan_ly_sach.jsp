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
            <a href="quan-ly-sach" class="active">Quản lý Sách</a>
            <a href="quan-ly-nguoi-dung">Quản lý Người dùng</a>
        </nav>
    </div>

    <div class="content-area">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-primary">Danh Mục Sách</h3>
            
            <form action="quan-ly-sach" method="GET" class="d-flex gap-2 w-50">
                <input type="text" name="txtSearch" class="form-control" placeholder="Tìm tên sách...">
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
    </body>
</html>