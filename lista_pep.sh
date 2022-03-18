#!/bin/bash

# Script faz o download da lista pep do site da transparencia 
# do governo e armazena os dados no banco de dados postgres.

main()
{
    create_db_and_tables
    import_data
    insert_table_final
}

# Inicia um novo banco e as devidas tabelas caso nao existam
create_db_and_tables()
{
    psql -U root postgres << EOF 
    /* cria um novo banco de dados */
    CREATE DATABASE listapep;
    \c listapep
    DROP TABLE IF EXISTS public.tmp_pep;
    CREATE TABLE public.tmp_pep (
        cpf VARCHAR(1024) NULL,
        nome VARCHAR(1024) NULL,
        codigo_funcao VARCHAR(32) NULL,
        nome_funcao VARCHAR(1024) NULL,
        nivel_funcao VARCHAR(32) NULL,
        nome_orgao VARCHAR(1024) NULL,
        data_inicio VARCHAR(32) NULL,
        data_fim VARCHAR(32) NULL,
        fim_carencia VARCHAR(32) NULL
);
    DROP TABLE IF EXISTS public.final_pep;
    CREATE TABLE public.final_pep (
        cpf VARCHAR(1024) NULL,
        nome VARCHAR(1024) NULL,
        motivo VARCHAR(1024) NULL,
        orgao VARCHAR(1024) NULL,
        data_fim VARCHAR NULL
);
EOF
}

# Faz download do csv, descompacta e importa os dados para o banco
import_data()
{
    # Cria pasta temporária para armazenar os arquivos csv
    mkdir .temp
    cd .temp
    p="${year}${month}"
    donwload_import $p
    cd ..
    rm -rf .temp
}
# Insere os dados pertinentes na tabela final
insert_table_final()
{
    psql -U root listapep <<EOF
    \x
    INSERT INTO final_pep (cpf, nome, motivo, orgao, data_fim)
        SELECT cpf,
                nome,
                nome_funcao,
                nome_orgao,
                data_fim
        FROM tmp_pep;
EOF
}
# Faz o download do arquivo e importa para o banco
donwload_import()
{
    echo "Inserindo os dados..."
    url="https://www.portaltransparencia.gov.br/download-de-dados/pep/$1"
    wget "$url" 2>log${1}.txt
    unzip "$1"
    path=$(pwd)
    psql -U root listapep --command="
        COPY tmp_pep FROM '${path}/${1}_PEP.csv' CSV DELIMITER ';' HEADER ENCODING 'latin1';"
    mv log${1}.txt ../
}


# Trata os parametros passados
if [ $# == 2 ];
then
    month=$1
    year=$2

    main
else
    echo "Error: incorrect number of parameters"
fi


