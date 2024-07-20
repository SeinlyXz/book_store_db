-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jul 20, 2024 at 07:33 AM
-- Server version: 8.0.35
-- PHP Version: 8.2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fp_pbd_new`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `pinjam_buku` (`p_id_user` INT, `p_id_buku` INT)   BEGIN
   DECLARE tanggal_pinjam DATE;
   DECLARE tanggal_kembali DATE;
  
   -- Menetapkan tanggal pinjam dan tanggal kembali
   SET tanggal_pinjam = CURDATE();
   SET tanggal_kembali = DATE_ADD(tanggal_pinjam, INTERVAL 30 DAY);
  
   -- Mengecek ketersediaan buku
   SELECT jumlah_buku INTO @jumlah_buku
   FROM buku
   WHERE id = p_id_buku;


   IF @jumlah_buku > 0 THEN
       -- Mengurangi stok buku
       UPDATE buku
       SET jumlah_buku = jumlah_buku - 1
       WHERE id = p_id_buku;
      
       -- Mencatat data peminjaman
       INSERT INTO peminjaman (tanggal_pinjam, tanggal_kembali, ID_user, ID_buku)
       VALUES (tanggal_pinjam, tanggal_kembali, p_id_user, p_id_buku);
       SELECT 'Buku berhasil dipinjam.' AS pesan;
   ELSE
       SELECT 'Buku tidak tersedia.' AS pesan;
   END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `total_buku` () RETURNS INT READS SQL DATA BEGIN
    DECLARE jumlah INT;
    SELECT SUM(jumlah_buku) INTO jumlah FROM buku;
    RETURN jumlah;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id` int NOT NULL,
  `judul_buku` varchar(255) NOT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  `jumlah_buku` int NOT NULL,
  `ID_Genre` int DEFAULT NULL,
  `ID_penulis` int DEFAULT NULL,
  `ID_Penerbit` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id`, `judul_buku`, `deskripsi`, `jumlah_buku`, `ID_Genre`, `ID_penulis`, `ID_Penerbit`) VALUES
(1, 'Pengabdi Setan Vol. 2', 'Buku yang menceritakan seorang hantu china', 13, 1, 1, 1),
(2, 'Laskar Pelangi', 'Kisah inspiratif anak-anak di Belitung', 20, 2, 2, 2),
(3, 'Sapiens: A Brief History of Humankind', 'Sejarah umat manusia dari zaman kuno hingga modern', 9, 9, 3, 3),
(4, 'Harry Potter and the Sorcerer\'s Stone', 'Petualangan Harry Potter di dunia sihir', 25, 7, 4, 4),
(5, 'The Da Vinci Code', 'Misteri dan petualangan dalam mencari rahasia kuno', 15, 4, 5, 5),
(6, 'The Fault in Our Stars', 'Kisah cinta dua remaja penderita kanker', 12, 5, 6, 6),
(7, '1984', 'Distopia di masa depan tentang pengawasan total', 18, 6, 7, 7),
(8, 'Becoming', 'Memoar mantan ibu negara Amerika Serikat Michelle Obama', 8, 8, 8, 8),
(9, 'The Great Gatsby', 'Kehidupan glamor dan tragedi di era jazz', 14, 2, 9, 9),
(10, 'How to Win Friends and Influence People', 'Panduan dalam membangun hubungan sosial dan bisnis', 11, 10, 9, 10),
(12, 'Panduan Belajar MySQL', 'Buku ini membahas dasar-dasar MySQL dan cara penggunaannya.', 10, 1, 1, 1),
(13, 'Pemrograman Python untuk Pemula', 'Buku ini adalah panduan lengkap untuk pemrograman Python bagi pemula.', 7, 2, 2, 2),
(14, 'Kiat Sukses Menulis Novel', 'Panduan praktis untuk menulis novel yang menarik dan laris.', 5, 3, 3, 3),
(15, 'Data Science dengan R', 'Pelajari cara menggunakan R untuk analisis data dan data science.', 8, 4, 4, 1),
(16, 'Seni Berbicara di Depan Umum', 'Tips dan trik untuk menjadi pembicara yang handal di depan umum.', 12, 5, 5, 2),
(17, 'Pemrograman Java Lanjutan', 'Buku ini membahas konsep lanjutan dalam pemrograman Java.', 6, 2, 6, 3),
(18, 'Belajar Desain Grafis dengan Photoshop', 'Panduan untuk menguasai teknik dasar dan lanjutan dalam desain grafis menggunakan Photoshop.', 9, 6, 7, 1),
(19, 'Manajemen Waktu Efektif', 'Buku ini memberikan tips untuk mengelola waktu dengan lebih baik.', 11, 5, 8, 2),
(20, 'Mengenal Machine Learning', 'Buku ini memberikan pengantar tentang konsep dan aplikasi machine learning.', 10, 4, 9, 3),
(21, 'Fotografi Digital untuk Pemula', 'Panduan dasar untuk memulai hobi fotografi digital.', 7, 6, 9, 1),
(22, 'Memahami Algoritma dan Struktur Data', 'Buku ini membahas algoritma dan struktur data secara mendalam.', 15, 2, 8, 4),
(23, 'Mahir CSS dalam 30 Hari', 'Panduan praktis untuk menguasai CSS dalam waktu singkat.', 10, 7, 9, 5),
(24, 'Sistem Operasi: Konsep dan Desain', 'Pengenalan konsep dasar dan desain sistem operasi modern.', 8, 2, 8, 6),
(25, 'Statistika untuk Bisnis dan Ekonomi', 'Buku ini menjelaskan konsep statistika yang digunakan dalam bisnis dan ekonomi.', 12, 4, 6, 7),
(26, 'Belajar Kotlin untuk Android', 'Panduan lengkap untuk memulai pengembangan aplikasi Android dengan Kotlin.', 9, 2, 7, 8),
(27, 'Pengantar Jaringan Komputer', 'Dasar-dasar jaringan komputer dan cara kerjanya.', 11, 2, 7, 9),
(28, 'Psikologi Warna dalam Desain', 'Mempelajari pengaruh warna dalam desain dan psikologi.', 13, 6, 6, 5),
(29, 'SEO untuk Pemula', 'Panduan untuk mengoptimalkan situs web agar lebih mudah ditemukan di mesin pencari.', 7, 8, 4, 10),
(30, 'E-commerce: Strategi dan Implementasi', 'Buku ini membahas strategi dan implementasi e-commerce yang efektif.', 10, 9, 2, 4),
(31, 'Mengenal Kriptografi', 'Dasar-dasar kriptografi dan aplikasinya dalam keamanan informasi.', 8, 4, 1, 6),
(32, 'Teori Komunikasi Massa', 'Pengantar teori-teori komunikasi massa dan aplikasinya.', 14, 5, 1, 3),
(33, 'Belajar Swift untuk iOS', 'Panduan memulai pengembangan aplikasi iOS menggunakan Swift.', 6, 2, 1, 8),
(34, 'Dasar-dasar Mikrokontroler', 'Pengantar mikrokontroler dan aplikasinya dalam berbagai proyek.', 12, 2, 1, 7),
(35, 'Membangun Startup Sukses', 'Panduan untuk membangun dan mengembangkan startup yang sukses.', 11, 9, 1, 5),
(36, 'Analisis Data dengan Python', 'Pelajari teknik-teknik analisis data menggunakan bahasa pemrograman Python.', 13, 4, 2, 9),
(37, 'Pengantar Sosiologi', 'Dasar-dasar sosiologi dan kajian tentang masyarakat.', 15, 5, 3, 10),
(38, 'Fotografi Lanskap', 'Teknik-teknik dasar dan lanjutan dalam fotografi lanskap.', 9, 6, 9, 1),
(39, 'Kecerdasan Buatan untuk Semua Orang', 'Pengenalan konsep kecerdasan buatan dan aplikasinya dalam kehidupan sehari-hari.', 10, 4, 8, 3),
(40, 'Desain UX untuk Aplikasi Mobile', 'Panduan untuk menciptakan pengalaman pengguna yang baik dalam aplikasi mobile.', 8, 6, 8, 4),
(41, 'Manajemen Proyek IT', 'Dasar-dasar manajemen proyek dalam konteks teknologi informasi.', 7, 9, 8, 2),
(42, 'New Book', 'New description', 5, 1, 1, 1),
(43, 'New Book', 'New description', 5, 1, 1, 1),
(44, 'New Book', 'New description', 5, 1, 1, 1);

--
-- Triggers `buku`
--
DELIMITER $$
CREATE TRIGGER `after_buku_delete` AFTER DELETE ON `buku` FOR EACH ROW BEGIN
    INSERT INTO log_changes (table_name, operation, old_values)
    VALUES ('buku', 'AFTER DELETE', CONCAT('id: ', OLD.id, ', judul_buku: ', OLD.judul_buku, ', deskripsi: ', OLD.deskripsi, ', jumlah_buku: ', OLD.jumlah_buku, ', ID_Genre: ', OLD.ID_Genre, ', ID_penulis: ', OLD.ID_penulis, ', ID_Penerbit: ', OLD.ID_Penerbit));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_buku_update` AFTER UPDATE ON `buku` FOR EACH ROW BEGIN
    INSERT INTO log_changes (table_name, operation, old_values, new_values)
    VALUES ('buku', 'AFTER UPDATE', CONCAT('id: ', OLD.id, ', judul_buku: ', OLD.judul_buku, ', deskripsi: ', OLD.deskripsi, ', jumlah_buku: ', OLD.jumlah_buku, ', ID_Genre: ', OLD.ID_Genre, ', ID_penulis: ', OLD.ID_penulis, ', ID_Penerbit: ', OLD.ID_Penerbit),
                                      CONCAT('id: ', NEW.id, ', judul_buku: ', NEW.judul_buku, ', deskripsi: ', NEW.deskripsi, ', jumlah_buku: ', NEW.jumlah_buku, ', ID_Genre: ', NEW.ID_Genre, ', ID_penulis: ', NEW.ID_penulis, ', ID_Penerbit: ', NEW.ID_Penerbit));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_buku_delete` BEFORE DELETE ON `buku` FOR EACH ROW BEGIN
    INSERT INTO log_changes (table_name, operation, old_values)
    VALUES ('buku', 'BEFORE DELETE', CONCAT('id: ', OLD.id, ', judul_buku: ', OLD.judul_buku, ', deskripsi: ', OLD.deskripsi, ', jumlah_buku: ', OLD.jumlah_buku, ', ID_Genre: ', OLD.ID_Genre, ', ID_penulis: ', OLD.ID_penulis, ', ID_Penerbit: ', OLD.ID_Penerbit));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_buku_insert` BEFORE INSERT ON `buku` FOR EACH ROW BEGIN
    INSERT INTO log_changes (table_name, operation, new_values)
    VALUES ('buku', 'BEFORE INSERT', CONCAT('id: ', NEW.id, ', judul_buku: ', NEW.judul_buku, ', deskripsi: ', NEW.deskripsi, ', jumlah_buku: ', NEW.jumlah_buku, ', ID_Genre: ', NEW.ID_Genre, ', ID_penulis: ', NEW.ID_penulis, ', ID_Penerbit: ', NEW.ID_Penerbit));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_buku_update` BEFORE UPDATE ON `buku` FOR EACH ROW BEGIN
    INSERT INTO log_changes (table_name, operation, old_values, new_values)
    VALUES ('buku', 'BEFORE UPDATE', CONCAT('id: ', OLD.id, ', judul_buku: ', OLD.judul_buku, ', deskripsi: ', OLD.deskripsi, ', jumlah_buku: ', OLD.jumlah_buku, ', ID_Genre: ', OLD.ID_Genre, ', ID_penulis: ', OLD.ID_penulis, ', ID_Penerbit: ', OLD.ID_Penerbit),
                                      CONCAT('id: ', NEW.id, ', judul_buku: ', NEW.judul_buku, ', deskripsi: ', NEW.deskripsi, ', jumlah_buku: ', NEW.jumlah_buku, ', ID_Genre: ', NEW.ID_Genre, ', ID_penulis: ', NEW.ID_penulis, ', ID_Penerbit: ', NEW.ID_Penerbit));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `id` int NOT NULL,
  `nama` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`id`, `nama`) VALUES
(1, 'Horor'),
(2, 'Horor'),
(3, 'Fiksi'),
(4, 'Non-Fiksi'),
(5, 'Misteri'),
(6, 'Romansa'),
(7, 'Sci-Fi'),
(8, 'Fantasi'),
(9, 'Biografi'),
(10, 'Sejarah'),
(11, 'Self-Help');

-- --------------------------------------------------------

--
-- Stand-in structure for view `horizontal_view_buku`
-- (See below for the actual view)
--
CREATE TABLE `horizontal_view_buku` (
`id` int
,`judul_buku` varchar(255)
,`deskripsi` varchar(255)
,`ID_Genre` int
,`ID_penulis` int
,`ID_Penerbit` int
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insideview`
-- (See below for the actual view)
--
CREATE TABLE `insideview` (
`id` int
,`tanggal_pinjam` date
,`tanggal_kembali` date
,`ID_user` int
,`ID_buku` int
,`durasi` int
);

-- --------------------------------------------------------

--
-- Table structure for table `log_changes`
--

CREATE TABLE `log_changes` (
  `id` int NOT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `operation` varchar(255) DEFAULT NULL,
  `old_values` text,
  `new_values` text,
  `changed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `log_changes`
--

INSERT INTO `log_changes` (`id`, `table_name`, `operation`, `old_values`, `new_values`, `changed_at`) VALUES
(2, 'buku', 'BEFORE INSERT', NULL, 'id: 0, judul_buku: New Book, deskripsi: New description, jumlah_buku: 5, ID_Genre: 1, ID_penulis: 1, ID_Penerbit: 1', '2024-07-20 07:20:25'),
(4, 'buku', 'BEFORE INSERT', NULL, 'id: 0, judul_buku: New Book, deskripsi: New description, jumlah_buku: 5, ID_Genre: 1, ID_penulis: 1, ID_Penerbit: 1', '2024-07-20 07:21:20'),
(5, 'buku', 'BEFORE INSERT', NULL, 'id: 0, judul_buku: New Book, deskripsi: New description, jumlah_buku: 5, ID_Genre: 1, ID_penulis: 1, ID_Penerbit: 1', '2024-07-20 07:25:27');

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id` int NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_kembali` date NOT NULL,
  `ID_user` int DEFAULT NULL,
  `ID_buku` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id`, `tanggal_pinjam`, `tanggal_kembali`, `ID_user`, `ID_buku`) VALUES
(1, '2024-06-27', '2024-06-30', 1, 1),
(2, '2024-07-01', '2024-07-10', 1, 10),
(4, '2024-07-03', '2024-07-11', 3, 12),
(5, '2024-07-04', '2024-07-14', 4, 13),
(6, '2024-07-05', '2024-07-15', 5, 13),
(7, '2024-07-06', '2024-07-13', 1, 12),
(8, '2024-07-07', '2024-07-17', 2, 14),
(9, '2024-07-08', '2024-07-18', 3, 14),
(10, '2024-07-09', '2024-07-19', 4, 23),
(11, '2024-07-10', '2024-07-20', 5, 23),
(12, '2024-07-20', '2024-08-19', 1, 1),
(13, '2024-07-20', '2024-08-19', 1, 1),
(14, '2024-07-20', '2024-08-19', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `penerbits`
--

CREATE TABLE `penerbits` (
  `id` int NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nomor_penerbit` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `updated_at` date NOT NULL,
  `created_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `penerbits`
--

INSERT INTO `penerbits` (`id`, `email`, `nomor_penerbit`, `alamat`, `updated_at`, `created_at`) VALUES
(1, 'Nicolas, Roberts and Denesik', '(424) 205-4350', '1958 Zion Center\nLemkefort, FL 65223', '2024-06-27', '2024-06-27'),
(2, 'Gerlach, Miller and Collier', '1-351-446-2101', '379 Dibbert Viaduct\nBrisafurt, NE 58220-6846', '2024-06-27', '2024-06-27'),
(3, 'Bernier, Roob and Sawayn', '+1-480-758-5243', '8603 Kovacek Meadows Suite 851\nSouth Luellastad, IA 36656', '2024-06-27', '2024-06-27'),
(4, 'Ward-Lynch', '562.386.8531', '29252 Jadon Forge\nMitchellhaven, OK 11024', '2024-06-27', '2024-06-27'),
(5, 'Huels and Sons', '(956) 356-3716', '6852 Zieme Locks\nWeimannfort, AK 97300', '2024-06-27', '2024-06-27'),
(6, 'Howell, Langosh and Schmitt', '+17697742196', '75892 Abbott Rapids Suite 237\nRoderickshire, KS 35763', '2024-06-27', '2024-06-27'),
(7, 'Crona Inc', '480-713-8895', '92457 Santa Common\nNew Skylar, SD 72103', '2024-06-27', '2024-06-27'),
(8, 'Nikolaus-Hill', '+1-732-988-7164', '1486 Devon Mall\nLake Kylestad, MO 51815-4310', '2024-06-27', '2024-06-27'),
(9, 'Rempel, Hilpert and Rogahn', '(283) 897-4095', '6993 Laury Common\nJoliestad, KY 87387-6292', '2024-06-27', '2024-06-27'),
(10, 'Von Inc', '+1 (605) 903-1174', '550 Conroy Well\nConroyview, AR 68675', '2024-06-27', '2024-06-27'),
(11, 'Runte-Torphy', '+1.801.620.1055', '518 Lockman Land\nCarrollville, ND 79988', '2024-06-27', '2024-06-27');

-- --------------------------------------------------------

--
-- Table structure for table `penulis`
--

CREATE TABLE `penulis` (
  `id` int NOT NULL,
  `nama` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `penulis`
--

INSERT INTO `penulis` (`id`, `nama`) VALUES
(1, 'Seinly Ashviya'),
(2, 'Andrea Hirata'),
(3, 'Pramoedya Ananta Toer'),
(4, 'Dee Lestari'),
(5, 'Eka Kurniawan'),
(6, 'Leila S. Chudori'),
(7, 'Nh. Dini'),
(8, 'Ahmad Fuadi'),
(9, 'Ika Natassa');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `nama` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telepon` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama`, `username`, `password`, `email`, `telepon`, `status`) VALUES
(1, 'John Doe', 'johnd', 'pass123', 'john@example.com', '1234567890', 1),
(2, 'Jane Smith', 'janes', 'securepass', 'jane@example.com', '9876543210', 1),
(3, 'Alice Johnson', 'alicej', 'alicepass', 'alice@example.com', '5551234567', 1),
(4, 'Bob Wilson', 'bobw', 'bobsecret', 'bob@example.com', '7778889999', 1),
(5, 'Emma Brown', 'emmab', 'brownie123', 'emma@example.com', '3334445555', 1),
(6, 'Michael Lee', 'mikel', 'leepass456', 'michael@example.com', '6667778888', 1),
(7, 'Sarah Davis', 'sarahd', 'davispass', 'sarah@example.com', '1112223333', 1),
(8, 'David Clark', 'davidc', 'clarkpass', 'david@example.com', '4445556666', 1),
(9, 'Olivia White', 'oliviaw', 'whiteolive', 'olivia@example.com', '8889990000', 1),
(10, 'Ryan Taylor', 'ryant', 'taylorpass', 'ryan@example.com', '2223334444', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vertical_peminjaman`
-- (See below for the actual view)
--
CREATE TABLE `vertical_peminjaman` (
`id` int
,`tanggal_pinjam` date
,`tanggal_kembali` date
,`ID_user` int
,`ID_buku` int
,`durasi` int
);

-- --------------------------------------------------------

--
-- Structure for view `horizontal_view_buku`
--
DROP TABLE IF EXISTS `horizontal_view_buku`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `horizontal_view_buku`  AS SELECT `buku`.`id` AS `id`, `buku`.`judul_buku` AS `judul_buku`, `buku`.`deskripsi` AS `deskripsi`, `buku`.`ID_Genre` AS `ID_Genre`, `buku`.`ID_penulis` AS `ID_penulis`, `buku`.`ID_Penerbit` AS `ID_Penerbit` FROM `buku` ;

-- --------------------------------------------------------

--
-- Structure for view `insideview`
--
DROP TABLE IF EXISTS `insideview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `insideview`  AS SELECT `vertical_peminjaman`.`id` AS `id`, `vertical_peminjaman`.`tanggal_pinjam` AS `tanggal_pinjam`, `vertical_peminjaman`.`tanggal_kembali` AS `tanggal_kembali`, `vertical_peminjaman`.`ID_user` AS `ID_user`, `vertical_peminjaman`.`ID_buku` AS `ID_buku`, `vertical_peminjaman`.`durasi` AS `durasi` FROM `vertical_peminjaman` WHERE (`vertical_peminjaman`.`ID_user` = 1)WITH CASCADED CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `vertical_peminjaman`
--
DROP TABLE IF EXISTS `vertical_peminjaman`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vertical_peminjaman`  AS SELECT `peminjaman`.`id` AS `id`, `peminjaman`.`tanggal_pinjam` AS `tanggal_pinjam`, `peminjaman`.`tanggal_kembali` AS `tanggal_kembali`, `peminjaman`.`ID_user` AS `ID_user`, `peminjaman`.`ID_buku` AS `ID_buku`, (to_days(`peminjaman`.`tanggal_kembali`) - to_days(`peminjaman`.`tanggal_pinjam`)) AS `durasi` FROM `peminjaman` WHERE ((to_days(`peminjaman`.`tanggal_kembali`) - to_days(`peminjaman`.`tanggal_pinjam`)) > 2) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buku_genre_FK` (`ID_Genre`),
  ADD KEY `buku_penulis_FK` (`ID_penulis`),
  ADD KEY `idx_buku` (`ID_Penerbit`,`ID_penulis`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_changes`
--
ALTER TABLE `log_changes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_peminjaman_user_buku` (`ID_user`,`ID_buku`),
  ADD KEY `peminjaman_buku_FK` (`ID_buku`);

--
-- Indexes for table `penerbits`
--
ALTER TABLE `penerbits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `penerbits_unique` (`email`),
  ADD KEY `idx_penerbit` (`nomor_penerbit`,`alamat`);

--
-- Indexes for table `penulis`
--
ALTER TABLE `penulis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Username` (`username`),
  ADD UNIQUE KEY `users_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `genre`
--
ALTER TABLE `genre`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `log_changes`
--
ALTER TABLE `log_changes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `penulis`
--
ALTER TABLE `penulis`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `buku`
--
ALTER TABLE `buku`
  ADD CONSTRAINT `buku_genre_FK` FOREIGN KEY (`ID_Genre`) REFERENCES `genre` (`id`),
  ADD CONSTRAINT `buku_penerbits_FK` FOREIGN KEY (`ID_Penerbit`) REFERENCES `penerbits` (`id`),
  ADD CONSTRAINT `buku_penulis_FK` FOREIGN KEY (`ID_penulis`) REFERENCES `penulis` (`id`);

--
-- Constraints for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD CONSTRAINT `peminjaman_buku_FK` FOREIGN KEY (`ID_buku`) REFERENCES `buku` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `peminjaman_users_FK` FOREIGN KEY (`ID_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
