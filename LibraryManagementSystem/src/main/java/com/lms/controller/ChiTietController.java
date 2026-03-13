package com.lms.controller;

import com.lms.dao.SachDAO;
import com.lms.model.Sach;
import com.lms.model.User; // Đã thêm import User
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // Đã thêm import Session
import java.io.IOException;

@WebServlet("/chi-tiet")
public class ChiTietController extends HttpServlet {
    
    private SachDAO sachDAO = new SachDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Lấy mã sách từ URL (ví dụ: ?maSach=978-01)
        String maSach = request.getParameter("maSach");
        
        if (maSach != null) {
            // 2. Dùng hàm laySachTheoMa đã có sẵn từ hôm qua để lấy thông tin
            Sach sach = sachDAO.laySachTheoMa(maSach);
            
            if (sach != null) {
                // 3. Gửi sách sang trang JSP
                request.setAttribute("sach", sach);
                request.getRequestDispatcher("/templates/client/chi_tiet_sach.jsp").forward(request, response);
                return;
            }
        }
        
        // Nếu mã sách bị sai hoặc không tìm thấy, đá người dùng về lại trang chủ
        response.sendRedirect(request.getContextPath() + "/trang-chu");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("muon_sach".equals(action)) {
            String maSach = request.getParameter("maSach");
            
            // ==========================================================
            // LOGIC KIỂM TRA ĐĂNG NHẬP (LẤY TỪ SESSION)
            // ==========================================================
            HttpSession session = request.getSession();
            User nguoiDung = (User) session.getAttribute("userLogin");
            
            // Nếu chưa đăng nhập (Session rỗng) -> Đá văng ra trang Login
            if (nguoiDung == null) {
                response.sendRedirect(request.getContextPath() + "/dang-nhap");
                return; // Dừng hàm ngay lập tức, không cho mượn
            }
            
            // Nếu đã đăng nhập, rút mã sinh viên thật từ trong Session ra
            String maNguoiDung = nguoiDung.getUserId();
            // ==========================================================

            String maBanSaoRanh = null;
            
            try (java.sql.Connection conn = com.lms.config.DatabaseConnection.getConnection()) {
                
                // BƯỚC 1: TÌM 1 BẢN SAO ĐANG RẢNH (Dùng ma_vach và trạng thái SAN_SANG)
                String sqlTimSach = "SELECT ma_vach FROM ban_sao_sach WHERE ma_sach = ? AND trang_thai = 'SAN_SANG' LIMIT 1";
                try (java.sql.PreparedStatement psTim = conn.prepareStatement(sqlTimSach)) {
                    psTim.setString(1, maSach);
                    java.sql.ResultSet rs = psTim.executeQuery();
                    if (rs.next()) {
                        maBanSaoRanh = rs.getString("ma_vach"); // Lấy mã vạch ra
                    }
                }
                
                // BƯỚC 2: NẾU TÌM THẤY SÁCH RẢNH -> TẠO PHIẾU MƯỢN
                if (maBanSaoRanh != null) {
                    // Bảng phieu_muon dùng cột ma_ban_sao
                    String sqlMuon = "INSERT INTO phieu_muon (ma_nguoi_dung, ma_ban_sao, ngay_muon, trang_thai) VALUES (?, ?, CURDATE(), 'CHO_DUYET')";
                    try (java.sql.PreparedStatement psMuon = conn.prepareStatement(sqlMuon)) {
                        psMuon.setString(1, maNguoiDung); // MÃ NGƯỜI DÙNG THẬT SỰ Ở ĐÂY NÈ!
                        psMuon.setString(2, maBanSaoRanh);
                        psMuon.executeUpdate();
                        
                        // Cập nhật lại kho: Đổi SAN_SANG thành DANG_GIU_CHO
                        String sqlCapNhatKho = "UPDATE ban_sao_sach SET trang_thai = 'DANG_GIU_CHO' WHERE ma_vach = ?";
                        try (java.sql.PreparedStatement psUpdate = conn.prepareStatement(sqlCapNhatKho)) {
                            psUpdate.setString(1, maBanSaoRanh);
                            psUpdate.executeUpdate();
                        }
                    }
                    
                    // Báo thành công xanh lá
                    response.sendRedirect(request.getContextPath() + "/chi-tiet?maSach=" + maSach + "&success=true");
                } else {
                    // Báo lỗi đỏ (hết sách)
                    response.sendRedirect(request.getContextPath() + "/chi-tiet?maSach=" + maSach + "&error=hethang");
                }
                
            } catch (Exception e) { 
                e.printStackTrace(); 
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().println("<h3>Lỗi Database:</h3><p>" + e.getMessage() + "</p>");
            }
        }
    }
}