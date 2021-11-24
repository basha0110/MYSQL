


CREATE DATABASE IF NOT EXISTS grantor;
USE grantor
DELIMITER $$
DROP PROCEDURE IF EXISTS grant_table $$
CREATE PROCEDURE grant_table
(
    tb VARCHAR(64)
   ,userhost VARCHAR(128)
   ,grantlist VARCHAR(255)
)
BEGIN
    DROP TABLE IF EXISTS DBLIST;
    CREATE TABLE DBLIST
    (
        id INT NOT NULL AUTO_INCREMENT,
        db VARCHAR(64),
        PRIMARY KEY (id)
    ) ENGINE=MEMORY;
    INSERT INTO DBLIST (db)
    SELECT table_schema FROM information_schema.tables WHERE
    table_schema NOT IN
    ('information_schema','performance_schema','mysql','sys')
    AND table_name = tb;
    SELECT MAX(id) INTO @rcount FROM DBLIST;
    SELECT @rcount;
    SET @x = 0;
    WHILE @x < @rcount DO
        SET @x = @x + 1;
        SELECT CONCAT('GRANT ',grantlist,' ON `',db,'`.',tb,' TO ',userhost)
        INTO @sql
        FROM DBLIST WHERE id = @x;
        SELECT @sql;
        PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;
    END WHILE;    

END $$
DELIMITER ;



call grant_table ('table_name','user_host','grant list');