#!/bin/bash

# Script faz o download de arquivos referente a viagens do portal da transparencia 

main()
{
    create_db_and_tables
    import_data
    insert_table_final
}

# Inicia um novo banco e as devidas tabelas caso nao existam
create_db_and_tables()
{
    psql -U root amlcpgf  < arch_sql/create_tables_viagens.sql
}

# Faz download do csv, descompacta e importa os dados para o banco
import_data()
{
    # Cria pasta temporária para armazenar os arquivos csv
    mkdir .temp; cd .temp
    download
    cd ..; rm -rf .temp
}

# Insere os dados pertinentes na tabela final
insert_table_final()
{
    psql -U root amlcpgf < arch_sql/insert_final_viagens.sql 
}

# Faz o download do arquivo e importa para o banco
download()
{
    url="https://www.portaltransparencia.gov.br/download-de-dados/viagens/2022"
    wget "$url" 2>>log.txt
    unzip "2022"
    path=$(pwd)
    psql -U root amlcpgf --command="
        COPY tmp_viagem FROM '${path}/2022_Viagem.csv' CSV DELIMITER ';' HEADER ENCODING 'latin1';"
    mv log.txt ../
}

main
