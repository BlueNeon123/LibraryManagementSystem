-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 12, 2026 at 12:33 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quan_ly_thu_vien`
--

-- --------------------------------------------------------

--
-- Table structure for table `ban_sao_sach`
--

CREATE TABLE `ban_sao_sach` (
  `ma_vach` varchar(20) NOT NULL,
  `ma_sach` varchar(20) DEFAULT NULL,
  `trang_thai` varchar(50) DEFAULT 'SAN_SANG'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ban_sao_sach`
--

INSERT INTO `ban_sao_sach` (`ma_vach`, `ma_sach`, `trang_thai`) VALUES
('BSS-001', '978-01', 'SAN_SANG');

-- --------------------------------------------------------

--
-- Table structure for table `nguoi_dung`
--

CREATE TABLE `nguoi_dung` (
  `ma_nguoi_dung` varchar(20) NOT NULL,
  `ho_ten` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `vai_tro` varchar(20) DEFAULT 'USER',
  `trang_thai` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nguoi_dung`
--

INSERT INTO `nguoi_dung` (`ma_nguoi_dung`, `ho_ten`, `email`, `mat_khau`, `vai_tro`, `trang_thai`) VALUES
('ADMIN', 'Thủ Thư', 'admin@truong.edu.vn', '123456', 'ADMIN', 1),
('SV123456', 'Nguyên', 'nguyen@truong.edu.vn', '123', 'USER', 1);

-- --------------------------------------------------------

--
-- Table structure for table `phieu_muon`
--

CREATE TABLE `phieu_muon` (
  `ma_phieu` int(11) NOT NULL,
  `ma_nguoi_dung` varchar(50) NOT NULL,
  `ma_ban_sao` varchar(50) NOT NULL,
  `ngay_muon` date DEFAULT NULL,
  `han_tra` date DEFAULT NULL,
  `ngay_tra_thuc_te` date DEFAULT NULL,
  `trang_thai` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `phieu_muon`
--

INSERT INTO `phieu_muon` (`ma_phieu`, `ma_nguoi_dung`, `ma_ban_sao`, `ngay_muon`, `han_tra`, `ngay_tra_thuc_te`, `trang_thai`) VALUES
(6, 'SV123456', 'BSS-001', '2026-03-12', '2026-03-26', '2026-03-12', 'Đã trả'),
(7, 'SV123456', 'BSS-001', '2026-03-12', '2026-03-01', '2026-03-12', 'Đã trả');

-- --------------------------------------------------------

--
-- Table structure for table `sach`
--

CREATE TABLE `sach` (
  `ma_sach` varchar(20) NOT NULL,
  `ten_sach` varchar(255) NOT NULL,
  `the_loai` varchar(100) DEFAULT NULL,
  `tac_gia` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sach`
--

INSERT INTO `sach` (`ma_sach`, `ten_sach`, `the_loai`, `tac_gia`) VALUES
('978-01', 'Clean Code', 'Công Nghệ', 'Robert C. Martin'),
('978-02', 'Nhà Giả Kim ', 'Văn Học', 'Paulo Coelho');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ban_sao_sach`
--
ALTER TABLE `ban_sao_sach`
  ADD PRIMARY KEY (`ma_vach`),
  ADD KEY `ma_sach` (`ma_sach`);

--
-- Indexes for table `nguoi_dung`
--
ALTER TABLE `nguoi_dung`
  ADD PRIMARY KEY (`ma_nguoi_dung`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `phieu_muon`
--
ALTER TABLE `phieu_muon`
  ADD PRIMARY KEY (`ma_phieu`);

--
-- Indexes for table `sach`
--
ALTER TABLE `sach`
  ADD PRIMARY KEY (`ma_sach`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `phieu_muon`
--
ALTER TABLE `phieu_muon`
  MODIFY `ma_phieu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ban_sao_sach`
--
ALTER TABLE `ban_sao_sach`
  ADD CONSTRAINT `ban_sao_sach_ibfk_1` FOREIGN KEY (`ma_sach`) REFERENCES `sach` (`ma_sach`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
