# Modelagem
1. Nunca modelar baseado em negócio
> Ex: Tornar o CPF como sendo chave única em uma tabela.
> Vamos supor que futuramente o CPF deixe de existir, o que acontecerá com nossos cadastros futuros?
> Nosso banco quebrará.
2. Dois tipos de chaves
    * Natural (CPF, RG)
    * Artificial (Código, Identificador)
3. Conceitos
    * Conceitual (Rascunho)
    * Lógica (Software de modelagem)
    * Física (Script)
4. O banco deve guardar dados e não informações.
    * Através dos dados são geradas as informações.

## Primeira forma normal
1. Todo campo vetorizado se tornará outra tabela
> Ex: ['9981-4499', '9109-1201', '9831-4806'] -> Telefone
2. Todo campo multivalorado se tornará outra tabela
> Ex: ['Rua Maria Paulone', 'Douradina', 'Paraná', 'Brasil'] -> Endereço
> Nesse caso não é um vetor, pois cada informação remete à uma tabela diferente.
> Veja que Rua, Cidade, Estado e País não são da mesma família.
3. Toda tabela necessita de pelo menos um campo que identifique todo o registro como sendo único
> Ex: id, cod (PK Chave Primária)

## Segunda forma normal
1. Em uma tabela associativa, um campo não chave deve depender da Totalidade das chaves
> Ex: Supondo que temos uma tabela associativa Consulta, e na Consulta temos o id do paciente, id do mécido, id do hospital e um campo de data. Esse campo de data deve depender dessas outras 3 chaves. Se não existir as 3 chaves, então não há consulta.
2. Caso a consulta possa se repetir, com o mesmo médico, mesmo hospital e mesmo paciente, a tabela deverá ter uma Chave Primária (PK)

## Terceira forma normal
1. Dependência transitiva
2. Campos não chaves que dependem de outros campos não chaves, devem se tornar outra tabela
> Ex: Supondo que temos a mesma tabela Consulta, com id do paciente, id do medico e id do hospital, e mais outros dois campos Diagnostico e Internacao. O campo Internação depende do Diagnóstico, pois nem todos Diagnósticos levam a Internação. Logo o campo Internação deve se tornar outra tabela.

## Relacionamento
1. 1 X 1 Chave estrangeira ficará sempre na tabela mais fraca
    * Em relacionamento 1 X 1 a chave estrageira não se repete
2. 1 X N Chave estrangeira ficará sempre na cardinalidade N

## 4 conceitos importantes
1. Seleção
    * É a geração de um subconjunto através da filtragem (WHERE).
2. Projeção
    * É tudo que você quer ver na tela (SELECT).
3. Origem
    * É de onde virá a projeção (FROM).
4. Junção
    * É a junção de duas ou mais tabelas por uma referência em comum, geralmente o id (JOIN).

## Definição
1. DML (Data Manipulation Language)
    ```sql
    INSERT INTO cliente VALUES()

    SELECT * FROM cliente

    UPDATE cliente

    DELETE FROM cliente
    ```
2. DDL (Data Deninition Language)
    ```sql
    CREATE TABLE produto(
        id INT PRIMARY KEY AUTO_INCREMENT,
        descricao VARCHAR(30) NOT NULL,
        preco INT,
        frete FLOAT(10,2) NOT NULL,
        estoque INT NOT NULL;
    )

    ALTER TABLE produto 
    CHANGE preco valor_unitario FLOAT(10,2) NOT NULL;

    ALTER TABLE produto
    MODIFY valor_unitario VARCHAR(50) NOT NULL;

    ALTER TABLE produto
    ADD peso FLOAT(10,2) NOT NULL;

    ALTER TABLE produto
    DROP COLUMN peso;

    ALTER TABLE produto
    ADD COLUMN peso FLOAT(10,2) NOT NULL
    AFTER descricao;

    ALTER TABLE produto
    ADD COLUMN peso FLOAT(10,2) NOT NULL
    FIRST;
    ```
    * Boas práticas: Criar a tabela primeiro e depois as Constraints.
3. DCL (Data Control Language)
4. TCL (Transaction Control Language)

## View
1. A View é criada a partir de uma projeção
```sql
CREATE view v_relatorio AS
SELECT
    c.nome,
    c.sexo,
    IFNULL(c.email, 'CLIENTE SEM EMAIL') AS email,
    t.tipo,
    t.numero,
    e.bairro,
    e.cidade,
    e.estado
FROM cliente c
INNER JOIN telefone t ON c.id = t.cliente_id
INNER JOIN endereco e ON c.id = e.cliente_id;
```
2. Não se pode fazer INSERT nem DELETE em View com joins.

## Ordenação
1. A projeção pode ser ordenada pelo nome da coluna ou pelo índice.
2. Pode haver mais de uma ordenação na mesma Query.
```sql
SELECT numero, nome
FROM aluno
ORDER BY numero DESC, nome;
```

## Delimiter
1. Alterar o delimitador padrão ";" por outro.
> Ex: $
```sql
DELIMITER $

SELECT * FROM cliente$
```

## Stored Procedure
1. Criar blocos de programação dentro do banco de dados.
2. Passos para criar uma Procedure:
```sql
DELIMITER $

CREATE PROCEDURE nome_empresa()
BEGIN
    SELECT 'Moveis Gazin' AS empresa;
END
$
```
3. Chamar a Procedure:
```sql
DELIMITER ;

CALL nome_empresa();
```
4. Procedure com parâmetro:
```sql
DELIMITER $

CREATE PROCEDURE soma(numero1 INT, numero2 INT)
BEGIN
    SELECT numero1 + numero2 AS soma;
END
$
```
5. Dropar uma Procedure
```sql
DROP PROCEDURE soma()
```

## Subquery
1. A Subquery também é chamada de Inner Query.
2. Ela sempre é resolvida primeira.
```sql
SELECT -- Alter Query
    nome, 
    fevereiro
FROM vendedor
WHERE fevereiro = (SELECT MIN(fevereiro) from vendedor) -- Inner Query;
```

## Dicionário de Dados (Metadados)
1. No MySQL o Dicionário de Dados fica em 3 bancos:
    * informatio_schema
    * mysql
    * performance_schema
2. As informações de objetos estão disponíveis dentro desses bancos.
3. Pesquisar Constraits:
```sql
USE information_schema;

-- Buscar todas as Constraints do Banco comercio
SELECT 
    CONSTRAINT_SCHEMA AS "BANCO",
    TABLE_NAME AS "TABELA",
    CONSTRAINT_NAME AS "NOME REGRA",
    CONSTRAINT_TYPE AS "TIPO"
FROM TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'comercio';
```

## Tabela associativa
> A tabela associativa deve ter uma chave primária composta
```sql
CREATE TABLE carro_cor(
    cor_id INT,
    carro_id INT,
    PRIMARY KEY(cor_id, carro_id)
);
```

## Trigger
> Trigger é um gatinho que fica ouvindo um evento
```sql
DELIMITER $

CREATE TRIGGER NOME
BEFORE/AFTER INSERT/UPDATE/DELETE ON TABELA
FOR EACH ROW (PARA CADA LINHA)
BEGIN -> INICIO
    COMANDO SQL;
END -> FIM

DELIMITER ;
```
> Encontrar as Triggers
```sql
USE information_schema;
DESC TRIGGERS;
SELECT 
    TRIGGER_SCHEMA,
    TRIGGER_NAME
FROM TRIGGERS;
```

## Autorelacionamentos
> É quando uma tabela se relaciona com ela mesma
```sql
CREATE TABLE curso(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30),
    horas INT,
    valor FLOAT(10,2),
    prereq_id INT
);

ALTER TABLE curso
add CONSTRAINT fk_prereq
FOREIGN KEY(prereq_id)
REFERENCES curso(id);
```
> Para consultar eu aponto a própria tabela com o JOIN
```sql
SELECT
    c.nome,
    c.valor,
    c.horas,
    IFNULL(p.nome, 'SEM PRE-REQUISITOS') AS curso_requisito
FROM curso c
LEFT JOIN curso p ON p.id = c.prereq_id;
```

## Cursores
> Utiliza da programação para desafogar o banco de dados de Querys com cálculos complexos
```sql
DELIMITER $
CREATE PROCEDURE inseredados()
BEGIN
    DECLARE fim INT DEFAULT 0;
    DECLARE var1, var2, var3, vtotal, vmedia INT;
    DECLARE vnome VARCHAR(50);

    DECLARE reg CURSOR FOR(
        SELECT nome, jan, fev, mar FROM vendedores
    );

    DECLARE continue HANDLER FOR NOT FOUND SET fim = 1;

    OPEN reg;

    REPEAT
        FETCH reg INTO vnome, var1, var2, var3;
        IF NOT fim THEN
            SET vtotal = var1 + var2 + var3;
            SET vmedia = vtotal / 3;
            INSERT INTO vend_total VALUES(vnome, var1, var2, var3, vtotal, vmedia);
        END IF;
    UNTIL FIM END REPEAT;

    CLOSE reg;
END
$
DELIMITER ;
```