----ALTER Large tables 


--If your table is quite big do not use below statemet :
alter table `goods` add column `id` int(10) unsigned primary KEY AUTO_INCREMENT ;

-- because it makes a copy of all data in a temporary table, alter table and then copies it back. 
-- It is better to do it manually. 

--Follow below steps: 
--Rename the  table:

RENAME TABLE goods TO goods_old;

--Create new table with primary key and all necessary indexes:

CREATE TABLE goods LIKE goods_old;


-- Move all data from the old table into new, disabling keys and indexes to speed up copying:

-- USE THIS FOR MyISAM TABLES:

SET UNIQUE_CHECKS=0;
    ALTER TABLE goods DISABLE KEYS;
        INSERT INTO goods (SELECT * FROM  goods_old ); 
    ALTER TABLE goods ENABLE KEYS;
SET UNIQUE_CHECKS=1;


-- USE THIS FOR InnoDB TABLES:

SET AUTOCOMMIT = 0; 
SET UNIQUE_CHECKS=0; 
SET FOREIGN_KEY_CHECKS=0;
    INSERT INTO goods (SELECT * FROM  goods_old ); 
SET FOREIGN_KEY_CHECKS=1; 
SET UNIQUE_CHECKS=1; 
COMMIT; SET AUTOCOMMIT = 1;