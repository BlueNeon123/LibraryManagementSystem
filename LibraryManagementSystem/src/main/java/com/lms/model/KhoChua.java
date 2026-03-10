package com.lms.model;

import java.util.ArrayList; // Thiếu cái này sẽ bị lỗi ArrayList
import java.util.List;      // Đã có nhưng cần đảm bảo đúng package

public class KhoChua {
    // Khai báo danh sách sách
    private List<Sach> danhSachSach;

    // Constructor: Khởi tạo danh sách để tránh lỗi NullPointerException
    public KhoChua() {
        this.danhSachSach = new ArrayList<>();
    }

    // Thêm sách mới vào kho
    public void themSach(Sach sach) {
        if (sach != null) {
            danhSachSach.add(sach);
            System.out.println("Đã nhập sách: " + sach.getTenSach() + " vào kho.");
        }
    }

    // Xóa sách dựa trên mã sách (ISBN)
    public boolean xoaSach(String maSach) {
        // Trả về true nếu xóa thành công, false nếu không tìm thấy mã
        return danhSachSach.removeIf(s -> s.getMaSach().equalsIgnoreCase(maSach));
    }

    // Hiển thị toàn bộ sách trong kho
    public void hienThiKho() {
        if (danhSachSach == null || danhSachSach.isEmpty()) {
            System.out.println("Kho hiện tại đang trống!");
        } else {
            System.out.println("---------- DANH SÁCH SÁCH TRONG KHO ----------");
            for (Sach s : danhSachSach) {
                // Lưu ý: Lớp Sach cần ghi đè (Override) phương thức toString() 
                // để hiển thị đẹp hơn thay vì mã hash
                System.out.println(s); 
            }
            System.out.println("----------------------------------------------");
        }
    }

    // Tìm kiếm sách theo tên (Tính năng bổ sung hữu ích)
    public void timKiemTheoTen(String ten) {
        System.out.println("Kết quả tìm kiếm cho: " + ten);
        danhSachSach.stream()
            .filter(s -> s.getTenSach().toLowerCase().contains(ten.toLowerCase()))
            .forEach(System.out::println);
    }

    // Getter và Setter
    public List<Sach> getDanhSachSach() {
        return danhSachSach;
    }

    public void setDanhSachSach(List<Sach> danhSachSach) {
        this.danhSachSach = danhSachSach;
    }
}