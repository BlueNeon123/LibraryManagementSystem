package com.lms.model;

import java.util.List;

public class Sach {
    private String maSach; // Khóa chính (ISBN)
    private String tenSach;
    private TheLoai theLoai; // Khóa ngoại (Mối quan hệ 1-n)
    private List<TacGia> danhSachTacGia; // Khóa ngoại (Mối quan hệ n-n)
    private String anhBia;
    private String moTa;

    // 1. Hàm khởi tạo không đối số (Default Constructor)
    public Sach() {}

    // 2. Hàm khởi tạo đầy đủ đối số
    public Sach(String maSach, String tenSach, TheLoai theLoai, List<TacGia> danhSachTacGia, String anhBia, String moTa) {
        this.maSach = maSach;
        this.tenSach = tenSach;
        this.theLoai = theLoai;
        this.danhSachTacGia = danhSachTacGia;
        this.anhBia = anhBia;
        this.moTa = moTa;
    }

    // 3. Các Getter và Setter (Bắt buộc phải có để các lớp khác truy cập)
    public String getMaSach() { return maSach; }
    public void setMaSach(String maSach) { this.maSach = maSach; }

    public String getTenSach() { return tenSach; }
    public void setTenSach(String tenSach) { this.tenSach = tenSach; }

    public TheLoai getTheLoai() { return theLoai; }
    public void setTheLoai(TheLoai theLoai) { this.theLoai = theLoai; }

    public List<TacGia> getDanhSachTacGia() { return danhSachTacGia; }
    public void setDanhSachTacGia(List<TacGia> danhSachTacGia) { this.danhSachTacGia = danhSachTacGia; }

    public String getAnhBia() { return anhBia; }
    public void setAnhBia(String anhBia) { this.anhBia = anhBia; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }
}