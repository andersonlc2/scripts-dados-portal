drop table if exists public.tmp_bolsa_familia;
CREATE TABLE public.tmp_bolsa_familia (
	"MÊS REFERÊNCIA" varchar(1024) NULL,
	"MÊS COMPETÊNCIA" varchar(1024) NULL,
	uf varchar(1024) NULL,
	"CÓDIGO MUNICÍPIO SIAFI" varchar(1024) NULL,
	"NOME MUNICÍPIO" varchar(1024) NULL,
	"CPF FAVORECIDO" varchar(1024) NULL,
	"NIS FAVORECIDO" varchar(1024) NULL,
	"NOME FAVORECIDO" varchar(1024) NULL,
	"VALOR PARCELA" varchar(1024) NULL
);

CREATE TABLE if not exists public.final_bolsa_familia (
	"MÊS REFERÊNCIA" varchar(1024) NULL,
	"MÊS COMPETÊNCIA" varchar(1024) NULL,
	uf varchar(1024) NULL,
	"CÓDIGO MUNICÍPIO SIAFI" varchar(1024) NULL,
	"NOME MUNICÍPIO" varchar(1024) NULL,
	"CPF FAVORECIDO" varchar(1024) NULL,
	"NIS FAVORECIDO" varchar(1024) NULL,
	"NOME FAVORECIDO" varchar(1024) NULL,
	"VALOR PARCELA" decimal(11,2) NULL
);
