-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Jeu 09 Février 2017 à 10:53
-- Version du serveur :  5.7.9
-- Version de PHP :  5.6.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `jeu_de_role`
--

-- --------------------------------------------------------

--
-- Structure de la table `classe`
--

DROP TABLE IF EXISTS `classe`;
CREATE TABLE IF NOT EXISTS `classe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fk_stats` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8F87BF966C6E55B5` (`nom`),
  UNIQUE KEY `UNIQ_8F87BF9696AA44DF` (`fk_stats`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `classe`
--

INSERT INTO `classe` (`id`, `nom`, `fk_stats`) VALUES
(1, 'guerrier', 6),
(2, 'magicien', 7),
(3, 'archer', 8),
(4, 'palade', 9),
(5, 'crétin', 10);

-- --------------------------------------------------------

--
-- Structure de la table `personnage`
--

DROP TABLE IF EXISTS `personnage`;
CREATE TABLE IF NOT EXISTS `personnage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pa` int(11) NOT NULL,
  `fk_stats` int(11) DEFAULT NULL,
  `fk_race` int(11) DEFAULT NULL,
  `fk_classe` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_6AEA486D96AA44DF` (`fk_stats`),
  UNIQUE KEY `UNIQ_6AEA486D56516591` (`fk_race`),
  UNIQUE KEY `UNIQ_6AEA486DAF29D706` (`fk_classe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `race`
--

DROP TABLE IF EXISTS `race`;
CREATE TABLE IF NOT EXISTS `race` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fk_stats` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_DA6FBBAF96AA44DF` (`fk_stats`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `race`
--

INSERT INTO `race` (`id`, `nom`, `fk_stats`) VALUES
(1, 'humain', 1),
(2, 'elfe', 2),
(3, 'orc', 3),
(4, 'nain', 4),
(5, 'lapin', 5);

-- --------------------------------------------------------

--
-- Structure de la table `stats`
--

DROP TABLE IF EXISTS `stats`;
CREATE TABLE IF NOT EXISTS `stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pv` int(11) NOT NULL,
  `mov` int(11) NOT NULL,
  `att` int(11) NOT NULL,
  `def` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `stats`
--

INSERT INTO `stats` (`id`, `pv`, `mov`, `att`, `def`) VALUES
(1, 1000, 4, 100, 0.15),
(2, 750, 6, 120, 0.1),
(3, 1350, 3, 150, 0.25),
(4, 1150, 2, 135, 0.38),
(5, 550, 8, 50, -0.5),
(6, 200, -1, 25, 0.1),
(7, -300, 1, 50, -0.08),
(8, -248, 2, 20, -0.04),
(9, 2000, 5, -200, 0.3),
(10, 10000, 10, 300, -0.5);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `classe`
--
ALTER TABLE `classe`
  ADD CONSTRAINT `FK_8F87BF9696AA44DF` FOREIGN KEY (`fk_stats`) REFERENCES `stats` (`id`);

--
-- Contraintes pour la table `personnage`
--
ALTER TABLE `personnage`
  ADD CONSTRAINT `FK_6AEA486D56516591` FOREIGN KEY (`fk_race`) REFERENCES `race` (`id`),
  ADD CONSTRAINT `FK_6AEA486D96AA44DF` FOREIGN KEY (`fk_stats`) REFERENCES `stats` (`id`),
  ADD CONSTRAINT `FK_6AEA486DAF29D706` FOREIGN KEY (`fk_classe`) REFERENCES `classe` (`id`);

--
-- Contraintes pour la table `race`
--
ALTER TABLE `race`
  ADD CONSTRAINT `FK_DA6FBBAF96AA44DF` FOREIGN KEY (`fk_stats`) REFERENCES `stats` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
