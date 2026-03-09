package com.lms.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // Thông tin cấu hình MySQL (Thành viên 4 sẽ đổi lại cho khớp máy cá nhân)
    private static final String URL = "jdbc:mysql://localhost:3306/quan_ly_thu_vien";
    private static final String USER = "root"; 
    private static final String PASS = "";     

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASS);
            System.out.println("Kết nối Database thành công!");
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Lỗi kết nối Database!");
            e.printStackTrace();
        }
        return conn;
    }
}