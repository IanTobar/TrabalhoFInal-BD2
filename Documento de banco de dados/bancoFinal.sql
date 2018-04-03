--CRICAO DAS TABELAS
create table estado (id_estado serial primary key, nome_estado varchar(25) not null,sigla char(2) not null);
create table municipio (id_municipio smallint primary key, id_estado smallint, nome_municipio varchar(40), foreign key(id_estado) references estado(id_estado));
create table indicativos_municipio(id_municipio smallint, ano smallint, tMortalidade_municipio numeric(2) CHECK(tMortalidade_municipio >= 0) , tIDHM numeric(3)CHECK(tIDHM >=0 and tIDHM <= 1),tAnalfabetismo_municipio numeric(2) check(tAnalfabetismo_municipio >= 0), tRendaPercapita_municipio numeric(2) check (tRendaPercapita_municipio >= 0), primary key (id_municipio,ano), foreign key (id_municipio) references municipio(id_municipio), classificacao varchar(15) not null);
create table indicativos_estado(id_estado smallint, ano smallint, tMortalidade_estado numeric(2) CHECK(tMortalidade_estado >= 0), tIDH numeric(3)CHECK(tIDH >=0 and tIDH <= 1),tAnalfabetismo_estado numeric(2) check(tAnalfabetismo_estado >= 0), tRendaPercapita_estado numeric(2) check (tRendaPercapita_estado >= 0), primary key (id_estado,ano), foreign key (id_estado) references estado(id_estado), classificacao varchar(15) not null );


--VIEWS MUNICIPIO
create view view_tMortalidade_municipio as select tmortalidade_municipio from indicativos_municipio;
create view view_tIDHM as select tIDHm FROM municipio;
create view view_tAnalfabetismo_municipio as select tAnalfabetismo_municipio from municipio;
create view view_tRendaPercapita_municipio as select tRendaPercapita_municipio from municipio;

--VIEWS ESTADO
create view view_tMortalidade_estado as select tMortalidade_estado from estado;
create view view_tIDH as select tIDH from municipio;
create view view_tAnalfabetismo_estado as select tAnalfabetismo_estado from estado;
create view view_tRendaPercapita_estado as select tRendaPercapita_estado from estado;

--IMPORTAR ARQUIVO CSV
COPY estado(nome_estado, sigla) FROM 'C:/AtlasBrasil_Consulta Estado2.csv'  using delimiters ';'