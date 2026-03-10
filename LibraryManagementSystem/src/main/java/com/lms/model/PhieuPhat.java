package com.lms.model;

import javax.persistence.*;

@Entity
@Table(name = "phieu_phat")
public class PhieuPhat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Double soTienPhat;
    private String lyDo;

    @OneToOne
    @JoinColumn(name = "phieu_muon_id")
    private PhieuMuon phieuMuon;

    // Getters và Setters...
}