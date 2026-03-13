package com.lms.controller;

import com.lms.dao.SachDAO;
import com.lms.model.Sach;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/trang-chu")
public class TrangChuController extends HttpServlet {
    
    private SachDAO sachDAO = new SachDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Xử lý tìm kiếm (nếu có)
        String tuKhoa = request.getParameter("txtSearch");
        List<Sach> danhSach;

        if (tuKhoa != null && !tuKhoa.trim().isEmpty()) {
            danhSach = sachDAO.timKiemSach(tuKhoa);
            request.setAttribute("tuKhoaVuaTim", tuKhoa); // Giữ lại từ khóa trên ô tìm kiếm
        } else {
            danhSach = sachDAO.layTatCaSach();
        }

        // 2. Gửi danh sách qua trang JSP
        request.setAttribute("listSach", danhSach);
        request.getRequestDispatcher("/templates/client/trang_chu.jsp").forward(request, response);
    }
}