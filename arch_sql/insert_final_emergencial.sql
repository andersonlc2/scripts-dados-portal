insert into final_emergencial
select
	"MÊS DISPONIBILIZAÇÃO",uf,"CÓDIGO MUNICÍPIO IBGE","NOME MUNICÍPIO","NIS BENEFICIÁRIO","CPF BENEFICIÁRIO","NOME BENEFICIÁRIO","NIS RESPONSÁVEL","CPF RESPONSÁVEL","NOME RESPONSÁVEL",enquadramento,parcela,observação,cast(replace("VALOR BENEFÍCIO", ',', '.') as decimal(10,2))
from tmp_emergencial;


