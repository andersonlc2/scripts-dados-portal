insert into public."final_servidores" 
select 
id_servidor_portal ,
max(nome) ,
max(cpf) ,
max(matricula) ,
max(descricao_cargo)    ,
max(classe_cargo) ,
max(referencia_cargo) ,
max(padrao_cargo) ,
max(nivel_cargo)    ,
max(sigla_funcao) ,
max(nivel_funcao ),
max(funcao  )  ,
max(codigo_atividade ),
max(atividade ) ,
max(opcao_parcial) ,
max(cod_uorg_lotacao) ,
max(uorg_lotacao ),
max(cod_org_lotacao) ,
max(org_lotacao   ) ,
max(cod_orgsup_lotacao) ,
max(orgsup_lotacao) ,
max(cod_uorg_exercicio) ,
max(uorg_exercicio) ,
max(cod_org_exercicio) ,
max(org_exercicio) ,
max(cod_orgsup_exercicio) ,
max(orgsup_exercicio) ,
max(cod_tipo_vinculo) ,
max(tipo_vinculo) ,
max(situacao_vinculo) , 
max(to_date("data_inicio_afastamento", 'dd/mm/yyyy') ),
max(to_date("data_termino_afastamento", 'dd/mm/yyyy') ),
max(regime_juridico )   ,
max(jornada_de_trabalho) ,
max(to_date("data_ingresso_cargofuncao", 'dd/mm/yyyy'))  ,
max(to_date("data_nomeacao_cargofuncao", 'dd/mm/yyyy') )  ,
max(to_date("data_ingresso_orgao", 'dd/mm/yyyy') )  ,
max(documento_ingresso_servicopublico ) ,
max(to_date("data_diploma_ingresso_servicopublico", 'dd/mm/yyyy') ) ,
max(diploma_ingresso_cargofuncao)  ,
max(diploma_ingresso_orgao)  ,
max(diploma_ingresso_servicopublico)    ,
max(uf_exercicio)
from public."tmp_servidores" 
group by 
id_servidor_portal;

insert into public."final_servidores_remu"
select 
cast(ano as int),
cast(mes as int),
id_servidor_portal,
cpf,
nome,
cast(replace("REMUNERAÇÃO APÓS DEDUÇÕES OBRIGATÓRIAS (R$)", ',', '.') as decimal(13,2)) + 
cast(replace("TOTAL DE VERBAS INDENIZATÓRIAS (R$)(*)", ',', '.') as decimal(13,2)),
cast(replace("REMUNERAÇÃO APÓS DEDUÇÕES OBRIGATÓRIAS (U$)", ',', '.') as decimal(13,2)) + 
cast(replace("TOTAL DE VERBAS INDENIZATÓRIAS (U$)(*)", ',', '.') as decimal(13,2))
from public."tmp_servidores_remu"
where "tmp_servidores_remu".id_servidor_portal <> '';
