create database cursores;

use cursores;

create table vendedores(
    id int primary key auto_increment,
    nome varchar(50),
    jan int,
    fev int,
    mar int
);

insert into vendedores values(null,'BRUNELLI',3322,5554,6669);
insert into vendedores values(null,'CLARA',44892,44321,88943);
insert into vendedores values(null,'JOÃO',44321,55432,55432);
insert into vendedores values(null,'DAYSA',43445,66674,24674);
insert into vendedores values(null,'JOSELINO',2245,66543,77564);
insert into vendedores values(null,'ALFREDO',5543,77543,3543);
insert into vendedores values(null,'BON JOVI',6724,77824,89022);

select nome, (jan + fev + mar) as total from vendedores;
select nome, (jan + fev + mar) as total, (jan + fev + mar)/3 as media from vendedores;

create table vend_total(
    nome varchar(50),
    jan int,
    fev int,
    mar int,
    total int,
    media int
);

/* Criar Cursor */
delimiter $
create procedure inseredados()
begin
    declare fim int default 0;
    declare var1, var2, var3, vtotal, vmedia int;
    declare vnome varchar(50);

    declare reg cursor for(
        select nome, jan, fev, mar from vendedores
    );

    declare continue handler for not found set fim = 1;

    open reg;

    repeat
        fetch reg into vnome, var1, var2, var3;
        if not fim then
            set vtotal = var1 + var2 + var3;
            set vmedia = vtotal / 3;
            insert into vend_total values(vnome, var1, var2, var3, vtotal, vmedia);
        end if;
    until fim end repeat;

    close reg;
end
$
delimiter ;

select * from vendedores;
select * from vend_total;

/* Executar o Cursor */
call inseredados();
