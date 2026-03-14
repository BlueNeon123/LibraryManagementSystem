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
        
        // 1. Lấy tín hiệu từ giao diện (Tìm kiếm hoặc Thể loại)
        String tuKhoa = request.getParameter("txtSearch");
        String theLoai = request.getParameter("theLoai"); // Tín hiệu mới từ Menu Thể loại
        List<Sach> danhSach;

        // 2. Logic phân luồng xử lý
        if (theLoai != null && !theLoai.trim().isEmpty()) {
            // Luồng 1: Nếu người dùng bấm vào Menu bên trái
            danhSach = sachDAO.laySachTheoTheLoai(theLoai);
            request.setAttribute("theLoaiDangChon", theLoai); // Để lát nữa in đậm cái menu đang chọn
            
        } else if (tuKhoa != null && !tuKhoa.trim().isEmpty()) {
            // Luồng 2: Nếu người dùng gõ vào ô Tìm kiếm
            danhSach = sachDAO.timKiemSach(tuKhoa);
            request.setAttribute("tuKhoaVuaTim", tuKhoa); 
            
        } else {
            // Luồng 3: Mặc định (Vào trang chủ lần đầu) -> Lấy hết sách
            danhSach = sachDAO.layTatCaSach();
        }
        
        // 3. Lấy danh sách thể loại và gửi sang JSP để in ra Menu
        List<String> danhSachTheLoai = sachDAO.layDanhSachTheLoai();
        request.setAttribute("danhSachTheLoai", danhSachTheLoai);

        // 4. Gửi danh sách qua trang JSP (Chỉ gọi 1 LẦN DUY NHẤT)
        request.setAttribute("listSach", danhSach);
        request.getRequestDispatcher("/templates/client/trang_chu.jsp").forward(request, response);
    }
}