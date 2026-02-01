-- ============================================================================
-- Migration: Create Flashcards Table
-- Description: Creates the flashcards table to store individual flashcards
--              created by users or AI, with automatic updated_at trigger.
-- Tables: flashcards
-- Special Considerations:
--   - References auth.users and generations tables
--   - RLS enabled with user-specific access policies
--   - Includes trigger to auto-update updated_at timestamp
--   - Depends on generations table existing first
-- ============================================================================

-- ============================================================================
-- Table: flashcards
-- Purpose: Stores individual flashcards created by users or AI
-- ============================================================================
create table public.flashcards (
  id bigserial primary key,
  front varchar(200) not null,
  back varchar(500) not null,
  source varchar not null check (source in ('ai-full', 'ai-edited', 'manual')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  generation_id bigint references public.generations(id) on delete set null,
  user_id uuid not null references auth.users(id) on delete cascade
);

-- Enable row level security for flashcards table
alter table public.flashcards enable row level security;

-- RLS Policy: Allow authenticated users to select their own flashcards
create policy "authenticated_users_select_own_flashcards"
  on public.flashcards
  for select
  to authenticated
  using (auth.uid() = user_id);

-- RLS Policy: Allow authenticated users to insert their own flashcards
create policy "authenticated_users_insert_own_flashcards"
  on public.flashcards
  for insert
  to authenticated
  with check (auth.uid() = user_id);

-- RLS Policy: Allow authenticated users to update their own flashcards
create policy "authenticated_users_update_own_flashcards"
  on public.flashcards
  for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- RLS Policy: Allow authenticated users to delete their own flashcards
create policy "authenticated_users_delete_own_flashcards"
  on public.flashcards
  for delete
  to authenticated
  using (auth.uid() = user_id);

-- Index: Improve query performance for user-specific flashcard lookups
create index idx_flashcards_user_id on public.flashcards(user_id);

-- Index: Improve query performance for generation-specific flashcard lookups
create index idx_flashcards_generation_id on public.flashcards(generation_id);

comment on table public.flashcards is 'Stores flashcards created by users or AI';
comment on column public.flashcards.front is 'Front side of flashcard (question/prompt)';
comment on column public.flashcards.back is 'Back side of flashcard (answer)';
comment on column public.flashcards.source is 'Origin of flashcard: ai-full (unedited AI), ai-edited (edited AI), or manual (user-created)';
comment on column public.flashcards.generation_id is 'Optional reference to the generation session that created this flashcard';

-- ============================================================================
-- Trigger Function: Auto-update updated_at timestamp
-- Purpose: Automatically updates the updated_at column when a flashcard is modified
-- ============================================================================
create or replace function public.update_flashcards_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

-- Trigger: Execute update_flashcards_updated_at function before each update
create trigger trigger_update_flashcards_updated_at
  before update on public.flashcards
  for each row
  execute function public.update_flashcards_updated_at();

comment on function public.update_flashcards_updated_at() is 'Trigger function to automatically update updated_at timestamp on flashcard modifications';
