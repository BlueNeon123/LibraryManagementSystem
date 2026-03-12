package com.lms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// Đường dẫn URL để gọi tới Controller này
@WebServlet("/dang-nhap") 
public class AuthController extends HttpServlet {

    // 1. XỬ LÝ GET: Hiển thị giao diện Đăng nhập
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Trỏ tới file HTML/JSP của nhóm View (Lưu ý: Bạn trỏ đúng đường dẫn trong thư mục webapp nhé)
    	request.getRequestDispatcher("/templates/login.html").forward(request, response);
    }

    // 2. XỬ LÝ POST: Nhận dữ liệu khi người dùng bấm nút Submit form
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy dữ liệu từ form HTML (Phố/Quang phải đặt thẻ <input name="email">)
        String email = request.getParameter("email");
        String matKhau = request.getParameter("password");

        // --- BƯỚC 1: GỌI DATABASE ĐỂ KIỂM TRA ---
        // Đoạn này giả lập khi nhóm Model chưa làm xong Database:
        boolean dangNhapThanhCong = "admin@truong.edu.vn".equals(email) && "123456".equals(matKhau);

        // --- BƯỚC 2: XỬ LÝ KẾT QUẢ ---
        if (dangNhapThanhCong) {
            // Lưu Session
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            session.setAttribute("role", "ADMIN");

            // Chuyển hướng sang trang Dashboard
            response.sendRedirect(request.getContextPath() + "/templates/admin/dashboard.html");
        } else {
            // Sai pass -> Báo lỗi và quay lại trang đăng nhập
            request.setAttribute("loi", "Sai email hoặc mật khẩu!");
            request.getRequestDispatcher("/templates/admin/login.html").forward(request, response);
        }
    }
}