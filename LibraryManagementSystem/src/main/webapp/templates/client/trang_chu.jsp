<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.lms.model.Sach" %>
<%@ page import="com.lms.model.User" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thư Viện - Trang Chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background-color: #f4f6f9; }
        .navbar { background-color: #0d6efd; }
        .sidebar { background-color: white; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .book-card { border: none; box-shadow: 0 2px 5px rgba(0,0,0,0.05); transition: transform 0.2s; }
        .book-card:hover { transform: translateY(-5px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .book-img-placeholder { height: 200px; background-color: #e9ecef; display: flex; align-items: center; justify-content: center; color: #6c757d; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/trang-chu">THƯ VIỆN</a>
            
            <form action="${pageContext.request.contextPath}/trang-chu" method="GET" class="d-flex w-50 mx-auto">
                <div class="input-group">
                    <input type="text" class="form-control" name="txtSearch" placeholder="Tìm tên sách, tác giả..." value="${tuKhoaVuaTim != null ? tuKhoaVuaTim : ''}">
                    <button class="btn btn-light text-primary" type="submit"><i class="bi bi-search"></i></button>
                </div>
            </form>

            <ul class="navbar-nav ms-auto">
                <% 
                    User currentUser = (User) session.getAttribute("userLogin");
                    if (currentUser == null) { 
                %>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="${pageContext.request.contextPath}/dang-nhap">
                            <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
                        </a>
                    </li>
                <% } else { %>
                    <% if ("ADMIN".equals(currentUser.getRole())) { %>
                        <li class="nav-item me-2">
                            <a class="nav-link btn btn-warning text-dark fw-bold px-3 rounded-pill" href="${pageContext.request.contextPath}/dashboard">
                                <i class="bi bi-speedometer2"></i> Quản lý Admin
                            </a>
                        </li>
                    <% } %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white fw-bold" href="#" id="userMenu" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle"></i> <%= currentUser.getFullName() %>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0" aria-labelledby="userMenu">
                            <% if (!"ADMIN".equals(currentUser.getRole())) { %>
                                <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/profile"><i class="bi bi-person-lines-fill text-primary me-2"></i>Hồ sơ của tôi</a></li>
                                <li><hr class="dropdown-divider"></li>
                            <% } %>
                            <li>
                                <a class="dropdown-item py-2 text-danger fw-bold" href="${pageContext.request.contextPath}/dang-xuat">
                                    <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </li>
                <% } %>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3 mb-4">
                
                <% String theLoaiDangChon = (String) request.getAttribute("theLoaiDangChon"); %>
                <div class="list-group sidebar">
                    <a href="${pageContext.request.contextPath}/trang-chu" 
                       class="list-group-item list-group-item-action <%= (theLoaiDangChon == null) ? "active bg-primary border-primary fw-bold" : "" %>">
                       <i class="bi bi-collection-fill me-2"></i> Tất cả thể loại
                    </a>
                    
                    <% 
                        List<String> danhSachTheLoai = (List<String>) request.getAttribute("danhSachTheLoai");
                        if (danhSachTheLoai != null) {
                            for (String tl : danhSachTheLoai) {
                    %>
                        <a href="${pageContext.request.contextPath}/trang-chu?theLoai=<%= tl %>" 
                           class="list-group-item list-group-item-action d-flex justify-content-between align-items-center <%= (tl.equals(theLoaiDangChon)) ? "active bg-primary border-primary fw-bold" : "" %>">
                           <span><i class="bi bi-bookmark-fill me-2 opacity-50"></i> <%= tl %></span>
                        </a>
                    <% 
                            }
                        }
                    %>
                </div>
            </div>

            <div class="col-md-9">
                <h4 class="mb-4 fw-bold text-secondary">
                    <%= (theLoaiDangChon != null) ? "Sách thể loại: " + theLoaiDangChon : "Sách mới cập nhật" %>
                </h4>
                
                <div class="row row-cols-1 row-cols-md-3 g-4">
                    <% 
                        List<Sach> list = (List<Sach>) request.getAttribute("listSach");
                        if(list != null && !list.isEmpty()) { 
                            for(Sach s : list) { 
                    %>
                    <div class="col">
                        <div class="card h-100 book-card text-center p-3">
							<% if (s.getHinhAnh() != null && !s.getHinhAnh().isEmpty()) { %>
							    <img src="<%= s.getHinhAnh() %>" class="img-fluid mb-3 rounded shadow-sm" style="height: 200px; width: 100%; object-fit: cover;">
							<% } else { %>
							    <div class="book-img-placeholder mb-3 rounded">
							        <i class="bi bi-book fs-1"></i>
							    </div>
							<% } %>
                            <h6 class="card-title fw-bold text-dark mb-1 text-truncate" title="<%= s.getTenSach() %>">
                                <%= s.getTenSach() %>
                            </h6>
                            <p class="card-text text-muted small mb-2"><%= s.getTacGia() %></p>
                            
                            <div class="mb-3">
                                <span class="badge bg-success rounded-pill px-3">Sẵn có</span>
                            </div>
                            
                            <div class="mt-auto">
                                <a href="${pageContext.request.contextPath}/chi-tiet?maSach=<%= s.getMaSach() %>" class="btn btn-outline-primary btn-sm w-100 rounded-pill">Chi tiết</a>
                            </div>
                        </div>
                    </div>
                    <% 
                            } 
                        } else { 
                    %>
                        <div class="col-12 text-center text-danger mt-5">
                            <i class="bi bi-emoji-frown fs-1"></i>
                            <h5 class="mt-3">Không tìm thấy cuốn sách nào thuộc thể loại này!</h5>
                        </div>
                    <% } %>

                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>