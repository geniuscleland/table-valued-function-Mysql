WITH ccRevenue_CTE (BranchID, JAN, FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,`DEC`)  
AS 

(
    
     SELECT
  BranchID,
  sum(if(month(RecordedDate) = 1, Amount, 0))  AS JAN,
  sum(if(month(RecordedDate) = 2, Amount, 0))  AS FEB,
  sum(if(month(RecordedDate) = 3, Amount, 0))  AS MAR,
  sum(if(month(RecordedDate) = 4, Amount, 0))  AS APR,
  sum(if(month(RecordedDate) = 5, Amount, 0))  AS MAY,
  sum(if(month(RecordedDate) = 6, Amount, 0))  AS JUN,
  sum(if(month(RecordedDate) = 7, Amount, 0))  AS JUL,
  sum(if(month(RecordedDate) = 8, Amount, 0))  AS AUG,
  sum(if(month(RecordedDate) = 9, Amount, 0))  AS SEP,
  sum(if(month(RecordedDate) = 10, Amount, 0)) AS Oct,
  sum(if(month(RecordedDate) = 11, Amount, 0)) AS NOV,
  sum(if(month(RecordedDate) = 12, Amount, 0)) AS `DEC`
FROM Giving
where FundTypeID = MyFundID and YEAR(RecordedDate)=MyYear
    and isuploaded=1
GROUP BY BranchID

),

 FULLNAME_CTE (BusinessEntityID,Fullname)

AS
(  
       SELECT 
	     BusinessEntityID,BranchName AS Fullname
		FROM Branches
		
       
),

SUBTOTAL_CTE (NameID1,Total)

AS
(  
       SELECT 
	     BranchID ,
		 (JAN+ FEB+MAR+APR+MAY+JUN+JUL+AUG+SEP+OCT+NOV+`DEC`) AS Total 
       FROM   ccRevenue_CTE
       ORDER BY  BranchID
	   LIMIT 18446744073709551610 OFFSET 0
),


GRANDTOTAL_CTE (JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,`DEC`,sTotal)

AS
  (  SELECT  
	        SUM(JAN) as JAN,
			SUM(FEB) as FEB,
			SUM(MAR) as MAR,
			SUM(APR) as APR,
			SUM(MAY) as MAY,
			SUM(JUN) as JUN,
			SUM(JUL) as JUL,
			SUM(AUG) as AUG,
			SUM(SEP) as SEP,
			SUM(OCT) as OCT,
			SUM(NOV) as NOV,
			SUM(`DEC`) as `DEC`,
	        1 AS sTotal
	FROM ccRevenue_CTE  
)

SELECT Fullname,



	  cast(round(JAN,2) as char)  AS JAN
	  ,cast(round(FEB,2) as char) AS FEB  
	  ,cast(round(MAR,2) as char) AS MAR
	  ,cast(round(APR,2) as char) AS APR 
	  ,cast(round(MAY,2)as char) AS MAY 
	  ,cast(round(JUN,2) as char) AS JUN 
	  ,cast(round(JUL,2) as char) AS JUL 
	  ,cast(round(AUG,2) as char) AS AUG 
	  ,cast(round(SEP,2) as char) as SEP
	  ,cast(round(OCT,2) as char) as OCT
	  ,cast(round(NOV,2) as char)as NOV
	  ,cast(round(`DEC`,2) as char) as `DEC`

	 ,cast(round(Total,2) as char)as Total
	 FROM ccRevenue_CTE   
      INNER JOIN FULLNAME_CTE
	 ON ccRevenue_CTE.BranchID= FULLNAME_CTE.BusinessEntityID
     INNER JOIN SUBTOTAL_CTE
	 ON ccRevenue_CTE.BranchID= SUBTOTAL_CTE.NameID1
	
	
	 UNION ALL
	 
	 SELECT 'GRAND TOTAL',
	  cast(round(JAN,2) as char)  AS JAN
	  ,cast(round(FEB,2) as char) AS FEB  
	  ,cast(round(MAR,2) as char) AS MAR
	  ,cast(round(APR,2) as char) AS APR 
	  ,cast(round(MAY,2)as char) AS MAY 
	  ,cast(round(JUN,2) as char) AS JUN 
	  ,cast(round(JUL,2) as char) AS JUL 
	  ,cast(round(AUG,2) as char) AS AUG 
	  ,cast(round(SEP,2) as char) as SEP
	  ,cast(round(OCT,2) as char) as OCT
	  ,cast(round(NOV,2) as char)as NOV
	  ,cast(round(`DEC`,2) as char) as `DEC`
	  ,cast(round(JAN+ FEB+MAR+MAY+JUN+JUL+AUG+SEP+OCT+NOV+`DEC`,2) as char)
	
	   AS Total 
	 FROM GRANDTOTAL_CTE