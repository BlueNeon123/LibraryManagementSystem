package com.lms.model;

import java.util.Date;

import javax.persistence.*;

@Entity
@Table(name = "phieu_muon")
public class PhieuMuon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Temporal(TemporalType.DATE)
    private Date ngayMuon;

    @Temporal(TemporalType.DATE)
    private Date hanTra;

    private String trangThai; // Ví dụ: "DANG_MUON", "DA_TRA", "QUA_HAN"

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // Nếu có phạt, 1 phiếu mượn thường gắn với 1 phiếu phạt
    @OneToOne(mappedBy = "phieuMuon", cascade = CascadeType.ALL)
    private PhieuPhat phieuPhat;

    // Getters và Setters...
}