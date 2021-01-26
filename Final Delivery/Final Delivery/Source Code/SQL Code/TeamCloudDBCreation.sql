-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Vehicle Types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Vehicle Types` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Vehicle Types` (
  `Vehicle_Type` VARCHAR(20) NOT NULL,
  `Description` VARCHAR(45) NULL,
  PRIMARY KEY (`Vehicle_Type`),
  UNIQUE INDEX `Vehicle_Type_UNIQUE` (`Vehicle_Type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Event Type` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Event Type` (
  `Type_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(45) NOT NULL,
  `Vehicle_Recommendation` VARCHAR(20) NULL,
  PRIMARY KEY (`Type_ID`),
  UNIQUE INDEX `Description_UNIQUE` (`Description` ASC) VISIBLE,
  UNIQUE INDEX `Type_ID_UNIQUE` (`Type_ID` ASC) VISIBLE,
  INDEX `Vehicle_Recommendation_idx` (`Vehicle_Recommendation` ASC) VISIBLE,
  CONSTRAINT `Vehicle_Recommendation`
    FOREIGN KEY (`Vehicle_Recommendation`)
    REFERENCES `mydb`.`Vehicle Types` (`Vehicle_Type`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Mission` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Mission` (
  `Mission_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Leader` VARCHAR(45) NOT NULL,
  `Mission_Status` VARCHAR(45) NOT NULL,
  `Leader_Phone` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Mission_ID`),
  UNIQUE INDEX `Mission_ID_UNIQUE` (`Mission_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tickets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tickets` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tickets` (
  `Ticket_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Comments` VARCHAR(120) NULL,
  `Status` INT UNSIGNED NOT NULL,
  `Event_Type` INT UNSIGNED NOT NULL,
  `Street_Number` INT UNSIGNED NOT NULL,
  `Street_Name` VARCHAR(30) NOT NULL,
  `City` VARCHAR(20) NOT NULL,
  `State` VARCHAR(2) NOT NULL,
  `Zip_Code` INT NOT NULL,
  `Map_X_Coordinate` DOUBLE NULL,
  `Map_Y_Coordinate` DOUBLE NULL,
  `Assigned_Mission` INT UNSIGNED NULL,
  `Phone_Number` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Ticket_ID`),
  UNIQUE INDEX `Ticket_ID_UNIQUE` (`Ticket_ID` ASC) VISIBLE,
  INDEX `Event_Type_idx` (`Event_Type` ASC) VISIBLE,
  INDEX `Assigned_Mission_idx` (`Assigned_Mission` ASC) VISIBLE,
  CONSTRAINT `Event_Type`
    FOREIGN KEY (`Event_Type`)
    REFERENCES `mydb`.`Event Type` (`Type_ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `Assigned_Mission`
    FOREIGN KEY (`Assigned_Mission`)
    REFERENCES `mydb`.`Mission` (`Mission_ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Service Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Service Location` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Service Location` (
  `Service_Location_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Operations Chief` VARCHAR(45) NOT NULL,
  `OC_Phone` VARCHAR(10) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Service_Location_ID`),
  UNIQUE INDEX `Service_Location_ID_UNIQUE` (`Service_Location_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Agent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Agent` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Agent` (
  `Agent_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Service_Location_ID` INT UNSIGNED NOT NULL,
  `Assigned_Mission` INT UNSIGNED NULL,
  `Status` INT UNSIGNED NULL,
  PRIMARY KEY (`Agent_ID`),
  UNIQUE INDEX `Agent_ID_UNIQUE` (`Agent_ID` ASC) VISIBLE,
  INDEX `Service_Location_ID_idx` (`Service_Location_ID` ASC) VISIBLE,
  INDEX `Assigned_Mission_idx` (`Assigned_Mission` ASC) VISIBLE,
  CONSTRAINT `Agent_Service_Location_ID`
    FOREIGN KEY (`Service_Location_ID`)
    REFERENCES `mydb`.`Service Location` (`Service_Location_ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `Agent_Assigned_Mission`
    FOREIGN KEY (`Assigned_Mission`)
    REFERENCES `mydb`.`Mission` (`Mission_ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Vehicle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Vehicle` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Vehicle` (
  `Vehicle_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Service_Location_ID` INT UNSIGNED NOT NULL,
  `Assigned_Mission` INT UNSIGNED NULL DEFAULT 0,
  `Vehicle_Type` VARCHAR(20) NOT NULL,
  `Status` INT UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`Vehicle_ID`),
  UNIQUE INDEX `Vehicle_ID_UNIQUE` (`Vehicle_ID` ASC) VISIBLE,
  INDEX `Service_Location_ID_idx` (`Service_Location_ID` ASC) VISIBLE,
  INDEX `Assigned_Mission_idx` (`Assigned_Mission` ASC) VISIBLE,
  INDEX `Vehicle_Type_idx` (`Vehicle_Type` ASC) VISIBLE,
  CONSTRAINT `Vehicle_Service_Location_ID`
    FOREIGN KEY (`Service_Location_ID`)
    REFERENCES `mydb`.`Service Location` (`Service_Location_ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `Vehicle_Assigned_Mission`
    FOREIGN KEY (`Assigned_Mission`)
    REFERENCES `mydb`.`Mission` (`Mission_ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Vehicle_Type`
    FOREIGN KEY (`Vehicle_Type`)
    REFERENCES `mydb`.`Vehicle Types` (`Vehicle_Type`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`Vehicle Types`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Vehicle Types` (`Vehicle_Type`, `Description`) VALUES ('Firetruck', 'Fire, Misc');
INSERT INTO `mydb`.`Vehicle Types` (`Vehicle_Type`, `Description`) VALUES ('Helicopter', 'Flooding, Paramedic');
INSERT INTO `mydb`.`Vehicle Types` (`Vehicle_Type`, `Description`) VALUES ('Service_Vehicle', 'Electrical, Misc');
INSERT INTO `mydb`.`Vehicle Types` (`Vehicle_Type`, `Description`) VALUES ('Ambulance', 'Paramedic, Fire');
INSERT INTO `mydb`.`Vehicle Types` (`Vehicle_Type`, `Description`) VALUES ('Police_Vehicle', 'Fire, Electrical, Paramedic, Misc');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Event Type`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Event Type` (`Type_ID`, `Description`, `Vehicle_Recommendation`) VALUES (1, 'Fire', 'Firetruck');
INSERT INTO `mydb`.`Event Type` (`Type_ID`, `Description`, `Vehicle_Recommendation`) VALUES (2, 'Flooding', 'Helicopter');
INSERT INTO `mydb`.`Event Type` (`Type_ID`, `Description`, `Vehicle_Recommendation`) VALUES (3, 'Electrical', 'Service_Vehicle');
INSERT INTO `mydb`.`Event Type` (`Type_ID`, `Description`, `Vehicle_Recommendation`) VALUES (4, 'Paramedic', 'Ambulance');
INSERT INTO `mydb`.`Event Type` (`Type_ID`, `Description`, `Vehicle_Recommendation`) VALUES (5, 'Misc', 'Police_Vehicle');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Mission`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Mission` (`Mission_ID`, `Leader`, `Mission_Status`, `Leader_Phone`) VALUES (1, 'Mission Manager 1', 'In Progress', '4101234567');
INSERT INTO `mydb`.`Mission` (`Mission_ID`, `Leader`, `Mission_Status`, `Leader_Phone`) VALUES (2, 'Mission Manager 1', 'In Progress', '4101234567');
INSERT INTO `mydb`.`Mission` (`Mission_ID`, `Leader`, `Mission_Status`, `Leader_Phone`) VALUES (3, 'Mission Manager 1', 'In Progress', '4101234567');
INSERT INTO `mydb`.`Mission` (`Mission_ID`, `Leader`, `Mission_Status`, `Leader_Phone`) VALUES (4, 'Mission Manager 2', 'In Progress', '4431234567');
INSERT INTO `mydb`.`Mission` (`Mission_ID`, `Leader`, `Mission_Status`, `Leader_Phone`) VALUES (5, 'Mission Manager 2', 'In Progress', '4431234567');
INSERT INTO `mydb`.`Mission` (`Mission_ID`, `Leader`, `Mission_Status`, `Leader_Phone`) VALUES (6, 'Mission Manager 2', 'In Progress', '4431234567');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Tickets`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Tickets` (`Ticket_ID`, `Comments`, `Status`, `Event_Type`, `Street_Number`, `Street_Name`, `City`, `State`, `Zip_Code`, `Map_X_Coordinate`, `Map_Y_Coordinate`, `Assigned_Mission`, `Phone_Number`) VALUES (1, 'Electrical Fire', 1, 1, 8211, 'Snowden River Pkwy', 'Columbia', 'MD', 21045, 39.210330, -76.800330, 1, '1234567890');
INSERT INTO `mydb`.`Tickets` (`Ticket_ID`, `Comments`, `Status`, `Event_Type`, `Street_Number`, `Street_Name`, `City`, `State`, `Zip_Code`, `Map_X_Coordinate`, `Map_Y_Coordinate`, `Assigned_Mission`, `Phone_Number`) VALUES (2, 'Electrical Fire', 1, 3, 8211, 'Snowden River Pkwy', 'Columbia', 'MD', 21045, 39.210330, -76.800330, 1, '1234567890');
INSERT INTO `mydb`.`Tickets` (`Ticket_ID`, `Comments`, `Status`, `Event_Type`, `Street_Number`, `Street_Name`, `City`, `State`, `Zip_Code`, `Map_X_Coordinate`, `Map_Y_Coordinate`, `Assigned_Mission`, `Phone_Number`) VALUES (3, 'First Floor Flooded', 1, 2, 8700, 'Washington Blvd', 'Jessup', 'MD', 20794, 39.156490, -76.797890, 2, '2234567890');
INSERT INTO `mydb`.`Tickets` (`Ticket_ID`, `Comments`, `Status`, `Event_Type`, `Street_Number`, `Street_Name`, `City`, `State`, `Zip_Code`, `Map_X_Coordinate`, `Map_Y_Coordinate`, `Assigned_Mission`, `Phone_Number`) VALUES (4, 'Broken Bone', 1, 4, 10300, 'Little Patuxent Pkwy', 'Columbia', 'MD', 21044, 39.219261, -76.858910, 3, '3234567890');
INSERT INTO `mydb`.`Tickets` (`Ticket_ID`, `Comments`, `Status`, `Event_Type`, `Street_Number`, `Street_Name`, `City`, `State`, `Zip_Code`, `Map_X_Coordinate`, `Map_Y_Coordinate`, `Assigned_Mission`, `Phone_Number`) VALUES (5, 'Traffic Accident', 1, 5, 10160, 'Baltimore National Pike', 'Ellicott City', 'MD', 21042, 39.279750, -76.862590, 4, '4234567890');
INSERT INTO `mydb`.`Tickets` (`Ticket_ID`, `Comments`, `Status`, `Event_Type`, `Street_Number`, `Street_Name`, `City`, `State`, `Zip_Code`, `Map_X_Coordinate`, `Map_Y_Coordinate`, `Assigned_Mission`, `Phone_Number`) VALUES (6, 'Traffic Accident', 1, 4, 10160, 'Baltimore National Pike', 'Ellicott City', 'MD', 21042, 39.279750, -76.862590, 4, '4234567890');
INSERT INTO `mydb`.`Tickets` (`Ticket_ID`, `Comments`, `Status`, `Event_Type`, `Street_Number`, `Street_Name`, `City`, `State`, `Zip_Code`, `Map_X_Coordinate`, `Map_Y_Coordinate`, `Assigned_Mission`, `Phone_Number`) VALUES (7, 'Power Outtage', 1, 3, 8191, 'Westside Blvd', 'Fulton', 'MD', 20759, 39.147390, -76.908310, 5, '5234567890');
INSERT INTO `mydb`.`Tickets` (`Ticket_ID`, `Comments`, `Status`, `Event_Type`, `Street_Number`, `Street_Name`, `City`, `State`, `Zip_Code`, `Map_X_Coordinate`, `Map_Y_Coordinate`, `Assigned_Mission`, `Phone_Number`) VALUES (8, 'Traffic Light Down', 1, 3, 3881, 'Ten Oaks Rd', 'Glenelg', 'MD', 21737, 39.266340, -76.986400, 6, '6234567890');
INSERT INTO `mydb`.`Tickets` (`Ticket_ID`, `Comments`, `Status`, `Event_Type`, `Street_Number`, `Street_Name`, `City`, `State`, `Zip_Code`, `Map_X_Coordinate`, `Map_Y_Coordinate`, `Assigned_Mission`, `Phone_Number`) VALUES (9, 'Traffic Light Down', 1, 5, 3881, 'Ten Oaks Rd', 'Glenelg', 'MD', 21737, 39.266340, -76.986400, 6, '6234567890');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Service Location`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Service Location` (`Service_Location_ID`, `Operations Chief`, `OC_Phone`, `Description`) VALUES (1, 'Joe Phiremun', '1234567890', 'Fire Station');
INSERT INTO `mydb`.`Service Location` (`Service_Location_ID`, `Operations Chief`, `OC_Phone`, `Description`) VALUES (2, 'Jane Fyre', '1234567891', 'Fire Station');
INSERT INTO `mydb`.`Service Location` (`Service_Location_ID`, `Operations Chief`, `OC_Phone`, `Description`) VALUES (3, 'Johnny Storm', '1234567892', 'Fire Station');
INSERT INTO `mydb`.`Service Location` (`Service_Location_ID`, `Operations Chief`, `OC_Phone`, `Description`) VALUES (4, 'Susan Hopital', '1234567893', 'Hospital');
INSERT INTO `mydb`.`Service Location` (`Service_Location_ID`, `Operations Chief`, `OC_Phone`, `Description`) VALUES (5, 'Ben Garrett Emerson', '1234567894', 'Service Center');
INSERT INTO `mydb`.`Service Location` (`Service_Location_ID`, `Operations Chief`, `OC_Phone`, `Description`) VALUES (6, 'Jim Gordon', '1234567895', 'Police Station');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Agent`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (1, 1, 1, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (2, 1, 1, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (3, 1, 1, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (4, 1, 1, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (5, 1, 1, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (6, 1, 2, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (7, 1, 2, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (8, 1, 2, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (9, 1, 2, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (10, 1, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (11, 1, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (12, 1, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (13, 1, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (14, 1, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (15, 1, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (16, 1, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (17, 1, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (18, 1, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (19, 1, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (20, 1, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (21, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (22, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (23, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (24, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (25, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (26, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (27, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (28, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (29, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (30, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (31, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (32, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (33, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (34, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (35, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (36, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (37, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (38, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (39, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (40, 2, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (41, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (42, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (43, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (44, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (45, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (46, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (47, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (48, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (49, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (50, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (51, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (52, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (53, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (54, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (55, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (56, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (57, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (58, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (59, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (60, 3, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (61, 4, 3, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (62, 4, 3, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (63, 4, 4, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (64, 4, 4, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (65, 4, 4, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (66, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (67, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (68, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (69, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (70, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (71, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (72, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (73, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (74, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (75, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (76, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (77, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (78, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (79, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (80, 4, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (81, 5, 1, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (82, 5, 1, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (83, 5, 5, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (84, 5, 5, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (85, 5, 6, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (86, 5, 6, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (87, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (88, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (89, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (90, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (91, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (92, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (93, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (94, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (95, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (96, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (97, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (98, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (99, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (100, 5, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (101, 6, 4, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (102, 6, 4, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (103, 6, 6, 1);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (104, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (105, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (106, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (107, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (108, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (109, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (110, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (111, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (112, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (113, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (114, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (115, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (116, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (117, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (118, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (119, 6, NULL, 0);
INSERT INTO `mydb`.`Agent` (`Agent_ID`, `Service_Location_ID`, `Assigned_Mission`, `Status`) VALUES (120, 6, NULL, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Vehicle`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (1, 1, 1, 'Firetruck', 1);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (2, 1, NULL, 'Firetruck', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (3, 1, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (4, 1, 2, 'Helicopter', 1);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (5, 2, NULL, 'Firetruck', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (6, 2, NULL, 'Firetruck', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (7, 2, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (8, 2, NULL, 'Helicopter', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (9, 3, NULL, 'Firetruck', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (10, 3, NULL, 'Firetruck', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (11, 3, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (12, 3, NULL, 'Helicopter', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (13, 4, 3, 'Ambulance', 1);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (14, 4, 4, 'Ambulance', 1);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (15, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (16, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (17, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (18, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (19, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (20, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (21, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (22, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (23, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (24, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (25, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (26, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (27, 4, NULL, 'Ambulance', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (28, 4, NULL, 'Helicopter', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (29, 5, 1, 'Service_Vehicle', 1);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (30, 5, 5, 'Service_Vehicle', 1);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (31, 5, 6, 'Service_Vehicle', 1);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (32, 5, NULL, 'Service_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (33, 5, NULL, 'Service_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (34, 5, NULL, 'Service_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (35, 5, NULL, 'Service_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (36, 5, NULL, 'Service_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (37, 5, NULL, 'Service_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (38, 5, NULL, 'Service_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (39, 6, 4, 'Police_Vehicle', 1);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (40, 6, 6, 'Police_Vehicle', 1);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (41, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (42, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (43, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (44, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (45, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (46, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (47, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (48, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (49, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (50, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (51, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (52, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (53, 6, NULL, 'Police_Vehicle', 0);
INSERT INTO `mydb`.`Vehicle` (`Vehicle_ID`, `Service_Location_ID`, `Assigned_Mission`, `Vehicle_Type`, `Status`) VALUES (54, 6, NULL, 'Helicopter', 0);

COMMIT;

