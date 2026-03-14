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
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Double getSoTienPhat() {
		return soTienPhat;
	}

	public void setSoTienPhat(Double soTienPhat) {
		this.soTienPhat = soTienPhat;
	}

	public String getLyDo() {
		return lyDo;
	}

	public void setLyDo(String lyDo) {
		this.lyDo = lyDo;
	}

	public PhieuMuon getPhieuMuon() {
		return phieuMuon;
	}

	public void setPhieuMuon(PhieuMuon phieuMuon) {
		this.phieuMuon = phieuMuon;
	}
}