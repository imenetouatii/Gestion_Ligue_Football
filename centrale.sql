CREATE database if NOT EXISTS Ligue_Centrale;
USE Ligue_Centrale;

DROP TABLE IF EXISTS region;
CREATE TABLE IF NOT EXISTS region (
    id int PRIMARY KEY auto_increment,
    designation varchar(250)
); 


DROP TABLE IF EXISTS wilaya;
CREATE TABLE IF NOT EXISTS wilaya (
    id int PRIMARY KEY auto_increment,
    designation varchar(250),
    idRegion int,
    foreign key(idRegion) references region(id)
);

DROP TABLE IF EXISTS division;
CREATE TABLE division (
    id int auto_increment,
    NomDivision varchar(100),
    idWilaya int,
    primary key (id),
    FOREIGN key (idWilaya) REFERENCES wilaya(id)
); 


DROP TABLE IF EXISTS groupe;
CREATE TABLE groupe (
    Id int AUTO_INCREMENT,
    IdDiv int,
    numGroupe int NOT NULL,
    primary key (Id,IdDiv), 
    foreign key (IdDiv) references division(id) 
); 

DROP TABLE IF EXISTS equipe; 
CREATE TABLE equipe (
    id int primary key auto_increment,
    sigle varchar(30),  
    nom varchar(100),
    anCreation int check( anCreation > 0) ,
    idGrp int,
    idDiv int,
    foreign key (idGrp,idDiv) REFERENCES groupe(id,IdDiv)
    ); 

DROP TABLE IF EXISTS entraineur;
CREATE TABLE entraineur (
    id int primary key AUTO_INCREMENT,
    nom varchar(250),
    prenom varchar(250),
    categorie varchar(250),
    idEquipe int,
    foreign key (idEquipe) REFERENCES equipe(id)    
);




DROP TABLE IF EXISTS joueur;

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

DROP TABLE IF EXISTS stade; 

CREATE TABLE stade (
    id int primary key AUTO_INCREMENT,
    nom varchar(250) 
); 

DROP TABLE IF EXISTS saison; 

CREATE TABLE saison (
    id int primary key AUTO_INCREMENT,
    designation varchar(250) 
); 

DROP TABLE IF EXISTS journee; 

CREATE TABLE IF NOT EXISTS journee (
    id int AUTO_INCREMENT,
    dateDebut DATE NOT NULL,
    idSaison int , 
    primary key (id,idSaison),
    foreign key (idSaison) REFERENCES saison(id)  
); 


DROP TABLE IF EXISTS rencontre;
CREATE TABLE IF NOT EXISTS rencontre (
    id int primary key AUTO_INCREMENT,
    butEquipeA int check(butEquipeA >= 0),  
    butEquipeB int check(butEquipeB >= 0),  
    date date NOT NULL, 
    idEquipeA int,
    idEquipeB int,
    idStade int,
    idJournee int,
    foreign key (idEquipeA) REFERENCES equipe(id), 
    foreign key (idEquipeB) REFERENCES equipe(id), 
    foreign key (idStade) REFERENCES stade(id),    
    foreign key (idJournee) REFERENCES journee(id)
);

DROP TABLE IF EXISTS temps;

CREATE TABLE IF NOT EXISTS temps (
    id int primary key AUTO_INCREMENT,
    minute int check( minute >= 0) 
); 


DROP TABLE IF EXISTS marquer;

CREATE TABLE IF NOT EXISTS marquer (
    idRencontre int,
    idJoueur int,
    idTemps int,
    primary key (idRencontre, idJoueur, idTemps),
    foreign key (idRencontre) REFERENCES rencontre(id),
    foreign key (idJoueur) REFERENCES joueur(numLicence ),
    foreign key (idTemps) REFERENCES temps(id)
); 
DROP TABLE IF EXISTS carton;

CREATE TABLE IF NOT EXISTS carton (
    idRencontre int,
    idJoueur int,
    idTemps int,
    couleur varchar (50),
    primary key (idRencontre, idJoueur, idTemps),
    foreign key (idRencontre) REFERENCES rencontre(id),
    foreign key (idJoueur) REFERENCES joueur(numLicence ),
    foreign key (idTemps) REFERENCES temps(id)
); 

DROP TABLE IF EXISTS arbitre;
CREATE TABLE IF NOT EXISTS arbitre(
    id int PRIMARY KEY AUTO_INCREMENT,
    nom varchar(250),
    prenom varchar(250)
);


DROP TABLE IF EXISTS arbitrer;
CREATE TABLE IF NOT EXISTS arbitrer(
    idArbitre int,
    idRencontre int,
    PRIMARY KEY (idArbitre,idRencontre) 
);
