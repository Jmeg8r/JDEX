# JDEX

Desktop app for managing a [Johnny Decimal](https://johnnydecimal.com/) file-organization
system: visual index manager with CRUD, search, and import/export. This is the free/public
repo; the licensed premium build is the separate `jdex-premium` repo and checkout (not a git
remote of this one), and the two have diverged: don't assume parity (see Gotchas).
Electron + React (JSX, no TypeScript), Tailwind, SQLite via sql.js (WASM). ES modules
throughout (`"type": "module"`), Electron main process included. Versions and scripts:
`app/package.json`.

## Structure

`app/` is the project root; run every npm command from there. `app/src/` is a flat monolith,
not a components/services/context tree:

- `App.jsx`: all UI state, navigation, and feature wiring; new features wire in here
- `db.js`: all schema, migrations, and CRUD
- `utils/errors.js`, `utils/validation.js`: error classes and input sanitization
- `electron/main.js`: Electron main process, IPC handlers

Read first in a fresh session: `App.jsx`, `db.js`, `app/tailwind.config.js`.

**Style**: functional components and hooks only: no classes, no Redux, no Context, no service
layer. Tailwind utility classes for all styling, Lucide React for all icons, parameterized
sql.js queries for every database operation.

**Theme**: dark only. Brand colors `jd-navy`/`jd-teal`/`jd-orange` (plus `jd-slate`,
`jd-light`) and fonts Inter (sans) / JetBrains Mono (mono) in `app/tailwind.config.js`; the
glass effect is the `glass-card` class and the fade animations are keyframes in
`app/src/index.css`.

## Johnny Decimal hierarchy

```
Areas (10-19, 20-29, ...)                  # Broad life/work categories
  └── Categories (11, 12, ...)             # Topic groups within an area
      └── Folders (11.01, 11.02, ...)      # Container folders
          └── Items (11.01.001, ...)       # Individual tracked objects
```

## Gotchas

- **Local-first by design**: no server, no cloud sync. The whole database is serialized to
  `localStorage` key `jdex_database_v2` (one logical database, exportable as JSON), which
  caps it at roughly 5-10MB.
- **sql.js loads from a CDN at runtime** (`https://sql.js.org/dist/sql-wasm.js`), not bundled:
  a known external-dependency risk, kept deliberately. (`jdex-premium` bundles it instead.)
- **No license or gating code exists here**: no `licenseService`, `LicenseContext`, Gumroad,
  or `useLicense()`; those live only in `jdex-premium`. `db.js` still carries CRUD blocks
  marked "(Premium Feature)" (cloud drives, organization rules, watched folders) that no UI
  in this repo uses. Don't port gating code in.
- **Schema changes**: bump the `SCHEMA_VERSION` constant in `db.js` and add a matching
  `if (currentVersion < N)` branch in `runMigrations()`; the `schema_version` table records
  the applied version.
- **No git hook runs here.** `core.hooksPath` points at a lefthook shim and the repo has no
  `lefthook.yml`, so `.husky/pre-commit` (lint-staged) never fires. Run
  `npm run lint:fix && npm run format` yourself before every commit; CI checks
  `npm run lint` and `npm run format:check`.

## Known debt

- `App.jsx` and `db.js` are large single-file monoliths: no routing, all SQL inline, no ORM.
- No automated tests and no TypeScript (`jdex-premium` has both), so nothing catches a
  refactoring regression; see VERIFY below.

## Commands (run from `app/`)

| Command | Purpose |
|---|---|
| `npm install && npm run electron:dev` | First-time setup / hot-reload dev (Node 20+, as in CI; macOS is the primary dev platform) |
| `npm run build` | Vite production build (what CI's Build job runs) |
| `npm run electron:build:mac` (also `:win`, `:linux`) | Platform build |
| `npm run lint:fix && npm run format` | Before every commit |

Release builds need code signing: Apple Developer account, certificates and notarization
credentials in env vars (macOS); the FTL Consulting LLC EV certificate (Windows). See
`app/DISTRIBUTION-SETUP.md` and `app/NOTARIZATION-SETUP.md`.

## Git workflow

- **Forge-mirrored**: `origin` is the Forgejo forge (`jfcadm/JDEX`, authoritative); `github`
  (`Jmeg8r/JDEX`) is a push mirror. Push branches to `origin` and open PRs with
  `forge-pr create`; `gh` is read-only here. There is no AI-review gate kit in this repo, so
  `forge-pr status` shows no gate verdict and James merges in the forge UI.
- **CI** (`.github/workflows/ci.yml`, run by the forge) on every PR and push to `main`: lint
  and format check, `npm audit --audit-level=high` (non-blocking: `continue-on-error`),
  Semgrep, gitleaks, and the Vite build.
- **Branch names** follow the global prefixes (`feat/`, `fix/`, `docs/`, `chore/`, `ci/`); the
  old `feature/*` convention is retired. **Commit types**: `feat:`, `fix:`, `docs:`,
  `security:`, `chore:`, `refactor:`, `test:`, `release:`, `ci:`.

## Workflow: this repo's Ironclad mechanics

The global Ironclad workflow applies. Unlike `jdex-premium`, this repo has **no**
`scripts/verify.js`, `scripts/ship.js`, AI-review (Gemini) scripts, `.workflow/checklists/`
or `.workflow/state/`; `.workflow/sessions/` holds past session notes only. Don't assume the
premium repo's scripted verify/ship pipeline exists here. What this repo adds:

- **Human checkpoints**: approve the plan before any code, approve verification results
  before shipping, approve the merge. Never auto-proceed past one; ask explicitly, and say
  which phase you're in and which gate is next. A change request with no approved plan
  starts at PLAN.
- **PLAN** (where the plan lives: the global Ironclad loop): problem statement, success
  criteria, a completed security-considerations section, and tasks with dependencies.
  During EXECUTE, work in dependency order and mark tasks complete in the plan as you finish
  them; every task must be marked complete before VERIFY.
- **Security, every change**: validate all user input (`utils/validation.js`) and sanitize
  data before storage or display; parameterized queries only; raise the error classes in
  `utils/errors.js` rather than swallowing errors; never expose sensitive data in errors or
  logs; run `npm audit` before shipping, since CI's audit step doesn't block.
- **VERIFY**: lint, format check, `npm run build`, `npm audit`; for UI changes, check them
  visually in `npm run electron:dev` and capture screenshots.
- **Session notes**, kept up as you go in
  `.workflow/sessions/SESSION-YYYY-MM-DD-<slug>/session.md` (no template; follow the existing
  ones): changes made, issues hit, verification status, and any accepted risks. After
  significant work, update this file if architecture or conventions changed, and offer a
  session summary (decisions, next steps).
