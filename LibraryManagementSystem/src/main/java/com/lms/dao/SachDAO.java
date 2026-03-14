package com.lms.dao;

import com.lms.config.DatabaseConnection;
import com.lms.model.Sach;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SachDAO {

    // 1. Lấy toàn bộ danh sách sách từ database
    public List<Sach> layTatCaSach() {
        List<Sach> list = new ArrayList<>();
        String sql = "SELECT * FROM sach";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Sach(rs.getString("ma_sach"), rs.getString("ten_sach"), 
                                  rs.getString("the_loai"), rs.getString("tac_gia"), rs.getString("hinh_anh")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 2. Thêm sách mới
    public void themSachMoi(Sach s) {
        String sql = "INSERT INTO sach (ma_sach, ten_sach, the_loai, tac_gia, hinh_anh) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getMaSach());
            ps.setString(2, s.getTenSach());
            ps.setString(3, s.getTheLoai());
            ps.setString(4, s.getTacGia());
            ps.setString(5, s.getHinhAnh());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // 3. XÓA SÁCH THEO MÁ (ĐÃ FIX LỖI KHÓA NGOẠI MYSQL)
    public void xoaSach(String ma) {
        // Phải xóa các cuốn sách vật lý nằm trong kho trước
        String sqlXoaBanSao = "DELETE FROM ban_sao_sach WHERE ma_sach = ?";
        // Rồi mới xóa thông tin đầu sách
        String sqlXoaSach = "DELETE FROM sach WHERE ma_sach = ?";
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Chạy lệnh 1
            try (PreparedStatement ps1 = conn.prepareStatement(sqlXoaBanSao)) {
                ps1.setString(1, ma);
                ps1.executeUpdate();
            }
            // Chạy lệnh 2
            try (PreparedStatement ps2 = conn.prepareStatement(sqlXoaSach)) {
                ps2.setString(1, ma);
                ps2.executeUpdate();
            }
        } catch (Exception e) { 
            System.out.println("Lỗi khóa ngoại khi xóa sách!");
            e.printStackTrace(); 
        }
    }
    
    // 4. Lấy tổng số sách (để hiển thị lên Dashboard)
    public int getTongSoSach() {
        String sql = "SELECT COUNT(*) FROM sach";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
    
    // 5. Lấy thông tin 1 cuốn sách theo Mã (Dùng cho chức năng Sửa sách)
    public Sach laySachTheoMa(String maSach) {
        String sql = "SELECT * FROM sach WHERE ma_sach = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maSach);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Sach(rs.getString("ma_sach"), rs.getString("ten_sach"), 
                                rs.getString("the_loai"), rs.getString("tac_gia"), rs.getString("hinh_anh"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // 6. Tìm kiếm sách theo tên hoặc tác giả
 // 6. Tìm kiếm sách theo tên, tác giả hoặc thể loại (Đã nâng cấp)
    public List<Sach> timKiemSach(String tuKhoa) {
        List<Sach> list = new ArrayList<>();
        // Bác sĩ đã chèn thêm cái nòng "OR the_loai LIKE ?" vào đây
        String sql = "SELECT * FROM sach WHERE ten_sach LIKE ? OR tac_gia LIKE ? OR the_loai LIKE ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            // Nạp đạn cho cả 3 nòng
            ps.setString(1, "%" + tuKhoa + "%");
            ps.setString(2, "%" + tuKhoa + "%");
            ps.setString(3, "%" + tuKhoa + "%"); 
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Sach(
                    rs.getString("ma_sach"), 
                    rs.getString("ten_sach"), 
                    rs.getString("the_loai"), 
                    rs.getString("tac_gia"), 
                    rs.getString("hinh_anh")
                ));
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return list;
    }

    // 7. Hàm Cập nhật (Sửa) thông tin sách
    public void capNhatSach(Sach s) {
        String sql = "UPDATE sach SET ten_sach = ?, the_loai = ?, tac_gia = ?, hinh_anh = ? WHERE ma_sach = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, s.getTenSach());
            ps.setString(2, s.getTheLoai());
            ps.setString(3, s.getTacGia());
            ps.setString(4, s.getHinhAnh());
            ps.setString(5, s.getMaSach()); 
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
    
 // 8. Hàm lấy thông tin 1 cuốn sách dựa vào mã
    public Sach getSachById(String maSach) {
        String sql = "SELECT * FROM sach WHERE ma_sach = ?"; // Nhớ đổi tên cột cho đúng với Database của bạn
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maSach);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Sửa lại các tham số này cho khớp với Constructor Sach() của bạn nhé
                return new Sach(
                    rs.getString("ma_sach"),
                    rs.getString("ten_sach"),
                    rs.getString("the_loai"),
                    rs.getString("tac_gia"),
                    rs.getString("hinh_anh")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
 // 9 Đếm số lượng bản sao đang rảnh trong kho
    public int demSoSachSanSang(String maSach) {
        String sql = "SELECT COUNT(*) FROM ban_sao_sach WHERE ma_sach = ? AND trang_thai = 'SAN_SANG'";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maSach);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
 // 10. Lọc sách theo thể loại (Dùng LIKE để tìm tương đối, ví dụ "Công nghệ" sẽ khớp với "Công nghệ thông tin")
    public List<Sach> laySachTheoTheLoai(String theLoai) {
        List<Sach> list = new ArrayList<>();
        String sql = "SELECT * FROM sach WHERE the_loai LIKE ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            // Thêm dấu % vào 2 đầu để tìm kiếm chứa từ khóa
            ps.setString(1, "%" + theLoai + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Sach(rs.getString("ma_sach"), rs.getString("ten_sach"), 
                                  rs.getString("the_loai"), rs.getString("tac_gia"), rs.getString("hinh_anh")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
 // 11. Lấy danh sách các thể loại duy nhất đang có trong Database
    public List<String> layDanhSachTheLoai() {
        List<String> list = new ArrayList<>();
        // Lệnh DISTINCT giúp gom các sách cùng thể loại lại thành 1 dòng duy nhất
        String sql = "SELECT DISTINCT the_loai FROM sach WHERE the_loai IS NOT NULL AND the_loai != ''";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString("the_loai"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}