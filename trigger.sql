create database aula_trigger;

use aula_trigger;

create table usuario(
    id int primary key auto_increment,
    nome varchar(30),
    login varchar(30),
    senha varchar(100)
);

create table bkp_usuario(
    id int primary key auto_increment,
    usuario_id int,
    nome varchar(30),
    login varchar(30)
);

/* Criar Trigger */
delimiter $
create trigger backup_user
before delete on usuario
for each row
begin
    insert into bkp_usuario values 
    (null, old.id, old.nome, old.login);
end
$
delimiter ;

/* Inserir usuários */
insert into usuario values(null,'Matheus','matheus.brunelli','teste');

/* Testar a Trigger */
delete from usuario where id = 1;
