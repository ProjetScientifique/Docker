DROP TABLE IF EXISTS detecte;
DROP TABLE IF EXISTS detecteur;
DROP TABLE IF EXISTS type_detecteur;
DROP TABLE IF EXISTS intervient;
DROP TABLE IF EXISTS incident;
DROP TABLE IF EXISTS type_status_incident;
DROP TABLE IF EXISTS type_incident;
DROP TABLE IF EXISTS pompier;
DROP TABLE IF EXISTS type_pompier;
DROP TABLE IF EXISTS vehicule;
DROP TABLE IF EXISTS type_vehicule;
DROP TABLE IF EXISTS type_disponibilite_vehicule;
DROP TABLE IF EXISTS caserne;

CREATE TABLE caserne (
    id_caserne          SERIAL NOT NULL,
    nom_caserne         VARCHAR(255) NOT NULL,
    latitude_caserne    NUMERIC(9,7) NOT NULL,
    longitude_caserne   NUMERIC(10,7) NOT NULL,
    CONSTRAINT pk_id_caserne PRIMARY KEY (id_caserne)
);

CREATE TABLE type_disponibilite_vehicule (
    id_type_disponibilite_vehicule  SERIAL NOT NULL,
    nom_type_disponibilite_vehicule VARCHAR(255) NOT NULL,
    CONSTRAINT pk_id_type_disponibilite_vehicule PRIMARY KEY (id_type_disponibilite_vehicule)
);

CREATE TABLE type_vehicule (
    id_type_vehicule                        SERIAL NOT NULL,
    nom_type_vehicule                       VARCHAR(255) NOT NULL,
    capacite_type_vehicule                  INTEGER NOT NULL,
    puissance_intervention_type_vehicule    INTEGER NOT NULL,
    CONSTRAINT pk_id_type_vehicule PRIMARY KEY (id_type_vehicule)
);

CREATE TABLE vehicule (
    id_vehicule                             SERIAL NOT NULL,
    id_caserne                              SERIAL NOT NULL,
    id_type_vehicule                        SERIAL NOT NULL,
    id_type_disponibilite_vehicule          SERIAL NOT NULL,
    annee_vehicule                          INTEGER NOT NULL,
    nombre_intervention_maximum_vehicule    INTEGER NOT NULL,
    latitude_vehicule                       NUMERIC(9,7) NOT NULL,
    longitude_vehicule                      NUMERIC(10,7) NOT NULL,
    CONSTRAINT pk_id_vehicule PRIMARY KEY (id_vehicule)
);

CREATE TABLE type_pompier (
    id_type_pompier         SERIAL NOT NULL,
    nom_type_pompier        VARCHAR(255) NOT NULL,
    efficacite_type_pompier INTEGER NOT NULL,
    CONSTRAINT pk_id_type_pompier PRIMARY KEY (id_type_pompier)
);

CREATE TABLE pompier (
    id_pompier                                  SERIAL NOT NULL,
    id_caserne                                  SERIAL NOT NULL,
    id_type_pompier                             SERIAL NOT NULL,
    nom_pompier                                 VARCHAR(255) NOT NULL,
    prenom_pompier                              VARCHAR(255) NOT NULL,
    date_naissance_pompier                      DATE NOT NULL,
    nombre_intervention_jour_maximum_pompier    INTEGER,
    disponibilite_pompier                       BOOLEAN,
    CONSTRAINT pk_id_pompier PRIMARY KEY (id_pompier)
);

CREATE TABLE type_incident (
    id_type_incident    SERIAL NOT NULL,
    nom_type_incident   VARCHAR(255) NOT NULL,
    CONSTRAINT pk_id_type_incident PRIMARY KEY (id_type_incident)
);

CREATE TABLE type_status_incident (
    id_type_status_incident     SERIAL NOT NULL,
    nom_type_status_incident    VARCHAR(255) NOT NULL,
    CONSTRAINT pk_id_type_status_incident PRIMARY KEY (id_type_status_incident)
);

CREATE TABLE incident (
    id_incident             SERIAL NOT NULL,
    id_type_incident        SERIAL NOT NULL,
    id_type_status_incident SERIAL NOT NULL,
    date_incident           TIMESTAMP NOT NULL,
    latitude_incident       NUMERIC(9,7) NOT NULL,
    longitude_incident      NUMERIC(10,7) NOT NULL,
    intensite_incident      NUMERIC(4,2) NOT NULL,
    CONSTRAINT pk_id_incident PRIMARY KEY (id_incident)
);

CREATE TABLE intervient (
    id_pompier      SERIAL NOT NULL,
    id_vehicule     SERIAL NOT NULL,
    id_incident     SERIAL NOT NULL,
    date_intervient TIMESTAMP NOT NULL,
    CONSTRAINT pk_id_pompier_id_vehicule_id_incident PRIMARY KEY (id_pompier, id_vehicule, id_incident)
);

CREATE TABLE type_detecteur (
    id_type_detecteur   SERIAL NOT NULL,
    nom_type_detecteur  VARCHAR(255) NOT NULL,
    CONSTRAINT pk_id_type_detecteur PRIMARY KEY (id_type_detecteur)
);

CREATE TABLE detecteur (
    id_detecteur        SERIAL NOT NULL,
    id_type_detecteur   SERIAL NOT NULL,
    latitude_detecteur  NUMERIC(9,7) NOT NULL,
    longitude_detecteur NUMERIC(10,7) NOT NULL,
    CONSTRAINT pk_id_detecteur PRIMARY KEY (id_detecteur)
);

CREATE TABLE detecte (
    id_incident         SERIAL NOT NULL,
    id_detecteur        SERIAL NOT NULL,
    intensite_detecte   NUMERIC(4,2) NOT NULL,
    date_detecte        TIMESTAMP NOT NULL,
    CONSTRAINT pk_id_incident_id_detecteur PRIMARY KEY (id_incident, id_detecteur)
);

ALTER TABLE vehicule
    ADD CONSTRAINT fk_vehicule_id_caserne FOREIGN KEY (id_caserne) REFERENCES caserne(id_caserne);

ALTER TABLE vehicule
    ADD CONSTRAINT fk_vehicule_id_type_vehicule FOREIGN KEY (id_type_vehicule) REFERENCES type_vehicule(id_type_vehicule);
    
ALTER TABLE vehicule
    ADD CONSTRAINT fk_vehicule_id_type_disponibilite_vehicule FOREIGN KEY (id_type_disponibilite_vehicule) REFERENCES type_disponibilite_vehicule(id_type_disponibilite_vehicule);


ALTER TABLE pompier
    ADD CONSTRAINT fk_pompier_id_caserne FOREIGN KEY (id_caserne) REFERENCES caserne(id_caserne);

ALTER TABLE pompier
    ADD CONSTRAINT fk_pompier_id_type_pompier FOREIGN KEY (id_type_pompier) REFERENCES type_pompier(id_type_pompier);


ALTER TABLE incident
    ADD CONSTRAINT fk_incident_id_type_incident FOREIGN KEY (id_type_incident) REFERENCES type_incident(id_type_incident);

ALTER TABLE incident
    ADD CONSTRAINT fk_incident_id_type_status_incident FOREIGN KEY (id_type_status_incident) REFERENCES type_status_incident(id_type_status_incident);


ALTER TABLE intervient
    ADD CONSTRAINT fk_intervient_id_type_incident FOREIGN KEY (id_pompier) REFERENCES pompier(id_pompier);

ALTER TABLE intervient
    ADD CONSTRAINT fk_intervient_id_vehicule FOREIGN KEY (id_vehicule) REFERENCES vehicule(id_vehicule);

ALTER TABLE intervient
    ADD CONSTRAINT fk_intervient_id_incident FOREIGN KEY (id_incident) REFERENCES incident(id_incident);


ALTER TABLE detecteur
    ADD CONSTRAINT fk_detecteur_id_type_detecteur FOREIGN KEY (id_type_detecteur) REFERENCES type_detecteur(id_type_detecteur);


ALTER TABLE detecte
    ADD CONSTRAINT fk_detecte_id_incident FOREIGN KEY (id_incident) REFERENCES incident(id_incident);

ALTER TABLE detecte
    ADD CONSTRAINT fk_detecte_id_detecteur FOREIGN KEY (id_detecteur) REFERENCES detecteur(id_detecteur);