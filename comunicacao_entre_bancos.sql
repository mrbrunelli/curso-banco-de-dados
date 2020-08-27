create database loja;

use loja;

create table produto(
    id int primary key auto_increment,
    nome varchar(30) not null,
    valor float(10,2)
);

create database backup;

use backup;

create table bkp_produto(
    id int primary key auto_increment,
    produto_id int,
    nome varchar(30),
    valor float(10,2)
);

/* Estamos conectados no banco loja e vamos realizar um insert no banco backup s*/
use loja;

insert into backup.bkp_produto values(null, 1000,'TESTE',0.0);

/* 
    Criar Trigger que faz o backup de um banco para outro 
    o new faz referência a tabela descrita no before insert (produto)
*/
delimiter $
create trigger backup_produto_insert
after insert on produto
for each row
begin
    insert into backup.bkp_produto values(null, new.id, new.nome, new.valor);
end
$
delimiter ;

delimiter $
create trigger backup_produto_delete
before delete on produto
for each row
begin
    insert into backup.bkp_produto values(null, old.id, old.nome, old.valor);
end
$
delimiter ;

/* Testar a Trigger */
insert into produto values(null, 'LIVRO SQL', 50.00);
insert into produto values(null, 'LIVRO MODELAGEM', 30.00);
insert into produto values(null, 'LIVRO POSTGRESQL', 70.00);
insert into produto values(null, 'LIVRO MYQL', 60.00);

select * from produto;

select * from backup.bkp_produto;

/* Dropar Trigger */
drop trigger backup_produto;