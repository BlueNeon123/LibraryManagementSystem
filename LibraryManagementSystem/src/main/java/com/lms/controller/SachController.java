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
    
    // ĐÂY CHÍNH LÀ DÒNG KHAI BÁO BIẾN GIÚP FIX LỖI "CANNOT BE RESOLVED"
    private SachDAO sachDAO = new SachDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Nhận lệnh từ đường link
        String action = request.getParameter("action");
        
        // ==========================================
        // CHỨC NĂNG 1: XÓA SÁCH
        // ==========================================
        if ("xoa".equals(action)) {
            String maSach = request.getParameter("maSach");
            if (maSach != null) {
                sachDAO.xoaSach(maSach); // Đã sử dụng biến sachDAO chuẩn xác
                System.out.println("LOG: Vừa xóa thành công sách mã: " + maSach);
            }
            // Xóa xong thì load lại trang
            response.sendRedirect(request.getContextPath() + "/quan-ly-sach");
            return; 
        }

        // ==========================================
        // CHỨC NĂNG 2: HIỂN THỊ DANH SÁCH
        // ==========================================
        // Đã sử dụng biến sachDAO chuẩn xác
        List<Sach> danhSach = sachDAO.layTatCaSach();
        
        request.setAttribute("listSach", danhSach);
        request.getRequestDispatcher("/templates/admin/quan_ly_sach.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Hỗ trợ tiếng Việt khi nhập form
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        // Nếu lệnh là "them" (khớp với <input type="hidden" name="action" value="them"> trên JSP)
        if ("them".equals(action)) {
            String maSach = request.getParameter("maSach");
            String tenSach = request.getParameter("tenSach");
            String theLoai = request.getParameter("theLoai");
            String tacGia = request.getParameter("tacGia");
            
            // Gói thành đối tượng Sach và gọi DAO lưu vào Database
            Sach sachMoi = new Sach(maSach, tenSach, theLoai, tacGia);
            sachDAO.themSachMoi(sachMoi);
            
            System.out.println("LOG: Đã thêm thành công sách mới: " + tenSach);
            
            // Tải lại trang để thấy sách mới xuất hiện trên bảng
            response.sendRedirect(request.getContextPath() + "/quan-ly-sach");
        }
    }
}