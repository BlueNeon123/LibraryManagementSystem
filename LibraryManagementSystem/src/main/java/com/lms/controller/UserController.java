package com.lms.controller;

import com.lms.dao.UserDAO;
import com.lms.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/quan-ly-nguoi-dung")
public class UserController extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action");
        String id = request.getParameter("id");

        // Nếu bấm nút Khóa/Mở khóa
        if ("toggle".equals(action)) {
            userDAO.toggleStatus(id);
            response.sendRedirect(request.getContextPath() + "/quan-ly-nguoi-dung");
            return;
        }

        // Mặc định: Hiển thị danh sách
        request.setAttribute("listUser", userDAO.getAll());
        request.getRequestDispatcher("/templates/admin/quan_ly_nguoi_dung.jsp").forward(request, response);
    }
}