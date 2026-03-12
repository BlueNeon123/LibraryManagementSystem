package com.lms.controller;

import com.lms.dao.SachDAO;
import com.lms.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    private SachDAO sachDao = new SachDAO();
    private UserDAO userDao = new UserDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Gom số liệu
        int tongSach = sachDao.getTongSoSach();
        int tongUser = userDao.getTongSoNguoiDung();
        int userBiKhoa = userDao.getSoNguoiDungBiKhoa();

        // Đóng gói gửi ra JSP
        request.setAttribute("tongSach", tongSach);
        request.setAttribute("tongUser", tongUser);
        request.setAttribute("userBiKhoa", userBiKhoa);

        request.getRequestDispatcher("/templates/admin/dashboard.jsp").forward(request, response);
    }
}