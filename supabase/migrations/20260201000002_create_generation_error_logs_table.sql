-- ============================================================================
-- Migration: Create Generation Error Logs Table
-- Description: Creates the generation_error_logs table to track errors that
--              occur during AI flashcard generation for debugging and monitoring.
-- Tables: generation_error_logs
-- Special Considerations:
--   - References auth.users table managed by Supabase Auth
--   - RLS enabled with user-specific access policies
--   - Independent table, no dependencies on other application tables
-- ============================================================================

-- ============================================================================
-- Table: generation_error_logs
-- Purpose: Logs errors that occur during AI flashcard generation
-- ============================================================================
create table public.generation_error_logs (
  id bigserial primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  model varchar not null,
  source_text_hash varchar not null,
  source_text_length integer not null check (source_text_length between 1000 and 10000),
  error_code varchar(100) not null,
  error_message text not null,
  created_at timestamptz not null default now()
);

-- Enable row level security for generation_error_logs table
alter table public.generation_error_logs enable row level security;

-- RLS Policy: Allow authenticated users to select their own error logs
create policy "authenticated_users_select_own_error_logs"
  on public.generation_error_logs
  for select
  to authenticated
  using (auth.uid() = user_id);

-- RLS Policy: Allow authenticated users to insert their own error logs
create policy "authenticated_users_insert_own_error_logs"
  on public.generation_error_logs
  for insert
  to authenticated
  with check (auth.uid() = user_id);

-- RLS Policy: Allow authenticated users to update their own error logs
-- Note: Updates to error logs are typically not needed, but included for completeness
create policy "authenticated_users_update_own_error_logs"
  on public.generation_error_logs
  for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- RLS Policy: Allow authenticated users to delete their own error logs
create policy "authenticated_users_delete_own_error_logs"
  on public.generation_error_logs
  for delete
  to authenticated
  using (auth.uid() = user_id);

-- Index: Improve query performance for user-specific error log lookups
create index idx_generation_error_logs_user_id on public.generation_error_logs(user_id);

comment on table public.generation_error_logs is 'Logs errors that occur during AI flashcard generation for debugging and monitoring';
comment on column public.generation_error_logs.model is 'AI model that was being used when error occurred';
comment on column public.generation_error_logs.source_text_hash is 'Hash of source text that caused the error';
comment on column public.generation_error_logs.source_text_length is 'Length of source text in characters (1000-10000)';
comment on column public.generation_error_logs.error_code is 'Error code for categorization';
comment on column public.generation_error_logs.error_message is 'Detailed error message';
