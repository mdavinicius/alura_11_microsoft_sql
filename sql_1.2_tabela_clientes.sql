create table [TABELA DE CLIENTES]
([CPF] varchar(11), [NOME] varchar(100), [ENDERECO 1] varchar(150), [ENDERECO 2] varchar(150), [BAIRRO] varchar(50), [CIDADE] varchar(50), [ESTADO] varchar(2),
[CEP] varchar(8), [DATA DE NASCIMENTO] date, [IDADE] smallint, [SEXO] varchar(1), [LIMITE DE CREDITO] money, [VOLUME DE COMPRA] float, [PRIMEIRA COMPRA] bit)


alter table [TABELA DE CLIENTES]
alter column [CPF] varchar(11) not null

alter table [TABELA DE CLIENTES]
add constraint PK_CLIENTES
primary key clustered ([CPF])

INSERT INTO [dbo].[TABELA DE CLIENTES]
           ([CPF], [NOME], [ENDERECO 1], [ENDERECO 2], [BAIRRO], [CIDADE], [ESTADO], [CEP], [DATA DE NASCIMENTO], [IDADE],
		   [SEXO], [LIMITE DE CREDITO], [VOLUME DE COMPRA], [PRIMEIRA COMPRA])
     VALUES
           ('00300000001', 'João da Silva', 'Rua Projetada A número 10', '', 'Centro', 'Rio de Janeiro', 'RJ',
           '20000000', '1990-10-25', 27, 'M', 120000.50, 1000, 1)