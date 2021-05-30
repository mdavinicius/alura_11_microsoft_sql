insert into [TABELA DE PRODUTOS]
([CODIGO DO PRODUTO], [NOME DO PRODUTO], [EMBALAGEM], [TAMANHO], [SABOR], [PREÇO DE LISTA])
values
('1040107','Light - 350 ml - Melancia', 'Lata', '350 ml', 'Melancia', 4.56)

insert into [TABELA DE PRODUTOS]
([CODIGO DO PRODUTO], [NOME DO PRODUTO], [EMBALAGEM], [TAMANHO], [SABOR], [PREÇO DE LISTA])
values
('1037797','Clean - 2 Litros - Laranja', 'PET', '2 Litros', 'Laranja', 16.01)

insert into [TABELA DE PRODUTOS]
([CODIGO DO PRODUTO], [NOME DO PRODUTO], [EMBALAGEM], [TAMANHO], [SABOR], [PREÇO DE LISTA])
values
('1000889','Sabor da Montanha - 700 ml - Uva', 'Garrafa', '700 ml', 'Uva', 6.31)

insert into [TABELA DE PRODUTOS]
([CODIGO DO PRODUTO], [NOME DO PRODUTO], [EMBALAGEM], [TAMANHO], [SABOR], [PREÇO DE LISTA])
values
('1004327','Videira do Campo - 1,5 Litros - Melancia', 'PET', '1,5 Litros', 'Melancia', 19.51),
('1088216','Linha Citros - 1 Litro - Limão', 'PET', '1 Litro', 'Limão', 7)

insert into [TABELA DE PRODUTOS]
([CODIGO DO PRODUTO], [NOME DO PRODUTO], [EMBALAGEM], [TAMANHO], [SABOR], [PREÇO DE LISTA])
values
('544931', 'Frescor do Verão - 350 ml - Limão', 'PET', '350 ml', 'Limão', 3.20),
('1078680', 'Frescor do Verão - 470 ml - Manga', 'Lata', '470 ml', 'Manga', 5.18)

update [TABELA DE PRODUTOS] set
[EMBALAGEM] = 'Lata',
[PREÇO DE LISTA] = 2.46
where [CODIGO DO PRODUTO] = '544931'

update [TABELA DE PRODUTOS] set
[EMBALAGEM] = 'Garrafa'
WHERE [CODIGO DO PRODUTO] = '1078680'

delete from [TABELA DE PRODUTOS]
where [CODIGO DO PRODUTO] = '1088216'

alter table [TABELA DE PRODUTOS]
alter column [CODIGO DO PRODUTO] varchar(10) not null

alter table [TABELA DE PRODUTOS]
add constraint PK_PRODUTOS
primary key clustered ([CODIGO DO PRODUTO])