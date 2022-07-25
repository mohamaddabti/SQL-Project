------- Data Bases

-------Creating tables  

CREATE TABLE vikartjeneste(     

org_nr VARCHAR(15) PRIMARY KEY,    

navn VARCHAR(20),    

adresse VARCHAR(30),    

telefon CHAR(12),    

epost VARCHAR(30));  

  

CREATE TABLE bedrift(    

org_nr CHAR(15) PRIMARY KEY,    

bedrift_navn VARCHAR(20),    

telefon CHAR(12),    

epost VARCHAR(30)); 


CREATE TABLE oppdrag(   

oppdrag_id INTEGER PRIMARY KEY AUTO_INCREMENT,    

planlagt_startdato DATE,   

planlagt_sluttdato DATE,    

planlagt_ant_timer INTEGER,    

virkelig_startdato DATE,    

virkelig_sluttdato DATE,    

virkelig_ant_timer INTEGER,    

sluttattest VARCHAR(200),    

bedrift_id CHAR(15) NOT NULL,    

kval_id INTEGER NOT NULL,    

kandidat_id INTEGER);  

  

CREATE TABLE kandidat(    

kandidat_id INTEGER PRIMARY KEY AUTO_INCREMENT,    

fornavn VARCHAR(20),   

etternavn VARCHAR(20),    

telefon CHAR(12),    

epost VARCHAR(30));  

  

CREATE TABLE kvalifikasjon(    

kval_id INTEGER PRIMARY KEY AUTO_INCREMENT,   

beskrivelse VARCHAR(30)); 

  

CREATE TABLE kval_kandidat(    

kval_id INTEGER,    

kandidat_id INTEGER,    

CONSTRAINT kval_kandidat_pk PRIMARY KEY(kval_id, kandidat_id)); 

--Fremmednøkler 

ALTER TABLE oppdrag  ADD CONSTRAINT oppdrag_fk1 FOREIGN KEY(bedrift_id) REFERENCES bedrift (org_nr);    

ALTER TABLE oppdrag  ADD CONSTRAINT oppdrag_fk2 FOREIGN KEY(kval_id) REFERENCES  kvalifikasjon (kval_id);    

ALTER TABLE oppdrag  ADD CONSTRAINT oppdrag_fk3 FOREIGN KEY(kval_id, kandidat_id) REFERENCES  kval_kandidat (kval_id, kandidat_id);   

ALTER TABLE kval_kandidat  ADD CONSTRAINT kval_kandidat_fk1 FOREIGN KEY(kval_id) REFERENCES  kvalifikasjon (kval_id);   

ALTER TABLE kval_kandidat  ADD CONSTRAINT kval_kandidat_fk2 FOREIGN KEY(kandidat_id) REFERENCES  kandidat (kandidat_id); 

 

-- INSERT DATA 

INSERT INTO vikartjeneste(org_nr, navn, adresse, telefon, epost)      

VALUES('8', 'VS', 'S456, 0fdgsd', '234', 'blabla.no');  

INSERT INTO bedrift(org_nr, bedrift_navn, telefon, epost)      

VALUES('8', 'VS', 'S456, 0fdgsd', '234', 'blabla.no'); 

INSERT INTO bedrift(org_nr, bedrift_navn, telefon, epost)      

VALUES('8', 'VS', 'S456, 0fdgsd', '234', 'blabla.no'); 

 

INSERT INTO kandidat(kandidat_id, fornavn, etternavn, telefon, epost)      

VALUES(DEFAULT, 'Ale', 'Alen', '114', 'ale_AT_alen.no');  

INSERT INTO kandidat(kandidat_id, fornavn, etternavn, telefon, epost)      

VALUES(DEFAULT, 'Emma', 'Han', 3, 'emma_AT_emma.no');  

INSERT INTO kandidat(kandidat_id, fornavn, etternavn, telefon, epost)      

VALUES(DEFAULT, 'Sami', 'Jen', '44', 'sami_AT_jen.no'); 

 

--Modifications  

SELECT bedrift_navn, telefon, epost FROM bedrift; 

SELECT o.oppdrag_id, b.bedrift_navn, b.telefon FROM oppdrag o, bedrift b WHERE o.bedrift_id = b.org_nr; 
-- alternativt: SELECT o.oppdrag_id, b.bedrift_navn, b.telefon FROM oppdrag o JOIN bedrift b ON (o.bedrift_id = b.org_nr); 

SELECT k.kandidat_id, k.fornavn, k.etternavn, kv.kval_id, kv.beskrivelse FROM kandidat k, kval_kandidat, kvalifikasjon kv WHERE k.kandidat_id = kval_kandidat.kandidat_id AND kv.kval_id = kval_kandidat.kval_id; 
-- alternativt: SELECT k.kandidat_id, k.fornavn, k.etternavn, kv.kval_id, kv.beskrivelse FROM kandidat k JOIN kval_kandidat ON (k.kandidat_id = kval_kandidat.kandidat_id) JOIN kvalifikasjon kv ON(kv.kval_id = kval_kandidat.kval_id);  

SELECT k.kandidat_id, k.fornavn, k.etternavn, kv.kval_id, kv.beskrivelse FROM kandidat k LEFT JOIN kval_kandidat kk ON (k.kandidat_id = kk.kandidat_id) LEFT JOIN kvalifikasjon kv ON(kv.kval_id = kk.kval_id); 

SELECT k.fornavn, k.etternavn, o.virkelig_sluttdato, o.oppdrag_id, b.bedrift_navn FROM kandidat k, oppdrag o, bedrift b WHERE k.kandidat_id = 2 AND k.kandidat_id = o.kandidat_id AND o.bedrift_id = b.org_nr; 