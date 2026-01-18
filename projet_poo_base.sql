create database pharmacie;
Use pharmacie;


create table Utilisateur(
idUser int primary key auto_increment,
nom varchar(50) not null,
prenom varchar(50) not null,
email varchar(50) not null,
motdepasse varchar(50) not null,
role varchar(50) not null,
salaire float,
check (email like '%@%'),
check (CHAR_LENGTH(motdepasse) > 8),
check (role in ('employe', 'admin'))
);


create table Fournisseur(
fournisseur_id INT auto_increment primary key,
nom_fournisseur Varchar(100) not null ,
num_telephone Varchar(15) not null,
adresse_mail Varchar(100) not null ,
CONSTRAINT chk_tn_num_tel
CHECK (num_telephone REGEXP '^(216)?[24579][0-9]{7}$'),
CONSTRAINT chk_email
CHECK (adresse_mail REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')
);


create table commandeF(
idF int auto_increment primary key,
date_commande date not null,
date_reception date,
date_limite date not null,
etat varchar(20) not null,
prix_total float not null,
fournisseur_id int, 
foreign key (fournisseur_id) references Fournisseur(fournisseur_id),
constraint chk_date
	check (date_reception >=date_commande or date_reception is null),
constraint chk_etat
check (etat in ('new_c','annule','recue')),
constraint 
check (prix_total>0),
constraint 
check (date_limite >= date_commande)
);



create table Produit(
RefProduit int primary key auto_increment,
nom varchar(50) not null,
quantiteStock int not null,
prixVente float not null,
info varchar(50) not null,
soeuilstock int not null,
statut varchar(50) not null,
check(quantiteStock >=0),
check(prixVente>0),
check( soeuilstock >0),
check (statut in ('en Vente','rupture','nouveau'))
);



create table Client(
numClient int primary key auto_increment,
nom varchar(50),
prenom varchar(50),
telephone varchar(50),
CONSTRAINT
CHECK (telephone REGEXP '^(216)?[24579][0-9]{7}$')
);


create table lotStock(
idLot int primary key auto_increment,
quantite int not null,
DLC date not null,
prixAchat float not null,
fournisseur_id int,
foreign key (fournisseur_id) References Fournisseur(fournisseur_id),
RefProduit int,
foreign key (RefProduit) references Produit(RefProduit),
check(quantite >0),
check (prixAchat >0)
);



create table CommandeC(
idc int primary key auto_increment,
date Date not null,
modePaiement varchar(50) not null,
total float not null,
numClient int,
foreign key (numClient) references client(numClient)
);


create table LigneCommande(
idc int ,
RefProduit int,
PRIMARY KEY (idc, RefProduit),
quantite int not null,
prixVente float not null,
foreign key (RefProduit) references Produit(RefProduit),
foreign key (idc) references CommandeC(idc),
check (quantite >=0),
check (prixVente>0)
);




INSERT INTO Utilisateur (nom, prenom, email, motdepasse, role)
VALUES
('Ben Ali', 'Ahmed', 'ahmed@pharma.tn', 'password123', 'admin'),
('Trabelsi', 'Sara', 'sara@pharma.tn', 'securepass9', 'employe'),
('Khaled', 'Youssef', 'youssef@pharma.tn', 'mypassword99', 'employe'),
('Mansouri', 'Lina', 'lina@pharma.tn', 'strongpass88', 'employe');


INSERT INTO Fournisseur (nom_fournisseur, num_telephone, adresse_mail)
VALUES
('PharmaPlus', '21651234567', 'contact@pharmaplus.tn'),
('MedSupply', '21691234567', 'info@medsupply.tn'),
('HealthCare TN', '21671234567', 'sales@healthcare.tn'),
('BioMed', '21641234567', 'contact@biomed.tn');

INSERT INTO Produit (nom, quantiteStock, prixVente, info, soeuilstock, statut)
VALUES
('Paracetamol', 100, 3.50, '500mg', 20, 'en Vente'),
('Ibuprofen', 50, 5.00, '400mg', 15, 'en Vente'),
('Vitamine C', 10, 2.00, '1000mg', 20, 'rupture');

INSERT INTO Client (nom, prenom, telephone)
VALUES ('Ben Ali', 'Ahmed', '21622345678'),
('Haddad', 'Karim', '21655544321'),
('Jaziri','ahmed','21691223344');


INSERT INTO commandeF (date_commande, date_reception,date_limite,etat, prix_total, fournisseur_id)
VALUES
('2026-01-05', '2026-01-07','2026-01-10','recue', 500, 1),
('2026-01-10', NULL,'2026-01-15','new_c', 300, 2);



INSERT INTO lotStock (quantite, DLC, prixAchat, fournisseur_id, RefProduit)
VALUES
(100, '2027-06-30', 2.00, 1, 1),
(50, '2026-12-31', 3.00, 2, 2);

INSERT INTO CommandeC (date, modePaiement, total, numClient)
VALUES
('2026-01-12', 'cash', 14.00, 1),
('2026-01-13', 'card',10.00, 2);


INSERT INTO LigneCommande (quantite, prixVente, RefProduit)
VALUES
(2, 3.50, 1),
(1, 5.00, 2);

/*/insertion des valeurs/*/

INSERT INTO Utilisateur (nom, prenom, email, motdepasse, role)
VALUES
(nom, prenom, email, motdepasse, role);


INSERT INTO Fournisseur (nom_fournisseur, num_telephone, adresse_mail)
VALUES
(nom_fournisseur, num_telephone, adresse_mail);


INSERT INTO Produit
VALUES (nom,qtstock,prix,infos,seuil,statut);

INSERT INTO CommandeF
VALUES (datecommande,null,etat,total);


INSERT INTO Client (nom, prenom, telephone)
VALUES (nom, prenom, telephone);


INSERT INTO CommandeC (date, modePaiement, etat, total, numClient)
VALUES (date, modePaiement, 'new_c', total, numClient);

INSERT INTO LigneCommande (quantite, prixVente, RefProduit)
VALUES (quantite, prixVente, RefProduit);

INSERT INTO lotStock (quantite, DLC, prixAchat, fournisseur_id, RefProduit)
VALUES (quantite, DLC, prixAchat, fournisseur_id, RefProduit);

/*/ Suppression des valeurs/*/

Delete from Utilisateur where( idUser=id);


Delete from Fournisseur where( fournisseur_id=id);

Delete from Produit where( RefProduit=ref);

Delete from CommandeF where( idF=id);

Delete from Client where( numClient =num);

Delete from CommandeC where( idc = id);

Delete from LigneCommande where( idc = id);

Delete from lotStock where( idLot = id);

/*/ Modification des valeurs/*/

/*/ changer mot de passe/*/
update utilisateur set motdepasse=(mdp) where (idUser = id);

/*/ changer la date de reception/*/
update commandef set date_reception=(dt) where( idF = id);

/*/changer l'etat/*/
update commandef set etat=(etat_saisie) where(idF=id);

/*/ mise a jour quantiteStock/*/

update Produit set quantiteStock=(qnt) where(Ref=reference_pr);

/*/ mise a jour prixvente/*/

update Produit set prixvente=(prix) where(Ref=reference_pr);

/*/ mise a jour statut/*/

update Produit set statut=(stat) where(Ref=reference_pr);
/*/ mise a jour quantité /*/

update lotstock set quantite=(qnt) where(idLot=id);

/*/ mise a jour prixachat/*/

update lotstock set prixAchat=(prx) where(idLot=id);

/*/ affiche/*/
select * from produit where(statut =stt);

select
cl.nom,
c.*
from Client cl ,Commandec c where(cl.numClient = c.numClient and cl.numClient = NUM);


CREATE USER 'pharmacie_app'@'%' IDENTIFIED BY 'Pharma2026';
GRANT ALL PRIVILEGES ON pharmacie.* TO 'pharmacie_app'@'%';
FLUSH PRIVILEGES;