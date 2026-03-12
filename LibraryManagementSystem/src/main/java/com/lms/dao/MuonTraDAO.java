package com.lms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.lms.config.DatabaseConnection;

public class MuonTraDAO {

    // Hàm xử lý Mượn sách (Dùng Transaction để bảo vệ dữ liệu)
    public boolean muonSach(String maNguoiDung, String maBanSao) {
        
        // Lệnh 1: Viết 1 tờ phiếu mượn (Lưu mã vạch vào cột ma_ban_sao của bảng phieu_muon)
        String sqlTaoPhieu = "INSERT INTO phieu_muon (ma_nguoi_dung, ma_ban_sao, ngay_muon, han_tra, trang_thai) "
                           + "VALUES (?, ?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 'Đang mượn')";
                           
        // Lệnh 2: Đổi trạng thái cuốn sách trong kho (ĐÃ FIX TÊN CỘT THÀNH ma_vach)
        String sqlCapNhatKho = "UPDATE ban_sao_sach SET trang_thai = 'Đã mượn' WHERE ma_vach = ?";
        
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            
            // BẬT CHẾ ĐỘ GIAO DỊCH (TRANSACTION)
            conn.setAutoCommit(false); 
            
            // Thực hiện Lệnh 1
            try (PreparedStatement ps1 = conn.prepareStatement(sqlTaoPhieu)) {
                ps1.setString(1, maNguoiDung);
                ps1.setString(2, maBanSao);
                ps1.executeUpdate();
            }
            
            // Thực hiện Lệnh 2
            try (PreparedStatement ps2 = conn.prepareStatement(sqlCapNhatKho)) {
                ps2.setString(1, maBanSao); // Truyền mã sách người dùng nhập vào đây
                ps2.executeUpdate();
            }
            
            // XÁC NHẬN LƯU VĨNH VIỄN
            conn.commit(); 
            System.out.println("LOG: Giao dịch mượn sách thành công 100%!");
            return true;
            
        } catch (Exception e) {
            System.out.println("LOG: Có lỗi xảy ra! Đang hoàn tác (Rollback) lại từ đầu...");
            try {
                if (conn != null) conn.rollback(); 
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true); 
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    // Hàm xử lý TRẢ SÁCH VÀ TÍNH TIỀN PHẠT
    // Trả về số tiền phạt (0: đúng hạn, >0: trễ hạn, -1: lỗi)
    // ========================================================
    public double traSach(String maVach) {
        double tienPhat = 0;
        long soNgayTre = 0;

        // Lệnh 1: Kiểm tra xem sách này hạn trả ngày nào, trễ bao nhiêu ngày rồi? (Dùng hàm DATEDIFF của MySQL)
        String sqlKiemTra = "SELECT han_tra, DATEDIFF(CURDATE(), han_tra) AS so_ngay_tre "
                          + "FROM phieu_muon WHERE ma_ban_sao = ? AND trang_thai = 'Đang mượn'";
                          
        // Lệnh 2: Chốt đơn Phiếu mượn thành "Đã trả"
        String sqlCapNhatPhieu = "UPDATE phieu_muon SET ngay_tra_thuc_te = CURDATE(), trang_thai = 'Đã trả' "
                               + "WHERE ma_ban_sao = ? AND trang_thai = 'Đang mượn'";
                               
        // Lệnh 3: Trả sách lại vào kho cho người khác mượn
        String sqlCapNhatKho = "UPDATE ban_sao_sach SET trang_thai = 'SAN_SANG' WHERE ma_vach = ?";

        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false); // Bắt đầu Giao dịch (Transaction)

            // Bước 1: Khám xét phiếu mượn xem có trễ không
            try (PreparedStatement psCheck = conn.prepareStatement(sqlKiemTra)) {
                psCheck.setString(1, maVach);
                ResultSet rs = psCheck.executeQuery();
                if (rs.next()) {
                    soNgayTre = rs.getLong("so_ngay_tre");
                    if (soNgayTre > 0) {
                        tienPhat = soNgayTre * 5000; // Phạt 5.000 VNĐ cho mỗi ngày trễ
                    }
                } else {
                    return -1; // Lỗi: Không tìm thấy sách này đang được mượn
                }
            }

            // Bước 2: Cập nhật Phiếu mượn
            try (PreparedStatement ps1 = conn.prepareStatement(sqlCapNhatPhieu)) {
                ps1.setString(1, maVach);
                ps1.executeUpdate();
            }

            // Bước 3: Cập nhật Kho sách
            try (PreparedStatement ps2 = conn.prepareStatement(sqlCapNhatKho)) {
                ps2.setString(1, maVach);
                ps2.executeUpdate();
            }

            conn.commit(); // Thành công rực rỡ thì lưu lại
            System.out.println("LOG: Trả sách thành công! Tiền phạt: " + tienPhat);
            return tienPhat;

        } catch (Exception e) {
            System.out.println("LOG: Lỗi khi trả sách! Đang Rollback...");
            try { if (conn != null) conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
            return -1;
        } finally {
            try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (Exception e) {}
        }
    }
}