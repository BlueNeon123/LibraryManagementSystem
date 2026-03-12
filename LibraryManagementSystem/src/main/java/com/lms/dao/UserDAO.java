package com.lms.dao;

import com.lms.model.User;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static List<User> listUser = new ArrayList<>();

    static {
        // Dữ liệu mẫu để test giao diện
        listUser.add(new User("SV001", "Nguyễn Hữu Nhân", "nhan@gmail.com", "123", "USER", true));
        listUser.add(new User("SV002", "Trần Văn Quang", "quang@gmail.com", "123", "USER", false));
        listUser.add(new User("ADMIN", "Thủ Thư", "admin@truong.edu.vn", "123456", "ADMIN", true));
    }

    public List<User> getAll() {
        return listUser;
    }

    // Hàm đảo ngược trạng thái: Đang hoạt động -> Khóa và ngược lại
    public void toggleStatus(String userId) {
        for (User u : listUser) {
            if (u.getUserId().equals(userId)) {
                u.setActive(!u.isActive());
                break;
            }
        }
    }
    public int getTongSoNguoiDung() {
        return listUser.size();
    }

    public int getSoNguoiDungBiKhoa() {
        int count = 0;
        for(User u : listUser) {
            if(!u.isActive()) count++;
        }
        return count;
    }
}