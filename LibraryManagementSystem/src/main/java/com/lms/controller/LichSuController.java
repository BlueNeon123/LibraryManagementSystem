package com.lms.controller;

import com.lms.dao.MuonTraDAO;
import com.lms.model.User;
import com.lms.model.PhieuMuon; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/lich-su-muon")
public class LichSuController extends HttpServlet {
    
    private MuonTraDAO muonTraDAO = new MuonTraDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Kiểm tra xem người dùng đã đăng nhập chưa
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("userLogin");
        
        if (currentUser == null) {
            // Chưa đăng nhập thì đá về trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
            return;
        }
        
        // 2. Lấy mã người dùng để truy vấn lịch sử
        String maNguoiDung = currentUser.getUserId();
        
        try {

            List<PhieuMuon> danhSachPhieu = muonTraDAO.layLichSuMuon(maNguoiDung);
            
            // 3. Gửi danh sách qua cho JSP in ra màn hình
            request.setAttribute("listPhieu", danhSachPhieu);
            
            // Tạm thời mở giao diện lên trước (khi nào có DAO thì mở comment 2 dòng trên)
            request.getRequestDispatcher("/templates/client/lich_su_muon.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/trang-chu?error=sys");
        }
    }
}