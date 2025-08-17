-- register_admin_page.sql
insert into pages (page_id, title, url) values
  ('admin', 'Admin', '/admin.html')
on conflict (page_id) do nothing;
