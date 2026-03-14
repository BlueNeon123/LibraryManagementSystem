package com.lms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.lms.config.DatabaseConnection;
import com.lms.model.User;

public class UserDAO {

    // 1. Hàm Đăng nhập (Lấy đầy đủ 8 thông tin để dùng cho Profile)
    public User kiemTraDangNhap(String email, String matKhau) {
        String sql = "SELECT * FROM nguoi_dung WHERE email = ? AND mat_khau = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, matKhau);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                    rs.getString("ma_nguoi_dung"), 
                    rs.getString("ho_ten"), 
                    rs.getString("email"), 
                    rs.getString("mat_khau"), 
                    rs.getString("vai_tro"), 
                    rs.getBoolean("trang_thai"),
                    rs.getString("dien_thoai"), // Cột mới thêm
                    rs.getString("lop")         // Cột mới thêm
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null; 
    }

    // 2. Lấy toàn bộ danh sách người dùng (Đã cập nhật lên 8 tham số)
    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM nguoi_dung";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = taoPreparedStatement(conn, sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new User(
                    rs.getString("ma_nguoi_dung"), 
                    rs.getString("ho_ten"), 
                    rs.getString("email"), 
                    rs.getString("mat_khau"), 
                    rs.getString("vai_tro"), 
                    rs.getBoolean("trang_thai"),
                    rs.getString("dien_thoai"),
                    rs.getString("lop")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 3. Cập nhật thông tin hồ sơ (Dùng cho ProfileController)
    public boolean updateProfile(User user) {
        String sql = "UPDATE nguoi_dung SET ho_ten = ?, dien_thoai = ?, lop = ? WHERE ma_nguoi_dung = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getDienThoai());
            ps.setString(3, user.getLop());
            ps.setString(4, user.getUserId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // --- CÁC HÀM THỐNG KÊ DASHBOARD ---

    public int getTongSoNguoiDung() {
        String sql = "SELECT COUNT(*) FROM nguoi_dung";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = taoPreparedStatement(conn, sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getSoNguoiDungBiKhoa() {
        String sql = "SELECT COUNT(*) FROM nguoi_dung WHERE trang_thai = false";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = taoPreparedStatement(conn, sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // --- CÁC HÀM QUẢN TRỊ ---

    public void toggleStatus(String userId) {
        String sql = "UPDATE nguoi_dung SET trang_thai = NOT trang_thai WHERE ma_nguoi_dung = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
    
    public boolean themNguoiDung(String maNguoiDung, String hoTen, String email, String matKhau) {
        String sql = "INSERT INTO nguoi_dung (ma_nguoi_dung, ho_ten, email, mat_khau, vai_tro, trang_thai) VALUES (?, ?, ?, ?, 'USER', true)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maNguoiDung);
            ps.setString(2, hoTen);
            ps.setString(3, email);
            ps.setString(4, matKhau);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // Hàm phụ trợ giúp chuẩn hóa câu lệnh (Fix lỗi treo DB)
    private PreparedStatement taoPreparedStatement(Connection conn, String sql) throws Exception{
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setQueryTimeout(10);
        return ps;
    }
}