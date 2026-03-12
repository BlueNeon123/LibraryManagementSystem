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
        // Đã sửa đổi: Trỏ đúng vào thư mục templates chứa file
        request.getRequestDispatcher("/templates/login.html").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String matKhau = request.getParameter("password");

        User user = userDAO.kiemTraDangNhap(email, matKhau);

        if (user != null) {
            System.out.println("LOG: Đăng nhập thành công với tên " + user.getFullName());
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Đã sửa đổi: Trỏ đúng vào file JSP trong thư mục admin
            response.sendRedirect(request.getContextPath() + "/templates/admin/dashboard.jsp");
        } else {
            System.out.println("LOG: Đăng nhập thất bại. Sai tài khoản!");
            // Đã sửa đổi: Trỏ đúng đường dẫn khi bị lỗi
            response.sendRedirect(request.getContextPath() + "/templates/login.html?error=1");
        }
    }
}