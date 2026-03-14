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

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Kiểm tra xem người dùng đã đăng nhập chưa
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("userLogin");
        
        if (currentUser == null) {
            // Chưa đăng nhập thì đá về trang login
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
            return;
        }
        
        // 2. Nếu đã đăng nhập, cho phép xem trang hồ sơ
        request.getRequestDispatcher("/templates/client/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Đảm bảo nhận tiếng Việt không bị lỗi font
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("userLogin");

        if (currentUser != null) {
            // 1. Lấy dữ liệu từ các ô nhập liệu (input name="...") trong profile.jsp
            String hoTen = request.getParameter("fullName");
            String sdt = request.getParameter("phone");
            String lop = request.getParameter("classInfo");

            // 2. Cập nhật dữ liệu mới vào đối tượng đang giữ trong Session
            currentUser.setFullName(hoTen);
            currentUser.setDienThoai(sdt);
            currentUser.setLop(lop);

            // 3. Gọi UserDAO để lưu dữ liệu này xuống Database thật
            boolean thanhCong = userDAO.updateProfile(currentUser);

            if (thanhCong) {
                // Lưu thành công: Cập nhật lại Session và báo tin vui
                session.setAttribute("userLogin", currentUser);
                response.sendRedirect(request.getContextPath() + "/profile?success=true");
            } else {
                // Thất bại: Báo tin buồn
                response.sendRedirect(request.getContextPath() + "/profile?error=true");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
        }
    }
}