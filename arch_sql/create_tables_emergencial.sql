drop table if exists public.tmp_emergencial;
CREATE TABLE public.tmp_emergencial (
	"MÊS DISPONIBILIZAÇÃO" varchar(1024) NULL,
	uf varchar(1024) NULL,
	"CÓDIGO MUNICÍPIO IBGE" varchar(1024) NULL,
	"NOME MUNICÍPIO" varchar(1024) NULL,
	"NIS BENEFICIÁRIO" varchar(1024) NULL,
	"CPF BENEFICIÁRIO" varchar(1024) NULL,
	"NOME BENEFICIÁRIO" varchar(1024) NULL,
	"NIS RESPONSÁVEL" varchar(1024) NULL,
	"CPF RESPONSÁVEL" varchar(1024) NULL,
	"NOME RESPONSÁVEL" varchar(1024) NULL,
	enquadramento varchar(1024) NULL,
	parcela varchar(1024) NULL,
	observação varchar(1024) NULL,
	"VALOR BENEFÍCIO" varchar(1024) NULL
);

CREATE TABLE if not exists public.final_emergencial (
	"MÊS DISPONIBILIZAÇÃO" varchar(1024) NULL,
	uf varchar(1024) NULL,
	"CÓDIGO MUNICÍPIO IBGE" varchar(1024) NULL,
	"NOME MUNICÍPIO" varchar(1024) NULL,
	"NIS BENEFICIÁRIO" varchar(1024) NULL,
	"CPF BENEFICIÁRIO" varchar(1024) NULL,
	"NOME BENEFICIÁRIO" varchar(1024) NULL,
	"NIS RESPONSÁVEL" varchar(1024) NULL,
	"CPF RESPONSÁVEL" varchar(1024) NULL,
	"NOME RESPONSÁVEL" varchar(1024) NULL,
	enquadramento varchar(1024) NULL,
	parcela varchar(1024) NULL,
	observação varchar(1024) NULL,
	"VALOR BENEFÍCIO" decimal(10,2) NULL
);
