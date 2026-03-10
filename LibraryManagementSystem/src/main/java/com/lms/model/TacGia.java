package com.lms.model;

public class TacGia {
    private int maTacGia;
    private String tenTacGia;

    // Constructor không tham số (Bắt buộc cho Hibernate/Mapping)
    public TacGia() {}

    // Constructor đầy đủ
    public TacGia(int maTacGia, String tenTacGia) {
        this.maTacGia = maTacGia;
        this.tenTacGia = tenTacGia;
    }

    // Getters và Setters
    public int getMaTacGia() { return maTacGia; }
    public void setMaTacGia(int maTacGia) { this.maTacGia = maTacGia; }
    
    public String getTenTacGia() { return tenTacGia; }
    public void setTenTacGia(String tenTacGia) { this.tenTacGia = tenTacGia; }
}