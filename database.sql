-- phpMyAdmin SQL Dump
-- version 4.0.6deb1
-- http://www.phpmyadmin.net
--
-- Machine: localhost
-- Genereertijd: 06 mrt 2014 om 14:07
-- Serverversie: 5.5.35-0ubuntu0.13.10.2
-- PHP-versie: 5.5.3-1ubuntu2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databank: `c7185zrc_isis`
--
CREATE DATABASE IF NOT EXISTS `c7185zrc_isis` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `c7185zrc_isis`;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `admins`
--

CREATE TABLE IF NOT EXISTS `admins` (
  `login` char(50) DEFAULT NULL,
  `password` char(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Website login';

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `ap_info`
--

CREATE TABLE IF NOT EXISTS `ap_info` (
  `wifi_network` varchar(33) NOT NULL,
  `caption` varchar(50) NOT NULL,
  `quality` tinyint(4) DEFAULT NULL,
  `channel` tinyint(4) DEFAULT NULL,
  `mac_adress` varchar(20) NOT NULL DEFAULT '',
  `encryption` varchar(50) DEFAULT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `wifi_key` varchar(80) DEFAULT NULL,
  `manufac` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`wifi_network`,`caption`,`mac_adress`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='latin1_swedish_ci';

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `assignments`
--

CREATE TABLE IF NOT EXISTS `assignments` (
  `assignments_id` int(11) NOT NULL AUTO_INCREMENT,
  `assignment` varchar(50) NOT NULL DEFAULT '',
  `status` varchar(50) DEFAULT '',
  `caption` varchar(50) NOT NULL,
  `parameter` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`assignments_id`),
  KEY `FK_units` (`caption`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='latin1_swedish_ci' AUTO_INCREMENT=1003 ;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `passwords`
--

CREATE TABLE IF NOT EXISTS `passwords` (
  `login` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '0',
  `website` varchar(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`login`,`password`,`website`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `probed_networks`
--

CREATE TABLE IF NOT EXISTS `probed_networks` (
  `MAC` varchar(20) NOT NULL,
  `SSID` varchar(50) NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MAC`,`SSID`,`Timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='latin1_swedish_ci';

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `target_devices`
--

CREATE TABLE IF NOT EXISTS `target_devices` (
  `MAC` varchar(20) NOT NULL,
  `location` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Hostname` varchar(50) DEFAULT NULL,
  `manufac` varchar(30) NOT NULL DEFAULT '',
  `associated_ap` varchar(20) NOT NULL,
  `info` text,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`MAC`,`timestamp`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='latin1_swedish_ci' AUTO_INCREMENT=108 ;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `units`
--

CREATE TABLE IF NOT EXISTS `units` (
  `caption` varchar(50) NOT NULL DEFAULT 'pi',
  `location` varchar(50) NOT NULL,
  `time_added` timestamp NULL DEFAULT NULL,
  `last_seen` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `caption` (`caption`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Beperkingen voor gedumpte tabellen
--

--
-- Beperkingen voor tabel `assignments`
--
ALTER TABLE `assignments`
  ADD CONSTRAINT `FK_units` FOREIGN KEY (`caption`) REFERENCES `units` (`caption`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
