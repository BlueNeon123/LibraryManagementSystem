package com.lms.model;

import javax.persistence.*; // Thư viện để làm việc với Database

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_name", nullable = false)
    private String userName;

    private String password;

    // Hàm khởi tạo (Constructor) không tham số
    public User() {}

    // Các hàm Getter và Setter (Để các lớp khác có thể truy cập dữ liệu)
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
}