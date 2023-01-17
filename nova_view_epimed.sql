-- New script in PROD.
-- Date: 17 de jan. de 2023
-- Time: 12:54:16
-- By Analista Wesley

/*
 * view epimed
 * prontuario
 * cpf
 * rg
 * nome paciente
 * sexo 
 * data de nascimento
 * convenio
 * hospital code CAST(NULL AS VARCHAR(10)) AS HOSPITALCODE,
 * registro 
 * data/hora entrada
 * bloco
 * cod atendimento
 * data/hora na unidade
 * id do leito
 * RICADINT.MOTIVO  AS DISCHARGECAUSE,
 *  linha 37 a 65 da view V_INTEGRACAO_SCMI_X_EPIMED
 * 
 * 
 * 
 * */


SELECT 

*

FROM (
SELECT 
--DISTINCT 
RICADPAC.PRONT AS MEDICALRECORD,
RICADPAC.CPF,
RICADPAC.IDENT,
RICADPAC.NOME,
--RILEITOS.ANDAR,



RICTRLOC.BLOCO AS blocoLOC, 
--RILEITOS.BLOCO,
RICTRLOC.LEITO AS leitoLOC2,
--RILEITOS.LEITO,
RICTRLOC.ACOMOD acomodLOC2,
--RILEITOS.ACOMOD, 

RICADINT.ENTRADA

FROM ATCABECATEND ATCABECATEND  /*Atendimento -Cabecalho de atendimento*/
JOIN RICADPAC RICADPAC ON ATCABECATEND.ID_RICADPAC = RICADPAC.ID /*Cadastro de Paciente*/ 
JOIN RICADINT RICADINT ON RICADINT.ID_ATCABECATEND = ATCABECATEND.ID /*Recepção Interna - Cadastro de internações*/ 
--JOIN RILEITOS RILEITOS ON RICADINT.ID_RILEITOS = RILEITOS.ID /*Recepção Interna - Cadastro de leitos*/  
JOIN RICTRLOC RICTRLOC ON RICTRLOC.REG = RICADINT.REG  /*Recepção Interna - Controle de localizações*/
where ((atcabecatend.data_hora_alta_medica >= current_timestamp - 20) or (atcabecatend.data_hora_alta_medica is null))
      and atcabecatend.tp_atendimento = 'I'
 

ORDER BY RICADPAC.NOME asc

)EPIMED





