--CRICAO DAS TABELAS
create table estado (id_estado serial primary key, nome_estado varchar(25) not null,sigla char(2) not null);
create table municipio (id_municipio serial primary key, nome_municipio varchar(40) not null, id_estado smallint not null, foreign key(id_estado) references estado(id_estado));

create table indicativos_estado(id_estado smallint, tMortalidade_estado decimal(4,2) CHECK(tMortalidade_estado >= 0), tAnalfabetismo_estado decimal(5,2) check(tAnalfabetismo_estado >= 0), tIDH decimal(4,3) CHECK(tIDH >=0 and tIDH <= 1), tRendaPercapita_estado decimal(10,3) check (tRendaPercapita_estado >= 0), ano smallint, primary key (id_estado,ano), foreign key (id_estado) references estado(id_estado), classificacao varchar(15));
create table indicativos_municipio(id_municipio smallint, tMortalidade_municipio decimal(10,3) CHECK(tMortalidade_municipio >= 0), tAnalfabetismo_municipio decimal(5,2) check(tAnalfabetismo_municipio >= 0), tIDHM decimal(4,3) CHECK(tIDHM >=0 and tIDHM <= 1), tRendaPercapita_municipio decimal(10,3) check (tRendaPercapita_municipio >= 0), ano smallint , primary key (id_municipio,ano), foreign key (id_municipio) references municipio(id_municipio), classificacao varchar(15) not null);


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

--TRIGGERS
--para classificar idh de estado
create or replace function classifica_idh()
returns trigger as $$
begin

if((new.tidh >= 0 )and (new.tidh <= 0.499)) then
	--insert into indicativos_estado(id_estado, tmortalidade_estado, tanalfabetismo_estado, tidh, trendapercapita_estado, ano, classificacao) 
	--values(new.id_estado, new.tmortalidade_estado, new.tanalfabetismo_estado, new.tidh, new.trendapercapita_estado, new.ano, 'Muito Baixo');
	update indicativos_estado set classificacao = 'Muito Baixo'
   	where id_estado = new.id_estado and ano = new.ano;
else
   if((new.tidh >= 0.500 )and (new.tidh <= 0.599)) then
			--insert into indicativos_estado(classificacao)
			--values(new.id_estado, new.tmortalidade_estado, new.tanalfabetismo_estado, new.tidh, new.trendapercapita_estado, new.ano, 'Baixo');
   			update indicativos_estado set classificacao = 'Baixo'	
   			where id_estado = new.id_estado and ano = new.ano;   
	else
		if((new.tidh >= 0.600 )and (new.tidh <= 0.699)) then
			--insert into indicativos_estado(classificacao)
			--values(new.id_estado, new.tmortalidade_estado, new.tanalfabetismo_estado, new.tidh, new.trendapercapita_estado, new.ano, 'Médio');
			update indicativos_estado set classificacao = 'Médio'	
   			where id_estado = new.id_estado and ano = new.ano;   
		else
				if((new.tidh >= 0.700 )and (new.tidh <= 0.799)) then
					--insert into indicativos_estado(classificacao)
					--values(new.id_estado, new.tmortalidade_estado, new.tanalfabetismo_estado, new.tidh, new.trendapercapita_estado, new.ano, 'Alto');
					update indicativos_estado set classificacao = 'Alto'	
   					where id_estado = new.id_estado and ano = new.ano;   
				else
					if((new.tidh >= 0.800 )and (new.tidh <= 1.000)) then
						--insert into indicativos_estado(classificacao)
						--values(new.id_estado, new.tmortalidade_estado, new.tanalfabetismo_estado, new.tidh, new.trendapercapita_estado, new.ano, 'Muito Alto');
   						update indicativos_estado set classificacao = 'Muito Alto'	
   						where id_estado = new.id_estado and ano = new.ano;
					else
						RAISE EXCEPTION 'Valor invalido para IDH!';
					end if;					
				end if;
		end if;
	end if;
end if;	
return null;
end;
$$language plpgsql;

create trigger tgidh
after insert on indicativos_estado
for each row
execute procedure classifica_idh();




--TRIGGERS
--para classificar idh de municipios
create or replace function classifica_idh_municipio()
returns trigger as $$
begin

if((new.tidhm >= 0 )and (new.tidhm <= 0.499)) then
	--insert into indicativos_estado(id_estado, tmortalidade_estado, tanalfabetismo_estado, tidh, trendapercapita_estado, ano, classificacao) 
	--values(new.id_estado, new.tmortalidade_estado, new.tanalfabetismo_estado, new.tidh, new.trendapercapita_estado, new.ano, 'Muito Baixo');
	update indicativos_municipio set classificacao = 'Muito Baixo'
   	where id_municipio = new.id_municipio and ano = new.ano;
else
   if((new.tidhm >= 0.500 )and (new.tidhm <= 0.599)) then
			--insert into indicativos_estado(classificacao)
			--values(new.id_estado, new.tmortalidade_estado, new.tanalfabetismo_estado, new.tidh, new.trendapercapita_estado, new.ano, 'Baixo');
   			update indicativos_municipio set classificacao = 'Baixo'	
   			where id_municipio = new.id_municipio and ano = new.ano;   
	else
		if((new.tidhm >= 0.600 )and (new.tidhm <= 0.699)) then
			--insert into indicativos_estado(classificacao)
			--values(new.id_estado, new.tmortalidade_estado, new.tanalfabetismo_estado, new.tidh, new.trendapercapita_estado, new.ano, 'Médio');
			update indicativos_municipio set classificacao = 'Médio'	
   			where id_municipio = new.id_municipio and ano = new.ano;   
		else
				if((new.tidhm >= 0.700 )and (new.tidhm <= 0.799)) then
					--insert into indicativos_estado(classificacao)
					--values(new.id_estado, new.tmortalidade_estado, new.tanalfabetismo_estado, new.tidh, new.trendapercapita_estado, new.ano, 'Alto');
					update indicativos_municipio set classificacao = 'Alto'	
   					where id_municipio = new.id_municipio and ano = new.ano;   
				else
					if((new.tidhm >= 0.800 )and (new.tidhm <= 1.000)) then
						--insert into indicativos_estado(classificacao)
						--values(new.id_estado, new.tmortalidade_estado, new.tanalfabetismo_estado, new.tidh, new.trendapercapita_estado, new.ano, 'Muito Alto');
   						update indicativos_municipio set classificacao = 'Muito Alto'	
   						where id_municipio = new.id_municipio and ano = new.ano;
					else
						RAISE EXCEPTION 'Valor invalido para IDH!';
					end if;					
				end if;
		end if;
	end if;
end if;	
return null;
end;
$$language plpgsql;

create trigger tgidh
after insert on indicativos_municipio
for each row
execute procedure classifica_idh_municipio();






--IMPORTAR ARQUIVO CSV
--arquivo dos estados
COPY estado(nome_estado, sigla) FROM 'C:/estados.csv'  using delimiters ';'
--arquvi dos municipios
COPY municipio(nome_estado, sigla) FROM 'C:/municipios.csv'  using delimiters ';'
--indicadores estaduais
COPY indicativos_estado(id_estado, tmortalidade_estado, tanalfabetismo_estado, tidh, trendapercapita_estado, ano) FROM 'C:/taxas_estados.csv'  using delimiters ';'
--indicadores municipais
COPY indicativos_municipio(id_municipio, tMortalidade_municipio, tAnalfabetismo_municipio, tIDHM, tRendaPercapita_municipio, ano) FROM 'C:/taxas_municipios.csv'  using delimiters ';'