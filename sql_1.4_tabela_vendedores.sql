create table [TABELA DE VENDEDORES]
([MATRICULA] varchar(5), [NOME] varchar(100), [PERCENTUAL COMISSAO] float)

create table [TABELA DE CLIENTES]
(
[CPF] varchar(11), [NOME] varchar(100), [ENDERECO 1] varchar(150), [ENDERECO 2] varchar(150), [BAIRRO] varchar(50), [CIDADE] varchar(50),
[ESTADO] varchar(2), [CEP] varchar(8), [DATA DE NASCIMENTO] date, [IDADE] smallint, [SEXO] varchar(1), [LIMITE DE CREDITO] smallmoney, [PRIMEIRA COMPRA] bit
)

create table [TABELA DE PRODUTOS]
([CODIGO DO PRODUTO] varchar(10), [NOME DO PRODUTO] varchar(50), [EMBALAGEM] varchar(20), [TAMANHO] varchar(10), [SABOR] varchar(20), [PREÇO DE LISTA] smallmoney)

insert into [TABELA DE VENDEDORES]
([MATRICULA], [NOME], [PERCENTUAL COMISSAO])
values
('00233', 'José Geraldo Fonsenca', 0.1)

insert into [TABELA DE VENDEDORES]
([MATRICULA], [NOME], [PERCENTUAL COMISSAO])
values
('00235', 'Márcio Almeida Silva', 0.08)

insert into [TABELA DE VENDEDORES]
([MATRICULA], [NOME], [PERCENTUAL COMISSAO])
values
('00236', 'Cláudia Morais', 0.08)

insert into [TABELA DE VENDEDORES]
([MATRICULA], [NOME], [PERCENTUAL COMISSAO])
values
('00237', 'Roberta Martins', 0.11)

insert into [TABELA DE VENDEDORES]
([MATRICULA], [NOME], [PERCENTUAL COMISSAO])
values
('00238', 'Pericles Alves', 0.11)

update [TABELA DE VENDEDORES] set
[NOME] = 'José Geraldo Fonsenca Junior'
where [MATRICULA] = '00233'

alter table [TABELA DE VENDEDORES]
alter column [MATRICULA] varchar(5) not null

alter table [TABELA DE VENDEDORES]
add constraint PK_VENDEDORES
primary key clustered ([MATRICULA])

alter table [TABELA DE VENDEDORES]
drop constraint PK_PRODUTOS

alter table [TABELA DE CLIENTES]
alter column [CPF] varchar (11) not null

alter table [TABELA DE CLIENTES]
add constraint PK_CLIENTES
primary key clustered ([CPF])

drop table [TABELA DE VENDEDORES]

create table [TABELA DE VENDEDORES]
([MATRICULA] varchar(5) not null, [NOME] varchar(100), [COMISSAO] float, [DATA ADMISSÃO] date, [DE FÉRIAS] bit)

alter table [TABELA DE VENDEDORES]
add constraint PK_VENDEDORES
primary key clustered ([MATRICULA])

INSERT INTO [dbo].[TABELA DE VENDEDORES]
           ([MATRICULA],[NOME], [COMISSAO], [DATA ADMISSÃO], [DE FÉRIAS])
     VALUES
           ('00235', 'Márcio Almeida Silva', 0.08, '2014-08-15', '0')

INSERT INTO [dbo].[TABELA DE VENDEDORES]
           ([MATRICULA],[NOME], [COMISSAO], [DATA ADMISSÃO], [DE FÉRIAS])
     VALUES
           ('00236', 'Cláudia Morais', 0.08, '2013-09-17', '1')

INSERT INTO [dbo].[TABELA DE VENDEDORES]
           ([MATRICULA],[NOME], [COMISSAO], [DATA ADMISSÃO], [DE FÉRIAS])
     VALUES
           ('00237', 'Roberta Martins', 0.11, '2017-03-18', '1')

INSERT INTO [dbo].[TABELA DE VENDEDORES]
           ([MATRICULA],[NOME], [COMISSAO], [DATA ADMISSÃO], [DE FÉRIAS])
     VALUES
           ('00238', 'Pericles Alves', 0.11, '2016-08-21', '0')

select NOME, MATRICULA from [TABELA DE VENDEDORES]

select * from [TABELA DE VENDEDORES] where NOME = 'Cláudia Morais' 