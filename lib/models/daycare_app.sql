-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 29 Jun 2024 pada 01.09
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `daycare_app`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `anak`
--

CREATE TABLE `anak` (
  `id` int(11) NOT NULL,
  `nama_lengkap` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') DEFAULT NULL,
  `alamat_rumah` varchar(255) DEFAULT NULL,
  `nama_darurat` varchar(100) DEFAULT NULL,
  `hubungan_darurat` varchar(50) DEFAULT NULL,
  `nomor_darurat` varchar(20) DEFAULT NULL,
  `riwayat_medis` text DEFAULT NULL,
  `id_orangtua` int(11) DEFAULT NULL,
  `id_pengasuh` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `anak`
--

INSERT INTO `anak` (`id`, `nama_lengkap`, `tanggal_lahir`, `jenis_kelamin`, `alamat_rumah`, `nama_darurat`, `hubungan_darurat`, `nomor_darurat`, `riwayat_medis`, `id_orangtua`, `id_pengasuh`) VALUES
(1, 'asd', '2024-06-28', 'Laki-laki', 'asd', 'asd', 'asd', 'asd', 'asd', 4, 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `bottle`
--

CREATE TABLE `bottle` (
  `id` int(11) NOT NULL,
  `time` varchar(50) NOT NULL,
  `ML` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `bottle`
--

INSERT INTO `bottle` (`id`, `time`, `ML`, `type`, `created_at`) VALUES
(1, '5:14 AM', 0, 'Formula', '2024-06-28 22:19:52'),
(2, '5:14 AM', 0, 'Formula', '2024-06-28 22:20:02'),
(3, '5:14 AM', 0, 'Formula', '2024-06-28 22:32:00'),
(4, '5:14 AM', 0, 'Formula', '2024-06-28 22:32:22'),
(5, '5:14 AM', 0, 'Formula', '2024-06-28 22:33:57'),
(6, '5:14 AM', 0, 'Formula', '2024-06-28 22:33:59'),
(7, '5:14 AM', 0, 'Formula', '2024-06-28 22:34:45'),
(8, '5:14 AM', 0, 'Formula', '2024-06-28 22:35:46'),
(9, '5:14 AM', 0, 'Formula', '2024-06-28 22:36:47'),
(10, '5:14 AM', 0, 'Formula', '2024-06-28 22:38:53'),
(11, '5:14 AM', 0, 'Formula', '2024-06-28 22:41:07'),
(12, '5:14 AM', 0, 'Formula', '2024-06-28 22:55:51'),
(13, '5:14 AM', 0, 'Formula', '2024-06-28 22:57:36'),
(14, '5:14 AM', 0, 'Formula', '2024-06-28 23:08:05');

-- --------------------------------------------------------

--
-- Struktur dari tabel `item`
--

CREATE TABLE `item` (
  `id` int(11) NOT NULL,
  `key` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `item`
--

INSERT INTO `item` (`id`, `key`, `quantity`) VALUES
(1, 'Diapers', 8);

-- --------------------------------------------------------

--
-- Struktur dari tabel `meals`
--

CREATE TABLE `meals` (
  `id` int(11) NOT NULL,
  `food` varchar(100) DEFAULT NULL,
  `quantity` varchar(50) DEFAULT NULL,
  `comment` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `meals`
--

INSERT INTO `meals` (`id`, `food`, `quantity`, `comment`) VALUES
(1, 'sadsdasdasdsasdasdasdadasd', 'Some', 'asdasd'),
(2, 'asdasdasdasd', 'Some', 'asdasd'),
(3, 'sad', 'none', 'asd');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pasien`
--

CREATE TABLE `pasien` (
  `id` int(11) NOT NULL,
  `nama_lengkap` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') DEFAULT NULL,
  `alamat_rumah` varchar(255) DEFAULT NULL,
  `nama_darurat` varchar(100) DEFAULT NULL,
  `hubungan_darurat` varchar(50) DEFAULT NULL,
  `nomor_darurat` varchar(20) DEFAULT NULL,
  `riwayat_medis` text DEFAULT NULL,
  `id_orangtua` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `rest`
--

CREATE TABLE `rest` (
  `id` int(11) NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `rest`
--

INSERT INTO `rest` (`id`, `start_time`, `end_time`) VALUES
(1, '04:50:00', '06:50:00'),
(2, '04:50:00', '06:50:00'),
(3, '04:50:00', '06:50:00'),
(4, '04:50:00', '06:50:00'),
(5, '04:50:00', '06:50:00'),
(6, '04:50:00', '06:50:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `shower`
--

CREATE TABLE `shower` (
  `id` int(11) NOT NULL,
  `morning_shower` varchar(50) NOT NULL,
  `evening_shower` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `shower`
--

INSERT INTO `shower` (`id`, `morning_shower`, `evening_shower`) VALUES
(1, '4:31 AM', '4:31 AM'),
(2, '4:31 AM', '4:31 AM'),
(3, '4:31 AM', '4:31 AM'),
(4, '4:31 AM', '4:31 AM');

-- --------------------------------------------------------

--
-- Struktur dari tabel `toilet`
--

CREATE TABLE `toilet` (
  `id` int(11) NOT NULL,
  `waktu` datetime DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `kondisi` varchar(100) DEFAULT NULL,
  `catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `username`, `password`) VALUES
(1, 'yosuasolissa@gmail.com', ''),
(2, 'yosuasolissa@gmail.com', ''),
(3, 'yosuasolissa@gmail.com', ''),
(4, 'yosuasolissa@gmail.com', '1234');

-- --------------------------------------------------------

--
-- Struktur dari tabel `vitamin`
--

CREATE TABLE `vitamin` (
  `id` int(11) NOT NULL,
  `vitamin_name` varchar(50) NOT NULL,
  `amount` varchar(50) NOT NULL,
  `time` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `vitamin`
--

INSERT INTO `vitamin` (`id`, `vitamin_name`, `amount`, `time`) VALUES
(1, 'aa', 'a', 'none'),
(2, 'aa', 'a', 'none');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `anak`
--
ALTER TABLE `anak`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_orangtua` (`id_orangtua`),
  ADD KEY `id_pengasuh` (`id_pengasuh`);

--
-- Indeks untuk tabel `bottle`
--
ALTER TABLE `bottle`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `meals`
--
ALTER TABLE `meals`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_orangtua` (`id_orangtua`);

--
-- Indeks untuk tabel `rest`
--
ALTER TABLE `rest`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `shower`
--
ALTER TABLE `shower`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `toilet`
--
ALTER TABLE `toilet`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `vitamin`
--
ALTER TABLE `vitamin`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `anak`
--
ALTER TABLE `anak`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `bottle`
--
ALTER TABLE `bottle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT untuk tabel `item`
--
ALTER TABLE `item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `meals`
--
ALTER TABLE `meals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `rest`
--
ALTER TABLE `rest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `shower`
--
ALTER TABLE `shower`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `toilet`
--
ALTER TABLE `toilet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `vitamin`
--
ALTER TABLE `vitamin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `anak`
--
ALTER TABLE `anak`
  ADD CONSTRAINT `anak_ibfk_1` FOREIGN KEY (`id_orangtua`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `anak_ibfk_2` FOREIGN KEY (`id_pengasuh`) REFERENCES `user` (`id`);

--
-- Ketidakleluasaan untuk tabel `pasien`
--
ALTER TABLE `pasien`
  ADD CONSTRAINT `pasien_ibfk_1` FOREIGN KEY (`id_orangtua`) REFERENCES `pasien` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
