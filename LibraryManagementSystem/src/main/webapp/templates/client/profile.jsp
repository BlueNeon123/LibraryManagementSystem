<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lms.model.User" %>
<%
    User user = (User) session.getAttribute("userLogin");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/dang-nhap");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang cá nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow border-0 overflow-hidden">
                    <div class="card-header bg-primary text-white text-center py-5">
                        <img src="https://via.placeholder.com/100" class="rounded-circle border border-4 border-white mb-3 shadow" alt="Avatar">
                        <h4 class="fw-bold"><%= user.getFullName() %></h4>
                        <p class="mb-0 opacity-75">Mã tài khoản: <%= user.getUserId() %></p>
                    </div>
                    <div class="card-body p-4">
                        <h5 class="fw-bold border-bottom pb-2 mb-3">Thông tin chi tiết</h5>
                        <div class="row mb-3">
                            <div class="col-5 text-muted small text-uppercase">Email:</div>
                            <div class="col-7 text-end fw-bold">student@univ.edu.vn</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-5 text-muted small text-uppercase">Điện thoại:</div>
                            <div class="col-7 text-end fw-bold">0987-xxx-xxx</div>
                        </div>
                        <div class="row mb-4">
                            <div class="col-5 text-muted small text-uppercase">Lớp chuyên ngành:</div>
                            <div class="col-7 text-end fw-bold">K65 - Hệ thống thông tin</div>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/lich-su-muon" class="btn btn-primary py-2 shadow-sm">
                                <i class="bi bi-clock-history me-2"></i>Xem lịch sử mượn trả
                            </a>
                            <a href="${pageContext.request.contextPath}/trang-chu" class="btn btn-outline-secondary py-2">Quay lại trang chủ</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>