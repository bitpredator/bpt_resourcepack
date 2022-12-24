INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_baker', 'Baker', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_baker', 'Baker', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_baker', 'Baker', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('baker', 'Panettiere')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('baker',0,'apprentice','Apprendista',20,'{}','{}'),
	('baker',1,'gunsmith','Panettiere',40,'{}','{}'),
	('baker',2,'armorychief','Capo',60,'{}','{}'),
	('baker',3,'deputydirector','Vice direttore',85,'{}','{}'),
	('baker',4,'boss','Direttore',100,'{}','{}')
;