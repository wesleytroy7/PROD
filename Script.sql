-- New script in PROD.
-- Date: 12 de jan. de 2023
-- Time: 08:39:11
-- By Analista Wesley



select * from fcctaext where anopro=:anopro and mespro=:mespro
and cod=:cod and tipo_cta=:tipo_cta


SELECT 0 
FROM FCCTAEXT C 
INNER JOIN TBCONVEN T ON (C.CON = T.COD) 
INNER JOIN RICADINT R ON R.REG=C.COD 
INNER JOIN MFCCCONV M ON M.DEV = 'I' AND M.COD = C.COD 
WHERE T.CLASSIF_C IN (2, 5, 8) 
AND C.TIPO_CTA = 'I' 
AND R.PRONT = :pront

SELECT * FROM MFCCCONV c WHERE c.COD=54892


