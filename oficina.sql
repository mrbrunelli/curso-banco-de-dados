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

create database oficina;

use oficina;

create table carro(
    id int primary key auto_increment,
    modelo varchar(30) not null,
    placa varchar(7) not null unique,
    marca_id int
);

create table marca(
    id int primary key auto_increment,
    nome varchar(30) not null unique
);

create table cor(
    id int primary key auto_increment,
    nome varchar(20) not null unique
);

create table carro_cor(
    cor_id int,
    carro_id int,
    primary key(cor_id, carro_id)
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

/* Constraints */

alter table carro
add constraint fk_carro_marca
foreign key(marca_id) 
references marca(id);

alter table carro_cor
add constraint fk_cor
foreign key(cor_id) 
references cor(id);

alter table carro_cor
add constraint fk_carro
foreign key(carro_id) 
references carro(id);

alter table cliente
add constraint fk_cliente_carro
foreign key(carro_id) 
references carro(id);

alter table telefone
add constraint fk_telefone_cliente
foreign key(cliente_id) 
references cliente(id);

insert into marca values(null,'FORD');
insert into marca values(null,'CHEVROLET');
insert into marca values(null,'FIAT');

insert into carro values(null,'ESCORT 1.6','ABA2A18',1);
insert into carro values(null,'OPALA 4.0','CAA2A29',2);
insert into carro values(null,'UNO 1.0','AKK2A10',3);

insert into cor values(null,'PRETO');
insert into cor values(null,'VERMELHO');
insert into cor values(null,'PRATA');

insert into carro_cor values(1,1);
insert into carro_cor values(3,1);
insert into carro_cor values(2,2);
insert into carro_cor values(3,3);

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
from carro_cor cc
inner join carro cr on cr.id = cc.carro_id
inner join cor c on c.id = cc.cor_id
inner join marca m on m.id = cr.marca_id
inner join cliente cl on cl.carro_id = cr.id
inner join telefone t on t.cliente_id = cl.id
order by cr.id;
