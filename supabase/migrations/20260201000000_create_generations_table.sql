-- ============================================================================
-- Migration: Create Generations Table
-- Description: Creates the generations table to track AI flashcard generation
--              sessions and their metadata.
-- Tables: generations
-- Special Considerations:
--   - References auth.users table managed by Supabase Auth
--   - RLS enabled with user-specific access policies
--   - Must be created before flashcards table (dependency)
-- ============================================================================

-- ============================================================================
-- Table: generations
-- Purpose: Tracks AI generation sessions and their metadata
-- ============================================================================
create table public.generations (
  id bigserial primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  model varchar not null,
  generated_count integer not null,
  accepted_unedited_count integer,
  accepted_edited_count integer,
  source_text_hash varchar not null,
  source_text_length integer not null check (source_text_length between 1000 and 10000),
  generation_duration integer not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Enable row level security for generations table
alter table public.generations enable row level security;

-- RLS Policy: Allow authenticated users to select their own generation records
create policy "authenticated_users_select_own_generations"
  on public.generations
  for select
  to authenticated
  using (auth.uid() = user_id);

-- RLS Policy: Allow authenticated users to insert their own generation records
create policy "authenticated_users_insert_own_generations"
  on public.generations
  for insert
  to authenticated
  with check (auth.uid() = user_id);

-- RLS Policy: Allow authenticated users to update their own generation records
create policy "authenticated_users_update_own_generations"
  on public.generations
  for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- RLS Policy: Allow authenticated users to delete their own generation records
create policy "authenticated_users_delete_own_generations"
  on public.generations
  for delete
  to authenticated
  using (auth.uid() = user_id);

-- Index: Improve query performance for user-specific generation lookups
create index idx_generations_user_id on public.generations(user_id);

comment on table public.generations is 'Stores metadata about AI flashcard generation sessions';
comment on column public.generations.model is 'AI model used for generation';
comment on column public.generations.generated_count is 'Total number of flashcards generated in this session';
comment on column public.generations.accepted_unedited_count is 'Number of AI-generated flashcards accepted without edits';
comment on column public.generations.accepted_edited_count is 'Number of AI-generated flashcards accepted with edits';
comment on column public.generations.source_text_hash is 'Hash of source text to detect duplicates';
comment on column public.generations.source_text_length is 'Length of source text in characters (1000-10000)';
comment on column public.generations.generation_duration is 'Time taken to generate flashcards in milliseconds';
