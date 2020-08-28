create database consultorio;

use consultorio;

create table paciente(
    id int primary key auto_increment,
    nome varchar(30),
    sexo char(1),
    email varchar(30),
    nascimento date
);

create table medico(
    id int primary key auto_increment,
    nome varchar(30),
    sexo char(1),
    especialidade varchar(30),
    funcionario enum('S','N')
);

create table hospital(
    id int primary key auto_increment,
    nome varchar(30),
    bairro varchar(30),
    cidade varchar(30),
    estado char(2)
);

create table consulta(
    id int primary key auto_increment,
    paciente_id int,
    medico_id int,
    hospital_id int,
    data datetime,
    diagnostico varchar(50)
);

create table internacao(
    id int primary key auto_increment,
    entrada datetime,
    quarto int,
    saida datetime,
    observacoes varchar(50),
    consulta_id int unique
);

alter table consulta
add constraint fk_consulta_paciente
foreign key(paciente_id)
references paciente(id);

alter table consulta
add constraint fk_consulta_medico
foreign key(medico_id)
references medico(id);

alter table consulta
add constraint fk_consulta_hospital
foreign key(hospital_id)
references hospital(id);

alter table internacao
add constraint fk_internacao_consulta
foreign key(consulta_id)
references consulta(id);