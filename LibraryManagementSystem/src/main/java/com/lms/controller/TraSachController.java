package com.lms.controller;

import com.lms.dao.MuonTraDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/quan-ly-tra-sach")
public class TraSachController extends HttpServlet {
    
    private MuonTraDAO muonTraDAO = new MuonTraDAO();

    // Mở trang Giao diện Nhận Trả Sách
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/templates/admin/nhan_tra_sach.jsp").forward(request, response);
    }

    // Xử lý khi Thủ thư bấm nút Xác nhận trả
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        if ("traSach".equals(action)) {
            // Lấy mã vạch từ giao diện gửi về
            String maVach = request.getParameter("maVach");
            
            // Gọi DAO xử lý trả sách và hứng kết quả tiền phạt
            double tienPhat = muonTraDAO.traSach(maVach);
            
            // Dựa vào tiền phạt để báo lỗi hoặc báo thành công ra màn hình
            if (tienPhat == -1) {
                // Lỗi: Mã vạch sai hoặc sách này chưa ai mượn
                response.sendRedirect(request.getContextPath() + "/quan-ly-tra-sach?status=error");
            } else if (tienPhat > 0) {
                // Thành công nhưng trễ hạn -> Trả về số tiền phạt để hiện lên màn hình
                response.sendRedirect(request.getContextPath() + "/quan-ly-tra-sach?status=phat&tien=" + (long)tienPhat);
            } else {
                // Trả đúng hạn, không bị phạt
                response.sendRedirect(request.getContextPath() + "/quan-ly-tra-sach?status=success");
            }
        }
    }
}