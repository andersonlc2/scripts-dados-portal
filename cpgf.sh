#!/bin/bash

# Script faz o download de arquivos csv do site da transparencia 
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
    CREATE DATABASE amlcpgf;
    \c amlcpgf

    /* cria as tabelas */
    DROP TABLE IF EXISTS public.tmp_cpgf;
    CREATE TABLE public.tmp_cpgf (
        "codigo_orgao_superior" integer NULL,
        "nome_orgao_superior" varchar(1024) NULL,
        "codigo_orgao" integer NULL,
        "nome_orgao" varchar(1024) NULL,
        "codigo_unidade_gestora" integer NULL,
        "nome_unidade_gestora" varchar(1024) NULL,
        "ano" integer NULL,
        "mes" integer NULL,
        "cpf_portador" varchar(1024) NULL,
        "nome_portador" varchar(1024) NULL,
        "documento_favorecido" varchar(1024) NULL,
        "nome_favorecido" varchar(1024) NULL,
        "transacao" varchar(1024) NULL,
        "data" varchar(1024) NULL,
        "valor" varchar(1024) NULL
    );
    CREATE TABLE IF NOT EXISTS public.final_cpgf (
        "codigo_orgao_superior" integer NULL,
        "nome_orgao_superior" varchar(1024) NULL,
        "codigo_orgao" integer NULL,
        "nome_orgao" varchar(1024) NULL,
        "codigo_unidade_gestora" integer NULL,
        "nome_unidade_gestora" varchar(1024) NULL,
        "ano" integer NULL,
        "mes" integer NULL,
        "cpf_portador" varchar(1024) NULL,
        "nome_portador" varchar(1024) NULL,
        "documento_favorecido" varchar(1024) NULL,
        "nome_favorecido" varchar(1024) NULL,
        "transacao" varchar(1024) NULL,
        "data" date NULL,
        "valor" decimal(20,2) NULL
    );
EOF
}

# Faz download do csv, descompacta e importa os dados para o banco
import_data()
{
    # Cria pasta temporária para armazenar os arquivos csv
    mkdir .temp
    cd .temp
    
    # Inicia o loop que vai passar por todos os periodos 
    mi=0
    mf=12
    p=""
    cont=1
    for y in $(seq $year_init $year_fin);
    do
        if [ $cont -eq 1 ];
        then
            mi=$month_init
        else
            mi=1
        fi

        if [ $y -eq $year_fin ];
        then
            mf=$month_fin
        fi

        for m in $(seq $mi $mf);
        do
            if [ "$m" -lt 10 ]; 
            then
                p+="${y}0${m}"
            else
                p+="$y$m"
            fi

            donwload_import $p
            # echo $p

            unset p
        done      

        cont=$((cont+1))
    done

    cd ..
    rm -rf .temp
}

# Insere os dados pertinentes na tabela final
insert_table_final()
{
    psql -U root amlcpgf --command="
        INSERT INTO final_cpgf
        SELECT codigo_orgao_superior,
            nome_orgao_superior,
            codigo_orgao,
            nome_orgao,
            codigo_unidade_gestora,
            nome_unidade_gestora,
            ano,
            mes,
            cpf_portador,
            nome_portador,
            documento_favorecido,
            nome_favorecido,
            transacao,
            TO_DATE("data",'DD/MM/YYYY') AS data_transacao,
            CAST(REPLACE(valor, ',', '.') as DECIMAL(20, 2))
        FROM tmp_cpgf;"
}

# Faz o download do arquivo e importa para o banco
donwload_import()
{
    echo "Inserindo os dados: $1"
    url="https://www.portaltransparencia.gov.br/download-de-dados/cpgf/$1"
    wget "$url" 2>log${1}.txt
    unzip "$1"
    path=$(pwd)
    psql -U root amlcpgf --command="
        COPY tmp_cpgf FROM '${path}/${1}_CPGF.csv' CSV DELIMITER ';' HEADER ENCODING 'latin1';"
    mv log${1}.txt ../
}


# Trata os parametros passados
if [ $# == 0 ];
then
    month_init=01
    year_init=2017
    month_fin=12
    year_fin=2021
    
    main
elif [ $# == 4 ];
then
    month_init=$1
    year_init=$2
    month_fin=$3
    year_fin=$4

    main
else
    echo "Error: incorrect number of parameters"
fi


