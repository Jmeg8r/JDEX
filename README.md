# JDex

**Johnny Decimal index manager for your digital life**

JDex is a personal knowledge organization system built on the [Johnny Decimal](https://johnnydecimal.com/) methodology. Track, search, and manage your files across multiple cloud storage platforms with a clean, hierarchical index.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Version](https://img.shields.io/badge/version-2.0.0-green.svg)

## Features

- **4-Level Hierarchy**: Areas → Categories → Folders (XX.XX) → Items (XX.XX.XX)
- **Multi-Platform Tracking**: iCloud, ProtonDrive, Google Drive, OneDrive, Dropbox
- **Sensitivity Routing**: Automatic storage suggestions based on content sensitivity
- **Drill-Down Navigation**: Intuitive breadcrumb navigation through your index
- **Full-Text Search**: Find anything by number, name, keywords, or notes
- **Sensitivity Inheritance**: Items inherit folder sensitivity or override as needed
- **Import/Export**: Backup your database or export to JSON
- **Offline-First**: SQLite database runs entirely in your browser

## The Johnny Decimal System

Johnny Decimal is a file organization methodology that uses a structured numbering system:

```
10-19 Personal
  11 Identity and Legal
    11.01 Passports ← Folder container
      11.01.01 US_Passport_2024.pdf ← Tracked item
      11.01.02 Birth_Certificate.pdf
```

Learn more at [johnnydecimal.com](https://johnnydecimal.com/)

## Quick Start

```bash
# Clone the repository
git clone https://github.com/Jmeg8r/JDEX.git

# Navigate to app directory
cd JDex/app

# Install dependencies
npm install

# Start development server
npm run dev
```

Open [http://localhost:5173](http://localhost:5173) in your browser.

## Tech Stack

- **React 18** - UI framework
- **Vite** - Build tool
- **Tailwind CSS** - Styling
- **sql.js** - SQLite in the browser (WebAssembly)
- **Lucide React** - Icons
- **Electron** (optional) - Desktop app packaging

## Project Structure

```
JDex/
├── app/
│   ├── src/
│   │   ├── App.jsx      # Main application
│   │   ├── db.js        # Database layer
│   │   ├── index.css    # Styles
│   │   └── main.jsx     # Entry point
│   ├── electron/        # Desktop app wrapper
│   └── package.json
├── docs/                # Documentation
└── scripts/             # Utility scripts
```

## Storage Sensitivity Model

JDex helps route files to appropriate storage based on sensitivity:

| Sensitivity | Default Storage | Use Case |
|-------------|-----------------|----------|
| Standard | iCloud Drive | General files, documents |
| Sensitive | ProtonDrive | Medical, financial, encrypted |
| Work | Work OneDrive | Employer-owned content |

## Database Schema

JDex uses a 4-level hierarchical structure:

1. **Areas** (00-09, 10-19, etc.) - Broad life categories
2. **Categories** (00, 01, 22, etc.) - Specific topics within areas
3. **Folders** (XX.XX) - Container folders for related items
4. **Items** (XX.XX.XX) - Actual tracked files/objects

## Roadmap

- [ ] Mobile-responsive UI
- [ ] Filesystem scanner (auto-detect files)
- [ ] Cloud sync across devices
- [ ] File verification (check paths exist)
- [ ] Storage platform integrations
- [ ] Team workspaces

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**James Cruce** - [As The Geek Learns](https://astgl.com)

---

*Built with ❤️ for people who want to organize their digital chaos*
