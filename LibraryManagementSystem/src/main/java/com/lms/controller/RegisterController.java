package com.lms.controller;

import com.lms.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dang-ky")
public class RegisterController extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Trỏ đường dẫn vào file register.jsp
        request.getRequestDispatcher("/templates/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Ép kiểu UTF-8 để gõ tiếng Việt (Họ tên)
        request.setCharacterEncoding("UTF-8");
        
        // Rút dữ liệu từ các ô input của form register.jsp
        String maNguoiDung = request.getParameter("maNguoiDung");
        String hoTen = request.getParameter("hoTen");
        String matKhau = request.getParameter("matKhau");
        String email = request.getParameter("email");
        
        // Xử lý logic lưu vào Database (Yêu cầu UserDAO phải có hàm themNguoiDung)
        try {
            boolean isSuccess = userDAO.themNguoiDung(maNguoiDung, hoTen, email, matKhau);
            
            if (isSuccess) {
                System.out.println("LOG: Đăng ký thành công tài khoản: " + maNguoiDung);
                // Đăng ký xong thì chuyển hướng thẳng về trang Đăng nhập
                response.sendRedirect(request.getContextPath() + "/dang-nhap?status=registered");
            } else {
                System.out.println("LOG: Đăng ký thất bại (Trùng mã SV hoặc lỗi DB)!");
                // Lỗi thì quay lại trang đăng ký và báo lỗi
                response.sendRedirect(request.getContextPath() + "/dang-ky?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/dang-ky?error=sys");
        }
    }
}