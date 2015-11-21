-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 18 Nov 2015 pada 09.58
-- Versi Server: 5.6.26
-- PHP Version: 5.5.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `futsal`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `booking`
--

CREATE TABLE IF NOT EXISTS `booking` (
  `id_book` int(11) NOT NULL,
  `id_penyewa` int(11) NOT NULL,
  `id_penyedia` int(11) NOT NULL,
  `jam_mulai_booking` time NOT NULL,
  `jam_selesai_booking` time NOT NULL,
  `booking_fee` bigint(20) NOT NULL,
  `status_accept` enum('1','0') NOT NULL,
  `tgl_booking` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `booking`
--

INSERT INTO `booking` (`id_book`, `id_penyewa`, `id_penyedia`, `jam_mulai_booking`, `jam_selesai_booking`, `booking_fee`, `status_accept`, `tgl_booking`) VALUES
(1, 1, 1, '14:00:00', '16:00:00', 25000, '1', '2015-11-14'),
(2, 2, 1, '13:00:00', '14:00:00', 15000, '1', '2015-11-14');

-- --------------------------------------------------------

--
-- Struktur dari tabel `chat`
--

CREATE TABLE IF NOT EXISTS `chat` (
  `id_chat` int(11) NOT NULL,
  `dari` int(11) NOT NULL,
  `ke` int(11) NOT NULL,
  `msg` varchar(160) NOT NULL,
  `waktu` time NOT NULL,
  `tgl` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `chat`
--

INSERT INTO `chat` (`id_chat`, `dari`, `ke`, `msg`, `waktu`, `tgl`) VALUES
(1, 1, 2, 'test', '05:26:15', '2015-11-18'),
(2, 2, 1, 'iya', '17:19:44', '2015-11-18'),
(3, 1, 2, 'hahah', '04:25:00', '2015-11-18'),
(4, 2, 1, 'hihihi', '04:28:00', '2015-11-18'),
(5, 1, 2, 'WOKWOKOWKWOWKWOKW, mantep njeg!', '04:30:00', '2015-11-18'),
(6, 1, 3, 'ini dari 1 ke 3', '09:00:00', '2015-11-18'),
(7, 3, 1, 'ini dari 3 ke 1', '09:30:00', '2015-11-18'),
(8, 4, 1, 'hallo, ini dari user ke 4', '08:13:00', '2015-11-18'),
(9, 5, 1, 'Hallo ini dari user ke 5', '07:00:00', '2015-11-18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `infojadwal_booking`
--

CREATE TABLE IF NOT EXISTS `infojadwal_booking` (
  `id_info` int(11) NOT NULL,
  `id_penyedia` int(11) NOT NULL,
  `jam` int(11) NOT NULL,
  `status` enum('terima','tolak','hangus') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `lapangan`
--

CREATE TABLE IF NOT EXISTS `lapangan` (
  `id_lapangan` int(11) NOT NULL,
  `id_penyedia` int(11) NOT NULL,
  `foto_lapangan` varchar(255) NOT NULL,
  `status` enum('1','0') NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `lapangan`
--

INSERT INTO `lapangan` (`id_lapangan`, `id_penyedia`, `foto_lapangan`, `status`) VALUES
(1, 1, 'foto1.png', '1'),
(2, 1, 'foto2.png', '1'),
(3, 1, 'foto1.png', '1'),
(4, 1, 'foto2.png', '1'),
(5, 1, 'foto2.png', '1');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penyedia`
--

CREATE TABLE IF NOT EXISTS `penyedia` (
  `id_penyedia` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `nama_penyedia` varchar(250) NOT NULL,
  `alamat` text NOT NULL,
  `kota` varchar(255) NOT NULL,
  `harga` bigint(20) NOT NULL,
  `foto` text NOT NULL,
  `aktif` enum('1','0') NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `penyedia`
--

INSERT INTO `penyedia` (`id_penyedia`, `id_user`, `nama_penyedia`, `alamat`, `kota`, `harga`, `foto`, `aktif`) VALUES
(1, 3, 'Gadok Futsal', 'Jl. Cengkeh No.5, Beji, Kota Depok, Jawa Barat 16424, Indonesia', 'bogor', 60000, 'gadok.png', '1'),
(2, 4, 'Sintya Futsal', 'Jl.Gas Alam', 'depok', 80000, 'sintya.png', '1'),
(3, 6, 'Liber Futsal', 'Jl. Margonda Raya, Pancoran MAS, Kota Depok, Jawa Barat 16431, Indonesia', 'depok', 80000, 'ada.png', '1');

-- --------------------------------------------------------

--
-- Struktur dari tabel `team`
--

CREATE TABLE IF NOT EXISTS `team` (
  `id_team` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `nama_team` varchar(255) NOT NULL,
  `ava_team` varchar(255) NOT NULL,
  `telp_team` bigint(20) NOT NULL,
  `jml_pemain_team` int(11) NOT NULL,
  `kota` varchar(150) NOT NULL,
  `email` varchar(250) NOT NULL,
  `banned` enum('0','1') NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `team`
--

INSERT INTO `team` (`id_team`, `id_user`, `nama_team`, `ava_team`, `telp_team`, `jml_pemain_team`, `kota`, `email`, `banned`) VALUES
(1, 1, 'NK Developer Team', 'ionic.png', 21975881979, 12, 'Depok', 'nkdev@gmail.com', '0'),
(2, 2, 'Gang Kapak', 'man.png', 127489789, 15, 'Depok', 'ggkapak@gmail.com', '0'),
(3, 5, 'xiaomi team', 'icon.jpg', 897284718, 12, 'Depok', 'xiaomi@gnail.xom', '0'),
(4, 7, 'Titit FC', 'default.png', 89653967913, 20, 'Depok', 'atsuko.aditia@gmail.com', '0'),
(5, 8, 'NK Develooper', 'default.png', 71982748989, 15, 'Depok', 'nakudevs@gmail.com', '0'),
(6, 9, 'Kampret Team', 'default.png', 789124789, 19, 'Depok', 'kampret@gmail.com', '0');

-- --------------------------------------------------------

--
-- Struktur dari tabel `timeline`
--

CREATE TABLE IF NOT EXISTS `timeline` (
  `id_tl` int(11) NOT NULL,
  `id_team` int(11) NOT NULL,
  `foto` text NOT NULL,
  `caption` varchar(255) NOT NULL,
  `tgl_post` datetime NOT NULL,
  `status` enum('1','0') NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `timeline`
--

INSERT INTO `timeline` (`id_tl`, `id_team`, `foto`, `caption`, `tgl_post`, `status`) VALUES
(1, 1, 'foto1.png', 'Ini text untuk caption nantinya disini', '2015-11-14 06:28:23', '1'),
(2, 2, 'profile-bg.jpg', 'Text caption 2', '2015-11-14 11:16:00', '1'),
(3, 3, 'profile-bg.jpg', 'Hahahahahah', '0000-00-00 00:00:00', '1');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('penyedia','penyewa') NOT NULL,
  `aktif` enum('1','0') NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `status`, `aktif`) VALUES
(1, 'nkdevs', 'nkdevs', 'penyewa', '1'),
(2, 'ggkapak', 'ggkapak', 'penyewa', '1'),
(3, 'sintya', 'sintya', 'penyedia', '1'),
(4, 'gadok', 'gadok', 'penyedia', '1'),
(5, 'xiaomi', 'ziaomi', 'penyewa', '1'),
(6, 'libero', 'liberofutsal', 'penyedia', '1'),
(7, 'menthoelsr', 'goodgame', 'penyewa', '1'),
(8, 'nk', 'nkdev', 'penyewa', '1'),
(9, 'kampret', 'kk', 'penyewa', '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id_book`),
  ADD KEY `id_book` (`id_book`),
  ADD KEY `id_penyedia` (`id_penyedia`),
  ADD KEY `id_penyewa` (`id_penyewa`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id_chat`);

--
-- Indexes for table `infojadwal_booking`
--
ALTER TABLE `infojadwal_booking`
  ADD PRIMARY KEY (`id_info`);

--
-- Indexes for table `lapangan`
--
ALTER TABLE `lapangan`
  ADD PRIMARY KEY (`id_lapangan`);

--
-- Indexes for table `penyedia`
--
ALTER TABLE `penyedia`
  ADD PRIMARY KEY (`id_penyedia`),
  ADD KEY `id_penyedia` (`id_penyedia`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id_team`);

--
-- Indexes for table `timeline`
--
ALTER TABLE `timeline`
  ADD PRIMARY KEY (`id_tl`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id_book` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `id_chat` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `infojadwal_booking`
--
ALTER TABLE `infojadwal_booking`
  MODIFY `id_info` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `lapangan`
--
ALTER TABLE `lapangan`
  MODIFY `id_lapangan` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `penyedia`
--
ALTER TABLE `penyedia`
  MODIFY `id_penyedia` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `id_team` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `timeline`
--
ALTER TABLE `timeline`
  MODIFY `id_tl` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
