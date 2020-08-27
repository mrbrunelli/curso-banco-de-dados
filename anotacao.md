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

## Segunda forma normal
1. Todo campo multivalorado se tornará outra tabela
> Ex: ['Rua Maria Paulone', 'Douradina', 'Paraná', 'Brasil'] -> Endereço
> Nesse caso não é um vetor, pois cada informação remete à uma tabela diferente.
> Veja que Rua, Cidade, Estado e País não são da mesma família. 

## Terceira forma normal
1. Toda tabela necessita de pelo menos um campo que identifique todo o registro como sendo único
> Ex: id, cod

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
> Para consultar eu aponto a própria tabela como JOIN
```sql
SELECT
    c.nome,
    c.valor,
    c.horas,
    IFNULL(p.nome, 'SEM PRE-REQUISITOS') AS curso_requisito
FROM curso c
LEFT JOIN curso p ON p.id = c.prereq_id;
```