-- MySQL Script generated by MySQL Workbench
-- Mon Nov 26 15:34:00 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema p1710336
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema p1710336
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `p1710336` DEFAULT CHARACTER SET utf8 ;
USE `p1710336` ;

-- -----------------------------------------------------
-- Table `p1710336`.`Cartes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p1710336`.`Cartes` (
  `idC` INT(11) NOT NULL,
  `codeC` VARCHAR(45) NOT NULL,
  `nomC` VARCHAR(255) NOT NULL,
  `contenu` MEDIUMBLOB NULL,
  PRIMARY KEY (`idC`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p1710336`.`Action`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p1710336`.`Action` (
  `idAction` INT NOT NULL,
  `nomAction` VARCHAR(45) NULL,
  PRIMARY KEY (`idAction`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p1710336`.`Tour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p1710336`.`Tour` (
  `idTour` INT NOT NULL,
  `scoreTotal` INT(5) NULL,
  `Action_idAction` INT NOT NULL,
  PRIMARY KEY (`idTour`, `Action_idAction`),
  INDEX `fk_Tour_Action1_idx` (`Action_idAction` ASC),
  CONSTRAINT `fk_Tour_Action1`
    FOREIGN KEY (`Action_idAction`)
    REFERENCES `p1710336`.`Action` (`idAction`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p1710336`.`Manche`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p1710336`.`Manche` (
  `idManche` INT NOT NULL,
  `debutManche` DATETIME NULL,
  `finManche` DATETIME NULL,
  `vainqueurManche` VARCHAR(45) NULL,
  `ScoreJ1` INT(5) NULL,
  `ScoreJ2` INT(5) NULL,
  `Tour_idTour` INT NOT NULL,
  PRIMARY KEY (`idManche`, `Tour_idTour`),
  INDEX `fk_Manche_Tour1_idx` (`Tour_idTour` ASC),
  CONSTRAINT `fk_Manche_Tour1`
    FOREIGN KEY (`Tour_idTour`)
    REFERENCES `p1710336`.`Tour` (`idTour`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p1710336`.`Joueur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p1710336`.`Joueur` (
  `idJoueur` INT NOT NULL AUTO_INCREMENT,
  `couleur` VARCHAR(45) NULL,
  `Action_idAction` INT NULL,
  PRIMARY KEY (`idJoueur`),
  INDEX `fk_Joueur_Action1_idx` (`Action_idAction` ASC),
  CONSTRAINT `fk_Joueur_Action1`
    FOREIGN KEY (`Action_idAction`)
    REFERENCES `p1710336`.`Action` (`idAction`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p1710336`.`IA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p1710336`.`IA` (
  `strategie` VARCHAR(20) NOT NULL,
  `chanceCogner` INT(2) NULL,
  `chancePiocher` INT(2) NULL,
  `chanceDefausser` INT(2) NULL,
  `Joueur_idJoueur` INT NOT NULL,
  PRIMARY KEY (`strategie`, `Joueur_idJoueur`),
  INDEX `fk_IA_Joueur1_idx` (`Joueur_idJoueur` ASC),
  CONSTRAINT `fk_IA_Joueur1`
    FOREIGN KEY (`Joueur_idJoueur`)
    REFERENCES `p1710336`.`Joueur` (`idJoueur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p1710336`.`Humain`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p1710336`.`Humain` (
  `Pseudo` VARCHAR(20) NOT NULL,
  `nomJ` VARCHAR(45) NULL,
  `prenomJ` VARCHAR(45) NULL,
  `dateCreationCompte` DATETIME NULL,
  `val_hachage` VARCHAR(45) NULL,
  `Joueur_idJoueur` INT NOT NULL,
  PRIMARY KEY (`Pseudo`, `Joueur_idJoueur`),
  INDEX `fk_Joueur_H_Joueur1_idx` (`Joueur_idJoueur` ASC),
  CONSTRAINT `fk_Joueur_H_Joueur1`
    FOREIGN KEY (`Joueur_idJoueur`)
    REFERENCES `p1710336`.`Joueur` (`idJoueur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p1710336`.`Partie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p1710336`.`Partie` (
  `idPartie` INT(11) NOT NULL,
  `vainqueurPartie` VARCHAR(45) NULL,
  `nbManches` INT(2) NULL,
  `debutPartie` DATETIME NULL,
  `finPartie` DATETIME NULL,
  `Manche_idManche` INT NOT NULL,
  `IA_strategie` VARCHAR(20) NOT NULL,
  `IA_Joueur_idJoueur` INT NOT NULL,
  `Humain_Pseudo` VARCHAR(20) NOT NULL,
  `Humain_Joueur_idJoueur` INT NOT NULL,
  PRIMARY KEY (`idPartie`, `Manche_idManche`),
  INDEX `fk_Partie_Manche1_idx` (`Manche_idManche` ASC),
  INDEX `fk_Partie_IA1_idx` (`IA_strategie` ASC, `IA_Joueur_idJoueur` ASC),
  INDEX `fk_Partie_Humain1_idx` (`Humain_Pseudo` ASC, `Humain_Joueur_idJoueur` ASC),
  CONSTRAINT `fk_Partie_Manche1`
    FOREIGN KEY (`Manche_idManche`)
    REFERENCES `p1710336`.`Manche` (`idManche`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partie_IA1`
    FOREIGN KEY (`IA_strategie` , `IA_Joueur_idJoueur`)
    REFERENCES `p1710336`.`IA` (`strategie` , `Joueur_idJoueur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Partie_Humain1`
    FOREIGN KEY (`Humain_Pseudo` , `Humain_Joueur_idJoueur`)
    REFERENCES `p1710336`.`Humain` (`Pseudo` , `Joueur_idJoueur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `p1710336`.`Jeu_Carte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `p1710336`.`Jeu_Carte` (
  `idJeu` INT NOT NULL,
  `Cartes_idC` INT(11) NOT NULL,
  `Partie_idP` INT NOT NULL,
  PRIMARY KEY (`idJeu`, `Cartes_idC`, `Partie_idP`),
  INDEX `fk_JeuDeCarte_Cartes_idx` (`Cartes_idC` ASC),
  INDEX `fk_JeuDeCarte_Partie1_idx` (`Partie_idP` ASC),
  CONSTRAINT `fk_JeuDeCarte_Cartes`
    FOREIGN KEY (`Cartes_idC`)
    REFERENCES `p1710336`.`Cartes` (`idC`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_JeuDeCarte_Partie1`
    FOREIGN KEY (`Partie_idP`)
    REFERENCES `p1710336`.`Partie` (`idPartie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
