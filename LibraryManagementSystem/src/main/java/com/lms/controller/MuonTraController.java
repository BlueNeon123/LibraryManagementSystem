package com.lms.controller;

import com.lms.dao.MuonTraDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/quan-ly-muon-tra")
public class MuonTraController extends HttpServlet {
    
    private MuonTraDAO muonTraDAO = new MuonTraDAO();

    // Hàm doGet: Dùng để mở trang giao diện Mượn/Trả lên
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Trỏ đường dẫn mở đúng cái file bạn vừa đổi tên
        request.getRequestDispatcher("/templates/admin/cap_phieu_muon.jsp").forward(request, response);
    }

    // Hàm doPost: Dùng để nhận lệnh "Cho Mượn" từ thủ thư bấm trên Web
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        // Bắt đúng lệnh mượn sách
        if ("muonSach".equals(action)) {
            // Lấy thông tin từ form
            String maNguoiDung = request.getParameter("maNguoiDung");
            String maBanSao = request.getParameter("maBanSao"); 
            
            // Gọi DAO xử lý Transaction (Viết phiếu + Trừ kho)
            boolean thanhCong = muonTraDAO.muonSach(maNguoiDung, maBanSao);
            
            // Chuyển hướng kèm theo kết quả báo cáo
            if (thanhCong) {
                response.sendRedirect(request.getContextPath() + "/quan-ly-muon-tra?status=success");
            } else {
                response.sendRedirect(request.getContextPath() + "/quan-ly-muon-tra?status=error");
            }
        }
    }
}