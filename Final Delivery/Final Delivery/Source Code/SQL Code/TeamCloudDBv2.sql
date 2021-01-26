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
-- Table `mydb`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Users` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `User_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Role` VARCHAR(45) NULL DEFAULT NULL,
  `Phone_Number` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  UNIQUE INDEX `User_ID_UNIQUE` (`User_ID` ASC) VISIBLE,
  UNIQUE INDEX `Phone_Number_UNIQUE` (`Phone_Number` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Mission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Mission` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Mission` (
  `Mission_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Manager` VARCHAR(45) NOT NULL,
  `Mission_Status` VARCHAR(45) NOT NULL,
  `Associated_User` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Mission_ID`),
  UNIQUE INDEX `Mission_ID_UNIQUE` (`Mission_ID` ASC) VISIBLE,
  INDEX `Associated User_idx` (`Associated_User` ASC) VISIBLE,
  CONSTRAINT `Associated Manger User ID`
    FOREIGN KEY (`Associated_User`)
    REFERENCES `mydb`.`Users` (`User_ID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Service Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Service Location` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Service Location` (
  `Service_Location_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Operations Chief` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `Associated_User` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Service_Location_ID`),
  UNIQUE INDEX `Service_Location_ID_UNIQUE` (`Service_Location_ID` ASC) VISIBLE,
  INDEX `AssociatedUser_idx` (`Associated_User` ASC) VISIBLE,
  CONSTRAINT `Associated OC User ID`
    FOREIGN KEY (`Associated_User`)
    REFERENCES `mydb`.`Users` (`User_ID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Agent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Agent` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Agent` (
  `Agent_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Service_Location_ID` INT UNSIGNED NOT NULL,
  `Assigned_Mission` INT UNSIGNED NULL DEFAULT NULL,
  `Status` INT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`Agent_ID`),
  UNIQUE INDEX `Agent_ID_UNIQUE` (`Agent_ID` ASC) VISIBLE,
  INDEX `Service_Location_ID_idx` (`Service_Location_ID` ASC) VISIBLE,
  INDEX `Assigned_Mission_idx` (`Assigned_Mission` ASC) VISIBLE,
  CONSTRAINT `Agent_Assigned_Mission`
    FOREIGN KEY (`Assigned_Mission`)
    REFERENCES `mydb`.`Mission` (`Mission_ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Agent_Service_Location_ID`
    FOREIGN KEY (`Service_Location_ID`)
    REFERENCES `mydb`.`Service Location` (`Service_Location_ID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 121
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Vehicle Types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Vehicle Types` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Vehicle Types` (
  `Vehicle_Type` VARCHAR(20) NOT NULL,
  `Description` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Vehicle_Type`),
  UNIQUE INDEX `Vehicle_Type_UNIQUE` (`Vehicle_Type` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Event Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Event Type` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Event Type` (
  `Type_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Description` VARCHAR(45) NOT NULL,
  `Vehicle_Recommendation` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`Type_ID`),
  UNIQUE INDEX `Description_UNIQUE` (`Description` ASC) VISIBLE,
  UNIQUE INDEX `Type_ID_UNIQUE` (`Type_ID` ASC) VISIBLE,
  INDEX `Vehicle_Recommendation_idx` (`Vehicle_Recommendation` ASC) VISIBLE,
  CONSTRAINT `Vehicle_Recommendation`
    FOREIGN KEY (`Vehicle_Recommendation`)
    REFERENCES `mydb`.`Vehicle Types` (`Vehicle_Type`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Tickets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tickets` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tickets` (
  `Ticket_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Comments` VARCHAR(120) NULL DEFAULT NULL,
  `Status` INT UNSIGNED NOT NULL,
  `Event_Type` INT UNSIGNED NOT NULL,
  `Street_Number` INT UNSIGNED NOT NULL,
  `Street_Name` VARCHAR(30) NOT NULL,
  `City` VARCHAR(20) NOT NULL,
  `State` VARCHAR(2) NOT NULL,
  `Zip_Code` INT NOT NULL,
  `Latitude` DOUBLE NULL DEFAULT NULL,
  `Longitude` DOUBLE NULL DEFAULT NULL,
  `Assigned_Mission` INT UNSIGNED NULL DEFAULT NULL,
  `Phone_Number` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Ticket_ID`),
  UNIQUE INDEX `Ticket_ID_UNIQUE` (`Ticket_ID` ASC) VISIBLE,
  INDEX `Event_Type_idx` (`Event_Type` ASC) VISIBLE,
  INDEX `Assigned_Mission_idx` (`Assigned_Mission` ASC) VISIBLE,
  CONSTRAINT `Assigned_Mission`
    FOREIGN KEY (`Assigned_Mission`)
    REFERENCES `mydb`.`Mission` (`Mission_ID`)
    ON UPDATE CASCADE,
  CONSTRAINT `Event_Type`
    FOREIGN KEY (`Event_Type`)
    REFERENCES `mydb`.`Event Type` (`Type_ID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Vehicle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Vehicle` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Vehicle` (
  `Vehicle_ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Service_Location_ID` INT UNSIGNED NOT NULL,
  `Assigned_Mission` INT UNSIGNED NULL DEFAULT '0',
  `Vehicle_Type` VARCHAR(20) NOT NULL,
  `Status` INT UNSIGNED NULL DEFAULT '0',
  PRIMARY KEY (`Vehicle_ID`),
  UNIQUE INDEX `Vehicle_ID_UNIQUE` (`Vehicle_ID` ASC) VISIBLE,
  INDEX `Service_Location_ID_idx` (`Service_Location_ID` ASC) VISIBLE,
  INDEX `Assigned_Mission_idx` (`Assigned_Mission` ASC) VISIBLE,
  INDEX `Vehicle_Type_idx` (`Vehicle_Type` ASC) VISIBLE,
  CONSTRAINT `Vehicle_Assigned_Mission`
    FOREIGN KEY (`Assigned_Mission`)
    REFERENCES `mydb`.`Mission` (`Mission_ID`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `Vehicle_Service_Location_ID`
    FOREIGN KEY (`Service_Location_ID`)
    REFERENCES `mydb`.`Service Location` (`Service_Location_ID`)
    ON UPDATE CASCADE,
  CONSTRAINT `Vehicle_Type`
    FOREIGN KEY (`Vehicle_Type`)
    REFERENCES `mydb`.`Vehicle Types` (`Vehicle_Type`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 55
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
