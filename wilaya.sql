CREATE database if NOT EXISTS Ligue_Wilaya;
USE Ligue_Wilaya;

CREATE TABLE division (
    Id int auto_increment,
    NomDivision varchar(100),
    primary key (Id)
); 


CREATE TABLE groupe (
    Id int AUTO_INCREMENT,
    IdDiv int,
    numGroupe int NOT NULL,
    primary key (Id,IdDiv), 
    foreign key (IdDiv) references division(id) 
); 

CREATE TABLE equipe (
    id int primary key auto_increment,
    sigle varchar(30),  
    nom varchar(100),
    anCreation int check( anCreation > 0) ,
    idGrp int,
    idDiv int,
    foreign key (idGrp,idDiv) REFERENCES groupe(id,IdDiv) 
    ); 

CREATE TABLE entraineur (
    id int primary key AUTO_INCREMENT,
    nom varchar(250),
    prenom varchar(250),
    categorie varchar(250),
    idEquipe int,
    foreign key (idEquipe) REFERENCES equipe(id) 
);



CREATE TABLE joueur (
    numLicence int NOT NULL, 
    idEquipe int ,
    nom varchar(250), 
    prenom varchar(250),
    categorie varchar(250),
    numero int check(numero > 0), 
    dateNaissance varchar(50),
    lieuNaissance varchar(250),
    groupage varchar(10),
    primary key (numLicence),
    foreign key (idEquipe) REFERENCES equipe(id) 
); 


CREATE TABLE stade (
    id int primary key AUTO_INCREMENT,
    nom varchar(250) 
); 


CREATE TABLE saison (
    id int primary key AUTO_INCREMENT,
    designation varchar(250) 
); 


CREATE TABLE IF NOT EXISTS journee (
    id int AUTO_INCREMENT,
    dateDebut DATE NOT NULL,
    idSaison int , 
    primary key (id,idSaison),
    foreign key (idSaison) REFERENCES saison(id) 
); 


CREATE TABLE IF NOT EXISTS rencontre (
    id int primary key AUTO_INCREMENT,
    butEquipeA int check(butEquipeA >= 0),  
    butEquipeB int check(butEquipeB >= 0),  
    date date NOT NULL, 
    idEquipeA int,
    idEquipeB int,
    idStade int,
    idJournee int,
    foreign key (idEquipeA) REFERENCES equipe(id)  , 
    foreign key (idEquipeB) REFERENCES equipe(id)  , 
    foreign key (idStade) REFERENCES stade(id)  ,    
    foreign key (idJournee) REFERENCES journee(id) 
);


CREATE TABLE IF NOT EXISTS temps (
    id int primary key AUTO_INCREMENT,
    minute int check( minute >= 0) 
); 



CREATE TABLE IF NOT EXISTS marquer (
    idRencontre int,
    idJoueur int,
    idTemps int,
    primary key (idRencontre, idJoueur, idTemps),
    foreign key (idRencontre) REFERENCES rencontre(id) ,
    foreign key (idJoueur) REFERENCES joueur(numLicence ) ,
    foreign key (idTemps) REFERENCES temps(id) 
); 

CREATE TABLE IF NOT EXISTS carton (
    idRencontre int,
    idJoueur int,
    idTemps int,
    couleur varchar (50),
    primary key (idRencontre, idJoueur, idTemps),
    foreign key (idRencontre) REFERENCES rencontre(id),
    foreign key (idJoueur) REFERENCES joueur(numLicence ) ,
    foreign key (idTemps) REFERENCES temps(id)
); 

CREATE TABLE IF NOT EXISTS arbitre(
    id int PRIMARY KEY AUTO_INCREMENT,
    nom varchar(250),
    prenom varchar(250)
);


CREATE TABLE IF NOT EXISTS arbitrer(
    idArbitre int,
    idRencontre int,
    PRIMARY KEY (idArbitre,idRencontre),
    foreign key (idRencontre) references rencontre(id) 
);
