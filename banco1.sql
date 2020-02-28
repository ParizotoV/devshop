-- MySQL Script generated by MySQL Workbench
-- qui 20 fev 2020 12:25:50 -03
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema devshop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema devshop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `devshop` DEFAULT CHARACTER SET utf8 ;
USE `devshop` ;

-- -----------------------------------------------------
-- Table `devshop`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `devshop`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(245) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `devshop`.`product_variations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `devshop`.`product_variations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sku` VARCHAR(245) NULL DEFAULT NULL,
  `avaible` INT NULL DEFAULT NULL,
  `variation_name` VARCHAR(245) NULL DEFAULT NULL,
  `price` FLOAT NULL DEFAULT NULL,
  `price_from` FLOAT NULL DEFAULT NULL,
  `weight` INT NULL DEFAULT NULL,
  `order` INT NULL DEFAULT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_variations_products_idx` (`product_id` ASC),
  CONSTRAINT `fk_product_variations_products`
    FOREIGN KEY (`product_id`)
    REFERENCES `devshop`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `devshop`.`product_images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `devshop`.`product_images` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(245) NULL DEFAULT NULL,
  `url` VARCHAR(245) NULL DEFAULT NULL,
  `order` VARCHAR(45) NULL DEFAULT NULL,
  `product_variation_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_images_product_variations1_idx` (`product_variation_id` ASC),
  CONSTRAINT `fk_product_images_product_variations1`
    FOREIGN KEY (`product_variation_id`)
    REFERENCES `devshop`.`product_variations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `devshop`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `devshop`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(245) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `devshop`.`categories_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `devshop`.`categories_products` (
  `product_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`product_id`, `category_id`),
  INDEX `fk_products_has_categories_categories1_idx` (`category_id` ASC),
  INDEX `fk_products_has_categories_products1_idx` (`product_id` ASC),
  CONSTRAINT `fk_products_has_categories_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `devshop`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_has_categories_categories1`
    FOREIGN KEY (`category_id`)
    REFERENCES `devshop`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `devshop`.`banner_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `devshop`.`banner_types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `banner_type` VARCHAR(245) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `devshop`.`banners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `devshop`.`banners` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(245) NULL DEFAULT NULL,
  `banner_types_id` INT NOT NULL,
  `url` VARCHAR(245) NULL DEFAULT NULL,
  `order` INT NULL DEFAULT NULL,
  `image_url` VARCHAR(245) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_banners_banner_types1_idx` (`banner_types_id` ASC),
  CONSTRAINT `fk_banners_banner_types1`
    FOREIGN KEY (`banner_types_id`)
    REFERENCES `devshop`.`banner_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `devshop`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `devshop`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(245) NULL,
  `email` VARCHAR(245) NULL,
  `passwd` VARCHAR(245) NULL,
  `email_checked` TINYTEXT NULL,
  `created` DATETIME NULL,
  `updated` DATETIME NULL,
  `roles` VARCHAR(245) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `devshop`.`email_tokens`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `devshop`.`email_tokens` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `token` VARCHAR(245) NULL,
  `valid_until` DATETIME NULL,
  `email` VARCHAR(245) NULL,
  `user_id` INT NOT NULL,
  `used` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_email_tokens_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_email_tokens_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `devshop`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
