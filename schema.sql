-- ============================================================
--  schema.sql — Base de données du site vitrine JurisNova
-- ============================================================
--  À exécuter UNE FOIS, en tant que root/admin sur le serveur
--  MariaDB (VLAN 30 / 10.0.0.162), AVANT de mettre le site en
--  ligne. Le compte applicatif user_web n'a, lui, que les
--  droits SELECT + INSERT (voir GRANT dans votre rapport) :
--  il peut donc lire les expertises et enregistrer les
--  messages de contact, mais pas créer/modifier la structure.
-- ============================================================

CREATE DATABASE IF NOT EXISTS jurisnova_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE jurisnova_db;

-- ------------------------------------------------------------
--  Domaines d'expertise affichés sur le site (lecture : SELECT)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS expertises (
    id        INT AUTO_INCREMENT PRIMARY KEY,
    titre     VARCHAR(120)  NOT NULL,
    resume    VARCHAR(400)  NOT NULL,
    position  INT           NOT NULL DEFAULT 0
) ENGINE=InnoDB;

-- ------------------------------------------------------------
--  Messages reçus via le formulaire de contact (écriture : INSERT)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS messages_contact (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    nom           VARCHAR(120)  NOT NULL,
    email         VARCHAR(180)  NOT NULL,
    organisation  VARCHAR(180)  DEFAULT NULL,
    sujet         VARCHAR(160)  NOT NULL,
    message       TEXT          NOT NULL,
    ip_source     VARCHAR(45)   DEFAULT NULL,
    cree_le       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ------------------------------------------------------------
--  Données initiales : les domaines de compétence du cabinet
--  (droit commercial & compliance, cf. présentation JurisNova)
-- ------------------------------------------------------------
INSERT INTO expertises (titre, resume, position) VALUES
('Droit commercial & des affaires',
 "Négociation et sécurisation de vos contrats stratégiques, relations fournisseurs et distributeurs, baux commerciaux et litiges entre entreprises.",
 1),
('Compliance & conformité',
 "Mise en conformité réglementaire, programmes anti-corruption (Sapin II), dispositifs d'alerte interne et cartographie des risques pour vos opérations.",
 2),
('Droit des sociétés & gouvernance',
 "Constitution, opérations sur le capital, fusions-acquisitions et accompagnement de la gouvernance pour PME, start-ups et filiales de groupes.",
 3),
('Contentieux & arbitrage',
 "Défense de vos intérêts devant les juridictions commerciales et en arbitrage, de la stratégie pré-contentieuse à l'exécution des décisions.",
 4),
('Protection des données',
 "Conformité RGPD, contrats de traitement, gestion des violations de données et conseil sur la circulation des informations sensibles.",
 5),
('Conseil aux start-ups',
 "Accompagnement des jeunes entreprises : levées de fonds, pactes d'associés, propriété intellectuelle et structuration de la croissance.",
 6);
