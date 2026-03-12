package com.lms.model;

public class User {
    private String userId;
    private String fullName;
    private String email;
    private String password;
    private String role;
    private boolean active; // Trạng thái thẻ: true (mở), false (khóa)

    // 1. Constructor mặc định
    public User() {}

    // 2. Constructor có đủ 6 tham số (Để fix lỗi dòng 12, 13, 14 ở UserDAO)
    public User(String userId, String fullName, String email, String password, String role, boolean active) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.active = active;
    }

    // --- Getter và Setter (Để fix lỗi dòng 25 ở UserDAO) ---
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

    public boolean isActive() { return active; } // Hàm kiểm tra trạng thái
    public void setActive(boolean active) { this.active = active; } // Hàm thay đổi trạng thái
}