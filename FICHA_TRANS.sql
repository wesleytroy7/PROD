-- CONNECTION: name=PROD

-- New script in PROD.
-- Date: 24 de ago. de 2022
-- Time: 10:17:20
-- By Wesley
SELECT   
DISTINCT 
--COUNT(*) OVER(PARTITION BY FCH_TRANS.DATA_CAD ) AS TOTAL_BOLSA /*AGRUPANDO POR DATA/PAC*/,
FCH_TRANS.ID,
FCH_TRANS.PRONT,
FCH_TRANS.REG,
FCH_TRANS.NOME,
            DECODE ( SEXO,
            'M','MASCULINO',
            'FEMININO') AS SEXO,
FCH_TRANS.DATA_CAD,
FCH_TRANS.TIPO_AT,
FCH_TRANS.ACOMOD,
FCH_TRANS.LEITO,
FCH_TRANS.DTA_ATEND,
FCH_TRANS.CONV,
FCH_TRANS.CLINICA,
FCH_TRANS.SANGUE,
     DECODE( FCH_TRANS.FATOR_RH,
                  1,'POSITIVO',
                    'NEGATIVO') AS RH,
FCH_TRANS.HB_INDEX,

SUBSTRING( 
'Hb '|| 
(       
         SELECT 
              FIRST 1
               SIRES01.NUMERICO
              FROM SIRES01 SIRES01 
              WHERE 
              SIRES01.ELEMENTO = 3
              AND 
              SIRES01.EXAME = 'HG' 
              AND 
              FCH_TRANS.HB_INDEX = SIRES01.ID_SILANEXA 
                  )FROM 1 FOR 7) || ' g%' AS hb ,
FCH_TRANS.HT_INDEX, 

 SUBSTRING(
'Ht '|| 
(       
         SELECT 
              FIRST 1
               SIRES01.NUMERICO
              FROM SIRES01 SIRES01 
              WHERE 
              SIRES01.ELEMENTO = 4
              AND 
              SIRES01.EXAME = 'HG' 
              AND 
              FCH_TRANS.HT_INDEX = SIRES01.ID_SILANEXA 
                   )FROM 1 FOR 7)||' g%'AS HT 
FROM (  
SELECT


 RICADPAC.PRONT, 
-- SHTRANS.REG  AS REG,
 
 RICADPAC.NOME,
 RICADPAC.SEXO AS SEXO,
 ATCABECATEND.TP_ATENDIMENTO AS TIPO_AT ,
 ATCABECATEND.DATA_HORA_ENTRADA AS DTA_ATEND,
 /*    
   (SELECT  TBCONVEN.NOME 
        FROM TBCONVEN TBCONVEN
        WHERE 
        TBCONVEN.COD = ATCABECATEND.ID_TBCONVEN) AS CONV,
 
   (SELECT TBCLINICA.NOME  
        FROM TBCLINICA  
        WHERE 
        ATCABECATEND.ID_TBCLINICA =TBCLINICA.COD  
      )AS CLINICA,    
   (SELECT TBACOMODLEITO.COD_ACOMODACAO 
          FROM TBACOMODLEITO  
          WHERE  TBLEITO.ID_TBACOMODLEITO  = TBACOMODLEITO.ID  )AS ACOMOD,
 TBLEITO.COD_LEITO AS LEITO,        
RICADPAC.SANGUE AS SANGUE,
RICADPAC.FATORRH  AS FATOR_RH,
SHTRANS."DATA"  AS DATA_CAD,
   (SELECT FIRST 1 
    MAX(SIRES01.ID_SILANEXA) 
    FROM SIRES01 
    WHERE 
    SIRES01.REG = ATCABECATEND.COD_ATENDIMENTO
    AND SIRES01.EXAME='HG'
    AND SIRES01.ELEMENTO= 3
     )HB_INDEX,
     (SELECT FIRST 1 
    MAX(SIRES01.ID_SILANEXA) 
    FROM SIRES01 
    WHERE 
    SIRES01.REG = ATCABECATEND.COD_ATENDIMENTO
    AND SIRES01.EXAME='HG'
    AND SIRES01.ELEMENTO= 4
     )HT_INDEX,*/
ATCABECATEND.ID AS ID

FROM ATCABECATEND ATCABECATEND
--INNER JOIN SHTRANS SHTRANS ON SHTRANS.REG  = ATCABECATEND.COD_ATENDIMENTO AND SHTRANS.ATEND = ATCABECATEND.TP_ATENDIMENTO
--INNER JOIN SHPRETRA SHPRETRA ON SHPRETRA.ID_PRETRANS = SHTRANS.ID_SHPRETRA
--INNER JOIN SHBOLSA SHBOLSA ON SHBOLSA.ID_BOLSA = SHPRETRA.ID_BOLSA
INNER JOIN RICADPAC RICADPAC ON ATCABECATEND.ID_RICADPAC = RICADPAC.ID
INNER JOIN TBLEITO TBLEITO ON TBLEITO.ID = ATCABECATEND.ID_TBLEITO  
INNER JOIN HTATENDIMENTO HTATENDIMENTO ON HTATENDIMENTO.ID_ATCABECATEND =ATCABECATEND.ID
/*FROM SHBOLSA SHBOLSA 
INNER JOIN SHPRETRA SHPRETRA ON SHPRETRA.ID_BOLSA = SHBOLSA.ID_BOLSA  
INNER JOIN SHTRANS SHTRANS ON SHTRANS.ID_SHPRETRA = SHPRETRA.ID_PRETRANS 
INNER JOIN ATCABECATEND ATCABECATEND ON ATCABECATEND.COD_ATENDIMENTO = SHTRANS.REG 
AND SHTRANS.ATEND = ATCABECATEND.TP_ATENDIMENTO
INNER JOIN RICADPAC RICADPAC ON ATCABECATEND.ID_RICADPAC = RICADPAC.ID
--INNER JOIN RECADATE RECADATE ON RECADATE.ID_ATCABECATEND =ATCABECATEND.ID  
INNER JOIN TBLEITO TBLEITO ON TBLEITO.ID = ATCABECATEND.ID_TBLEITO  
INNER JOIN HTATENDIMENTO HTATENDIMENTO ON HTATENDIMENTO.ID_ATCABECATEND =ATCABECATEND.ID*/  
WHERE
----SHTRANS.REG =   52768 
----AND 
----SHTRANS."DATA" >=  '2022-06-13'
--SHTRANS.REG=:REGISTRO
ATCABECATEND.COD_ATENDIMENTO=:REGISTRO
--AND 
--RICADPAC.PRONT=:PRONTU??RIO
--AND
--SHTRANS."DATA"=:DATAPRETRASNFUSAO
AND 
ATCABECATEND.TP_ATENDIMENTO =:TIPOATENDIMENTO
--SHTRANS."DATA"  >=  CURRENT_DATE 
) FCH_TRANS
