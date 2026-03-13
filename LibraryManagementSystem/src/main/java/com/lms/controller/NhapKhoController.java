package com.lms.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// Đây chính là cái tên đường link mà bạn gọi trên web
@WebServlet("/nhap-kho")
public class NhapKhoController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Khi người ta gọi /nhap-kho, Controller này sẽ mở file nhap_kho.jsp lên
        request.getRequestDispatcher("/templates/admin/nhap_kho.jsp").forward(request, response);
    }
}