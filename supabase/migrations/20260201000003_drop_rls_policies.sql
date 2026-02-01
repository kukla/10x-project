-- ============================================================================
-- Migration: Drop All RLS Policies
-- Description: Drops all RLS policies from generations, flashcards, and
--              generation_error_logs tables while keeping RLS enabled.
-- Tables: generations, flashcards, generation_error_logs
-- Special Considerations:
--   - RLS remains enabled on all tables
--   - Only policies are dropped, not the tables themselves
--   - Tables will have no access rules after this migration
-- ============================================================================

-- ============================================================================
-- Drop Policies: generations table
-- ============================================================================
drop policy if exists "authenticated_users_select_own_generations" on public.generations;
drop policy if exists "authenticated_users_insert_own_generations" on public.generations;
drop policy if exists "authenticated_users_update_own_generations" on public.generations;
drop policy if exists "authenticated_users_delete_own_generations" on public.generations;

-- ============================================================================
-- Drop Policies: flashcards table
-- ============================================================================
drop policy if exists "authenticated_users_select_own_flashcards" on public.flashcards;
drop policy if exists "authenticated_users_insert_own_flashcards" on public.flashcards;
drop policy if exists "authenticated_users_update_own_flashcards" on public.flashcards;
drop policy if exists "authenticated_users_delete_own_flashcards" on public.flashcards;

-- ============================================================================
-- Drop Policies: generation_error_logs table
-- ============================================================================
drop policy if exists "authenticated_users_select_own_error_logs" on public.generation_error_logs;
drop policy if exists "authenticated_users_insert_own_error_logs" on public.generation_error_logs;
drop policy if exists "authenticated_users_update_own_error_logs" on public.generation_error_logs;
drop policy if exists "authenticated_users_delete_own_error_logs" on public.generation_error_logs;

-- Note: RLS is still enabled on all tables. Without policies, no rows will be
-- accessible through normal queries. You may want to either:
-- 1. Disable RLS entirely with: alter table <table_name> disable row level security;
-- 2. Create new policies with different access rules
