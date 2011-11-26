-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 26, 2011 at 08:35 PM
-- Server version: 5.1.58
-- PHP Version: 5.3.6-13ubuntu3.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `wpa`
--

-- --------------------------------------------------------

--
-- Table structure for table `dicts`
--

CREATE TABLE IF NOT EXISTS `dicts` (
  `d_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dpath` varchar(256) NOT NULL,
  `dname` varchar(128) NOT NULL,
  `wcount` int(10) unsigned NOT NULL,
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`d_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `get_dict`
--
CREATE TABLE IF NOT EXISTS `get_dict` (
`d_id` bigint(20) unsigned
,`dpath` varchar(256)
);
-- --------------------------------------------------------

--
-- Table structure for table `n2d`
--

CREATE TABLE IF NOT EXISTS `n2d` (
  `net_id` bigint(15) NOT NULL,
  `d_id` int(11) NOT NULL,
  `hits` int(11) NOT NULL DEFAULT '1',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`net_id`,`d_id`),
  KEY `IDX_n2d_ts` (`ts`),
  KEY `IDX_n2d_net_id` (`net_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Triggers `n2d`
--
DROP TRIGGER IF EXISTS `TRG_n2d`;
DELIMITER //
CREATE TRIGGER `TRG_n2d` BEFORE INSERT ON `n2d`
 FOR EACH ROW BEGIN
    UPDATE nets SET hits=hits+1 WHERE nets.net_id=NEW.net_id;
    UPDATE dicts SET hits=hits+1 WHERE dicts.d_id=NEW.d_id;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `nets`
--

CREATE TABLE IF NOT EXISTS `nets` (
  `net_id` bigint(15) NOT NULL AUTO_INCREMENT,
  `nhash` binary(16) NOT NULL COMMENT 'Capture md5 hash',
  `bssid` bigint(15) unsigned NOT NULL,
  `ssid` varchar(32) NOT NULL,
  `pass` varchar(64) DEFAULT NULL,
  `ip` int(10) unsigned NOT NULL,
  `sip` int(10) unsigned DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sts` timestamp NULL DEFAULT NULL,
  `n_state` tinyint(1) unsigned NOT NULL,
  `u_id` bigint(20) DEFAULT NULL,
  `hits` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`net_id`),
  UNIQUE KEY `IDX_nets_nhash` (`nhash`),
  KEY `IDX_nets_ts` (`ts`),
  KEY `IDX_nets_ip` (`ip`),
  KEY `u_id` (`u_id`),
  KEY `IDX_nets_bssid` (`bssid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13458 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `onets`
--
CREATE TABLE IF NOT EXISTS `onets` (
`net_id` bigint(15)
,`nhash` varchar(32)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `onets_dicts`
--
CREATE TABLE IF NOT EXISTS `onets_dicts` (
`net_id` bigint(15)
,`d_id` int(11)
,`hits` int(11)
);
-- --------------------------------------------------------

--
-- Table structure for table `stats`
--

CREATE TABLE IF NOT EXISTS `stats` (
  `pname` varchar(20) NOT NULL,
  `pvalue` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`pname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `u_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ukey` char(32) NOT NULL,
  `mail` varchar(500) DEFAULT NULL,
  `ip` int(10) unsigned NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `key` (`ukey`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=126 ;

-- --------------------------------------------------------

--
-- Structure for view `get_dict`
--
DROP TABLE IF EXISTS `get_dict`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `get_dict` AS select `d`.`d_id` AS `d_id`,`d`.`dpath` AS `dpath` from (`dicts` `d` left join `onets_dicts` `od` on((`d`.`d_id` = `od`.`d_id`))) order by ifnull(`od`.`hits`,0),`d`.`wcount`;

-- --------------------------------------------------------

--
-- Structure for view `onets`
--
DROP TABLE IF EXISTS `onets`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `onets` AS select `nets`.`net_id` AS `net_id`,hex(`nets`.`nhash`) AS `nhash` from `nets` where (`nets`.`n_state` = 0) order by `nets`.`hits`,`nets`.`ts` limit 1;

-- --------------------------------------------------------

--
-- Structure for view `onets_dicts`
--
DROP TABLE IF EXISTS `onets_dicts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `onets_dicts` AS select `n2d`.`net_id` AS `net_id`,`n2d`.`d_id` AS `d_id`,`n2d`.`hits` AS `hits` from (`n2d` join `onets` `o`) where (`n2d`.`net_id` = `o`.`net_id`);

DELIMITER $$
--
-- Events
--
CREATE EVENT `e_stats` ON SCHEDULE EVERY '0 2' DAY_HOUR STARTS '2011-09-18 17:31:07' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Computes last day stats every 1h am' DO BEGIN
        UPDATE stats SET pvalue=(SELECT count(*) FROM n2d WHERE date(ts) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)) WHERE pname='24getwork';
        UPDATE stats SET pvalue=(SELECT sum(wcount) FROM n2d, dicts WHERE date(ts) = DATE_SUB(CURDATE(), INTERVAL 1 DAY) AND n2d.d_id=dicts.d_id) WHERE pname='24psk';
      END$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
