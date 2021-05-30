--Crie 4 variáveis com as características abaixo:
--Nome: Cliente. Tipo: Caracteres com 10 posições. Valor: João
--Nome: Idade. Tipo: Inteiro. Valor: 10
--Nome: DataNascimento. Tipo: Data. Valor: 10/01/2007
--Nome: Custo. Tipo: Número com casas decimais. Valor: 10,23
--Construa um script que declare estas variáveis, atribua valores a elas e exiba-as na saída do SQL Server Management Studio.

DECLARE @NOME VARCHAR(10), @IDADE INT, @DATA_NASCIMENTO DATE, @CUSTO FLOAT

SET @NOME = 'Cliente'
SET @IDADE = '10'
SET @DATA_NASCIMENTO = '20070110'
SET @CUSTO = '10.23'

PRINT @NOME
PRINT @IDADE
PRINT @DATA_NASCIMENTO
PRINT @CUSTO
--------------------

--Crie uma variável chamada NUMNOTAS e atribua a ela o número de notas fiscais do dia 01/01/2017. Mostre na saída do script o valor da variável.

SELECT * FROM [NOTAS FISCAIS]
WHERE DATA = '20170101'

DECLARE @NUMNOTAS INT

SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS]
WHERE DATA = '20170101'
GROUP BY DATA

PRINT @NUMNOTAS
--------------------

--Qual é o comando para testar se uma tabela TAB existe no SQL Server?
IF OBJECT_ID('TAB', 'U') IS NULL
BEGIN
	PRINT('NÃO EXISTE') 
END

--ou, se for apenas um comando, não precisa do Begin/End
IF OBJECT_ID('TAB', 'U') IS NULL PRINT('NÃO EXISTE') 
--------------------

--Crie um script que, baseado em uma data, que conte o número de notas fiscais. Se houver mais de 70 notas, exiba a mensagem "Muita nota".
--Se não, exiba a mensagem "Pouca nota". Exiba também o número de notas.

SELECT * FROM [NOTAS FISCAIS]

DECLARE @DIA_NF VARCHAR(8)
SET @DIA_NF = '20150106'

DECLARE @TOTAL_DIAS INT
SET @TOTAL_DIAS = (SELECT COUNT(*) FROM [NOTAS FISCAIS] WHERE DATA = @DIA_NF)

PRINT (@TOTAL_DIAS)

IF @TOTAL_DIAS > 70
PRINT ('Muita nota')
ELSE
PRINT ('Pouca nota')
--------------------

--Faça um script que, a partir do dia 01/01/2017, conte o número de notas fiscais até o dia 10/01/2017. Imprima a data e o número de notas fiscais.
--Minha versão

DECLARE @DATA_INICIAL DATE, @DATA_FINAL DATE
SET @DATA_INICIAL = '20170101'
SET @DATA_FINAL = '20170110'

WHILE @DATA_INICIAL <= @DATA_FINAL
	BEGIN
		SELECT DATA, COUNT(DATA) FROM [NOTAS FISCAIS]
		WHERE DATA = @DATA_INICIAL
		GROUP BY DATA
		
		SET @DATA_INICIAL = DATEADD(DAY, 1, @DATA_INICIAL)
	END

--Versão curso

DECLARE @DATA_INICIAL DATE, @DATA_FINAL DATE, @NUM_NOTAS INT
SET @DATA_INICIAL = '20170101'
SET @DATA_FINAL = '20170110'

WHILE @DATA_INICIAL <= @DATA_FINAL
BEGIN
	SELECT @NUM_NOTAS = COUNT(*) FROM [NOTAS FISCAIS]
		WHERE DATA = @DATA_INICIAL
	PRINT CONVERT(VARCHAR(10), @DATA_INICIAL) + ' -> ' + CONVERT(VARCHAR(10), @NUM_NOTAS)
	SELECT @DATA_INICIAL = DATEADD(DAY, 1, @DATA_INICIAL)
END
--------------------

--Continue evoluindo o script da resposta do exercício anterior. Agora, inclua o dia e o número de notas em uma tabela.

IF OBJECT_ID('NOTASF', 'U') IS NOT NULL
	DROP TABLE NOTASF
ELSE
	CREATE TABLE [NOTASF] (DIA DATE, [TOTAL_NOTAS] INT)

DECLARE @DATA_INICIAL DATE, @DATA_FINAL DATE, @NUM_NOTAS INT
SET @DATA_INICIAL = '20170101'
SET @DATA_FINAL = '20170110'

WHILE @DATA_INICIAL <= @DATA_FINAL
BEGIN
	SELECT @NUM_NOTAS = COUNT(*) FROM [NOTAS FISCAIS]
		WHERE DATA = @DATA_INICIAL
	
	INSERT INTO NOTASF (DIA, [TOTAL_NOTAS]) 
		VALUES (@DATA_INICIAL, @NUM_NOTAS)
	
	SELECT @DATA_INICIAL = DATEADD(DAY, 1, @DATA_INICIAL)
END

SELECT * FROM [NOTASF]
--------------------

--Crie uma nova consulta, obtenha a soma dos limites de créditos de clientes de um determinado bairro e compare-a com um valor máximo previamente determinado.
--Se a soma dos limites for maior que este valor, haverá uma resposta negativa, se não, positiva.

DECLARE @LIMITE FLOAT, @LIMITEDOBAIRRO FLOAT
SET @LIMITE = 500000
SET @LIMITEDOBAIRRO = (SELECT SUM([LIMITE DE CREDITO]) FROM [TABELA DE CLIENTES] WHERE BAIRRO = 'Tijuca')

PRINT(@LIMITEDOBAIRRO)

IF @LIMITEDOBAIRRO < @LIMITE
	PRINT('LIMITE PERMITIDO PARA NOVO CADASTRO')
ELSE
	PRINT('LIMITE INSUFICIENTE')

--------------------

--Crie uma nova consulta. Gere um loop para exibir um contador de números entre 1 e um valor máximo.

DECLARE @MIN INT, @MAX INT
SET @MIN = 1
SET @MAX = 10

WHILE @MIN <= @MAX
BEGIN
	PRINT(@MIN)
	SET @MIN = @MIN + 1
END
--------------------

--Em exercícios anteriores, construímos um script para obter o número de notas fiscais de uma determinada data.
--Transforme este script em uma função onde passamos a data como parâmetro e retornamos o número de notas. Chame esta função de NumeroNotas. Execute o SELECT para exibir os dados.

CREATE FUNCTION NumeroNotas (@DATA DATE) RETURNS INT
AS
BEGIN
	DECLARE @NUM_NOTAS INT
	SELECT @NUM_NOTAS = COUNT(*) FROM [NOTAS FISCAIS]
		WHERE DATA = @DATA
	RETURN @NUM_NOTAS
END

SELECT [dbo].[NumeroNotas]('20170102')
--------------------

--Em exercícios anteriores construímos um script para criar uma tabela com o número de notas fiscais para um período de datas.
--Reescreva este script usando a função NumeroNotas no momento de inserir dados na tabela. Execute o SELECT para exibir os dados.

IF OBJECT_ID('NOTASF', 'U') IS NOT NULL
	DROP TABLE NOTASF
ELSE
	BEGIN
	CREATE TABLE NOTASF (DATAS DATE, NUMNOTAS INT)

	DECLARE @DATA_INICIAL DATE, @DATA_FINAL DATE
	SET @DATA_INICIAL = '20170101'
	SET @DATA_FINAL = '20170110'

	WHILE @DATA_INICIAL <= @DATA_FINAL
	BEGIN
		INSERT INTO NOTASF (DATAS, NUMNOTAS)
		VALUES (@DATA_INICIAL, [dbo].[NumeroNotas](@DATA_INICIAL))
		SET @DATA_INICIAL = DATEADD(DAY, 1, @DATA_INICIAL)
	END

	SELECT * FROM NOTASF

	END
--------------------

--Veja a consulta abaixo. Ela irá retornar o número de notas fiscais entre duas datas.
--SELECT DISTINCT DATA, [dbo].[NumeroNotas](DATA) AS NUMERO FROM [NOTAS FISCAIS]
--WHERE DATA >= '20170101' AND DATA <= '20170110'
--Transforme isto em uma função chamada FuncTabelaNotas, onde o resultado é a consulta acima.
--Lembrando que a data inicial e final serão parâmetros desta função. Depois, teste a função através de um SELECT.

CREATE FUNCTION FuncTabelaNotas (@DATA_INICIAL DATE, @DATA_FINAL DATE) RETURNS TABLE
RETURN SELECT DISTINCT DATA, [dbo].[NumeroNotas](DATA) AS NUMERO FROM [NOTAS FISCAIS]
	WHERE DATA >= @DATA_INICIAL AND DATA <= @DATA_FINAL 

SELECT * FROM [dbo].[FuncTabelaNotas]('20170101', '20170110')
--------------------

--Modifique a função FuncTabelaNotas para que utilize esta consulta abaixo:
--SELECT DATA, COUNT(*) AS NUMERO FROM [NOTAS FISCAIS] 
--    WHERE DATA >= '20170101' AND DATA <= '20170110'
--GROUP BY DATA

ALTER FUNCTION FuncTabelaNotas (@DATA_INICIAL DATE, @DATA_FINAL DATE) RETURNS TABLE
RETURN SELECT DATA, COUNT(*) AS NUMERO FROM [NOTAS FISCAIS] 
    WHERE DATA >= '20170101' AND DATA <= '20170110'
	GROUP BY DATA

SELECT * FROM [dbo].[FuncTabelaNotas]('20170101', '20170110')
--------------------

--Crie uma função para retornar o faturamento de uma determinada nota fiscal

CREATE FUNCTION FaturamentoNota (@NUMERO INT) RETURNS FLOAT
AS
BEGIN
	DECLARE @FATURAMENTO FLOAT
	SELECT @FATURAMENTO = SUM(QUANTIDADE * [PREÇO]) 
		FROM [ITENS NOTAS FISCAIS]
	WHERE NUMERO = @NUMERO
	RETURN @FATURAMENTO
END

--Tendo uma função que retorna o faturamento de uma nota, basta usa-la com a tabela para trazer todos os resultados da tabela
SELECT NUMERO, [dbo].[FaturamentoNota](NUMERO) FROM [NOTAS FISCAIS]
--------------------

--Crie uma stored procedure chamada BuscaPorEntidadesCompleta e acrescente a entidade PRODUTOS. Das entidades, liste apenas os seus identificadores e os seus nomes.

CREATE PROCEDURE BuscaPorEntidadesCompleta @ENTIDADE AS VARCHAR(10)
AS
BEGIN
IF @ENTIDADE = 'CLIENTES'
    SELECT [CPF] AS IDENTIFICADOR, [NOME] AS DESCRITOR FROM [TABELA DE CLIENTES]
ELSE IF @ENTIDADE = 'VENDEDORES'
    SELECT [MATRICULA] AS IDENTIFICADOR, [NOME] AS DESCRITOR FROM [TABELA DE VENDEDORES]
ELSE IF @ENTIDADE = 'PRODUTOS'
	SELECT [CODIGO DO PRODUTO] AS IDENTIFICADOR, [NOME DO PRODUTO] AS DESCRITOR FROM [TABELA DE PRODUTOS]
END

EXEC BuscaPorEntidadesCompleta @ENTIDADE = 'CLIENTES'
EXEC BuscaPorEntidadesCompleta @ENTIDADE = 'VENDEDORES'
EXEC BuscaPorEntidadesCompleta @ENTIDADE = 'PRODUTOS'
--------------------

--Na nossa empresa de suco de frutas temos 3 categorias de produtos: Garrafas, Lata ou PET.
--Temos o campo IMPOSTO na tabela de notas fiscais, que determina o imposto a ser pago (alíquota sobre o faturamento).
--Faça uma stored procedure que terá como entrada de dados: Mês, Ano, Alíquota, Tipo de Produto (Garrafas, Lata ou PET)
--Ela irá modificar a alíquota para a alíquota informada na entrada da stored procedure, para as vendas de todas as notas fiscais no mês/ano informados, para todos os produtos do tipo informado.

--Primeiro, criei um select com filtro de dia e mês
SELECT * FROM [NOTAS FISCAIS]
WHERE MONTH(DATA) = 1 AND DAY(DATA) = 4 AND IMPOSTO = 0.12

--Depois, fazer joins para juntar a tabela de NF com o Tipo de Produto
SELECT NF.DATA, NF.IMPOSTO, NF.NUMERO, INF.[CODIGO DO PRODUTO], PROD.EMBALAGEM
FROM [ITENS NOTAS FISCAIS] INF INNER JOIN [NOTAS FISCAIS] NF
ON INF.NUMERO = NF.NUMERO
INNER JOIN [TABELA DE PRODUTOS] PROD
ON INF.[CODIGO DO PRODUTO] = PROD.[CODIGO DO PRODUTO]

--Juntando os dois
SELECT NF.DATA, NF.IMPOSTO, PROD.EMBALAGEM FROM [NOTAS FISCAIS] NF
INNER JOIN [ITENS NOTAS FISCAIS] INF
	ON NF.NUMERO = INF.NUMERO
INNER JOIN [TABELA DE PRODUTOS] PROD
	ON INF.[CODIGO DO PRODUTO] = PROD.[CODIGO DO PRODUTO]
WHERE MONTH(NF.DATA) = 1 AND YEAR(NF.DATA) = 2015 AND EMBALAGEM = 'PET'

--Query para update da planilha
UPDATE NF SET NF.IMPOSTO = 0.18 FROM [NOTAS FISCAIS] NF
INNER JOIN [ITENS NOTAS FISCAIS] INF
	ON NF.NUMERO = INF.NUMERO
INNER JOIN [TABELA DE PRODUTOS] PROD
	ON INF.[CODIGO DO PRODUTO] = PROD.[CODIGO DO PRODUTO]
WHERE MONTH(NF.DATA) = 1 AND YEAR(NF.DATA) = 2015 AND EMBALAGEM = 'PET'

--Criando a Procedure
CREATE PROCEDURE AtualizaImposto @MES INT, @ANO INT, @IMPOSTO FLOAT, @EMBALAGEM VARCHAR(10)
AS
	UPDATE NF SET NF.IMPOSTO = @IMPOSTO FROM [NOTAS FISCAIS] NF
	INNER JOIN [ITENS NOTAS FISCAIS] INF
		ON NF.NUMERO = INF.NUMERO
	INNER JOIN [TABELA DE PRODUTOS] PROD
		ON INF.[CODIGO DO PRODUTO] = PROD.[CODIGO DO PRODUTO]
	WHERE MONTH(NF.DATA) = @MES AND YEAR(NF.DATA) = @ANO AND EMBALAGEM = @EMBALAGEM

--Usando a Procedure
EXEC AtualizaImposto @MES = 2, @ANO = 2017, @IMPOSTO = 0.16, @EMBALAGEM = 'PET'
--------------------

--Temos a seguinte consulta que nos retorna o número de notas fiscais por dia, onde @ListaDatas é uma variável do tipo tabela, com a lista de datas a serem exibidas:
--SELECT DATA, COUNT(*) AS NUMERO FROM [NOTAS FISCAIS]
--WHERE DATA IN (SELECT DATANOTA FROM @ListaDatas)
--GROUP BY DATA
--Construa uma SP que retorne o número de notas fiscais por dia, baseada na lista de dias passada como parâmetro.

SELECT * FROM [NOTAS FISCAIS]

--Primeiro, criar um tipo Tabela
CREATE TYPE TabelaDatas AS TABLE
(DATANOTA DATE NOT NULL)

--Depois, testar uma variável com esse tipo, conforme dados passados no enunciado
DECLARE @ListaDatas TabelaDatas
INSERT INTO @ListaDatas (DATANOTA) VALUES ('20150101'), ('20150102')
SELECT * FROM @ListaDatas

--E testar junto com a query passada
SELECT DATA, COUNT(*) AS NUMERO FROM [NOTAS FISCAIS]
WHERE DATA IN (SELECT DATANOTA FROM @ListaDatas)
GROUP BY DATA

--Tudo funcionando, hora de criar a SP e executa-la
CREATE PROCEDURE ListaNumeroNotas @ListaDatas
	AS TabelaDatas READONLY AS
		SELECT DATA, COUNT(*) AS NUMERO FROM [NOTAS FISCAIS]
		WHERE DATA IN (SELECT DATANOTA FROM @ListaDatas)
		GROUP BY DATA

DECLARE @ListaDatas TabelaDatas
INSERT INTO @ListaDatas (DATANOTA) VALUES ('20150101'), ('20150102')
EXEC ListaNumeroNotas @ListaDatas = @ListaDatas
--------------------

--Construa uma SP (nome NumNotasSP) cujos parâmetros são uma data, passada como valor, e o número de notas, passado como referência.
--Depois, faça um script onde, na variável @NUMNOTAS, some as notas do dia 01/01/2017 e 02/01/2017.

DECLARE @DATA DATE
DECLARE @NUMNOTAS INT

--Query com os filtros de data e contagem de notas
SELECT @NUMNOTAS = COUNT(NUMERO) FROM [NOTAS FISCAIS] WHERE DATA = '2015-01-01'

--Criando a SP
CREATE PROCEDURE NumNotasSP
@NUMNOTAS INT OUTPUT,
@DATA DATE
AS
BEGIN
	DECLARE @NUMNOTAS_LOCAL INT
	SELECT @NUMNOTAS_LOCAL = COUNT(NUMERO) FROM [NOTAS FISCAIS] WHERE DATA = @DATA
	SELECT @NUMNOTAS = @NUMNOTAS + @NUMNOTAS_LOCAL
END

--Executando a SP 2x para poder somar os valores das datas
DECLARE @DATA DATE
DECLARE @TOTALNOTAS INT
SET @DATA = '20170101'
SET @TOTALNOTAS = 0
EXEC NumNotasSP @NUMNOTAS = @TOTALNOTAS OUTPUT, @DATA = @DATA

DECLARE @DATA2 DATE
SET @DATA2 = '20170101'
EXEC NumNotasSP @NUMNOTAS = @TOTALNOTAS OUTPUT, @DATA = @DATA2

SELECT @TOTALNOTAS
--------------------

--Crie a seguinte Stored Procedure, conforme o código abaixo:

CREATE PROCEDURE InclusaoVendedor 
@MATRICULA AS VARCHAR(5), @NOME AS VARCHAR(100), @PERCENTUAL AS FLOAT,
@DATAADMISSAO AS DATE, @FERIAS AS BIT, @BAIRRO AS VARCHAR(50)
AS
BEGIN
INSERT INTO [TABELA DE VENDEDORES] (MATRICULA, NOME, [PERCENTUAL COMISSÃO], [DATA ADMISSÃO], [DE FERIAS], BAIRRO)
VALUES (@MATRICULA, @NOME, @PERCENTUAL, @DATAADMISSAO, @FERIAS, @BAIRRO)
END

--Ela irá incluir um vendedor na tabela de vendedores. Depois, execute o comando:

EXEC InclusaoVendedor '00238','Pericles Alves',0.11,'20160821',0,'Santo Amaro'

--Temos o erro:
--Msg 2627, Level 14, State 1, Procedure InclusaoVendedor, Line 6 [Batch Start Line 192]
--Violation of PRIMARY KEY constraint 'PK_VENDEDORES'. 
--Cannot insert duplicate key in object 'dbo.TABELA DE VENDEDORES'. 
--The duplicate key value is (00238).
--The statement has been terminated.

-- Crie uma nova SP chamada InclusaoVendedor01, tratando este erro usando @@ERROR e @@ROWCOUNT.

CREATE PROCEDURE InclusaoVendedor01
@MATRICULA AS VARCHAR(5), @NOME AS VARCHAR(100), @PERCENTUAL AS FLOAT,
@DATAADMISSAO AS DATE, @FERIAS AS BIT, @BAIRRO AS VARCHAR(50), @NUMERRO AS INT OUTPUT, @ROWERRO AS INT OUTPUT
AS
BEGIN
	INSERT INTO [TABELA DE VENDEDORES] (MATRICULA, NOME, [PERCENTUAL COMISSÃO], [DATA ADMISSÃO], [DE FERIAS], BAIRRO)
	VALUES (@MATRICULA, @NOME, @PERCENTUAL, @DATAADMISSAO, @FERIAS, @BAIRRO)
	SELECT @NUMERRO = @@ERROR, @ROWERRO = @@ROWCOUNT
END

DECLARE @NUMERRO INT
DECLARE @ROWERRO INT
EXEC InclusaoVendedor01 '00238', 'Pericles Alves', 0.11,'20160821',0,'Santo Amaro', @NUMERRO = @NUMERRO OUTPUT, @ROWERRO = @ROWERRO OUTPUT
IF @NUMERRO <> 0
	PRINT ('Erro código: ' + CONVERT(VARCHAR(30), @NUMERRO) + ' na linha: ' + CONVERT(VARCHAR(30), @ROWERRO))
--------------------

--Crie uma nova SP chamada InclusaoVendedor02, agora tratando o erro com TRY-CATCH.

CREATE PROCEDURE InclusaoVendedor02
@MATRICULA AS VARCHAR(5), @NOME AS VARCHAR(100), @PERCENTUAL AS FLOAT,
@DATAADMISSAO AS DATE, @FERIAS AS BIT, @BAIRRO AS VARCHAR(50), @MENSAGEM VARCHAR(30) OUTPUT
AS
BEGIN
	BEGIN TRY
		INSERT INTO [TABELA DE VENDEDORES] (MATRICULA, NOME, [PERCENTUAL COMISSÃO], [DATA ADMISSÃO], [DE FERIAS], BAIRRO)
		VALUES (@MATRICULA, @NOME, @PERCENTUAL, @DATAADMISSAO, @FERIAS, @BAIRRO)
	END TRY
	BEGIN CATCH
		SELECT @MENSAGEM = 'Error codigo: ' + CONVERT(VARCHAR(30), @@ERROR)
	END CATCH
END

DECLARE @MENSAGEM VARCHAR(20)
EXEC InclusaoVendedor02 '00238', 'Pericles Alves', 0.11,'20160821',0,'Santo Amaro', @MENSAGEM = @MENSAGEM OUTPUT
IF @MENSAGEM <> ''
	PRINT (@MENSAGEM)
--------------------

--Crie uma variável TABELA com um campo INT, use um loop para gravar 100 números aleatórios entre 0 e 1000 nesta tabela. Depois, liste esta tabela em uma consulta.

CREATE TABLE TABELANUM (NUMEROS INT)

DECLARE @CONTA INT
SET @CONTA = 1

DECLARE @ALEATORIO INT
SET @ALEATORIO = (ROUND(((1000 - 0 - 1) * RAND() + 0), 0))


WHILE @CONTA <= 100
BEGIN
	INSERT INTO TABELANUM (NUMEROS)
	VALUES (ROUND(((1000 - 0 - 1) * RAND() + 0), 0))

	SET @CONTA = @CONTA + 1
END

SELECT * FROM TABELANUM
--------------------

--