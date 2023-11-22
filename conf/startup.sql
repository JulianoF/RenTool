/* Set up database if it hasn't been done yet */
CREATE DATABASE IF NOT EXISTS `rentool`;
USE `rentool`;

CREATE TABLE IF NOT EXISTS `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Email` varchar(45) DEFAULT NULL,
  `FirstName` varchar(45) DEFAULT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `Password` varchar(45) DEFAULT NULL,
  `PostalCode` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `payment` (
  `AmountOwed` float DEFAULT NULL,
  `AmountPaid` float DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `ReceiptNumber` int NOT NULL AUTO_INCREMENT,
  `PaymentType` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ReceiptNumber`),
  KEY `payment_FK` (`CustomerID`),
  CONSTRAINT `payment_FK` FOREIGN KEY (`CustomerID`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `items` (
  `ItemID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ItemName` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ItemCondition` varchar(45) DEFAULT NULL,
  `RentalPrice` float DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ItemID`),
  KEY `items_FK` (`UserID`),
  CONSTRAINT `items_FK` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `listing` (
  `ListingID` int NOT NULL AUTO_INCREMENT,
  `ItemID` int NOT NULL,
  `UserID_Listing` int NOT NULL,
  `DateListed` varchar(45) DEFAULT NULL,
  `InUse` tinyint DEFAULT NULL,
  PRIMARY KEY (`ListingID`),
  KEY `ItemID` (`ItemID`),
  KEY `listing_FK` (`UserID_Listing`),
  CONSTRAINT `ItemID` FOREIGN KEY (`ItemID`) REFERENCES `items` (`ItemID`),
  CONSTRAINT `listing_FK` FOREIGN KEY (`UserID_Listing`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `location` (
  `UserID_Location` int NOT NULL,
  `longitude` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  PRIMARY KEY (`UserID_Location`),
  CONSTRAINT `location_FK` FOREIGN KEY (`UserID_Location`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ListingID` int DEFAULT NULL,
  `OwnerID` int DEFAULT NULL,
  `RenterID` int DEFAULT NULL,
  `DateRented` varchar(45) DEFAULT NULL,
  `DateReturned` varchar(45) DEFAULT NULL,
  `ReceiptNumber` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ListingID` (`ListingID`),
  KEY `orders_FK` (`OwnerID`),
  KEY `orders_FK_1` (`RenterID`),
  KEY `orders_FK_2` (`ReceiptNumber`),
  CONSTRAINT `ListingID` FOREIGN KEY (`ListingID`) REFERENCES `listing` (`ListingID`),
  CONSTRAINT `orders_FK` FOREIGN KEY (`OwnerID`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orders_FK_1` FOREIGN KEY (`RenterID`) REFERENCES `users` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orders_FK_2` FOREIGN KEY (`ReceiptNumber`) REFERENCES `payment` (`ReceiptNumber`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* Set up webapp user if not set up already
CREATE ROLE IF NOT EXISTS 'website';
GRANT INSERT, UPDATE, DELETE ON rentool.* TO 'website';
GRANT 'website' TO 'rentool'@'localhost'; */