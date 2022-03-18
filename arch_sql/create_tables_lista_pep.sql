drop table if exists public.tmp_pep;
create table public.tmp_pep(
    "CPF" varchar(1024) null,
    "NOME_PEP" varchar(1024) null,
    "SIGLA_FUNCAO" varchar(1024) null,
    "DESCRICAO_FUNCAO" varchar(1024) null,
    "NIVEL_FUNCAO" varchar(1024) null,
    "NOME_ORGAO" varchar(1024) null,
    "DATA_INICIO_EXERCICIO" varchar(1024) null,
    "DATA_FIM_EXERCICIO" varchar(1024) null,
    "DATA_FIM_CARENCIA" varchar(1024) null    
);

drop table if exists public.final_pep;
create table public.final_pep(
    "CPF" varchar(1024) null,
    "NOME_PEP" varchar(1024) null,
    "SIGLA_FUNCAO" varchar(1024) null,
    "DESCRICAO_FUNCAO" varchar(1024) null,
    "NIVEL_FUNCAO" varchar(1024) null,
    "NOME_ORGAO" varchar(1024) null,
    "DATA_INICIO_EXERCICIO" date null,
    "DATA_FIM_EXERCICIO" date null,
    "DATA_FIM_CARENCIA" date null
);
