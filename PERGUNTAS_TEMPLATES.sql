-- CONNECTION: name=PROD
-- New script in PROD.
-- Date: 31 de jan. de 2023
-- Time: 16:22:55
-- By Analista Wesley
/*
 *    
 * 
 */

--PEP - Cadastro de dados do cabeçalho de uma composição
WITH  TEMPLATE AS ( 
SELECT 

PREVOLUCAO.* 
FROM PREVOLUCAO PREVOLUCAO 
WHERE 
PREVOLUCAO.COD IS NOT DISTINCT FROM :pCOD --CODIGO DO TEMPLATE

)



