package com.lms.controller;

import com.lms.dao.UserDAO;
import com.lms.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/dang-nhap")
public class AuthController extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Mở file JSP đã nâng cấp thay vì file HTML cũ
        request.getRequestDispatcher("/templates/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String matKhau = request.getParameter("password");

        User user = userDAO.kiemTraDangNhap(email, matKhau);

        if (user != null) {
            System.out.println("LOG: Đăng nhập thành công: " + user.getFullName());
            
            HttpSession session = request.getSession();
            // CỰC KỲ QUAN TRỌNG: Phải đặt tên là "userLogin" để ChiTietController nhận ra
            session.setAttribute("userLogin", user);
            
            // Đăng nhập xong đá về Trang chủ để test mượn sách
            response.sendRedirect(request.getContextPath() + "/trang-chu");
        } else {
            System.out.println("LOG: Đăng nhập thất bại!");
            // Quay lại trang login và báo lỗi
            response.sendRedirect(request.getContextPath() + "/dang-nhap?error=1");
        }
    }
}