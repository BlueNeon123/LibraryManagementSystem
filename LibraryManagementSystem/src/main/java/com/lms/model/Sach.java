package com.lms.model;

public class Sach {
    private String maSach;
    private String tenSach;
    private String theLoai;
    private String tacGia;

    // 1. CONSTRUCTOR MẶC ĐỊNH (Luôn nên có)
    public Sach() {
    }

    // 2. CONSTRUCTOR NHẬN 4 THAM SỐ (Chính là cái mà SachDAO đang gọi)
    public Sach(String maSach, String tenSach, String theLoai, String tacGia) {
        this.maSach = maSach;
        this.tenSach = tenSach;
        this.theLoai = theLoai;
        this.tacGia = tacGia;
    }

    // --- CÁC HÀM GETTER / SETTER ĐỂ LẤY VÀ SỬA DỮ LIỆU ---
    public String getMaSach() { return maSach; }
    public void setMaSach(String maSach) { this.maSach = maSach; }

    public String getTenSach() { return tenSach; }
    public void setTenSach(String tenSach) { this.tenSach = tenSach; }

    public String getTheLoai() { return theLoai; }
    public void setTheLoai(String theLoai) { this.theLoai = theLoai; }

    public String getTacGia() { return tacGia; }
    public void setTacGia(String tacGia) { this.tacGia = tacGia; }
}