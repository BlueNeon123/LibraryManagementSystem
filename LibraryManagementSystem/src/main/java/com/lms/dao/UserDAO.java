package com.lms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.lms.config.DatabaseConnection;
import com.lms.model.User;

public class UserDAO {

    // 1. Hàm Đăng nhập 
    public User kiemTraDangNhap(String email, String matKhau) {
        String sql = "SELECT * FROM nguoi_dung WHERE email = ? AND mat_khau = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, matKhau);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(rs.getString("ma_nguoi_dung"), rs.getString("ho_ten"), 
                                rs.getString("email"), rs.getString("mat_khau"), 
                                rs.getString("vai_tro"), rs.getBoolean("trang_thai"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // 2. Lấy toàn bộ danh sách người dùng (HÀM CHUẨN ĐÃ GIỮ LẠI)
    public List<User> getAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM nguoi_dung";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps =prepareStatement(conn, sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new User(rs.getString("ma_nguoi_dung"), rs.getString("ho_ten"), 
                                  rs.getString("email"), rs.getString("mat_khau"), 
                                  rs.getString("vai_tro"), rs.getBoolean("trang_thai")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    // Helper method to prepare statement with timeout to prevent hanging
    private PreparedStatement prepareStatement(Connection conn, String sql) throws Exception{
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setQueryTimeout(10);
        return ps;
    }

    // 3. Tính tổng số người dùng (Để DashboardController hết lỗi)
    public int getTongSoNguoiDung() {
        String sql = "SELECT COUNT(*) FROM nguoi_dung";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = prepareStatement(conn, sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 4. Tính số người dùng bị khóa (Để DashboardController hết lỗi)
    public int getSoNguoiDungBiKhoa() {
        String sql = "SELECT COUNT(*) FROM nguoi_dung WHERE trang_thai = false";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = prepareStatement(conn, sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 5. Khóa / Mở khóa tài khoản (Để UserController dùng tính năng Toggle)
    public void toggleStatus(String userId) {
        String sql = "UPDATE nguoi_dung SET trang_thai = NOT trang_thai WHERE ma_nguoi_dung = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}