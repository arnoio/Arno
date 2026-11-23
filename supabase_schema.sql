-- دستور ساخت جداول در Supabase SQL Editor
create table if not exists arno_profiles (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  username text unique not null,
  email text unique not null,
  phone text default '',
  password_hash text not null,
  avatar_data_url text default '',
  created_at timestamp with time zone default now()
);

create table if not exists arno_tickets (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references arno_profiles(id) on delete cascade,
  title text not null,
  body text not null,
  status text default 'open',
  reply text default '',
  created_at timestamp with time zone default now()
);

create table if not exists arno_reviews (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references arno_profiles(id) on delete cascade,
  text text not null,
  approved boolean default false,
  created_at timestamp with time zone default now()
);

create table if not exists arno_content (
  key text primary key,
  value text not null
);

alter table arno_profiles enable row level security;
alter table arno_tickets enable row level security;
alter table arno_reviews enable row level security;
alter table arno_content enable row level security;

create policy "public_all_profiles" on arno_profiles for all using (true) with check (true);
create policy "public_all_tickets" on arno_tickets for all using (true) with check (true);
create policy "public_all_reviews" on arno_reviews for all using (true) with check (true);
create policy "public_all_content" on arno_content for all using (true) with check (true);
