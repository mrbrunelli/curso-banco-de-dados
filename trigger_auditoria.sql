create database loja;

use loja;

create table produto(
    id int primary key auto_increment,
    nome varchar(30),
    valor float(10,2)
);

insert into produto values(null, 'LIVRO SQL', 50.00);
insert into produto values(null, 'LIVRO MODELAGEM', 30.00);
insert into produto values(null, 'LIVRO POSTGRESQL', 70.00);
insert into produto values(null, 'LIVRO MYQL', 60.00);

/* Quando e Quem alterou o produto */
select now();
select current_user();

create database backup;

use backup;

create table bkp_produto(
    id int primary key auto_increment,
    produto_id int,
    nome varchar(30),
    valor_original float(10,2),
    valor_alterado float(10,2),
    data datetime,
    usuario varchar(30),
    evento char(1)
);

/* Trigger que irá atuditar as modificações */
use loja;

delimiter $

create trigger audit_prod
after update on produto
for each row
begin
    insert into backup.bkp_produto values
    (null, old.id, old.nome, old.valor, new.valor, now(), current_user(), 'U');
end
$

delimiter ;

update produto set valor = 110.00
where id = 4;

select * from backup.bkp_produto;