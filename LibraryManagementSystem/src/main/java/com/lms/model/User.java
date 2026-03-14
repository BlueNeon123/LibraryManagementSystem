package com.lms.model;

public class User {
    private String userId;
    private String fullName;
    private String email;
    private String password;
    private String role;
    private boolean active; // Trạng thái thẻ: true (mở), false (khóa)
    private String dienThoai; // MỚI THÊM
    private String lop;       // MỚI THÊM

    // 1. Constructor mặc định
    public User() {}

    // 2. Constructor có đủ 8 tham số (Đã cập nhật thêm điện thoại và lớp)
    public User(String userId, String fullName, String email, String password, String role, boolean active, String dienThoai, String lop) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.active = active;
        this.dienThoai = dienThoai;
        this.lop = lop;
    }

    // --- Getter và Setter ---
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public boolean isActive() { return active; } 
    public void setActive(boolean active) { this.active = active; }

    public String getDienThoai() { return dienThoai; } // MỚI
    public void setDienThoai(String dienThoai) { this.dienThoai = dienThoai; } // MỚI

    public String getLop() { return lop; } // MỚI
    public void setLop(String lop) { this.lop = lop; } // MỚI
}