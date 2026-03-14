<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.lms.model.User" %>
<%
    User user = (User) session.getAttribute("userLogin");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/dang-nhap");
        return;
    }
%>
<%@ page import="java.util.List" %>
<%@ page import="com.lms.model.PhieuMuon" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử mượn sách</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-primary mb-0"><i class="bi bi-journal-text me-2"></i>Lịch sử Mượn & Trả</h3>
            <a href="${pageContext.request.contextPath}/trang-chu" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                <i class="bi bi-plus-lg me-1"></i> Mượn thêm sách
            </a>
        </div>

        <div class="table-responsive bg-white p-3 rounded shadow-sm">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th class="py-3">Tên sách</th>
                        <th>Ngày mượn</th>
                        <th>Hạn trả</th>
                        <th>Trạng thái</th>
                        <th>Phí phạt</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        // Lấy danh sách từ Controller truyền sang
                        List<PhieuMuon> listPhieu = (List<PhieuMuon>) request.getAttribute("listPhieu");
                        
                        // Kiểm tra nếu có dữ liệu thì chạy vòng lặp in ra
                        if (listPhieu != null && !listPhieu.isEmpty()) {
                            for (PhieuMuon phieu : listPhieu) {
                    %>
                    <tr>
                        <td class="fw-bold"><%= phieu.getTenSach() %></td>
                        <td><%= phieu.getNgayMuon() %></td>
                        <td><%= phieu.getHanTra() %></td>
                        <td>
                            <span class="badge rounded-pill bg-primary px-3"><%= phieu.getTrangThai() %></span>
                        </td>
                        <td class="text-danger fw-bold"><%= phieu.getTienPhat() %> VNĐ</td>
                    </tr>
                    <% 
                            } // Đóng vòng lặp for
                        } else { 
                    %>
                        <tr>
                            <td colspan="5" class="text-center py-4 text-muted">
                                <i>Bạn chưa mượn cuốn sách nào!</i>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>