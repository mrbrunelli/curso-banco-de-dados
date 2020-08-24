CREATE DATABASE projeto;

CREATE TABLE cliente(
    nome varchar(30),
    sexo char(1),
    email varchar(30),
    cpf int(11),
    telefone varchar(30),
    endereco varchar(100)
);

INSERT INTO
    cliente (nome, sexo, email, cpf, telefone, endereco)
VALUES
    (
        'José',
        'm',
        'josesilva@gmail.com',
        00998843,
        '44998314806',
        'Avenida Paraná, 670'
    ),
    (
        'Maria',
        'f',
        null,
        null,
        '44999834422',
        'Avenida Brasil, 1000'
    );