drop table if exists public.tmp_notas;
CREATE TABLE public.tmp_notas (
	"CHAVE DE ACESSO" varchar(1024) NULL,
	modelo varchar(1024) NULL,
	série varchar(1024) NULL,
	número varchar(1024) NULL,
	"NATUREZA DA OPERAÇÃO" varchar(1024) NULL,
	"DATA EMISSÃO" varchar(1024) NULL,
	"CPF/CNPJ Emitente" varchar(1024) NULL,
	"RAZÃO SOCIAL EMITENTE" varchar(1024) NULL,
	"INSCRIÇÃO ESTADUAL EMITENTE" varchar(1024) NULL,
	"UF EMITENTE" varchar(1024) NULL,
	"MUNICÍPIO EMITENTE" varchar(1024) NULL,
	"CNPJ DESTINATÁRIO" varchar(1024) NULL,
	"NOME DESTINATÁRIO" varchar(1024) NULL,
	"UF DESTINATÁRIO" varchar(1024) NULL,
	"INDICADOR IE DESTINATÁRIO" varchar(1024) NULL,
	"DESTINO DA OPERAÇÃO" varchar(1024) NULL,
	"CONSUMIDOR FINAL" varchar(1024) NULL,
	"PRESENÇA DO COMPRADOR" varchar(1024) NULL,
	"NÚMERO PRODUTO" varchar(1024) NULL,
	"DESCRIÇÃO DO PRODUTO/SERVIÇO" varchar(1024) NULL,
	"CÓDIGO NCM/SH" varchar(1024) NULL,
	"NCM/SH (TIPO DE PRODUTO)" varchar(1024) NULL,
	cfop varchar(1024) NULL,
	quantidade varchar(1024) NULL,
	unidade varchar(1024) NULL,
	"VALOR UNITÁRIO" varchar(1024) NULL,
	"VALOR TOTAL" varchar(1024) NULL
);
drop table if exists public.final_notas;
CREATE TABLE public.final_notas (
	"CHAVE DE ACESSO" varchar(1024) NULL,
	modelo varchar(1024) NULL,
	série varchar(1024) NULL,
	número varchar(1024) NULL,
	"NATUREZA DA OPERAÇÃO" varchar(1024) NULL,
	"DATA EMISSÃO" DATE NULL,
	"CPF/CNPJ Emitente" varchar(1024) NULL,
	"RAZÃO SOCIAL EMITENTE" varchar(1024) NULL,
	"INSCRIÇÃO ESTADUAL EMITENTE" varchar(1024) NULL,
	"UF EMITENTE" varchar(1024) NULL,
	"MUNICÍPIO EMITENTE" varchar(1024) NULL,
	"CNPJ DESTINATÁRIO" varchar(1024) NULL,
	"NOME DESTINATÁRIO" varchar(1024) NULL,
	"UF DESTINATÁRIO" varchar(1024) NULL,
	"INDICADOR IE DESTINATÁRIO" varchar(1024) NULL,
	"DESTINO DA OPERAÇÃO" varchar(1024) NULL,
	"CONSUMIDOR FINAL" varchar(1024) NULL,
	"PRESENÇA DO COMPRADOR" varchar(1024) NULL,
	"NÚMERO PRODUTO" varchar(1024) NULL,
	"DESCRIÇÃO DO PRODUTO/SERVIÇO" varchar(1024) NULL,
	"CÓDIGO NCM/SH" varchar(1024) NULL,
	"NCM/SH (TIPO DE PRODUTO)" varchar(1024) NULL,
	cfop varchar(1024) NULL,
	quantidade varchar(1024) NULL,
	unidade varchar(1024) NULL,
	"VALOR UNITÁRIO" decimal(11,2) NULL,
	"VALOR TOTAL" decimal(11,2) NULL
);

