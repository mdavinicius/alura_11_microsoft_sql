select * from [TABELA DE PRODUTOS] where EMBALAGEM = 'PET' or EMBALAGEM = 'Garrafa'

select * from [TABELA DE PRODUTOS] where EMBALAGEM = 'PET' and TAMANHO = '2 Litros'

select * from [TABELA DE PRODUTOS] where EMBALAGEM = 'PET' or TAMANHO = '2 Litros'

select * from [TABELA DE PRODUTOS] where EMBALAGEM = 'PET' or not (TAMANHO = '2 Litros')

select * from [TABELA DE PRODUTOS] where not (EMBALAGEM = 'PET' and TAMANHO = '2 Litros')

select * from [TABELA DE PRODUTOS] where EMBALAGEM = 'PET' and not (TAMANHO = '2 Litros')

select * from [TABELA DE PRODUTOS] where [SABOR] in ('Morango', 'Laranja')

select * from [TABELA DE PRODUTOS] where [SABOR] not in ('Morango', 'Laranja')

select * from [TABELA DE PRODUTOS] where [SABOR] in ('Morango', 'Laranja') and [PREÇO DE LISTA] between 10 and 20

select * from [ITENS NOTAS FISCAIS] where QUANTIDADE > 60 and [PREÇO] <= 3

select * from [TABELA DE VENDEDORES] where NOME like '%Silva'

select * from [TABELA DE CLIENTES] where NOME like '%Mattos'

select EMBALAGEM, TAMANHO from [TABELA DE PRODUTOS]

select top 10 EMBALAGEM, TAMANHO from [TABELA DE PRODUTOS]

select distinct EMBALAGEM, TAMANHO from [TABELA DE PRODUTOS]

select distinct BAIRRO, CIDADE from [TABELA DE CLIENTES] where CIDADE = 'Rio de Janeiro'

select BAIRRO, CIDADE from [TABELA DE CLIENTES] where CIDADE = 'Rio de Janeiro'

select top 10 * from [dbo].[NOTAS FISCAIS] where DATA = '2017-01-01' 

select top 10 * from [dbo].[NOTAS FISCAIS] where DATA = '2017-01-01' order by MATRICULA

select top 10 * from [dbo].[NOTAS FISCAIS] where DATA = '2017-01-01' order by MATRICULA, NUMERO

select top 10 EMBALAGEM, TAMANHO from [TABELA DE PRODUTOS] order by TAMANHO desc

select EMBALAGEM, TAMANHO from [TABELA DE PRODUTOS] order by TAMANHO desc

select * from [TABELA DE PRODUTOS] where [NOME DO PRODUTO] = 'Linha Refrescante - 1 Litro - Morango/Limão'

select * from [ITENS NOTAS FISCAIS] where [CODIGO DO PRODUTO] = '1101035' order by QUANTIDADE desc

select count(*) from [ITENS NOTAS FISCAIS] where [CODIGO DO PRODUTO] = '1101035' and QUANTIDADE = '99'

select * from [TABELA DE PRODUTOS]

select EMBALAGEM, max([PREÇO DE LISTA]) as 'PREÇO MAX', min([PREÇO DE LISTA]) as 'PREÇO MIN' from [TABELA DE PRODUTOS] group by EMBALAGEM having max([PREÇO DE LISTA]) >= 5 order by max([PREÇO DE LISTA])

select * from [NOTAS FISCAIS]

select CPF, count(*) as 'QNTD COMRPAS' from [NOTAS FISCAIS] where year(DATA) = 2016 group by CPF having count(*) > 2000

select [NOME DO PRODUTO], [PREÇO DE LISTA],
case when [PREÇO DE LISTA] <= 5 then 'barato'
when [PREÇO DE LISTA] > 5 and [PREÇO DE LISTA] <= 20 then 'preço intermediário'
else 'caro'
end
from [TABELA DE PRODUTOS]

select [NOME DO PRODUTO], [PREÇO DE LISTA],
case when [PREÇO DE LISTA] <= 5 then 'barato'
when [PREÇO DE LISTA] > 5 and [PREÇO DE LISTA] <= 20 then 'preço intermediário'
else 'caro' end,
avg([PREÇO DE LISTA])
from [TABELA DE PRODUTOS]
group by [NOME DO PRODUTO], [PREÇO DE LISTA],
case when [PREÇO DE LISTA] <= 5 then 'barato'
when [PREÇO DE LISTA] > 5 and [PREÇO DE LISTA] <= 20 then 'preço intermediário'
else 'caro' end

select CPF, 
case when count(*) < 2000 then 'compra pouco'
else 'compra > 2000' end as 'Perfil',
count(*) as 'QNTD COMRPAS' from [NOTAS FISCAIS] where year(DATA) = 2016 group by CPF

select * from [NOTAS FISCAIS]

select year(DATA), count(*) from [NOTAS FISCAIS] group by year(DATA) order by year(DATA)

select * from [TABELA DE CLIENTES]

select [NOME],
case
	when year([DATA DE NASCIMENTO]) < 1990 then 'Adulto'
	when year([DATA DE NASCIMENTO]) >= 1990 and year([DATA DE NASCIMENTO]) <= 1995 then 'Jovem'
	else 'Criança' end
from [TABELA DE CLIENTES]

select * from [TABELA DE VENDEDORES]
select * from [NOTAS FISCAIS]

select a.NOME, a.[PERCENTUAL COMISSÃO], b.CPF from [TABELA DE VENDEDORES] a inner join [NOTAS FISCAIS] b on a.MATRICULA = b.MATRICULA

select a.MATRICULA, a.NOME, count(*) from [TABELA DE VENDEDORES] a inner join [NOTAS FISCAIS] b on a.MATRICULA = b.MATRICULA group by a.MATRICULA, a.NOME

select a.MATRICULA, a.NOME, year(DATA) as 'Anos', count(*) as 'Qtd' from [TABELA DE VENDEDORES] a inner join [NOTAS FISCAIS] b on a.MATRICULA = b.MATRICULA
group by a.MATRICULA, a.NOME, year(DATA)

select a.MATRICULA, a.NOME, year(DATA) as 'Anos', count(*) as 'Qtd' from [TABELA DE VENDEDORES] a inner join [NOTAS FISCAIS] b on a.MATRICULA = b.MATRICULA
group by a.MATRICULA, a.NOME, year(DATA) order by a.NOME, year(DATA)

select * from [ITENS NOTAS FISCAIS]
select * from [NOTAS FISCAIS]

select year(DATA), sum(QUANTIDADE * PREÇO) from [ITENS NOTAS FISCAIS] a inner join [NOTAS FISCAIS] b on a.NUMERO = b.NUMERO group by year(DATA)

select * from [TABELA DE CLIENTES]
select * from [NOTAS FISCAIS]

select a.NOME, a.CPF, count(*) from [TABELA DE CLIENTES] a left join [NOTAS FISCAIS] b on a.CPF = b.CPF group by a.NOME, a.CPF

select [TABELA DE VENDEDORES].BAIRRO, [TABELA DE VENDEDORES].NOME, [TABELA DE CLIENTES].BAIRRO, [TABELA DE CLIENTES].NOME
from [TABELA DE VENDEDORES] right join [TABELA DE CLIENTES] on [TABELA DE VENDEDORES].BAIRRO = [TABELA DE CLIENTES].BAIRRO

select [TABELA DE VENDEDORES].BAIRRO, [TABELA DE VENDEDORES].NOME, [TABELA DE CLIENTES].BAIRRO, [TABELA DE CLIENTES].NOME
from [TABELA DE VENDEDORES] left join [TABELA DE CLIENTES] on [TABELA DE VENDEDORES].BAIRRO = [TABELA DE CLIENTES].BAIRRO

select [TABELA DE VENDEDORES].BAIRRO, [TABELA DE VENDEDORES].NOME, [TABELA DE CLIENTES].BAIRRO, [TABELA DE CLIENTES].NOME
from [TABELA DE VENDEDORES] full join [TABELA DE CLIENTES] on [TABELA DE VENDEDORES].BAIRRO = [TABELA DE CLIENTES].BAIRRO

select [TABELA DE VENDEDORES].BAIRRO, [TABELA DE VENDEDORES].NOME, [TABELA DE CLIENTES].BAIRRO, [TABELA DE CLIENTES].NOME
from [TABELA DE VENDEDORES] cross join [TABELA DE CLIENTES]

select a.BAIRRO from [TABELA DE VENDEDORES] a
union
select b.BAIRRO from [TABELA DE CLIENTES] b

select a.BAIRRO from [TABELA DE VENDEDORES] a
union all
select b.BAIRRO from [TABELA DE CLIENTES] b order by BAIRRO

select NOME, BAIRRO from [TABELA DE CLIENTES] where BAIRRO in (select BAIRRO from [TABELA DE VENDEDORES])

SELECT CPF, COUNT(*) FROM [NOTAS FISCAIS]
WHERE YEAR(DATA) = 2016
GROUP BY CPF
HAVING COUNT(*) > 2000

select x.CPF, x.conta from (select CPF, count (*) as 'conta' from [NOTAS FISCAIS] where year(DATA) = 2016 group by CPF) X where x.conta > 2000

select x.CPF, x.CONTADOR from VW_CPF2016 X where x.CONTADOR > 2000

select SELLERS.NOME, YEAR(NF.DATA) as 'ANO' , count(*) as 'QNTD DE VENDAS'from [TABELA DE VENDEDORES] SELLERS inner join [NOTAS FISCAIS] NF on SELLERS.MATRICULA = NF.MATRICULA group by SELLERS.NOME, YEAR(NF.DATA) order by SELLERS.NOME

select ltrim('   oi')
select left('oi tudo bem?', 2)
select concat('oi',' ', 'tudo bem?')

select * from [TABELA DE CLIENTES]

select CONCAT([ENDERECO 1], ', ', BAIRRO,', ', CIDADE,', ', ESTADO) from [TABELA DE CLIENTES]

select SYSDATETIME(), SYSDATETIMEOFFSET(), SYSUTCDATETIME()
select CURRENT_TIMESTAMP, GETDATE(), GETUTCDATE()

select DATENAME(year, GETDATE())
select DATETIMEFROMPARTS(1989, 03, 15, 12, 00, 10, 0)

select DATEDIFF(YEAR, '1989', GETDATE())
select DATEADD(YEAR, 32, '1989')

select [DATA], CONCAT(DATENAME(DAY, [DATA]), ' ', DATENAME(MONTH, [DATA]), ' ', DATENAME(YEAR, [DATA]))
from [NOTAS FISCAIS]

select * from [TABELA DE CLIENTES]
select NOME, DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE()) as 'IDADE' from [TABELA DE CLIENTES]

select FLOOR(12.58)
select RAND()
select ROUND(12.783141, 1)

select * from [NOTAS FISCAIS]
select * from [ITENS NOTAS FISCAIS]

select YEAR(DATA) as 'ANO', FLOOR(SUM((b.QUANTIDADE * b.PREÇO) * a.IMPOSTO)) as 'IMPOSTO GERAL' from [NOTAS FISCAIS] a inner join [ITENS NOTAS FISCAIS] b on a.NUMERO = b.NUMERO
where YEAR(DATA) = 2016
group by YEAR(DATA)

select CONVERT(varchar, GETDATE(), 101)
select CONVERT(varchar, GETDATE(), 113)
select CONVERT(varchar, GETDATE(), 130)
select CONVERT(decimal(10,2), 193.57)

select * from [TABELA DE CLIENTES]
select * from [NOTAS FISCAIS]
select * from [ITENS NOTAS FISCAIS]

select 'O cliente ' + TC.NOME + ' faturou R$ ' + CONVERT(varchar, CONVERT(DECIMAL(15,2), (SUM((INF.QUANTIDADE * INF.PREÇO))))) + ' no ano de 2016.'
from [NOTAS FISCAIS] NF
inner join [TABELA DE CLIENTES] TC on NF.CPF = TC.CPF
inner join [ITENS NOTAS FISCAIS] INF on NF.NUMERO = INF.NUMERO
where YEAR(DATA) = 2016
group by NOME

select CONCAT('O cliente ', TC.NOME, ' faturou R$ ', CONVERT(varchar, CONVERT(DECIMAL(15,2), (SUM((INF.QUANTIDADE * INF.PREÇO))))), ' no ano de 2016.')
from [NOTAS FISCAIS] NF
inner join [TABELA DE CLIENTES] TC on NF.CPF = TC.CPF
inner join [ITENS NOTAS FISCAIS] INF on NF.NUMERO = INF.NUMERO
where YEAR(DATA) = 2016
group by NOME