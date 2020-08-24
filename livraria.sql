create table livro (
    nome_livro varchar(30),
    nome_autor varchar(30),
    sexo_autor char(1),
    numero_paginas int(4),
    nome_editora varchar(30),
    valor_livro float(10, 2),
    uf_editora char(2),
    ano_publicacao year
);

insert into
    livro (
        nome_livro,
        nome_autor,
        sexo_autor,
        numero_paginas,
        nome_editora,
        valor_livro,
        uf_editora,
        ano_publicacao
    ) values (
        'Cavaleiro Real',
        'Ana Claudia',
        'f',
        465,
        'Atlas',
        49.9,
        'RJ',
        '2009'
    ),
    (
        'SQL para leigos',
        'Joao Nunes',
        'm',
        450,
        'Addison',
        98,
        'SP',
        '2018'
    ),
    (
        'Receitas Caseiras',
        'Celia Tavares',
        'f',
        210,
        'Atlas',
        45,
        'RJ',
        '2008'
    ),
    (
        'Pessoas Efetivas',
        'Eduardo Santos',
        'm',
        390,
        'Beta',
        78.99,
        'RJ',
        '2018'
    ),
    (
        'Habitos Saudaveis',
        'Eduardo Santos',
        'm',
        630,
        'Beta',
        '150.98',
        'RJ',
        '2019'
    ),
    (
        'A Casa Marrom',
        'Hermes Santos',
        'm',
        250,
        'Bubba',
        60,
        'MG',
        '2016'
    ),
    (
        'Estacio Querido',
        'Geraldo Francisco',
        'm',
        310,
        'Insignia',
        100,
        'ES',
        '2011'
    ),
    (
        'Pra sempre amigas',
        'Leda Silva',
        'f',
        510,
        'Insignia',
        79.98,
        'ES',
        '2011'
    ),
    (
        'Copas Inesqueciveis',
        'Marco Alcantara',
        'm',
        200,
        'Larson',
        130.98,
        'RS',
        '2018'
    ),
    (
        'O poder da mente',
        'Clara Mafra',
        'f',
        120,
        'Continental',
        56.58,
        'SP',
        '2017'
    );

select * from livro;

select nome_livro, nome_editora from livro;

select nome_livro, uf_editora from livro where sexo_autor = 'm';

select valor_livro from livro where uf_editora = 'SP';

select nome_autor, sexo_autor from livro where sexo_autor = 'm' and uf_editora in ('SP', 'RJ');