-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 10, 2013 at 05:44 PM
-- Server version: 5.5.32-0ubuntu0.12.04.1
-- PHP Version: 5.3.10-1ubuntu3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `wpa`
--

--
-- Dumping data for table `dicts`
--

INSERT INTO `dicts` (`d_id`, `dpath`, `dhash`, `dname`, `wcount`, `hits`) VALUES
(1, 'http://sec.stanev.org/dict/cow.txt.gz', '��*�o�����b', 'CoW', 930799, 36712),
(2, 'http://sec.stanev.org/dict/insidepro.txt.gz', '	)�<O�r�Ĵ[-�', 'InsidePro', 7788990, 17971),
(3, 'http://sec.stanev.org/dict/openwall.txt.gz', '���G��V"], %Nk�', 'OpenWall', 1148496, 36593),
(4, 'http://sec.stanev.org/dict/os.txt.gz', 'Es�����^r`�q���', 'Offensive Security', 34036913, 0),
(6, 'http://sec.stanev.org/dict/old_gold.txt.gz', 'E�wx��g�;�{��p', 'Old gold', 1560177, 36577),
(5, 'http://wpa-sec.stanev.org/dict/cracked.txt.gz', '��0X��� ��ܞ���', 'C-nets', 3647, 44273),
(7, 'http://sec.stanev.org/dict/wp.txt.gz', '��?o���,���t0', 'Wikipedia en', 5925979, 19461),
(8, 'http://sec.stanev.org/dict/ud.txt.gz', '��V%''�T��Q�9�r=', 'Slang', 510315, 40249),
(9, 'http://sec.stanev.org/dict/wpchit_bg.txt.gz', 'u��`LY[!w>��]F�', 'wp_chit bg', 1318313, 36582),
(10, 'http://sec.stanev.org/dict/wp_de.txt.gz', '=��R,�Z�7�w2�~', 'Wikipedia de', 5429072, 34689),
(11, 'http://sec.stanev.org/dict/wp_es.txt.gz', '����:͎+)''��=/', 'Wikipedia es', 1528843, 36578),
(12, 'http://sec.stanev.org/dict/wp_fr.txt.gz', '��F����)��}HX1', 'Wikipedia fr', 1294686, 36592),
(13, 'http://sec.stanev.org/dict/wp_ru.txt.gz', '���ެ�"�)��	�', 'Wikipedia ru', 2574086, 36565),
(14, 'http://sec.stanev.org/dict/used.txt.gz', '�ȴ����B�ěN�s�', 'Used', 9062908, 11435),
(15, 'http://sec.stanev.org/dict/pinyin.txt.gz', '��F6N''��YX��=�', 'Pinyin chinese', 61479, 44385);

--
-- Dumping data for table `stats`
--

INSERT INTO `stats` (`pname`, `pvalue`) VALUES
('nets', '49643'),
('cracked', '5543'),
('24getwork', '5899'),
('24psk', '123818461'),
('24sub', '4190'),
('words', '3227004402300'),
('triedwords', '949470772220');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
