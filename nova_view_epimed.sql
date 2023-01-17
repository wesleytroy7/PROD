-- New script in PROD.
-- Date: 17 de jan. de 2023
-- Time: 12:54:16
-- By Analista Wesley



SELECT 

*


FROM ATCABECATEND ATCABECATEND  /*Atendimento -Cabecalho de atendimento*/
JOIN RICADPAC RICADPAC ON ATCABECATEND.ID_RICADPAC = RICADPAC.ID /*Cadastro de Paciente*/ 
JOIN RICADINT RICADINT ON RICADINT.ID_ATCABECATEND = ATCABECATEND.ID /*Recepção Interna - Cadastro de internações*/ 
JOIN RILEITOS RILEITOS ON RICADINT.ID_RILEITOS = RILEITOS.ID /*Recepção Interna - Cadastro de leitos*/ 