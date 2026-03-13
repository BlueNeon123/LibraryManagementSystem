<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lms.model.Sach" %>
<% 
    // Hứng cuốn sách từ Controller
    Sach s = (Sach) request.getAttribute("sach"); 
    if (s == null) {
        response.sendRedirect(request.getContextPath() + "/trang-chu");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết: <%= s.getTenSach() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .navbar { background-color: #0d6efd; }
    </style>
</head>
<body class="bg-light">
    
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top mb-4 shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/trang-chu">THƯ VIỆN</a>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link text-white" href="#"><i class="bi bi-person-circle"></i> Tài khoản</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container py-2 mb-5">
        
        <% if ("true".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i> <strong>Thành công!</strong> Đã gửi yêu cầu mượn sách. Vui lòng chờ Thủ thư duyệt.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <% if ("hethang".equals(request.getParameter("error"))) { %>
            <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                <i class="bi bi-x-circle-fill me-2"></i> <strong>Rất tiếc!</strong> Cuốn sách này hiện đã hết bản sao rảnh trong kho.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/trang-chu" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item active"><%= s.getTenSach() %></li>
            </ol>
        </nav>

        <div class="card shadow border-0">
            <div class="row g-0 p-4">
                <div class="col-md-4 text-center">
                    <div style="height: 400px; background-color: #e9ecef;" class="img-fluid rounded shadow d-flex align-items-center justify-content-center text-secondary">
                        <i class="bi bi-book" style="font-size: 8rem;"></i>
                    </div>
                </div>
                <div class="col-md-8 px-md-5 mt-4 mt-md-0">
                    <h2 class="fw-bold mb-3 text-primary"><%= s.getTenSach() %></h2>
                    <p class="fs-5 text-secondary"><strong>Tác giả:</strong> <%= s.getTacGia() %></p>
                    <p class="fs-6"><strong>Thể loại:</strong> <%= s.getTheLoai() %></p>
                    <p class="fs-6"><strong>Mã ISBN:</strong> <%= s.getMaSach() %></p>
                    <hr>
                    <p class="text-dark">Cuốn sách <strong><%= s.getTenSach() %></strong> của tác giả <strong><%= s.getTacGia() %></strong> là tài liệu tuyệt vời thuộc thể loại <%= s.getTheLoai() %>. Mời bạn mượn sách để trải nghiệm chi tiết.</p>
                    
                    <div class="alert alert-info d-inline-block mt-3 shadow-sm border-0">
                        <i class="bi bi-info-circle-fill me-2"></i>
                        <strong>Tình trạng kho:</strong> Sẵn sàng cho mượn.
                    </div>

                    <div class="mt-4 d-flex">
                        <form action="${pageContext.request.contextPath}/chi-tiet" method="POST">
                            <input type="hidden" name="action" value="muon_sach">
                            <input type="hidden" name="maSach" value="<%= s.getMaSach() %>">
                            <button type="submit" class="btn btn-primary btn-lg px-5 shadow">
                                <i class="bi bi-bag-plus-fill me-2"></i>Mượn sách ngay
                            </button>
                        </form>

                        <button class="btn btn-outline-danger btn-lg ms-2 bg-white"><i class="bi bi-heart"></i></button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>