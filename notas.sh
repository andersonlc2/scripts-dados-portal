#!/bin/bash

# Script faz o download de arquivos csv do site da transparencia 
# do governo e armazena os dados no banco de dados postgres.

tmp="tmp_notas"
final="final_notas"

main()
{
    create_db_and_tables
    import_data
    insert_table_final
}

# Inicia um novo banco e as devidas tabelas caso nao existam
create_db_and_tables()
{
    psql -U root amlcpgf < arch_sql/create_tables_notas.sql
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
            # echo "$p"

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
    psql -U root amlcpgf < arch_sql/insert_final_notas.sql
}

# Faz o download do arquivo e importa para o banco
donwload_import()
{
    echo "Inserindo os dados: $1"
    url="https://www.portaltransparencia.gov.br/download-de-dados/notas-fiscais/$1"
    wget "$url"
    unzip "$1"
    path=$(pwd)
    psql -U root amlcpgf --command="
        COPY $tmp  FROM '${path}/${1}_NFe_NotaFiscalItem.csv' CSV DELIMITER ';' HEADER ENCODING 'latin1';"
    rm -rf "${1}"*
}


# Trata os parametros passados
if [ $# == 0 ];
then
    month_init=09
    year_init=2021
    month_fin=09
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


