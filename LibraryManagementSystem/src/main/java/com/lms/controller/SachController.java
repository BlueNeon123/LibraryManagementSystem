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
                sachDAO.xoaSach(maSach);
            }
            response.sendRedirect(request.getContextPath() + "/quan-ly-sach");
            return; 
        }

        // ==========================================
        // CHỨC NĂNG 2: MỞ FORM SỬA
        // ==========================================
        if ("sua".equals(action)) {
            String maSach = request.getParameter("maSach");
            // Lưu ý: Dùng đúng tên hàm trong SachDAO của bạn là laySachTheoMa
            Sach sachCanSua = sachDAO.laySachTheoMa(maSach); 
            request.setAttribute("sach", sachCanSua);
            request.getRequestDispatcher("/templates/admin/sua_sach.jsp").forward(request, response);
            return; 
        }

        // ==========================================
        // CHỨC NĂNG 3: HIỂN THỊ DANH SÁCH & TÌM KIẾM (MỚI FIX Ở ĐÂY)
        // ==========================================
        String tuKhoa = request.getParameter("txtSearch"); // Lấy chữ từ ô tìm kiếm
        List<Sach> danhSach;

        // Nếu có gõ chữ vào ô tìm kiếm (tuKhoa không null và không rỗng)
        if (tuKhoa != null && !tuKhoa.trim().isEmpty()) {
            danhSach = sachDAO.timKiemSach(tuKhoa); // Gọi hàm tìm kiếm
            System.out.println("LOG: Đang lọc sách theo từ khóa: " + tuKhoa);
            request.setAttribute("tuKhoaVuaTim", tuKhoa); // Gửi ngược lại để hiện trên ô tìm kiếm
        } 
        // Nếu không gõ gì thì hiện tất cả
        else {
            danhSach = sachDAO.layTatCaSach();
        }
        
        request.setAttribute("listSach", danhSach);
        request.getRequestDispatcher("/templates/admin/quan_ly_sach.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Hỗ trợ tiếng Việt khi nhập form
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        // ==========================================
        // CHỨC NĂNG 4: THÊM SÁCH MỚI
        // ==========================================
        if ("them".equals(action)) {
            String maSach = request.getParameter("maSach");
            String tenSach = request.getParameter("tenSach");
            String theLoai = request.getParameter("theLoai");
            String tacGia = request.getParameter("tacGia");
            
            Sach sachMoi = new Sach(maSach, tenSach, theLoai, tacGia);
            sachDAO.themSachMoi(sachMoi);
            System.out.println("LOG: Đã thêm thành công sách mới: " + tenSach);
            
            response.sendRedirect(request.getContextPath() + "/quan-ly-sach");
            return;
        }

        // ==========================================
        // CHỨC NĂNG 5: LƯU CẬP NHẬT SÁCH (MỚI THÊM)
        // ==========================================
        if ("capnhat".equals(action)) {
            String maSach = request.getParameter("maSach"); // Mã sách bị ẩn readonly trên form
            String tenSach = request.getParameter("tenSach");
            String theLoai = request.getParameter("theLoai");
            String tacGia = request.getParameter("tacGia");
            
            Sach sachSua = new Sach(maSach, tenSach, theLoai, tacGia);
            sachDAO.capNhatSach(sachSua); // Gọi DAO để update Database
            System.out.println("LOG: Đã cập nhật thành công sách mã: " + maSach);
            
            response.sendRedirect(request.getContextPath() + "/quan-ly-sach");
            return;
        }
    }
}