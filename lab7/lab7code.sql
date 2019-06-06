-- Thu May 16 00:58:27 2019
-- Model: New Model    Version: 1.0
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
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `idcustomer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `contact_phone` VARCHAR(45) NOT NULL,
  `emeil` VARCHAR(45) NOT NULL,
  `birth_date` DATE NULL,
  PRIMARY KEY (`idcustomer`),
  UNIQUE INDEX `idcustomer_UNIQUE` (`idcustomer` ASC) VISIBLE,
  UNIQUE INDEX `contact_phone_UNIQUE` (`contact_phone` ASC) VISIBLE,
  UNIQUE INDEX `emeil_UNIQUE` (`emeil` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`printer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`printer` (
  `idprinter` INT NOT NULL AUTO_INCREMENT,
  `binder_mark_up` INT NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`idprinter`),
  UNIQUE INDEX `idprinter_UNIQUE` (`idprinter` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`performer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`performer` (
  `idperformer` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `birth_date` DATE NULL,
  `emeil` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idperformer`),
  UNIQUE INDEX `idemloyee_UNIQUE` (`idperformer` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`book` (
  `idbooks` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  `customer_idcustomer` INT NOT NULL,
  `printer_idprinter` INT NOT NULL,
  `amount` INT NULL,
  `performer` VARCHAR(45) NOT NULL,
  `performer_idperformer` INT NOT NULL,
  PRIMARY KEY (`idbooks`),
  INDEX `fk_books_customer_idx` (`customer_idcustomer` ASC) VISIBLE,
  INDEX `fk_books_printer1_idx` (`printer_idprinter` ASC) VISIBLE,
  UNIQUE INDEX `idbooks_UNIQUE` (`idbooks` ASC) VISIBLE,
  INDEX `fk_book_performer1_idx` (`performer_idperformer` ASC) VISIBLE,
  CONSTRAINT `fk_books_customer`
    FOREIGN KEY (`customer_idcustomer`)
    REFERENCES `mydb`.`customer` (`idcustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_printer1`
    FOREIGN KEY (`printer_idprinter`)
    REFERENCES `mydb`.`printer` (`idprinter`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_performer1`
    FOREIGN KEY (`performer_idperformer`)
    REFERENCES `mydb`.`performer` (`idperformer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`binder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`binder` (
  `idbinder` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `price` INT NULL,
  `printer_idprinter1` INT NOT NULL,
  PRIMARY KEY (`idbinder`, `printer_idprinter1`),
  UNIQUE INDEX `idbinder_UNIQUE` (`idbinder` ASC) VISIBLE,
  INDEX `fk_binder_printer2_idx` (`printer_idprinter1` ASC) VISIBLE,
  CONSTRAINT `fk_binder_printer2`
    FOREIGN KEY (`printer_idprinter1`)
    REFERENCES `mydb`.`printer` (`idprinter`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`shop` (
  `idshop` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idshop`),
  UNIQUE INDEX `idshops_UNIQUE` (`idshop` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`size`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`size` (
  `idsize` INT NOT NULL AUTO_INCREMENT,
  `size` VARCHAR(45) NULL,
  `price` INT NULL,
  `printer_idprinter` INT NOT NULL,
  PRIMARY KEY (`idsize`, `printer_idprinter`),
  UNIQUE INDEX `idsize_UNIQUE` (`idsize` ASC) VISIBLE,
  INDEX `fk_size_printer1_idx` (`printer_idprinter` ASC) VISIBLE,
  CONSTRAINT `fk_size_printer1`
    FOREIGN KEY (`printer_idprinter`)
    REFERENCES `mydb`.`printer` (`idprinter`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`shop_has_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`shop_has_book` (
  `shop_idshop` INT NOT NULL,
  `book_idbooks` INT NOT NULL,
  INDEX `fk_shop_has_book_book1_idx` (`book_idbooks` ASC) VISIBLE,
  INDEX `fk_shop_has_book_shop1_idx` (`shop_idshop` ASC) VISIBLE,
  CONSTRAINT `fk_shop_has_book_shop1`
    FOREIGN KEY (`shop_idshop`)
    REFERENCES `mydb`.`shop` (`idshop`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shop_has_book_book1`
    FOREIGN KEY (`book_idbooks`)
    REFERENCES `mydb`.`book` (`idbooks`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

##############################################################

#insert into customer 
#values (null, "Ivan", "Franko", "0960099123", "ivan_franko@gmail.com", "1856-08-27"), 
#(null, "Oleh", "Vinnik", "0551245738", "zvezda_sychasnosti@gmail.com", "1973-07-31");
#insert into book 
#values (NULL, "book_1", 1, 1, 10, "world_man1", 3), 
#(NULL, "book_2", 1, 1, 10, "world_man2", 2), 
#(NULL, "book_3", 1, 1, 10, "world_man3", 1);

select * from customer;
select * from book;
select * from performer;

select performer.idperformer, performer.name, performer.emeil, book.description, book.amount 
from performer left join book on 
performer.idperformer = book.performer_idperformer;


select performer.name, performer.emeil, book.idbooks, book.amount, book.description 
from performer inner join book on book.performer_idperformer = performer.idperformer 
where performer.name = "Vasiliy"; 

select performer.name, performer.emeil, book.idbooks, book.amount, book.description, customer.name, customer.surname 
from (performer inner join book) inner join customer 
on book.performer_idperformer = performer.idperformer 
and book.customer_idcustomer = customer.idcustomer 
where performer.name in ("Vasiliy", "Kolya"); 

select performer.idperformer, performer.name, book.description, book.amount 
from performer inner join book 
on performer.idperformer = book.performer_idperformer 
where book.performer_idperformer 
in (select performer.idperformer from performer where performer.name in ("Vasiliy", "Kolya")) 
order by performer.emeil desc limit 2;