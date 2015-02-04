/*
 ----------------------------------------------------------------------------
             Génération d'une base de données pour
                        SQL Server 7.x
                       (14/1/2015 9:25:19)
 ----------------------------------------------------------------------------
     Nom de la base : MLR1
     Projet : Espace de travail
     Auteur : Mermoz
     Date de dernière modification : 14/1/2015 9:18:59
 ----------------------------------------------------------------------------
*/

drop database BdCongres
go

/* -----------------------------------------------------------------------------
      OUVERTURE DE LA BASE MLR1
----------------------------------------------------------------------------- */

create database BdCongres
go

use BdCongres
go



/* -----------------------------------------------------------------------------
      TABLE : ACTIVITES
----------------------------------------------------------------------------- */

create table ACTIVITES
  (
     NUM int  not null  ,
     LIBELLE char(32)  null  ,
     NBPLACES int  null  
     
     constraint PK_ACTIVITES primary key (NUM)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : CONGRESSISTE
----------------------------------------------------------------------------- */

create table CONGRESSISTE
  (
     NUM int  not null  ,
     NUM_APPARTIENT int  not null  ,
     NUM_HEBERGE int  not null  ,
     NOM char(32)  null  ,
     PRENOM char(32)  null  
     
     constraint PK_CONGRESSISTE primary key (NUM)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : SESSIONS
----------------------------------------------------------------------------- */

create table SESSIONS
  (
     NUM int  not null  ,
     NUM_PORTE int  not null  ,
     DATEHEURE datetime  not null  ,
     NUM_INTERVIENT int  not null  ,
     NOMINTERVENANT char(32)  null  ,
     NBPLACES int  null  ,
     SALLE smallint  null  ,
     PRIX decimal(10,2)  null  
     
     constraint PK_SESSIONS primary key (NUM)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : DATE
----------------------------------------------------------------------------- */

create table DATE
  (
     DATEHEURE datetime  not null  
     
     constraint PK_DATE primary key (DATEHEURE)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : LIGUES
----------------------------------------------------------------------------- */

create table LIGUES
  (
     NUM int  not null  ,
     LIBELLE char(32)  null  ,
     ADRESSE char(32)  null  ,
     CP int  null  ,
     VILLE char(32)  null  
     
     constraint PK_LIGUES primary key (NUM)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : THEMES
----------------------------------------------------------------------------- */

create table THEMES
  (
     NUM int  not null  ,
     LIBELLE char(32)  null  
     
     constraint PK_THEMES primary key (NUM)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : INTERVENANTS
----------------------------------------------------------------------------- */

create table INTERVENANTS
  (
     NUM int  not null  ,
     NOM char(32)  null  ,
     PRENOM char(32)  null  
     
     constraint PK_INTERVENANTS primary key (NUM)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : HOTELS
----------------------------------------------------------------------------- */

create table HOTELS
  (
     NUM int  not null  ,
     LIBELLE char(32)  null  ,
     ADRESSE char(32)  null  ,
     VILLE char(32)  null  ,
     CP int  null  ,
     TEL int  null  ,
     ETOILES smallint  null  ,
     PRIXCHAMBRE decimal(10,2)  null  
     
     constraint PK_HOTELS primary key (NUM)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : INSCRIRE
----------------------------------------------------------------------------- */

create table INSCRIRE
  (
     NUM int  not null  ,
     NUM_1 int  not null  ,
     ACOMPTE decimal(10,2)  null  
     
     constraint PK_INSCRIRE primary key (NUM, NUM_1)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : DEROULER
----------------------------------------------------------------------------- */

create table DEROULER
  (
     DATEHEURE datetime  not null  ,
     NUM int  not null  
     
     constraint PK_DEROULER primary key (DATEHEURE, NUM)
  ) 
go



/* -----------------------------------------------------------------------------
      TABLE : INSCRIPTION
----------------------------------------------------------------------------- */

create table INSCRIPTION
  (
     NUM int  not null  ,
     NUM_1 int  not null  ,
     DATEHEURE datetime  not null  
     
     constraint PK_INSCRIPTION primary key (NUM, NUM_1, DATEHEURE)
  ) 
go



/*
 -----------------------------------------------------------------------------
               FIN DE GENERATION
 -----------------------------------------------------------------------------
*/