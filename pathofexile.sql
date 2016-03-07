-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 07, 2016 at 04:37 PM
-- Server version: 5.5.47-0+deb8u1
-- PHP Version: 5.6.17-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `pathofexile`
--

-- --------------------------------------------------------

--
-- Table structure for table `additionalProperties`
--

DROP TABLE IF EXISTS `additionalProperties`;
CREATE TABLE IF NOT EXISTS `additionalProperties` (
`id` int(11) NOT NULL,
  `itemID` varchar(100) NOT NULL,
  `progress` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `displayMode` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7037 DEFAULT CHARSET=utf8 COMMENT='Additional properties.';

--
-- RELATIONS FOR TABLE `additionalProperties`:
--   `itemID`
--       `items` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `additionalPropertiesValues`
--

DROP TABLE IF EXISTS `additionalPropertiesValues`;
CREATE TABLE IF NOT EXISTS `additionalPropertiesValues` (
  `additionalPropertyID` int(11) NOT NULL,
  `value` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Properties values.';

--
-- RELATIONS FOR TABLE `additionalPropertiesValues`:
--   `additionalPropertyID`
--       `additionalProperties` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `cosmeticMods`
--

DROP TABLE IF EXISTS `cosmeticMods`;
CREATE TABLE IF NOT EXISTS `cosmeticMods` (
  `itemID` varchar(100) NOT NULL,
  `cosmeticMod` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item explicit mods.';

--
-- RELATIONS FOR TABLE `cosmeticMods`:
--   `itemID`
--       `items` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `craftedMods`
--

DROP TABLE IF EXISTS `craftedMods`;
CREATE TABLE IF NOT EXISTS `craftedMods` (
  `itemID` varchar(100) NOT NULL,
  `craftedMod` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item explicit mods.';

--
-- RELATIONS FOR TABLE `craftedMods`:
--   `itemID`
--       `items` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `explicitMods`
--

DROP TABLE IF EXISTS `explicitMods`;
CREATE TABLE IF NOT EXISTS `explicitMods` (
  `itemID` varchar(100) NOT NULL,
  `explicitMod` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item explicit mods.';

--
-- RELATIONS FOR TABLE `explicitMods`:
--   `itemID`
--       `items` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `flavourText`
--

DROP TABLE IF EXISTS `flavourText`;
CREATE TABLE IF NOT EXISTS `flavourText` (
  `itemID` varchar(100) NOT NULL,
  `flavourText` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item flavour texts.';

--
-- RELATIONS FOR TABLE `flavourText`:
--   `itemID`
--       `items` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `implicitMods`
--

DROP TABLE IF EXISTS `implicitMods`;
CREATE TABLE IF NOT EXISTS `implicitMods` (
  `itemID` varchar(100) NOT NULL,
  `implicitMod` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item explicit mods.';

--
-- RELATIONS FOR TABLE `implicitMods`:
--   `itemID`
--       `items` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `itemNotes`
--

DROP TABLE IF EXISTS `itemNotes`;
CREATE TABLE IF NOT EXISTS `itemNotes` (
  `id` varchar(100) NOT NULL,
  `note` varchar(250) NOT NULL,
  `noteDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Historical record of item notes.';

--
-- RELATIONS FOR TABLE `itemNotes`:
--   `id`
--       `items` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `stashTabID` varchar(100) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `w` int(11) NOT NULL,
  `h` int(11) NOT NULL,
  `ilvl` int(11) NOT NULL,
  `icon` varchar(500) NOT NULL,
  `support` tinyint(1) NOT NULL,
  `league` varchar(250) NOT NULL,
  `id` varchar(100) NOT NULL,
  `name` varchar(250) NOT NULL,
  `typeLine` varchar(250) NOT NULL,
  `identified` tinyint(1) NOT NULL,
  `corrupted` tinyint(1) NOT NULL,
  `lockedToCharacter` tinyint(1) NOT NULL,
  `frameType` int(11) NOT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `inventoryId` varchar(250) DEFAULT NULL,
  `note` varchar(500) DEFAULT NULL,
  `descrText` varchar(500) DEFAULT NULL,
  `secDescrText` varchar(500) DEFAULT NULL,
  `talismanTier` int(11) DEFAULT NULL,
  `artFilename` varchar(500) DEFAULT NULL,
  `duplicated` tinyint(1) DEFAULT NULL,
  `parentID` varchar(100) DEFAULT NULL,
  `colour` varchar(250) DEFAULT NULL,
  `socket` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Items.';

--
-- RELATIONS FOR TABLE `items`:
--   `stashTabID`
--       `publicStashTabs` -> `id`
--   `parentID`
--       `items` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `nextLevelRequirements`
--

DROP TABLE IF EXISTS `nextLevelRequirements`;
CREATE TABLE IF NOT EXISTS `nextLevelRequirements` (
`id` int(11) NOT NULL,
  `itemID` varchar(100) NOT NULL,
  `name` varchar(250) NOT NULL,
  `displayMode` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=375 DEFAULT CHARSET=utf8 COMMENT='Item properties.';

--
-- RELATIONS FOR TABLE `nextLevelRequirements`:
--   `itemID`
--       `items` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `nextLevelRequirementsValues`
--

DROP TABLE IF EXISTS `nextLevelRequirementsValues`;
CREATE TABLE IF NOT EXISTS `nextLevelRequirementsValues` (
  `nextLevelRequirementID` int(11) NOT NULL,
  `value` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Properties values.';

--
-- RELATIONS FOR TABLE `nextLevelRequirementsValues`:
--   `nextLevelRequirementID`
--       `nextLevelRequirements` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
CREATE TABLE IF NOT EXISTS `properties` (
`id` int(11) NOT NULL,
  `itemID` varchar(100) NOT NULL,
  `name` varchar(250) NOT NULL,
  `displayMode` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=132459 DEFAULT CHARSET=utf8 COMMENT='Item properties.';

--
-- RELATIONS FOR TABLE `properties`:
--   `itemID`
--       `items` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `propertiesValues`
--

DROP TABLE IF EXISTS `propertiesValues`;
CREATE TABLE IF NOT EXISTS `propertiesValues` (
  `propertyID` int(11) NOT NULL,
  `value` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Properties values.';

--
-- RELATIONS FOR TABLE `propertiesValues`:
--   `propertyID`
--       `properties` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `publicStashTabs`
--

DROP TABLE IF EXISTS `publicStashTabs`;
CREATE TABLE IF NOT EXISTS `publicStashTabs` (
  `accountName` varchar(100) NOT NULL,
  `lastCharacterName` varchar(100) NOT NULL,
  `id` varchar(100) NOT NULL,
  `stash` varchar(100) NOT NULL,
  `public` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Public stash tabs.';

-- --------------------------------------------------------

--
-- Table structure for table `requirements`
--

DROP TABLE IF EXISTS `requirements`;
CREATE TABLE IF NOT EXISTS `requirements` (
`id` int(11) NOT NULL,
  `itemID` varchar(100) NOT NULL,
  `name` varchar(250) NOT NULL,
  `displayMode` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=118790 DEFAULT CHARSET=utf8 COMMENT='Item properties.';

--
-- RELATIONS FOR TABLE `requirements`:
--   `itemID`
--       `items` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `requirementsValues`
--

DROP TABLE IF EXISTS `requirementsValues`;
CREATE TABLE IF NOT EXISTS `requirementsValues` (
  `requirementID` int(11) NOT NULL,
  `value` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Properties values.';

--
-- RELATIONS FOR TABLE `requirementsValues`:
--   `requirementID`
--       `requirements` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `sockets`
--

DROP TABLE IF EXISTS `sockets`;
CREATE TABLE IF NOT EXISTS `sockets` (
  `itemID` varchar(100) NOT NULL,
  `group` int(11) NOT NULL,
  `attr` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item sockets.';

--
-- RELATIONS FOR TABLE `sockets`:
--   `itemID`
--       `items` -> `id`
--

--
-- Indexes for dumped tables
--

--
-- Indexes for table `additionalProperties`
--
ALTER TABLE `additionalProperties`
 ADD PRIMARY KEY (`id`), ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `additionalPropertiesValues`
--
ALTER TABLE `additionalPropertiesValues`
 ADD KEY `propertyID` (`additionalPropertyID`);

--
-- Indexes for table `cosmeticMods`
--
ALTER TABLE `cosmeticMods`
 ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `craftedMods`
--
ALTER TABLE `craftedMods`
 ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `explicitMods`
--
ALTER TABLE `explicitMods`
 ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `flavourText`
--
ALTER TABLE `flavourText`
 ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `implicitMods`
--
ALTER TABLE `implicitMods`
 ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `itemNotes`
--
ALTER TABLE `itemNotes`
 ADD UNIQUE KEY `id` (`id`,`noteDate`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
 ADD PRIMARY KEY (`id`), ADD KEY `stashTabID` (`stashTabID`), ADD KEY `parentID` (`parentID`);

--
-- Indexes for table `nextLevelRequirements`
--
ALTER TABLE `nextLevelRequirements`
 ADD PRIMARY KEY (`id`), ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `nextLevelRequirementsValues`
--
ALTER TABLE `nextLevelRequirementsValues`
 ADD KEY `propertyID` (`nextLevelRequirementID`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
 ADD PRIMARY KEY (`id`), ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `propertiesValues`
--
ALTER TABLE `propertiesValues`
 ADD KEY `propertyID` (`propertyID`);

--
-- Indexes for table `publicStashTabs`
--
ALTER TABLE `publicStashTabs`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `requirements`
--
ALTER TABLE `requirements`
 ADD PRIMARY KEY (`id`), ADD KEY `itemID` (`itemID`);

--
-- Indexes for table `requirementsValues`
--
ALTER TABLE `requirementsValues`
 ADD KEY `propertyID` (`requirementID`);

--
-- Indexes for table `sockets`
--
ALTER TABLE `sockets`
 ADD KEY `itemID` (`itemID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `additionalProperties`
--
ALTER TABLE `additionalProperties`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7037;
--
-- AUTO_INCREMENT for table `nextLevelRequirements`
--
ALTER TABLE `nextLevelRequirements`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=375;
--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=132459;
--
-- AUTO_INCREMENT for table `requirements`
--
ALTER TABLE `requirements`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=118790;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `additionalProperties`
--
ALTER TABLE `additionalProperties`
ADD CONSTRAINT `additionalProperties_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `additionalPropertiesValues`
--
ALTER TABLE `additionalPropertiesValues`
ADD CONSTRAINT `additionalPropertiesValues_ibfk_1` FOREIGN KEY (`additionalPropertyID`) REFERENCES `additionalProperties` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cosmeticMods`
--
ALTER TABLE `cosmeticMods`
ADD CONSTRAINT `cosmeticMods_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `craftedMods`
--
ALTER TABLE `craftedMods`
ADD CONSTRAINT `craftedMods_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `explicitMods`
--
ALTER TABLE `explicitMods`
ADD CONSTRAINT `explicitMods_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `flavourText`
--
ALTER TABLE `flavourText`
ADD CONSTRAINT `flavourText_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `implicitMods`
--
ALTER TABLE `implicitMods`
ADD CONSTRAINT `implicitMods_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `itemNotes`
--
ALTER TABLE `itemNotes`
ADD CONSTRAINT `itemNotes_ibfk_1` FOREIGN KEY (`id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`stashTabID`) REFERENCES `publicStashTabs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `items_ibfk_2` FOREIGN KEY (`parentID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nextLevelRequirements`
--
ALTER TABLE `nextLevelRequirements`
ADD CONSTRAINT `nextLevelRequirements_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nextLevelRequirementsValues`
--
ALTER TABLE `nextLevelRequirementsValues`
ADD CONSTRAINT `nextLevelRequirementsValues_ibfk_1` FOREIGN KEY (`nextLevelRequirementID`) REFERENCES `nextLevelRequirements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `properties`
--
ALTER TABLE `properties`
ADD CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `propertiesValues`
--
ALTER TABLE `propertiesValues`
ADD CONSTRAINT `propertiesValues_ibfk_1` FOREIGN KEY (`propertyID`) REFERENCES `properties` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requirements`
--
ALTER TABLE `requirements`
ADD CONSTRAINT `requirements_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requirementsValues`
--
ALTER TABLE `requirementsValues`
ADD CONSTRAINT `requirementsValues_ibfk_1` FOREIGN KEY (`requirementID`) REFERENCES `requirements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sockets`
--
ALTER TABLE `sockets`
ADD CONSTRAINT `sockets_ibfk_1` FOREIGN KEY (`itemID`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

