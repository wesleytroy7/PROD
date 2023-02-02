-- CONNECTION: name=PROD
-- New script in PROD.
-- Date: 26 de jan. de 2023
-- Time: 16:53:02
-- By Analista Wesley
SELECT  id_cabevol, pront, cod_atendimento, nome, nome_mae, data_nascimento,  DATAINSTALACAO, DIASDECVC, SINAISDEINFECCAO,INTERCORRENCAIAS,NECESSIDADEDECVC from(
select distinct a.id_cabevol,
e.pront, f.cod_atendimento,  c.nome, c.nome_mae, c.data_nascimento,

(select first 1 c.respdata from prevolpac c
where c.id_cabevol=a.id_cabevol and c.id_resposta in
(select d.id_resposta from prresposta d where d.id_prpergunta=3238)) as DATAINSTALACAO,

(select first 1 c.respvalor from prevolpac c
where c.id_cabevol=a.id_cabevol and c.id_resposta in
(select d.id_resposta from prresposta d where d.id_prpergunta=3239)) as DIASDECVC,

(select first 1 c.respalfa from prevolpac c
where c.id_cabevol=a.id_cabevol and c.id_resposta in
(select d.id_resposta from prresposta d where d.id_prpergunta=3240)) as SINAISDEINFECCAO,

(select first 1 c.respalfa from prevolpac c
where c.id_cabevol=a.id_cabevol and c.id_resposta in
(select d.id_resposta from prresposta d where d.id_prpergunta=3241)) as INTERCORRENCAIAS,

(select first 1 c.respalfa from prevolpac c
where c.id_cabevol=a.id_cabevol and c.id_resposta in
(select d.id_resposta from prresposta d where d.id_prpergunta=3242)) as NECESSIDADEDECVC

from prcabevol a
inner join prevolpac b on b.id_cabevol=a.id_cabevol
inner join htpaciente c on c.id=a.id_htpaciente
inner join htatendimento d on d.id=a.id_htatendimento
inner join ricadpac e on e.id=c.id_ricadpac
inner join atcabecatend f on f.id=d.id_atcabecatend

where --a.id_evolucao=15 and 
cast(a.data_hora_evolucao as date) between :DataInicial and :DataFinal

order by c.nome) where DATAINSTALACAO is not null order by nome
