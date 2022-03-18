update public."tmp_pep"
    set "DATA_INICIO_EXERCICIO" = null where "DATA_INICIO_EXERCICIO" = 'Não informada';
update public."tmp_pep"
	set "DATA_FIM_EXERCICIO" = null where "DATA_FIM_EXERCICIO" = 'Não informada';
update public."tmp_pep"
	set "DATA_FIM_CARENCIA" = null where "DATA_FIM_CARENCIA" = 'Não informada';


insert into final_pep
select
	"CPF",
    "NOME_PEP",
    "SIGLA_FUNCAO",
    "DESCRICAO_FUNCAO",
    "NIVEL_FUNCAO",
    "NOME_ORGAO",
    to_date("DATA_INICIO_EXERCICIO", 'DD/MM/YYYY'),
    to_date("DATA_FIM_EXERCICIO", 'DD/MM/YYYY'),
    to_date("DATA_FIM_CARENCIA", 'DD/MM/YYYY')
from tmp_pep;

