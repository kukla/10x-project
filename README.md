# 10x Cards

An AI-powered web application that enables automatic generation of flashcards using Large Language Models. Transform any text into high-quality learning flashcards in seconds.

## Table of Contents

- [Overview](#overview)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Available Scripts](#available-scripts)
- [Project Scope](#project-scope)
- [Project Status](#project-status)
- [License](#license)

## Overview

10x Cards solves the time-consuming problem of manually creating high-quality flashcards for learning. By leveraging AI technology, users can:

- **Paste any text** (textbook excerpts, articles, notes) and automatically generate flashcards
- **Review and customize** AI-generated suggestions before saving
- **Create flashcards manually** when needed
- **Learn efficiently** using integrated spaced repetition algorithms
- **Manage personal flashcard collections** with full CRUD operations

### Key Features

- 🤖 AI-powered flashcard generation using LLM models via OpenRouter.ai
- 📝 Manual flashcard creation and editing
- 🔐 User authentication and secure data storage
- 🧠 Spaced repetition learning sessions
- 📊 Generation statistics tracking
- 🎨 Modern, responsive UI built with Shadcn/ui

## Tech Stack

### Frontend
- **Astro 5** - Fast, content-focused web framework
- **React 19** - Interactive UI components
- **TypeScript 5** - Type-safe development
- **Tailwind CSS 4** - Utility-first styling
- **Shadcn/ui** - Accessible component library

### Backend
- **Supabase** - PostgreSQL database, authentication, and Backend-as-a-Service
- **Node.js** - Server runtime (v22.14.0)

### AI Integration
- **OpenRouter.ai** - Access to multiple LLM providers (OpenAI, Anthropic, Google, etc.)

### DevOps
- **GitHub Actions** - CI/CD pipelines
- **DigitalOcean** - Application hosting with Docker
- **ESLint & Prettier** - Code quality and formatting
- **Husky** - Git hooks for pre-commit checks

## Getting Started

### Prerequisites

- Node.js v22.14.0 (use `.nvmrc` file)
- npm or pnpm package manager
- Supabase account
- OpenRouter.ai API key

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd 10x-project
   ```

2. **Install Node.js version**
   ```bash
   nvm use
   ```

3. **Install dependencies**
   ```bash
   npm install
   ```

4. **Set up environment variables**
   
   Copy `.env.example` to `.env` and configure:
   ```bash
   cp .env.example .env
   ```
   
   Add your credentials:
   - Supabase URL and keys
   - OpenRouter.ai API key
   - Other required environment variables

5. **Run development server**
   ```bash
   npm run dev
   ```

   The application will be available at `http://localhost:4321`

## Available Scripts

| Command | Description |
|---------|-------------|
| `npm run dev` | Start development server with hot reload |
| `npm run build` | Build production-ready application |
| `npm run preview` | Preview production build locally |
| `npm run astro` | Run Astro CLI commands |
| `npm run lint` | Check code for linting errors |
| `npm run lint:fix` | Automatically fix linting errors |
| `npm run format` | Format code using Prettier |

## Project Scope

### Included in MVP

✅ Automatic flashcard generation from text input (1,000-10,000 characters)  
✅ Manual flashcard creation and management (CRUD operations)  
✅ User authentication (registration, login, account deletion)  
✅ Spaced repetition learning sessions using existing algorithms  
✅ Secure data storage with GDPR compliance  
✅ Generation statistics tracking (AI-generated vs. accepted cards)  

### Excluded from MVP

❌ Custom spaced repetition algorithms (using open-source libraries)  
❌ Gamification features  
❌ Mobile applications (web-only for now)  
❌ Document import (PDF, DOCX, etc.)  
❌ Public API  
❌ Flashcard sharing between users  
❌ Advanced notification systems  
❌ Advanced search and filtering  

### Success Metrics

- **75%** of AI-generated flashcards are accepted by users
- **75%** of all flashcards are created using AI assistance
- High user engagement with learning sessions

## Project Status

**Current Version:** 0.0.1 (MVP Development)

This project is in active development. The core infrastructure is being set up with:

- ✅ Project structure and configuration
- ✅ Development tooling (ESLint, Prettier, Husky)
- ✅ UI component library (Shadcn/ui)
- 🚧 Supabase integration (in progress)
- 🚧 AI flashcard generation (in progress)
- 🚧 User authentication (in progress)
- 📋 Spaced repetition implementation (planned)

## License

This project is proprietary software. All rights reserved.

For questions or contributions, please contact the project maintainers.

---

**Built with ❤️ to make learning 10x faster**
