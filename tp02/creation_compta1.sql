-- Création de la base de données car je ne l'ai pas
CREATE DATABASE IF NOT EXISTS compta;
USE compta;

CREATE TABLE IF NOT EXISTS FOURNISSEUR (
id INT PRIMARY KEY ,
nom VARCHAR(45) NOT NULL
 );
 
CREATE TABLE IF NOT EXISTS ARTICLE (
id INT PRIMARY KEY,
ref VARCHAR(20) NOT NULL,
designation VARCHAR(255) NOT NULL,
prix DECIMAL(7, 2) NOT NULL,
id_fou INT,
FOREIGN KEY (id_fou) REFERENCES FOURNISSEUR(id)
 );

CREATE TABLE IF NOT EXISTS BON (
id INT PRIMARY KEY,
numero VARCHAR(20) NOT NULL,
date_cmde DATETIME NOT NULL,
delai INT NOT NULL,
id_fou INT,
FOREIGN KEY (id_fou) REFERENCES FOURNISSEUR(id)
 );
 
CREATE TABLE IF NOT EXISTS COMPO (
id INT PRIMARY KEY,
qte int NOT NULL,
id_art INT,
id_bon INT,
FOREIGN KEY (id_bon) REFERENCES BON(id),
FOREIGN KEY (id_art) REFERENCES ARTICLE(id)
 );