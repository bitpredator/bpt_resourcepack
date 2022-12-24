INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_ammu', 'Ammu', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_ammu', 'Ammu', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_ammu', 'Ammu', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('ammu', 'Armeria')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('ammu',0,'apprentice','Apprendista',20,'{}','{}'),
	('ammu',1,'gunsmith','Armaiolo',40,'{}','{}'),
	('ammu',2,'armorychief','Capo Armeria',60,'{}','{}'),
	('ammu',3,'deputydirector','Vice direttore',85,'{}','{}'),
	('ammu',4,'boss','Direttore',100,'{}','{}')
;