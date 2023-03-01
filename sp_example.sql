CREATE or replace Procedure update_autor_sp(id1 integer, nombre1 varchar(100))
language plpgsql as
$$
begin
  UPDATE public."Autores" SET "Nombre" = nombre1
  WHERE public."Autores"."Id" =id1;
end
$$;

call update_autor_sp(1,'pepepe');

select a.* from public."Autores" a;
select a.* from public."Libros" a;
select a.* from public."Comentarios" a;

select a1.*,c1."Titulo",c1."FechaPublicacion", d1."Contenido" from public."Autores" a1
full outer join public."AutoresLibros" b1 on a1."Id"=b1."AutorId"
full outer join public."Libros" c1 on c1."Id"=b1."LibroId"
full outer join public."Comentarios" d1 on d1."Id"=c1."Id"
where a1."Id" is not null
order by a1."Id";


select a1."Titulo", b1."Contenido" from public."Libros" a1
join public."Comentarios" b1 on a1."Id"=b1."LibroId"
where a1."Id"=2;

select a1.* from public."Autores" a1
where not exists (select * from public."Libros" b where a1."Id"=b."Id");


update public."Comentarios"
set "Contenido"=concat('comment: ->',upper(substr(md5(random()::text), 0, 25)))
where "Comentarios"."Contenido" like '%comment%';

select a.* from public."Comentarios" a order by a."Id";
