-- New script in PROD.
-- Date: 4 de jan. de 2023
-- Time: 14:27:28
-- By Analista Wesley
--ALTERACAO DE MAT/MED  -> LANCAMEWNTO INCORRETO
select * from FCLANEXT 
	JOIN FCCTAEXT ON FCCTAEXT.ID =   FCLANEXT.ID_FCCTAEXT 
    JOIN TBMATMED ON  TBMATMED.ID =FCLANEXT.ID_TBMATMED  
WHERE FCCTAEXT.COD  =54943;