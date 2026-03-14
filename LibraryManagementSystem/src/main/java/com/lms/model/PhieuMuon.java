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
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getNgayMuon() {
		return ngayMuon;
	}

	public void setNgayMuon(Date ngayMuon) {
		this.ngayMuon = ngayMuon;
	}

	public Date getHanTra() {
		return hanTra;
	}

	public void setHanTra(Date hanTra) {
		this.hanTra = hanTra;
	}

	public String getTrangThai() {
		return trangThai;
	}

	public void setTrangThai(String trangThai) {
		this.trangThai = trangThai;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public PhieuPhat getPhieuPhat() {
		return phieuPhat;
	}

	public void setPhieuPhat(PhieuPhat phieuPhat) {
		this.phieuPhat = phieuPhat;
	}
	
	// 2 BIẾN ẢO ĐỂ ĐẨY DỮ LIỆU RA GIAO DIỆN
    @Transient
    private String tenSach;
    @Transient
    private double tienPhat;

    public String getTenSach() {
        return tenSach;
    }

    public void setTenSach(String tenSach) {
        this.tenSach = tenSach;
    }

    public double getTienPhat() {
        return tienPhat;
    }

    public void setTienPhat(double tienPhat) {
        this.tienPhat = tienPhat;
    }
    
}