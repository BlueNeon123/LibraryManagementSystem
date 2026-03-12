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

@WebServlet("/quan-ly-sach")
public class SachController extends HttpServlet {
    private SachDAO sachDao = new SachDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        
        String action = request.getParameter("action");
        String maSach = request.getParameter("maSach");

        if ("xoa".equals(action)) {
            sachDao.xoaSach(maSach);
            response.sendRedirect(request.getContextPath() + "/quan-ly-sach");
        } else if ("sua".equals(action)) {
            Sach s = sachDao.laySachTheoMa(maSach);
            request.setAttribute("sach", s);
            request.getRequestDispatcher("/templates/admin/sua_sach.jsp").forward(request, response);
        } else {
            // XỬ LÝ TÌM KIẾM HOẶC HIỂN THỊ
            String tuKhoa = request.getParameter("txtSearch");
            List<Sach> danhSach;
            if (tuKhoa != null && !tuKhoa.trim().isEmpty()) {
                danhSach = sachDao.timKiemSach(tuKhoa);
            } else {
                danhSach = sachDao.layTatCaSach();
            }
            request.setAttribute("listSach", danhSach);
            request.getRequestDispatcher("/templates/admin/quan_ly_sach.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        Sach s = new Sach(
            request.getParameter("maSach"),
            request.getParameter("tenSach"),
            request.getParameter("theLoai"),
            request.getParameter("tacGia")
        );

        if ("update".equals(action)) {
            sachDao.capNhatSach(s);
        } else {
            sachDao.themSachMoi(s);
        }
        response.sendRedirect(request.getContextPath() + "/quan-ly-sach");
    }
}