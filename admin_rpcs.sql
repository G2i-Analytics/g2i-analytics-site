-- admin_rpcs.sql
-- EVERALDO UUID: f8cb92e7-5edb-4b14-b132-3ff515b22d61

create or replace function admin_set_access(
  target_email text,
  target_page_id text,
  target_can_view boolean
) returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  admin_id uuid := 'f8cb92e7-5edb-4b14-b132-3ff515b22d61'::uuid;
  caller uuid;
  uid uuid;
begin
  select auth.uid() into caller;
  if caller is distinct from admin_id then
    raise exception 'Acesso negado';
  end if;

  select id into uid from auth.users where email = target_email;
  if uid is null then
    raise exception 'Usuário com e-mail % não encontrado', target_email;
  end if;

  insert into user_pages (user_id, page_id, can_view)
  values (uid, target_page_id, target_can_view)
  on conflict (user_id, page_id) do update set can_view = excluded.can_view;
end;
$$;

revoke all on function admin_set_access(text,text,boolean) from public;
grant execute on function admin_set_access(text,text,boolean) to anon, authenticated;

create or replace function admin_list_access(target_email text)
returns table(page_id text, can_view boolean)
language plpgsql
security definer
set search_path = public
as $$
declare
  admin_id uuid := 'f8cb92e7-5edb-4b14-b132-3ff515b22d61'::uuid;
  caller uuid;
  uid uuid;
begin
  select auth.uid() into caller;
  if caller is distinct from admin_id then
    raise exception 'Acesso negado';
  end if;

  select id into uid from auth.users where email = target_email;
  if uid is null then
    raise exception 'Usuário com e-mail % não encontrado', target_email;
  end if;

  return query
  select up.page_id, up.can_view
  from user_pages up
  where up.user_id = uid
  order by up.page_id;
end;
$$;

revoke all on function admin_list_access(text) from public;
grant execute on function admin_list_access(text) to anon, authenticated;
