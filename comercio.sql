create database comercio;

use comercio;

show databases;

create table cliente (
    id int primary key auto_increment,
    nome varchar(30) not null,
    sexo enum('M','F') not null,
    email varchar(50) unique,
    cpf varchar(15) unique
);

create table endereco (
    id int primary key auto_increment,
    rua varchar(30) not null,
    bairro varchar(30) not null,
    cidade varchar(30) not null,
    estado char(2) not null,
    cliente_id int unique,
    foreign key(cliente_id) references cliente(id)
);

create table telefone (
    id int primary key auto_increment,
    tipo enum('RES','COM','CEL') not null,
    numero varchar(10) not null,
    cliente_id int,
    foreign key(cliente_id) references cliente(id)
);

/* 
    Endereço obrigatório
    Cadastro de somente um por cliente

    Telefone não obrigatório
    cadastro de mais de um por cliente (opcional)
*/

INSERT INTO cliente VALUES(NULL,'JOAO','M','JOAOA@IG.COM','76567587887');
INSERT INTO cliente VALUES(NULL,'CARLOS','M','CARLOSA@IG.COM','5464553466');
INSERT INTO cliente VALUES(NULL,'ANA','F','ANA@IG.COM','456545678');
INSERT INTO cliente VALUES(NULL,'CLARA','F',NULL,'5687766856');
INSERT INTO cliente VALUES(NULL,'JORGE','M','JORGE@IG.COM','8756547688');
INSERT INTO cliente VALUES(NULL,'CELIA','M','JCELIA@IG.COM','5767876889');

INSERT INTO endereco VALUES(NULL,'RUA ANTONIO SA','CENTRO','B. HORIZONTE','MG',4);
INSERT INTO endereco VALUES(NULL,'RUA CAPITAO HERMES','CENTRO','RIO DE JANEIRO','RJ',1);
INSERT INTO endereco VALUES(NULL,'RUA PRES VARGAS','JARDINS','SAO PAULO','SP',3);
INSERT INTO endereco VALUES(NULL,'RUA ALFANDEGA','ESTACIO','RIO DE JANEIRO','RJ',2);
INSERT INTO endereco VALUES(NULL,'RUA DO OUVIDOR','FLAMENGO','RIO DE JANEIRO','RJ',6);
INSERT INTO endereco VALUES(NULL,'RUA URUGUAIANA','CENTRO','VITORIA','ES',5);
INSERT INTO endereco VALUES(NULL,'RUA ALFANDEGA','CENTRO','SAO PAULO','SP',5);

INSERT INTO telefone VALUES(NULL,'CEL','78458743',5);
INSERT INTO telefone VALUES(NULL,'RES','56576876',5);
INSERT INTO telefone VALUES(NULL,'CEL','87866896',1);
INSERT INTO telefone VALUES(NULL,'COM','54768899',2);
INSERT INTO telefone VALUES(NULL,'RES','99667587',1);
INSERT INTO telefone VALUES(NULL,'CEL','78989765',3);
INSERT INTO telefone VALUES(NULL,'CEL','99766676',3);
INSERT INTO telefone VALUES(NULL,'COM','66687899',1);
INSERT INTO telefone VALUES(NULL,'RES','89986668',5);
INSERT INTO telefone VALUES(NULL,'CEL','88687909',2);

INSERT INTO cliente VALUES(NULL,'FLAVIO','M','FLAVIO@IG.COM','4657765');
INSERT INTO cliente VALUES(NULL,'ANDRE','M','ANDRE@GLOBO.COM','7687567');
INSERT INTO cliente VALUES(NULL,'GIOVANA','F',NULL,'0876655');
INSERT INTO cliente VALUES(NULL,'KARLA','M','KARLA@GMAIL.COM','545676778');
INSERT INTO cliente VALUES(NULL,'DANIELE','M','DANIELE@GMAIL.COM','43536789');
INSERT INTO cliente VALUES(NULL,'LORENA','M',NULL,'774557887');
INSERT INTO cliente VALUES(NULL,'EDUARDO','M',NULL,'54376457');
INSERT INTO cliente VALUES(NULL,'ANTONIO','F','ANTONIO@IG.COM','12436767');
INSERT INTO cliente VALUES(NULL,'ANTONIO','M','ANTONIO@UOL.COM','3423565');
INSERT INTO cliente VALUES(NULL,'ELAINE','M','ELAINE@GLOBO.COM','32567763');
INSERT INTO cliente VALUES(NULL,'CARMEM','M','CARMEM@IG.COM','787832213');
INSERT INTO cliente VALUES(NULL,'ADRIANA','F','ADRIANA@GMAIL.COM','88556942');
INSERT INTO cliente VALUES(NULL,'JOICE','F','JOICE@GMAIL.COM','55412256');

INSERT INTO endereco VALUES(NULL,'RUA MARIA PAULONE','DOURADINA','PARANA','PR',7);
INSERT INTO endereco VALUES(NULL,'RUA ROLANDIA','MARIA HELENA','PARANA','PR',8);
INSERT INTO endereco VALUES(NULL,'RUA MAIA LACERDA','ESTACIO','RIO DE JANEIRO','RJ',10);
INSERT INTO endereco VALUES(NULL,'RUA MAIA LACERDA','ESTACIO','RIO DE JANEIRO','RJ',10);
INSERT INTO endereco VALUES(NULL,'RUA GUEDES','CASCADURA','B. HORIZONTE','MG',9);
INSERT INTO endereco VALUES(NULL,'RUA MAIA LACERDA','ESTACIO','RIO DE JANEIRO','RJ',10);
INSERT INTO endereco VALUES(NULL,'RUA VISCONDESSA','CENTRO','RIO DE JANEIRO','RJ',11);
INSERT INTO endereco VALUES(NULL,'RUA NELSON MANDELA','COPACABANA','RIO DE JANEIRO','RJ',12);
INSERT INTO endereco VALUES(NULL,'RUA ARAUJO LIMA','CENTRO','VITORIA','ES',13);
INSERT INTO endereco VALUES(NULL,'RUA CASTRO ALVES','LEBLON','RIO DE JANEIRO','RJ',14);
INSERT INTO endereco VALUES(NULL,'AV CAPITAO ANTUNES','CENTRO','CURITIBA','PR',15);
INSERT INTO endereco VALUES(NULL,'AV CARLOS BARROSO','JARDINS','SAO PAULO','SP',16);
INSERT INTO endereco VALUES(NULL,'ALAMEDA SAMPAIO','BOM RETIRO','CURITIBA','PR',17);
INSERT INTO endereco VALUES(NULL,'RUA DA LAPA','LAPA','SAO PAULO','SP',18);
INSERT INTO endereco VALUES(NULL,'RUA GERONIMO','CENTRO','RIO DE JANEIRO','RJ',19);
INSERT INTO endereco VALUES(NULL,'RUA GOMES FREIRE','CENTRO','RIO DE JANEIRO','RJ',20);
INSERT INTO endereco VALUES(NULL,'RUA GOMES FREIRE','CENTRO','RIO DE JANEIRO','RJ',21);

INSERT INTO telefone VALUES(NULL,'RES','68976565',9);
INSERT INTO telefone VALUES(NULL,'CEL','99656675',9);
INSERT INTO telefone VALUES(NULL,'CEL','33567765',11);
INSERT INTO telefone VALUES(NULL,'CEL','88668786',11);
INSERT INTO telefone VALUES(NULL,'COM','55689654',11);
INSERT INTO telefone VALUES(NULL,'COM','88687979',12);
INSERT INTO telefone VALUES(NULL,'COM','88965676',13);
INSERT INTO telefone VALUES(NULL,'CEL','89966809',15);
INSERT INTO telefone VALUES(NULL,'COM','88679978',16);
INSERT INTO telefone VALUES(NULL,'CEL','99655768',17);
INSERT INTO telefone VALUES(NULL,'RES','89955665',18);
INSERT INTO telefone VALUES(NULL,'RES','77455786',19);
INSERT INTO telefone VALUES(NULL,'RES','89766554',19);
INSERT INTO telefone VALUES(NULL,'RES','77755785',20);
INSERT INTO telefone VALUES(NULL,'COM','44522578',20);

select distinct
(select count(*) from cliente where sexo = 'm') as total_homens,
(select count(*) from cliente where sexo = 'f') as total_mulheres
from cliente;
-- OU
select count(*), sexo
from cliente
group by sexo;

select c.id, c.email 
from cliente c
left join endereco e on c.id = e.cliente_id
left join telefone t on c.id = t.cliente_id 
where c.sexo = 'F'
and t.tipo != 'CEL'
and e.cidade = 'RIO DE JANEIRO'
and e.bairro = 'CENTRO';

select c.nome, c.email, t.numero as celular -- Projeção
from cliente c -- Origem
inner join endereco e -- Junção
on c.id = e.cliente_id -- Junção Condição
inner join telefone t -- Junção
on c.id = t.cliente_id -- Junção Condição
where t.tipo = 'CEL' -- Seleção
and e.estado = 'RJ'; -- Seleção

select c.nome, c.email, t.numero as celular
from cliente c
inner join endereco e on c.id = e.cliente_id
inner join telefone t on c.id = t.cliente_id
where c.sexo = 'F'
and t.tipo = 'CEL'
and e.estado = 'SP';

/* Função */
select 
    c.nome, 
    ifnull(c.email, 'NAO TEM EMAIL') as email, 
    e.estado, 
    t.numero
from cliente c
inner join endereco e on c.id = e.cliente_id
inner join telefone t on c.id = t.cliente_id;

/* View */
select
    c.nome,
    c.sexo,
    c.email,
    t.tipo,
    t.numero,
    e.bairro,
    e.cidade,
    e.estado
from cliente c
inner join telefone t on c.id = t.cliente_id
inner join endereco e on c.id = e.cliente_id;

create view relatorio as
select
    c.nome,
    c.sexo,
    c.email,
    t.tipo,
    t.numero,
    e.bairro,
    e.cidade,
    e.estado
from cliente c
inner join telefone t on c.id = t.cliente_id
inner join endereco e on c.id = e.cliente_id;

select * from relatorio;

/* Apagar View */
drop view relatorio;

/* Criar View utilizando prefixo */
create view v_relatorio as
select
    c.nome,
    c.sexo,
    ifnull(c.email, 'CLIENTE SEM EMAIL') as email,
    t.tipo,
    t.numero,
    e.bairro,
    e.cidade,
    e.estado
from cliente c
inner join telefone t on c.id = t.cliente_id
inner join endereco e on c.id = e.cliente_id;

select nome, numero, estado
from v_relatorio;

/* Procedures */
create table curso(
    id int primary key auto_increment,
    nome varchar(30) not null,
    horas int(3) not null,
    valor float(10,2) not null
);

insert into curso values(null, 'JAVA', 30, 500.00);
insert into curso values(null, 'FUNDAMENTOS DE BANCO DE DADOS', 40, 700.00);

delimiter $
create procedure cad_curso(p_nome varchar(30), p_horas int(3), p_valor float(10,2))
begin
    insert into curso values(null, p_nome, p_horas, p_valor);
end
$
delimiter;

call cad_curso('BI SQL SERVER', 35, 3000.00);
call cad_curso('POWER BI', 20, 1000.00);
call cad_curso('TABLEAU', 30, 1200.00);

delimiter $
create procedure consultar_cursos()
begin
    select id, nome, horas, valor from curso;
end
$
delimiter ;

/* Funções de Agregação */
create table vendedor(
    id int primary key auto_increment,
    nome varchar(30),
    sexo char(1),
    janeiro float(10,2),
    fevereiro float(10,2),
    marco float(10,2)
);

insert into vendedor values(null,'CARLOS','M',79234.78,5433453.87,998798.90);
insert into vendedor values(null,'MARIA','F',44332.58,54353.87,223455.90);
insert into vendedor values(null,'ANTONIO','M',88774.65,65652.87,7723453.90);
insert into vendedor values(null,'CLARA','F',22433.72,654245.87,554322.90);
insert into vendedor values(null,'ANDERSON','M',4432.12,54332.87,55322.90);
insert into vendedor values(null,'IVONE','F',55432.22,23423.87,7665433.90);
insert into vendedor values(null,'JOAO','M',22643.44,554322.87,4422211.90);
insert into vendedor values(null,'CELIA','F',99327.55,555322.87,799643.90);

/* Funcões */
select max(fevereiro) as maior_fev
from vendedor;

select min(fevereiro) as menor_fev
from vendedor;

select avg(fevereiro) as media_fev
from vendedor;

select
    max(janeiro) as max_jan,
    min(janeiro) as min_jan,
    truncate(avg(janeiro),2) as media_jan -- Limitar as casas decimais
from vendedor;

select sum(janeiro) as total_jan from vendedor;

select sexo, sum(marco) as total_marco
from vendedor
group by sexo;

select nome, min(marco) as min_marco
from vendedor
group by nome
order by min_marco
limit 1;
-- OU
select nome, marco
from vendedor
where marco = (select min(marco) from vendedor);

select nome, fevereiro
from vendedor
where fevereiro > (select avg(fevereiro) from vendedor);

select
    nome,
    janeiro,
    fevereiro,
    marco,
    (janeiro + fevereiro + marco) as total,
    ((janeiro + fevereiro + marco) * 0.25) as "desconto 25%",
    truncate(((janeiro + fevereiro + marco) / 3),2) as media
from vendedor;

/* Alterar estrutura da Tabela */
create table tabela(
    coluna1 varchar(30),
    coluna2 varchar(30),
    coluna3 varchar(30)
);

alter table tabela
add primary key (coluna1);

alter table tabela
add column coluna4 varchar(30) not null unique
after coluna3;

alter table tabela
modify coluna2 date not null;

alter table tabela
rename pessoa;

create table time(
    id int primary key auto_increment,
    time varchar(30),
    pessoa_id varchar(30)
);

alter table time
add foreign key(pessoa_id)
references pessoa(coluna1);

/* Verificar as chaves */
show create table time;

/* Organização de chaves */
create table jogador(
    id int primary key auto_increment,
    nome varchar(30)
);

create table time(
    id int primary key auto_increment,
    nome varchar(30),
    jogador_id int,
    foreign key(jogador_id) references jogador(id)
);

insert into jogador values(null, 'GUERREIRO');
insert into time values(null, 'FLAMENGO', 1);

drop table endereco;
drop table telefone;
drop table cliente;

/* Boas práticas - Criar a tabela primeiro e depois as Constraints */
create table cliente(
    id int,
    nome varchar(30) not null
);

create table telefone(
    id int,
    tipo char(3) not null,
    numero varchar(10) not null,
    cliente_id int
);

alter table cliente
add constraint pk_cliente
primary key(id);

alter table telefone
add constraint fk_cliente_telefone
foreign key(cliente_id) references cliente(id);

show create table telefone; -- Verificar como ficou o script de criação da tabela.

/* Dicionário de dados */
-- Pesquisar Constraints
USE information_schema;

SHOW tables;

DESC TABLE_CONSTRAINTS;

SELECT 
    CONSTRAINT_SCHEMA AS "BANCO",
    TABLE_NAME AS "TABELA",
    CONSTRAINT_NAME AS "NOME REGRA",
    CONSTRAINT_TYPE AS "TIPO"
FROM TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'comercio';

-- Apagar Constraints
ALTER TABLE telefone
DROP FOREIGN KEY fk_cliente_telefone;

/* 
Exercício
1) Crie um banco de dados chamado projeto e conecte-se ao banco.
2) Faça a seguinte modelagem:
Sr. José quer modernizar a sua oficina, e por enquanto, cadastrar os carros 
que entram para realizar serviços e os seus respectivos donos. Sr. José mencionou que cada cliente
possui apenas um carro. Um carro possui uma marca. Sr. José também quer saber as cores dos carros para ter
idéia de qual tinta comprar, e informa que um carro pode ter mais de uma cor. Sr José necessita
armazenar os telefones dos clientes, mas não quer que eles sejam obrigatórios. 
*/

create database projeto;

create table carro(
    id int primary key auto_increment,
    modelo varchar(30) not null,
    marca_id int
);

create table marca(
    id int primary key auto_increment,
    nome varchar(30) not null
);

create table cor(
    id int primary key auto_increment,
    nome varchar(20) not null
);

create table cor_carro(
    cor_id int,
    carro_id int
);

create table cliente(
    id int primary key auto_increment,
    nome varchar(30) not null,
    carro_id int unique
);

create table telefone(
    id int primary key auto_increment,
    tipo enum('RES', 'COM', 'CEL') not null,
    numero varchar(15) not null,
    cliente_id int
);

alter table carro
add constraint fk_marca_carro
foreign key(marca_id) references marca(id);

alter table cor_carro
add constraint fk_cor_cor_carro
foreign key(cor_id) references cor(id);

alter table cor_carro
add constraint fk_carro_cor_carro
foreign key(carro_id) references carro(id);

alter table cliente
add constraint fk_carro_cliente
foreign key(carro_id) references carro(id);

alter table telefone
add constraint fk_cliente_telefone
foreign key(cliente_id) references cliente(id);

insert into marca values(null,'FORD');
insert into marca values(null,'CHEVROLET');
insert into marca values(null,'FIAT');

insert into carro values(null,'ESCORT 1.6',1);
insert into carro values(null,'OPALA 4.0',2);
insert into carro values(null,'UNO 1.0',3);

insert into cor values(null,'PRETO');
insert into cor values(null,'VERMELHO');
insert into cor values(null,'PRATA');

insert into cor_carro values(1,1);
insert into cor_carro values(3,1);
insert into cor_carro values(2,2);
insert into cor_carro values(3,3);

insert into cliente values(null,'MATHEUS R BRUNELLI',2);
insert into cliente values(null,'DAYSA DE MORAIS DOS SANTOS',3);
insert into cliente values(null,'JOSE ALCUNHA PINTO',1);

insert into telefone values(null,'CEL','44991091201',1);
insert into telefone values(null,'CEL','44998314806',2);
insert into telefone values(null,'RES','4436621131',3);

select 
    c.id,
    c.modelo,
    m.nome as marca,
    cl.nome as cliente,
    t.numero as telefone
from carro c
inner join marca m on m.id = c.marca_id
inner join cliente cl on cl.carro_id = c.id
inner join telefone t on t.cliente_id = cl.id;

select
    cr.id,
    cr.modelo,
    m.nome as marca,
    c.nome as cor,
    cl.nome as cliente,
    t.numero as telefone
from cor_carro cc
inner join carro cr on cr.id = cc.carro_id
inner join cor c on c.id = cc.cor_id
inner join marca m on m.id = cr.marca_id
inner join cliente cl on cl.carro_id = cr.id
inner join telefone t on t.cliente_id = cl.id
order by cr.id;
