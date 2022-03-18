#!/bin/bash

# Baixa a lista Ceis do site da transparencia do governo
# e armazena os dados no banco de dados postgres.

main()
{
    create_db_and_tables
    import_data
    insert_table_final
}

# Inicia um novo banco e as devidas tabelas caso nao existam
create_db_and_tables()
{
    psql -U root amlcpgf << EOF 
    DROP TABLE IF EXISTS public.tmp_ceis; 
    CREATE TABLE public.tmp_ceis (
	"TIPO_DE_PESSOA" varchar(1) NULL,
	"CPF_OU_CNPJ_DO_SANCIONADO" varchar(1024) NULL,
	"NOME_INFORMADO_PELO_ORGAO_SANCIONADOR" varchar(1024) NULL,
	"RAZAO_SOCIAL_CADASTRO_RECEITA" varchar(1024) NULL,
	"NOME_FANTASIA_CADASTRO_RECEITA" varchar(1024) NULL,
	"NUMERO_DO_PROCESSO" varchar(1024) NULL,
	"TIPO_SANCAO" varchar(1024) NULL,
	"DATA_INICIO_SANCAO" varchar(10) NULL,
	"DATA_FINAL_SANCAO" varchar(10) NULL,
	"ORGAO_SANCIONADOR" varchar(1024) NULL,
	"UF_ORGAO_SANCIONADOR" varchar(2) NULL,
	"ORIGEM_INFORMACOES" varchar(1024) NULL,
	"DATA_ORIGEM_INFORMACOES" varchar(10) NULL,
	"DATA_PUBLICACAO" varchar(10) NULL,
	"PUBLICACAO" varchar(1024) NULL,
	"DETALHAMENTO" varchar(2000) NULL,
	"ABRAGENCIA_DEFINIDA_EM_DECISAO_JUDICIAL" varchar(1024) NULL,
	"FUNDAMENTACAO_LEGAL" varchar(2000) NULL,
	"DESCRICAO_DA_FUNDAMENTACAO_LEGAL" varchar(2500) NULL,
	"DATA_DO_TRANSITO_EM_JULGADO" varchar(10) NULL,
	"COMPLEMENTO_DO_ORGAO" varchar(2000) NULL,
	"OBSERVACOES" varchar(2500) NULL
);
    DROP TABLE IF EXISTS public.final_ceis;
    CREATE TABLE public.final_ceis (
	"TIPO_DE_PESSOA" varchar(1) NULL,
	"CPF_OU_CNPJ_DO_SANCIONADO" varchar(1024) NULL,
	"NOME_INFORMADO_PELO_ORGAO_SANCIONADOR" varchar(1024) NULL,
	"RAZAO_SOCIAL_CADASTRO_RECEITA" varchar(1024) NULL,
	"NOME_FANTASIA_CADASTRO_RECEITA" varchar(1024) NULL,
	"NUMERO_DO_PROCESSO" varchar(1024) NULL,
	"TIPO_SANCAO" varchar(1024) NULL,
	"DATA_INICIO_SANCAO" date  NULL,
	"DATA_FINAL_SANCAO" date NULL,
	"ORGAO_SANCIONADOR" varchar(1024) NULL,
	"UF_ORGAO_SANCIONADOR" varchar(2) NULL,
	"ORIGEM_INFORMACOES" varchar(1024) NULL,
	"DATA_ORIGEM_INFORMACOES" date NULL,
	"DATA_PUBLICACAO" date NULL,
	"PUBLICACAO" varchar(1024) NULL,
	"DETALHAMENTO" varchar(2000) NULL,
	"ABRAGENCIA_DEFINIDA_EM_DECISAO_JUDICIAL" varchar(1024) NULL,
	"FUNDAMENTACAO_LEGAL" varchar(2000) NULL,
	"DESCRICAO_DA_FUNDAMENTACAO_LEGAL" varchar(2500) NULL,
	"DATA_DO_TRANSITO_EM_JULGADO" date NULL,
	"COMPLEMENTO_DO_ORGAO" varchar(2000) NULL,
	"OBSERVACOES" varchar(2500) NULL
);
EOF
}

# Faz download do csv, descompacta e importa os dados para o banco
import_data()
{
    # Cria pasta temporária para armazenar os arquivos csv
    mkdir .temp
    cd .temp    
    donwload
    cd ..
    rm -rf .temp
}
# Insere os dados pertinentes na tabela final
insert_table_final()
{
    psql -U root amlcpgf <<EOF
    \x
    INSERT INTO final_ceis
        SELECT "TIPO_DE_PESSOA",
	"CPF_OU_CNPJ_DO_SANCIONADO",
	"NOME_INFORMADO_PELO_ORGAO_SANCIONADOR",
	"RAZAO_SOCIAL_CADASTRO_RECEITA",
	"NOME_FANTASIA_CADASTRO_RECEITA",
	"NUMERO_DO_PROCESSO",
	"TIPO_SANCAO",
	TO_DATE("DATA_INICIO_SANCAO", 'DD/MM/YYYY'),
	TO_DATE("DATA_FINAL_SANCAO", 'DD/MM/YYYY'),
	"ORGAO_SANCIONADOR",
	"UF_ORGAO_SANCIONADOR",
	"ORIGEM_INFORMACOES",
	TO_DATE("DATA_ORIGEM_INFORMACOES", 'DD/MM/YYYY'),
	TO_DATE("DATA_PUBLICACAO", 'DD/MM/YYYY'),
	"PUBLICACAO",
	"DETALHAMENTO",
	"ABRAGENCIA_DEFINIDA_EM_DECISAO_JUDICIAL",
	"FUNDAMENTACAO_LEGAL",
	"DESCRICAO_DA_FUNDAMENTACAO_LEGAL",
	TO_DATE("DATA_DO_TRANSITO_EM_JULGADO", 'DD/MM/YYYY'),
	"COMPLEMENTO_DO_ORGAO",
	"OBSERVACOES"
    FROM tmp_ceis;
EOF
}
# Faz o download do arquivo e importa para o banco
donwload()
{
    echo "Inserindo os dados..."
    arch="20220303"
    url="https://www.portaltransparencia.gov.br/download-de-dados/ceis/$arch"
    wget "$url"
    unzip $arch
    path=$(pwd)
    psql -U root amlcpgf --command="
        COPY tmp_ceis FROM '${path}/${arch}_CEIS.csv' CSV DELIMITER ';' HEADER ENCODING 'latin1';"
}

main
