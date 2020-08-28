create database faculdade;

use faculdade;

create table curso(
    id int primary key auto_increment,
    nome varchar(30),
    horas int,
    valor float(10,2),
    prereq_id int
);

alter table curso
add constraint fk_prereq
foreign key(prereq_id)
references curso(id);

insert into curso values(null, 'BD RELACIONAL', 25, 400.00, null);
insert into curso values(null, 'BUSINESS INTELLIGENCE', 40, 700.00, 1);
insert into curso values(null, 'RELATORIOS AVANCADOS', 20, 100.00, 2);
insert into curso values(null, 'LOGICA DE PROGRAMACAO', 30, 200.00, null);
insert into curso values(null, 'PHP', 40, 300.00, 4);

select
    c.nome,
    c.valor,
    c.horas,
    ifnull(p.nome, 'SEM PRE-REQUISITOS') as requisito
from curso c
left join curso p on p.id = c.prereq_id;