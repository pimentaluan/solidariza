/*
2. Implementação do projeto de BDR no SGBD PostgreSQL 
	** Todas as operações devem apresentar seu enunciado e sua solução. 
	** Os comandos (todos) devem fazer sentido à aplicação e a seus requisitos.  
	a. Criação e uso de objetos básicos (15,0):  
		i. Tabelas e constraints (PK, FK, UNIQUE, campos que não podem ter valores  nulos, checks de validação) de acordo com as regras de negócio do projeto.
*/

CREATE TABLE CAMPANHA (
    codcamp SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    meta NUMERIC(10,2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    status VARCHAR(50) NOT NULL
);

CREATE TABLE DOADOR (
    cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    contato VARCHAR(255) NOT NULL,
    genero VARCHAR(50)
);

CREATE TABLE DOACAO (
    coddoacao SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    codcamp INT,
    doador_cpf VARCHAR(14),
    FOREIGN KEY (codcamp) REFERENCES CAMPANHA(codcamp),
    FOREIGN KEY (doador_cpf) REFERENCES DOADOR(cpf)
);

CREATE TABLE CATEGORIA_ITEM (
    codcategitem SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE ESTADO (
    codest SERIAL PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL
);

CREATE TABLE ITEM (
    coditem SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    codcategitem INT NOT NULL,
    codest INT NOT NULL,
    FOREIGN KEY (codcategitem) REFERENCES CATEGORIA_ITEM(codcategitem),
    FOREIGN KEY (codest) REFERENCES ESTADO(codest)
);

CREATE TABLE DOACAO_ITEM (
    coditem INT NOT NULL,
    coddoacao INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (coditem, coddoacao),
    FOREIGN KEY (coditem) REFERENCES ITEM(coditem),
    FOREIGN KEY (coddoacao) REFERENCES DOACAO(coddoacao)
);

CREATE TABLE RECEPTOR (
    codrec SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    rua VARCHAR(255) NOT NULL,
    bairro VARCHAR(255) NOT NULL,
    numero VARCHAR(50) NOT NULL
);

CREATE TABLE CATEGORIA_ONG (
    codcategong SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE ONG (
    codrec INT PRIMARY KEY,
    cnpj VARCHAR(20) UNIQUE NOT NULL,
    codcategong INT NOT NULL,
    FOREIGN KEY (codrec) REFERENCES RECEPTOR(codrec),
    FOREIGN KEY (codcategong) REFERENCES CATEGORIA_ONG(codcategong)
);

CREATE TABLE PESSOA_FISICA (
    codrec INT PRIMARY KEY,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    genero VARCHAR(50),
    FOREIGN KEY (codrec) REFERENCES RECEPTOR(codrec)
);

CREATE TABLE CAMPANHA_RECEPTOR (
    codrec INT NOT NULL,
    codcamp INT NOT NULL,
    PRIMARY KEY (codrec, codcamp),
    FOREIGN KEY (codrec) REFERENCES RECEPTOR(codrec),
    FOREIGN KEY (codcamp) REFERENCES CAMPANHA(codcamp)
);

-- INSERT para testes
-- Inserindo dados na tabela CAMPANHA
INSERT INTO CAMPANHA (nome, meta, data_inicio, data_fim, status) VALUES
('Natal Solidário', 50000.00, '2025-12-01', '2025-12-31', 'Ativa'),
('Inverno Sem Fome', 30000.00, '2025-06-01', '2025-07-15', 'Ativa'),
('Volta às Aulas', 20000.00, '2025-01-05', '2025-02-10', 'Finalizada'),
('Ajuda Humanitária Global', 75000.00, '2025-03-01', '2025-04-30', 'Ativa');


-- Inserindo dados na tabela DOADOR
INSERT INTO DOADOR (cpf, nome, contato, genero) VALUES
('12345678901', 'Carlos Silva', 'carlos@email.com', 'Masculino'),
('98765432100', 'Mariana Souza', 'mariana@email.com', 'Feminino'),
('55566677788', 'João Mendes', 'joao@email.com', 'Masculino'),
('68543221298', 'Felipe Cordeiro', 'felipe@email.com', 'Masculino'),
('85302945623', 'Clarissa Bezerra', 'clarissa@email.com', 'Feminino');

-- Inserindo dados na tabela DOACAO
INSERT INTO DOACAO (data, status, codcamp, doador_cpf) VALUES
('2025-12-10', 'Confirmada', 1, '12345678901'),
('2025-06-05', 'Pendente', 2, '98765432100'),
('2025-01-15', 'Confirmada', 3, '55566677788'),
('2025-01-19', 'Confirmada', 2, '68543221298'),
('2025-01-24', 'Pendente', 2, '12345678901'),
('2025-01-22', 'Confirmada', 3, '68543221298');

-- Inserindo dados na tabela CATEGORIA_ITEM
INSERT INTO CATEGORIA_ITEM (nome) VALUES
('Alimentos'),
('Roupas'),
('Material Escolar');

-- Inserindo dados na tabela ESTADO
INSERT INTO ESTADO (descricao) VALUES
('Novo'),
('Usado'),
('Danificado');

-- Inserindo dados na tabela ITEM
INSERT INTO ITEM (nome, codcategitem, codest) VALUES
('Arroz 5kg', 1, 1),
('Casaco de Lã', 2, 2),
('Caderno 100 folhas', 3, 1),
('Feijão 5kg', 1, 1),
('Estojo', 3, 2);

-- Inserindo dados na tabela DOACAO_ITEM
INSERT INTO DOACAO_ITEM (coditem, coddoacao, quantidade) VALUES
(1, 1, 10),
(2, 2, 5),
(3, 3, 15),
(1, 4, 6),
(4, 5, 9),
(5, 6, 4);

-- Inserindo dados na tabela RECEPTOR
INSERT INTO RECEPTOR (nome, rua, bairro, numero) VALUES
('Lar Esperança', 'Rua das Flores', 'Centro', '123'),
('Casa de Apoio', 'Av. Brasil', 'Zona Sul', '456'),
('Associação Mãos Unidas', 'Rua do Sol', 'Bairro Norte', '789'),
('José Pereira', 'Rua das Acácias', 'Centro', '101'),
('Maria Fernandes', 'Av. Paulista', 'Bela Vista', '202'),
('Lucas Almeida', 'Rua do Comércio', 'Zona Norte', '303'),
('Centro Comunitário Esperança', 'Rua das Rosas', 'Bairro Novo', '500');

-- Inserindo dados na tabela CATEGORIA_ONG
INSERT INTO CATEGORIA_ONG (nome) VALUES
('Assistência Social'),
('Educação'),
('Saúde');

-- Inserindo dados na tabela ONG
INSERT INTO ONG (cnpj, codrec, codcategong) VALUES
('12345678000199', 1, 1),
('98765432000155', 2, 2),
('11122233000144', 3, 3),
('12241985371623', 7, 1);

-- Inserindo dados na tabela PESSOA_FISICA
INSERT INTO PESSOA_FISICA (cpf, genero, codrec) VALUES
('44455566677', 'Masculino', 4),
('88899900011', 'Feminino', 5),
('22233344455', 'Masculino', 6);

-- Inserindo dados na tabela CAMPANHA_RECEPTOR
INSERT INTO CAMPANHA_RECEPTOR (codcamp, codrec) VALUES
(1, 1),
(2, 2),
(3, 3),
(2, 7),
(2, 6);

-- Verificar todas as tabelas
SELECT * FROM CAMPANHA;
SELECT * FROM CAMPANHA_RECEPTOR;
SELECT * FROM CATEGORIA_ITEM;
SELECT * FROM CATEGORIA_ONG;
SELECT * FROM DOACAO;
SELECT * FROM DOACAO_ITEM;
SELECT * FROM DOADOR;
SELECT * FROM ESTADO;
SELECT * FROM ITEM;
SELECT * FROM ONG;
SELECT * FROM PESSOA_FISICA;
SELECT * FROM RECEPTOR;

-- ii. 10 consultas variadas de acordo com requisitos da aplicação, com justificativa  semântica e conforme critérios seguintes: 

-- • 1 consulta com uma tabela usando operadores básicos de filtro (e.g., IN,  between, is null, etc).  
SELECT * 
FROM CAMPANHA
WHERE META BETWEEN 30000 AND 50000;

-- • 3 consultas com inner JOIN na cláusula FROM (pode ser self join, caso o  domínio indique esse uso).

-- 1ª consulta (Ver os doadores e as campanhas que eles fizeram doações)
SELECT D.NOME AS DOADOR, C.NOME AS CAMPANHA
FROM DOACAO DOA
JOIN DOADOR D ON DOA.DOADOR_CPF = D.CPF
JOIN CAMPANHA C ON DOA.CODCAMP = C.CODCAMP;

-- 2ª consulta (Ver o item e o estado físico em que ele se encontra)
SELECT I.NOME AS ITEM, E.DESCRICAO AS ESTADO
FROM ITEM I
JOIN ESTADO E ON I.CODEST = E.CODEST;

-- 3ª consulta (Ver o nome da ong e a categoria a qual ela pertence)
SELECT R.NOME AS ONG, CA.NOME AS CATEGORIA
FROM RECEPTOR R
JOIN ONG O ON R.CODREC = O.CODREC
JOIN CATEGORIA_ONG CA ON O.CODCATEGONG = CA.CODCATEGONG;

-- • 1 consulta com left/right/full outer join na cláusula FROM
-- Exibe todas as campanhas (incluindo aquelas que não estão associadas a um receptor)
SELECT C.NOME AS CAMPANHA, R.NOME AS RECEPTOR
FROM CAMPANHA C
LEFT JOIN CAMPANHA_RECEPTOR CR ON C.CODCAMP = CR.CODCAMP
LEFT JOIN RECEPTOR R ON CR.CODREC = R.CODREC;

-- • 2 consultas usando Group By (e possivelmente o having)
-- 1ª Consulta (mostra a campanha e a quantidade de doadores nela)
SELECT C.NOME AS CAMPANHA, COUNT(DISTINCT D) AS QUANTIDADE_DOADOR
FROM DOACAO DOA
JOIN DOADOR D ON DOA.DOADOR_CPF = D.CPF
JOIN CAMPANHA C ON DOA.CODCAMP = C.CODCAMP
GROUP BY C.NOME;

-- 2ª Consulta (mostra a soma de itens doados para cada campanha e os ordena de forma decrescente)
SELECT C.NOME AS CAMPANHA, SUM(DI.QUANTIDADE) AS TOTAL_ITENS_DOADOS
FROM DOACAO_ITEM DI
JOIN DOACAO DOA ON DI.CODDOACAO = DOA.CODDOACAO
JOIN CAMPANHA C ON DOA.CODCAMP = C.CODCAMP
GROUP BY C.NOME
ORDER BY TOTAL_ITENS_DOADOS DESC;

-- • 1 consulta usando alguma operação de conjunto (union, except ou intersect)
-- Mostra o CPF e o nome dos doadores que não fizeram nenhuma doação
SELECT CPF, NOME 
FROM DOADOR
EXCEPT
SELECT D.CPF, D.NOME 
FROM DOADOR D
JOIN DOACAO DOA ON D.CPF = DOA.DOADOR_CPF;

-- • 2 consultas que usem subqueries.
-- 1ª Consulta (campanhas que arrecadaram mais que a média de todas as campanhas)
SELECT NOME, META
FROM CAMPANHA
WHERE META > (
	SELECT AVG(META) FROM CAMPANHA
	);

-- 2ª consulta (nome do doador que mais doou itens)
SELECT NOME
FROM DOADOR
WHERE CPF = (
    SELECT DOADOR_CPF
    FROM DOACAO
    WHERE CODDOACAO = (
        SELECT CODDOACAO
        FROM DOACAO_ITEM
        GROUP BY CODDOACAO
        ORDER BY SUM(QUANTIDADE) DESC
        LIMIT 1
    )
);

-- b. Visões (14,0):
-- • 1 visão que permita inserção
-- Uma view que exibe apenas doações pendentes e permite inserções. Útil para restringir o acesso de usuários que devem gerenciar apenas doações em aberto.
CREATE VIEW V_DOACOES_PENDENTES AS
SELECT CODDOACAO, DATA, STATUS, CODCAMP, DOADOR_CPF
FROM DOACAO
WHERE STATUS = 'Pendente'
WITH CHECK OPTION;

INSERT INTO V_DOACOES_PENDENTES (DATA, STATUS, CODCAMP, DOADOR_CPF)
VALUES ('2025-07-25', 'Pendente', 2, '98765432100');

SELECT * FROM V_DOACOES_PENDENTES;

/*
Essa inserção daria erro, por não possuir status "Pendente", assim violando a verificação da view:

INSERT INTO V_DOACOES_PENDENTES (DATA, STATUS, CODCAMP, DOADOR_CPF)
VALUES ('2025-07-25', 'Ativo', 3, '68543221298');
*/

-- • 2 visões robustas (e.g., com vários joins) com justificativa semântica, de acordo com os requisitos da aplicação.

/*
1ª view: Esta view é extremamente útil para visualizar as doações de forma detalhada.  
Através de JOINs, ela exibe o código da doação, a data, o status, a campanha associada (mostrando o nome em vez do código),  
o item doado (também pelo nome) e a quantidade doada.  
Facilitando a auditoria de doações, permitindo que gestores e administradores tenham um melhor controle dessas doações.
*/

CREATE VIEW V_DOACOES_DETALHADAS AS
SELECT 
    D.CODDOACAO, 
    D.DATA, 
    D.STATUS, 
    C.NOME AS CAMPANHA, 
    DOA.NOME AS DOADOR, 
    I.NOME AS ITEM, 
    DI.QUANTIDADE AS QUANTIDADE_DOADA
FROM DOACAO D
JOIN CAMPANHA C ON D.CODCAMP = C.CODCAMP
JOIN DOADOR DOA ON D.DOADOR_CPF = DOA.CPF
JOIN DOACAO_ITEM DI ON D.CODDOACAO = DI.CODDOACAO
JOIN ITEM I ON DI.CODITEM = I.CODITEM;

SELECT * FROM V_DOACOES_DETALHADAS;


/*
2ª view: Através de múltiplos JOINs, essa view relaciona os receptores às campanhas das quais receberam doações,  
exibindo detalhes como nome, endereço formatado e a quantidade total de itens doados.  
Isso facilita a análise da distribuição de recursos, ajudando administradores a entenderem quais receptores foram beneficiados  
e eliminando a necessidade de cálculos manuais, já que a soma dos itens doados para a camapnha inteira é apresentada diretamente.
*/

CREATE VIEW V_RECEPTOR_DOACOES AS
SELECT 
    R.NOME AS RECEPTOR, 
    R.RUA || ', ' || R.NUMERO || ' - ' || R.BAIRRO AS ENDERECO,
    C.NOME AS CAMPANHA, 
    SUM(DI.QUANTIDADE) AS TOTAL_ITENS_DOADOS_PARA_CAMAPNHA
FROM CAMPANHA_RECEPTOR CR
JOIN RECEPTOR R ON CR.CODREC = R.CODREC
JOIN CAMPANHA C ON CR.CODCAMP = C.CODCAMP
JOIN DOACAO D ON C.CODCAMP = D.CODCAMP
JOIN DOACAO_ITEM DI ON D.CODDOACAO = DI.CODDOACAO
GROUP BY R.NOME, R.RUA, R.BAIRRO, R.NUMERO, C.NOME;

SELECT * FROM V_RECEPTOR_DOACOES;

-- c. Índices (12,0)
/*
1º Índice: Este índice melhora a performance de consultas que filtram campanhas dentro de um intervalo de metas.  
É útil para sistemas que precisam listar campanhas dentro de uma faixa financeira específica, tornando a busca mais rápida.
*/

CREATE INDEX idx_campanha_meta ON CAMPANHA (META);

--Exemplo de consulta otimizada da questão 2a:
SELECT * FROM CAMPANHA 
WHERE META BETWEEN 30000 AND 50000;


/*
2º Índice: Este índice composto melhora a performance de consultas que agrupam doadores por campanha.  
É útil para otimizar a contagem de doadores em cada campanha, acelerando operações de agregação.
*/

CREATE INDEX idx_doacao_campanha_doador ON DOACAO (CODCAMP, DOADOR_CPF);

--Exemplo de consulta otimizada da questão 2a:
SELECT C.NOME AS CAMPANHA, COUNT(D) AS QUANTIDADE_DOADOR
FROM DOACAO DOA
JOIN DOADOR D ON DOA.DOADOR_CPF = D.CPF
JOIN CAMPANHA C ON DOA.CODCAMP = C.CODCAMP
GROUP BY C.NOME;


/*
3º Índice: Este índice melhora a performance de consultas que buscam itens pelo estado.  
É útil para acelerar o carregamento de itens classificados por estado físico, evitando buscas demoradas.
*/

CREATE INDEX idx_item_estado ON ITEM (CODEST);

-- Exemplo de consulta otimizada da questão 2a:
SELECT I.NOME AS ITEM, E.DESCRICAO AS ESTADO
FROM ITEM I
JOIN ESTADO E ON I.CODEST = E.CODEST;

/*
d. Reescrita de consultas (6,0):
1ª reescrita: O JOIN com a tabela DOADOR foi removido, pois a contagem dos doadores pode ser feita diretamente na tabela DOACAO,
usando DOADOR_CPF. Isso torna a consulta mais eficiente, reduzindo o processamento desnecessário e mantendo o mesmo resultado.*/

SELECT C.NOME AS CAMPANHA, COUNT(DISTINCT DOA.DOADOR_CPF) AS QUANTIDADE_DOADORES
FROM DOACAO DOA
JOIN CAMPANHA C ON DOA.CODCAMP = C.CODCAMP
GROUP BY C.NOME;

/*
2ª reescrita: A consulta original usa EXCEPT, que pode ser custoso, existe uma maneira de não usar,
fazendo o left join e pegando onde o coddoacao é nulo.
*/
SELECT D.CPF, D.NOME
FROM DOADOR D
LEFT JOIN DOACAO DOA ON D.CPF = DOA.DOADOR_CPF
WHERE DOA.CODDOACAO IS NULL;

-- e. Funções e procedures armazenadas (16,0):

-- • 1 função que use SUM, MAX, MIN, AVG ou COUNT
/*
A função recebe o nome de um doador, usa esse nome para encontrar seu CPF e contar quantas doações possuem com esse cpf,
coloca esse resultado em uma variável e retorna ela, assim apresentando a quantidade de doações feitas por esse doador. 
*/
CREATE OR REPLACE FUNCTION total_doacoes_confirmadas(nome VARCHAR) 
RETURNS INT AS $$
DECLARE
	CPF_DOADOR VARCHAR;
    TOTAL_DOACOES INT;
BEGIN
	SELECT D.CPF INTO CPF_DOADOR
	FROM DOADOR D
	WHERE D.NOME = total_doacoes_confirmadas.NOME;
	
    SELECT COUNT(*) INTO TOTAL_DOACOES
    FROM DOACAO
    WHERE DOADOR_CPF = CPF_DOADOR AND STATUS = 'Confirmada';

    RETURN TOTAL_DOACOES;
END;
$$ LANGUAGE plpgsql;

-- Exemplo de uso:
SELECT total_doacoes_confirmadas('Felipe Cordeiro');

-- • Outras 2 funções com justificativa semântica, conforme os requisitos da aplicação
CREATE OR REPLACE FUNCTION INSERIR_ITEM_CATEGORIA_ESTADO(
    p_nome_item VARCHAR(255), 
    p_nome_categoria VARCHAR(255), 
    p_nome_estado VARCHAR(255)
)
RETURNS VOID AS $$
DECLARE
    v_categoria INT;
    v_estado INT;
    estados_disponiveis TEXT;
BEGIN
    -- Verifica se a categoria já existe, senão cria
    SELECT CODCATEGITEM INTO v_categoria
    FROM CATEGORIA_ITEM
    WHERE NOME = p_nome_categoria;

    IF v_categoria IS NULL THEN
        INSERT INTO CATEGORIA_ITEM (NOME)
        VALUES (p_nome_categoria)
        RETURNING CODCATEGITEM INTO v_categoria;
    END IF;

    -- Verifica se o estado existe
    SELECT CODEST INTO v_estado
    FROM ESTADO
    WHERE DESCRICAO = p_nome_estado;

    -- Se o estado não existir, captura os estados disponíveis e lança erro
    IF v_estado IS NULL THEN
        SELECT STRING_AGG(DESCRICAO, ', ') INTO estados_disponiveis FROM ESTADO;
        RAISE EXCEPTION 'Nenhum estado encontrado com o nome: %. Os possíveis são: %', 
                        p_nome_estado, estados_disponiveis;
    END IF;

    -- Insere o item usando os IDs da categoria e do estado
    INSERT INTO ITEM (NOME, CODCATEGITEM, CODEST)
    VALUES (p_nome_item, v_categoria, v_estado);

END;
$$ LANGUAGE plpgsql;


-- Uso:
SELECT INSERIR_ITEM_CATEGORIA_ESTADO('Bicicleta', 'Transporte', 'Novo');
SELECT INSERIR_ITEM_CATEGORIA_ESTADO('Notebook', 'Informática', 'Estragado');
SELECT INSERIR_ITEM_CATEGORIA_ESTADO('Tablet', 'Eletrônicos', 'Usado');

select * from item;
select * from categoria_item;
select * from estado;