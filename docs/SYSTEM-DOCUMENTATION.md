# James's Johnny Decimal System

## Complete Implementation Guide

---

## Table of Contents

1. [System Overview](#system-overview)
2. [Storage Architecture](#storage-architecture)
3. [Johnny Decimal Structure](#johnny-decimal-structure)
4. [Installation Guide](#installation-guide)
5. [JDex App Usage](#jdex-app-usage)
6. [Email Organization](#email-organization)
7. [Syncing Strategy](#syncing-strategy)
8. [Migration Plan](#migration-plan)
9. [Maintenance](#maintenance)

---

## System Overview

Your Johnny Decimal system organizes everything in your digital life across multiple storage locations, with sensitivity-based routing to ensure secure items stay on encrypted storage.

### Design Principles

1. **Everything has a unique ID** - Every document, project, or item gets a JD number
2. **Nothing more than 3 clicks away** - Shallow folder hierarchy
3. **Sensitivity-based routing** - Sensitive items automatically route to ProtonDrive
4. **The JDex is the source of truth** - Always search the index first

### Quick Reference

| JD Range | Area | Primary Storage |
|----------|------|-----------------|
| 00-09 | System | iCloud |
| 10-19 | Personal | iCloud (sensitive → ProtonDrive) |
| 20-29 | UF Health | Work OneDrive |
| 30-39 | As The Geek Learns | iCloud |
| 40-49 | Development | iCloud |
| 50-59 | Resistance | ProtonDrive (ALL) |
| 60-69 | Learning | iCloud |
| 90-99 | Archive | iCloud |

---

## Storage Architecture

### Primary Locations

```
┌─────────────────────────────────────────────────────────────┐
│                    STORAGE TOPOLOGY                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ┌─────────────┐     ┌─────────────┐     ┌─────────────┐  │
│   │   iCloud    │     │ ProtonDrive │     │Work OneDrive│  │
│   │  (Primary)  │     │ (Encrypted) │     │ (UF Health) │  │
│   └──────┬──────┘     └──────┬──────┘     └──────┬──────┘  │
│          │                   │                   │          │
│    ┌─────┴─────┐       ┌─────┴─────┐       ┌─────┴─────┐   │
│    │ 00-09     │       │ 50-59     │       │ 20-29     │   │
│    │ 10-19*    │       │ Resistance│       │ UF Health │   │
│    │ 30-39     │       │ (ALL)     │       │ Work Only │   │
│    │ 40-49     │       │           │       │           │   │
│    │ 60-69     │       │ + Any §   │       │           │   │
│    │ 90-99     │       │ items     │       │           │   │
│    └───────────┘       └───────────┘       └───────────┘   │
│                                                             │
│   * Sensitive items in 10-19 → ProtonDrive                 │
│   § = Sensitivity flag in JDex                              │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│                    BACKUP LAYER                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ┌─────────────────┐    ┌─────────────────┐               │
│   │ Personal OneDrive│    │    Dropbox      │               │
│   │   (Sync Copy)   │    │  (Extra Backup) │               │
│   └────────┬────────┘    └────────┬────────┘               │
│            │                      │                         │
│            └──────────┬───────────┘                         │
│                       │                                     │
│              Non-sensitive items only                       │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│                    ARQ 7 BACKUP                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   MacBook Pro ─────┐                                        │
│                    ├──► Backblaze B2 (Encrypted)           │
│   Alienware   ─────┘    1 Year Retention                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Sensitivity Classification

| Level | Marker | Storage | Examples |
|-------|--------|---------|----------|
| **Standard** | — | iCloud + backups | Course materials, general docs |
| **Sensitive** | § | ProtonDrive only | Identity docs, medical, financial, Resistance |
| **Work** | 💼 | Work OneDrive only | UF Health documents |

---

## Johnny Decimal Structure

### Complete Area & Category Map

```
00-09 SYSTEM ─────────────────────────────────────────────────
│
├── 00 Index
│   ├── 00.01 JDex Database
│   └── 00.02 System Documentation
│
├── 01 Inbox
│   ├── 01.01 Triage
│   └── 01.02 To Process
│
├── 02 Templates
│   ├── 02.01 Document Templates
│   └── 02.02 Email Templates
│
└── 03 Archive Index
    └── 03.01 Archive Catalog

10-19 PERSONAL ───────────────────────────────────────────────
│
├── 11 Identity and Legal [§ SENSITIVE]
│   ├── 11.01 Passports
│   ├── 11.02 Drivers License
│   ├── 11.03 Birth Certificates
│   ├── 11.04 Social Security
│   ├── 11.05 Wills and Estate
│   └── 11.06 Power of Attorney
│
├── 12 Health [§ SENSITIVE]
│   ├── 12.01 Medical Records
│   ├── 12.02 PBC Research
│   ├── 12.03 Prescriptions
│   ├── 12.04 Insurance Claims
│   └── 12.05 Provider Information
│
├── 13 Finance [§ SENSITIVE]
│   ├── 13.01 Bank Accounts
│   ├── 13.02 Credit Cards
│   ├── 13.03 Tax Returns
│   ├── 13.04 Tax Documents
│   ├── 13.05 Receipts
│   └── 13.06 Budget
│
├── 14 Investments [§ SENSITIVE]
│   ├── 14.01 Portfolio Overview
│   ├── 14.02 HDP Strategy Research
│   ├── 14.03 Brokerage Statements
│   ├── 14.04 Dividend Tracking
│   └── 14.05 Retirement Accounts
│
├── 15 Home and Property
│   ├── 15.01 Mortgage Documents [§]
│   ├── 15.02 Property Tax
│   ├── 15.03 Home Warranty
│   ├── 15.04 Utilities
│   └── 15.05 Maintenance Records
│
├── 16 Vehicles
│   ├── 16.01 Registration
│   ├── 16.02 Service Records
│   └── 16.03 Loan Documents [§]
│
└── 17 Insurance
    ├── 17.01 Health Insurance
    ├── 17.02 Auto Insurance
    ├── 17.03 Home Insurance
    └── 17.04 Life Insurance

20-29 UF HEALTH [💼 WORK ONEDRIVE ONLY] ──────────────────────
│
├── 21 Infrastructure Documentation
│   ├── 21.01 Architecture Diagrams
│   ├── 21.02 Network Documentation
│   ├── 21.03 Storage Configuration
│   ├── 21.04 Cluster Documentation
│   ├── 21.05 Host Configurations
│   └── 21.06 Inventory Reports
│
├── 22 PowerCLI Scripts
│   ├── 22.01 Production Scripts
│   ├── 22.02 Utility Scripts
│   ├── 22.03 Reporting Scripts
│   ├── 22.04 Automation Scripts
│   ├── 22.05 Script Documentation
│   └── 22.06 Module Development
│
├── 23 Backup Projects
│   ├── 23.01 Current Initiatives
│   ├── 23.02 December Deadline Items
│   ├── 23.03 Backup Policies
│   ├── 23.04 Recovery Procedures
│   ├── 23.05 Vendor Solutions
│   └── 23.06 Testing Documentation
│
├── 24 VM Management
│   ├── 24.01 Provisioning Templates
│   ├── 24.02 Lifecycle Management
│   ├── 24.03 Resource Allocation
│   ├── 24.04 Performance Reports
│   └── 24.05 Migration Projects
│
├── 25 Procedures Runbooks
│   ├── 25.01 Standard Operating Procedures
│   ├── 25.02 Emergency Procedures
│   ├── 25.03 Change Management
│   ├── 25.04 Troubleshooting Guides
│   └── 25.05 Maintenance Windows
│
├── 26 Vendor Licensing
│   ├── 26.01 VMware Licensing
│   ├── 26.02 Vendor Contacts
│   ├── 26.03 Support Contracts
│   ├── 26.04 Renewal Tracking
│   └── 26.05 Product Evaluations
│
└── 27 Training Materials
    ├── 27.01 VMware Training
    ├── 27.02 Certifications
    ├── 27.03 Conference Materials
    └── 27.04 Webinar Notes

30-39 AS THE GEEK LEARNS ─────────────────────────────────────
│
├── 31 Brand Identity
│   ├── 31.01 Logo Assets
│   ├── 31.02 Color Palette (Deep Blue, Teal, Orange)
│   ├── 31.03 Typography
│   └── 31.04 Brand Guidelines
│
├── 32 PowerCLI Course
│   ├── 32.01 Course Outline
│   ├── 32.02 Module 1 Introduction
│   ├── 32.03 Module 2 Basics
│   ├── 32.04 Module 3 Enterprise
│   ├── 32.05 Code Examples
│   └── 32.06 Lab Exercises
│
├── 33 Website Platform
│   ├── 33.01 Site Design
│   ├── 33.02 Content
│   └── 33.03 SEO
│
├── 34 Marketing
│   ├── 34.01 Social Media Content
│   ├── 34.02 Email Campaigns
│   └── 34.03 Promotional Graphics
│
├── 35 Audience
│   ├── 35.01 Subscriber Analytics
│   └── 35.02 Feedback
│
└── 36 Future Courses
    ├── 36.01 Course Ideas
    └── 36.02 Research

40-49 DEVELOPMENT ────────────────────────────────────────────
│
├── 41 KlockThingy
│   ├── 41.01 Source Code [GitHub]
│   ├── 41.02 Build Artifacts
│   ├── 41.03 Documentation
│   └── 41.04 Release Notes
│
├── 42 Apple Developer
│   ├── 42.01 Learning Notes
│   ├── 42.02 Practice Projects
│   └── 42.03 Certificates and Profiles [§]
│
├── 43 GitHub Repos
│   ├── 43.01 Repository Index
│   └── 43.02 Documentation
│
├── 44 Code Experiments
│   ├── 44.01 Python
│   ├── 44.02 Swift
│   ├── 44.03 PowerShell
│   └── 44.04 Web Development
│
└── 45 Tools Environments
    ├── 45.01 IDE Configurations
    ├── 45.02 Dev Environment Setup
    └── 45.03 MCP Integrations

50-59 RESISTANCE [§ ALL ON PROTONDRIVE] ──────────────────────
│
├── 51 Resist and Rise
│   ├── 51.01 Published Articles
│   ├── 51.02 Drafts
│   ├── 51.03 Research
│   ├── 51.04 Palantir ICE Coverage
│   ├── 51.05 Surveillance Tech Research
│   └── 51.06 Source Materials
│
├── 52 NC Florida Indivisible
│   ├── 52.01 Leadership Documents
│   ├── 52.02 Meeting Notes
│   ├── 52.03 Strategy Planning
│   ├── 52.04 Membership
│   └── 52.05 Bylaws and Governance
│
├── 53 Social Media
│   ├── 53.01 Content Calendar
│   ├── 53.02 Graphics and Assets
│   ├── 53.03 Analytics
│   └── 53.04 Platform Guidelines
│
├── 54 Actions Protests
│   ├── 54.01 Event Planning
│   ├── 54.02 Permits and Legal
│   ├── 54.03 Safety Protocols
│   └── 54.04 Post Event Reports
│
├── 55 Mutual Aid
│   ├── 55.01 Programs
│   ├── 55.02 Resources
│   └── 55.03 Partner Organizations
│
├── 56 Canvassing
│   ├── 56.01 Scripts
│   ├── 56.02 Materials
│   ├── 56.03 Territory Maps
│   └── 56.04 Results Tracking
│
├── 57 Progressive Campaigns
│   ├── 57.01 Active Campaigns
│   ├── 57.02 Candidate Research
│   └── 57.03 Voter Information
│
└── 58 Contacts Coalition
    ├── 58.01 Partner Organizations
    ├── 58.02 Key Contacts
    └── 58.03 Communication History

60-69 LEARNING ───────────────────────────────────────────────
│
├── 61 Books
│   ├── 61.01 Currently Reading
│   ├── 61.02 Book Notes
│   └── 61.03 Reading List
│
├── 62 Courses
│   ├── 62.01 Active Courses
│   ├── 62.02 Completed
│   └── 62.03 Certificates
│
├── 63 Reference
│   ├── 63.01 Technical Documentation
│   ├── 63.02 Cheat Sheets
│   └── 63.03 Best Practices
│
└── 64 Research
    ├── 64.01 Saved Articles
    └── 64.02 Topic Collections

90-99 ARCHIVE ────────────────────────────────────────────────
│
├── 91 Archived Projects
│   ├── 91.01 Completed Projects
│   └── 91.02 Abandoned Projects
│
└── 92 Historical
    ├── 92.01 Old Documents
    └── 92.02 Legacy Systems
```

---

## Installation Guide

### Step 1: Create Folder Structure

**On MacBook Pro:**
```bash
# Download and run the Mac script
chmod +x create-jd-folders-mac.sh
./create-jd-folders-mac.sh
```

This creates:
- iCloud Drive structure (00-09, 10-19, 30-39, 40-49, 60-69, 90-99)
- ProtonDrive structure (50-59 Resistance)

**On Alienware (Windows):**
```powershell
# Run in PowerShell as Administrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\create-jd-folders-windows.ps1
```

This creates:
- Work OneDrive structure (20-29 UF Health)
- Personal OneDrive backup structure

### Step 2: Set Up JDex App

**Option A: Run in Browser (Quick Start)**
```bash
cd jdex-project/app
npm install
npm run dev
```
Open http://localhost:5173

**Option B: Build Desktop App**
```bash
cd jdex-project/app
npm install
npm run electron:build
```
This creates installable apps in `dist-electron/`

### Step 3: Configure Email Folders

See [Email Organization](#email-organization) section.

---

## JDex App Usage

### Creating New Items

1. Click **+ New Item** button
2. Select the category from dropdown
3. The JD number auto-generates (e.g., `22.01` for first item in PowerCLI Scripts)
4. Enter name and details
5. Set sensitivity level:
   - **Standard** → iCloud + backups
   - **Sensitive** → ProtonDrive only
   - **Work** → Work OneDrive only
6. Click **Create Item**

### Searching

The search bar searches across:
- JD numbers
- Item names
- Descriptions
- Keywords
- Notes
- Category and area names

Use it first! The JDex is your source of truth.

### Backup & Export

- **Backup** → Exports SQLite database file
- **JSON** → Exports human-readable JSON
- **Import Backup** → Restores from SQLite file

The database is also auto-saved to browser localStorage.

---

## Email Organization

### Proton Email (Personal)

Create these folders:
```
📁 JD-10 Personal
   ├── JD-11 Identity Legal
   ├── JD-12 Health
   ├── JD-13 Finance
   ├── JD-14 Investments
   ├── JD-15 Home
   ├── JD-16 Vehicles
   └── JD-17 Insurance

📁 JD-30 As The Geek Learns
   ├── JD-31 Brand
   ├── JD-32 PowerCLI Course
   ├── JD-33 Website
   ├── JD-34 Marketing
   └── JD-35 Audience

📁 JD-40 Development
   ├── JD-41 KlockThingy
   ├── JD-42 Apple Dev
   └── JD-43 GitHub

📁 JD-50 Resistance
   ├── JD-51 Resist Rise
   ├── JD-52 NCFL Indivisible
   ├── JD-53 Social Media
   ├── JD-54 Actions
   └── JD-55 Mutual Aid

📁 JD-60 Learning
   ├── JD-61 Books
   ├── JD-62 Courses
   └── JD-63 Reference
```

### Work Outlook (UF Health)

Create these folders:
```
📁 JD-20 UF Health
   ├── JD-21 Infrastructure
   ├── JD-22 PowerCLI
   ├── JD-23 Backup Projects
   ├── JD-24 VM Management
   ├── JD-25 Procedures
   ├── JD-26 Vendor
   └── JD-27 Training
```

---

## Syncing Strategy

### iCloud → Personal OneDrive Sync

Use one of these tools to sync iCloud JD folders to Personal OneDrive:

**FreeFileSync (Recommended):**
1. Download from https://freefilesync.org
2. Create sync pair:
   - Left: `~/Library/Mobile Documents/com~apple~CloudDocs/JohnnyDecimal`
   - Right: `~/OneDrive/JohnnyDecimal/_SyncBackup`
3. Set to "Mirror" mode
4. Schedule daily via cron or Task Scheduler

**Syncthing (Advanced):**
- Peer-to-peer sync between Mac and Windows
- Real-time sync capability
- More setup required

### Dropbox Backup

Add Dropbox as a third backup destination:
- Sync non-sensitive folders only
- Exclude: 50-59 (Resistance), sensitive items from 10-19

---

## Migration Plan

### Phase 1: Structure (Week 1)
1. ✅ Run folder creation scripts on both machines
2. ✅ Install and configure JDex app
3. ✅ Create email folder structure
4. ✅ Document current file locations

### Phase 2: Index (Week 2)
1. Walk through existing files
2. Create JDex entries for key items
3. Note current locations
4. Identify sensitivity levels

### Phase 3: Migration (Weeks 3-4)
1. Move files in batches by area
2. Update JDex with new locations
3. Verify files in correct storage
4. Update any shortcuts/links

### Phase 4: Cleanup (Week 5)
1. Archive old folder structures
2. Remove duplicates
3. Set up sync automation
4. Final JDex review

---

## Maintenance

### Daily
- Use JDex to create new items
- File new documents to correct JD folders
- Process inbox (01.01 Triage)

### Weekly
- Review 01.02 To Process
- Verify sync is working
- Quick JDex backup

### Monthly
- Full JDex JSON export
- Review category usage
- Archive completed projects
- Check storage quotas

### Annually
- Review area/category structure
- Archive old items to 90-99
- Update documentation
- Verify backup integrity (Arq B2)

---

## Quick Reference Card

```
┌────────────────────────────────────────────────────────────┐
│               JAMES'S JD QUICK REFERENCE                   │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  WHERE DOES IT GO?                                         │
│  ─────────────────                                         │
│  Work stuff?           → 20-29 Work OneDrive              │
│  Resistance/Activism?  → 50-59 ProtonDrive                │
│  Sensitive personal?   → ProtonDrive (mark §)             │
│  Everything else?      → iCloud                           │
│                                                            │
│  HOW DO I FIND IT?                                         │
│  ─────────────────                                         │
│  1. Search JDex first                                      │
│  2. Navigate by JD number                                  │
│  3. Browse category tree                                   │
│                                                            │
│  KEY NUMBERS TO REMEMBER                                   │
│  ───────────────────────                                   │
│  22 = PowerCLI Scripts (work)                             │
│  32 = PowerCLI Course (ATGL)                              │
│  41 = KlockThingy                                         │
│  51 = Resist and Rise                                     │
│  52 = NC FL Indivisible                                   │
│                                                            │
│  SENSITIVITY MARKERS                                       │
│  ──────────────────                                        │
│  Standard  = Cloud icon   = iCloud + backups              │
│  Sensitive = Lock icon    = ProtonDrive only              │
│  Work      = Briefcase    = Work OneDrive only            │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

---

*"Much to learn, there always is."* — As The Geek Learns

*Document Version: 1.0 | December 2024*
