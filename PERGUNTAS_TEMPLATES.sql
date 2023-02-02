-- CONNECTION: name=PROD
-- New script in PROD.
-- Date: 31 de jan. de 2023
-- Time: 16:22:55
-- By Analista Wesley
/*
 *    
 * 
 * prevolucao -> TITULO DA EVOLUÇÃO
 *     -> PRPADEVOL
 * 
 * 
 * 'TECENF-01'
 * 
 */

--DADOS PACIENTE
WITH  PACIENTE AS
(
SELECT 
HTATENDIMENTO.ID AS HTATENDIMENTO_ID,  
RICADPAC.PRONT,
ATCABECATEND.COD_ATENDIMENTO AS REG,
RICADPAC.TIPOPAC,
RICADPAC.NOME
FROM HTATENDIMENTO HTATENDIMENTO
JOIN ATCABECATEND ATCABECATEND ON HTATENDIMENTO.ID_ATCABECATEND = ATCABECATEND.ID 
JOIN RICADPAC RICADPAC ON ATCABECATEND.ID_RICADPAC  = RICADPAC.ID  

),
--PEP - Cadastro de dados do cabeçalho de uma composição
TEMPLATE AS ( 
SELECT 
PREVOLUCAO.*
FROM PREVOLUCAO PREVOLUCAO 
WHERE 
PREVOLUCAO.COD IS NOT DISTINCT FROM   :pCOD  --CODIGO DO TEMPLATE 
),


--PEP - Cadastro de composição (anamnese, evolução ou diagnóstico) para o paciente

CABEVOL  AS (    
SELECT
PRCABEVOL.ID_HTATENDIMENTO,
PRCABEVOL.ID_EVOLUCAO  
FROM 
PRCABEVOL  PRCABEVOL   
),

CONTEVOL  AS (    
SELECT
PRCONTEVOL.*
FROM 
PRCONTEVOL PRCONTEVOL   
),
--PEP - Cadastro das perguntas padrões de uma composição
PERG_TEMPL  AS (    
SELECT
PRPADEVOL.*
FROM 
PRPADEVOL PRPADEVOL  
),
--PEP - Cadastro de perguntas de composições
PERGUNTAS AS (  
SELECT 
PRPERGUNTA.*
FROM PRPERGUNTA
),
CADREPOSTA AS (  
SELECT 
PRCADRESP.*
FROM PRCADRESP 
),
REPOSTA AS (  
SELECT 
PRRESPOSTA.*
FROM PRRESPOSTA
) 



SELECT
PACIENTE.NOME,
TEMPLATE.ID_EVOLUCAO,                 
TEMPLATE.COD,                         
TEMPLATE.DESCRICAO

FROM CABEVOL
JOIN PACIENTE ON PACIENTE.HTATENDIMENTO_ID = CABEVOL.ID_HTATENDIMENTO 
JOIN TEMPLATE ON TEMPLATE.ID_EVOLUCAO = CABEVOL.ID_EVOLUCAO











