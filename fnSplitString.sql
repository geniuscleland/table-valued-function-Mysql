fnSplitString

BEGIN

 DECLARE mystart INT;
  
  DECLARE myend INT ;
 
DROP TEMPORARY TABLE IF EXISTS split_table;

CREATE TEMPORARY TABLE split_table(
        splitdata  varchar(100)
	
);

 
   SELECT 1 INTO mystart FROM DUAL;
   SELECT LOCATE(mydelimiter, mystring) INTO myend FROM DUAL;
   
   


     WHILE mystart < LENGTH(mystring) + 1 DO 
        IF myend = 0  THEN
        
            SET myend = LENGTH(mystring) + 1;
            
            END IF;
       
        INSERT INTO split_table (splitdata)  
        VALUES(SUBSTRING(mystring, mystart, myend - mystart)); 
        SET mystart = myend + 1 ;
        SET myend = LOCATE(mydelimiter, mystring, mystart);
      END WHILE;  
                
             IF myoption > 0 THEN 
             
                select 
               splitdata
                    
                    from 
                    split_table
                    ORDER BY splitdata DESC
                    
                    LIMIT 1 ;
                    
                    ELSE 
                    
                    select 
               splitdata
                    
                    from 
                    split_table
                    ORDER BY splitdata ASC
                     LIMIT 1 ;
                     
                     END IF;




END