package com.lms.dao;

import com.lms.model.Sach;
import java.util.ArrayList;
import java.util.List;

public class SachDAO {
    private static List<Sach> khoSach = new ArrayList<>();

    static {
        // Dữ liệu mẫu
        khoSach.add(new Sach("978-01", "Clean Code", "Công Nghệ", "Robert C. Martin"));
        khoSach.add(new Sach("978-02", "Nhà Giả Kim", "Văn Học", "Paulo Coelho"));
    }

    public List<Sach> layTatCaSach() { return khoSach; }

    public void themSachMoi(Sach s) { khoSach.add(s); }

    public void xoaSach(String ma) {
        khoSach.removeIf(s -> s.getMaSach().equals(ma));
    }

    public Sach laySachTheoMa(String ma) {
        return khoSach.stream().filter(s -> s.getMaSach().equals(ma)).findFirst().orElse(null);
    }

    public void capNhatSach(Sach s) {
        for (int i = 0; i < khoSach.size(); i++) {
            if (khoSach.get(i).getMaSach().equals(s.getMaSach())) {
                khoSach.set(i, s);
                break;
            }
        }
    }

    // HÀM TÌM KIẾM (Để fix lỗi dòng 36 của bạn)
    public List<Sach> timKiemSach(String tuKhoa) {
        List<Sach> kq = new ArrayList<>();
        for (Sach s : khoSach) {
            if (s.getTenSach().toLowerCase().contains(tuKhoa.toLowerCase())) {
                kq.add(s);
            }
        }
        return kq;
    }
    public int getTongSoSach() {
        return khoSach.size();
    }
}