insert into "final_bolsa_familia"
select
	"MÊS REFERÊNCIA","MÊS COMPETÊNCIA",uf,"CÓDIGO MUNICÍPIO SIAFI","NOME MUNICÍPIO","CPF FAVORECIDO","NIS FAVORECIDO","NOME FAVORECIDO",cast(replace("VALOR PARCELA", ',', '.') as decimal(11,2))
from "tmp_bolsa_familia";

