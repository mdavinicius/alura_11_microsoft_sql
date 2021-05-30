select * from [TABELA DE PRODUTOS]

select * from [TABELA DE PRODUTOS] where [PREÇO DE LISTA] = 8.41

select * from [TABELA DE PRODUTOS] where [PREÇO DE LISTA] >= 8

select * from [TABELA DE PRODUTOS] where [EMBALAGEM] >= 'Lata'

select * from [TABELA DE PRODUTOS] where [EMBALAGEM] <> 'Lata'

select * from [TABELA DE VENDEDORES]

select * from [TABELA DE VENDEDORES] where [COMISSAO] > 0.1

select * from [TABELA DE CLIENTES]

select * from [TABELA DE CLIENTES] where [DATA DE NASCIMENTO] > '2000-01-01'

select * from [TABELA DE CLIENTES] where year([DATA DE NASCIMENTO]) = 1995

select * from [TABELA DE VENDEDORES] where year([DATA ADMISSÃO]) >= 2016