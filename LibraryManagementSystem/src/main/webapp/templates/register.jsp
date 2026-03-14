<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow">
                <div class="card-header bg-primary text-white text-center">
                    <h3 class="mb-0">ĐĂNG KÝ THÀNH VIÊN</h3>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/dang-ky" method="POST">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Mã người dùng (Tên đăng nhập)</label>
                            <input type="text" name="maNguoiDung" class="form-control" placeholder="Ví dụ: SV001" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Họ và Tên</label>
                            <input type="text" name="hoTen" class="form-control" placeholder="Nguyễn Văn A" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Địa chỉ Email</label>
                            <input type="email" name="email" class="form-control" placeholder="nguyenvana@gmail.com" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Mật khẩu</label>
                            <input type="password" name="matKhau" class="form-control" placeholder="********" required>
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100 fw-bold">TẠO TÀI KHOẢN</button>
                    </form>
                    <hr>
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/dang-nhap" class="text-decoration-none">Đã có tài khoản? Đăng nhập ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>