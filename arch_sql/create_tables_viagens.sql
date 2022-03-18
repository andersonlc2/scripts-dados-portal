drop table if exists "tmp_viagem";
CREATE TABLE "tmp_viagem" (
	"Identificador do processo de viagem" varchar(1024) NULL,
	"Número da Proposta (PCDP)" varchar(1024) NULL,
	situação varchar(1024) NULL,
	"Viagem Urgente" varchar(1024) NULL,
	"Justificativa Urgência Viagem" varchar(1024) NULL,
	"Código do órgão superior" varchar(1024) NULL,
	"Nome do órgão superior" varchar(1024) NULL,
	"Código órgão solicitante" varchar(1024) NULL,
	"Nome órgão solicitante" varchar(1024) NULL,
	"CPF viajante" varchar(1024) NULL,
	nome varchar(1024) NULL,
	cargo varchar(1024) NULL,
	função varchar(1024) NULL,
	"Descrição Função" varchar(1024) NULL,
	"Período - Data de início" varchar(1024) NULL,
	"Período - Data de fim" varchar(1024) NULL,
	destinos varchar(1024) NULL,
	motivo varchar(1024) NULL,
	"Valor diárias" varchar(1024) NULL,
	"Valor passagens" varchar(1024) NULL,
	"Valor outros gastos" varchar(1024) NULL
);
drop table if exists "final_viagem";
CREATE TABLE "final_viagem" (
	"Identificador do processo de viagem" varchar(1024) NULL,
	"Número da Proposta (PCDP)" varchar(1024) NULL,
	situação varchar(1024) NULL,
	"Viagem Urgente" varchar(1024) NULL,
	"Justificativa Urgência Viagem" varchar(1024) NULL,
	"Código do órgão superior" varchar(1024) NULL,
	"Nome do órgão superior" varchar(1024) NULL,
	"Código órgão solicitante" varchar(1024) NULL,
	"Nome órgão solicitante" varchar(1024) NULL,
	"CPF viajante" varchar(1024) NULL,
	nome varchar(1024) NULL,
	cargo varchar(1024) NULL,
	função varchar(1024) NULL,
	"Descrição Função" varchar(1024) NULL,
	"Período - Data de início" date NULL,
	"Período - Data de fim" date NULL,
	destinos varchar(1024) NULL,
	motivo varchar(1024) NULL,
	"Valor diárias" decimal(20, 2) NULL,
	"Valor passagens" decimal(20, 2) NULL,
	"Valor outros gastos" decimal(20, 2) NULL
);

