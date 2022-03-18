insert into "final_viagem" 
select
	"Identificador do processo de viagem",
	"Número da Proposta (PCDP)",
	situação,
	"Viagem Urgente",
	"Justificativa Urgência Viagem",
	"Código do órgão superior",
	"Nome do órgão superior",
	"Código órgão solicitante",
	"Nome órgão solicitante",
	"CPF viajante",
	nome,
	cargo,
	função,
	"Descrição Função",
	to_date("Período - Data de início", 'DD/MM/YYYY'),
	to_date("Período - Data de fim", 'DD/MM/YYYY'),
	destinos,
	motivo,
	cast(replace("Valor diárias", ',', '.') as decimal(20,2)),
	cast(replace("Valor passagens", ',', '.') as decimal(20,2)),
	cast(replace("Valor outros gastos",',','.') as decimal(20,2))
from "tmp_viagem";

