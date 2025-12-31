# Johnny Decimal Folder Structure Creator for Windows
# Creates the JD structure for Work OneDrive (UF Health)
# Author: Created for James
# Date: December 2024

#Requires -Version 5.1

param(
    [switch]$WhatIf,
    [string]$WorkOneDrivePath = "C:\Users\JMEG8R\OneDrive - UF Health\JohnnyDecimal",
    [string]$PersonalOneDrivePath = "C:\Users\JMEG8R\OneDrive\OneDrivePersonal\OneDrive\JohnnyDecimal"
)

# Color output functions
function Write-Success { param($Message) Write-Host "[✓] $Message" -ForegroundColor Green }
function Write-Info { param($Message) Write-Host "[i] $Message" -ForegroundColor Cyan }
function Write-Warn { param($Message) Write-Host "[!] $Message" -ForegroundColor Yellow }
function Write-Err { param($Message) Write-Host "[✗] $Message" -ForegroundColor Red }

# Function to create folder
function New-JDFolder {
    param([string]$Path)
    
    if ($WhatIf) {
        Write-Info "Would create: $Path"
        return
    }
    
    if (Test-Path $Path) {
        Write-Info "Exists: $Path"
    } else {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Success "Created: $Path"
    }
}

# Function to create the UF Health Work structure
function New-UFHealthStructure {
    param([string]$BasePath)
    
    Write-Host ""
    Write-Host "Creating 20-29 UF Health VMware Work Structure" -ForegroundColor Magenta
    Write-Host "Location: $BasePath" -ForegroundColor Gray
    Write-Host ""
    
    # 20-29 UF Health Work
    New-JDFolder "$BasePath\20-29 UF Health"
    
    # 21 Infrastructure Documentation
    New-JDFolder "$BasePath\20-29 UF Health\21 Infrastructure Documentation"
    New-JDFolder "$BasePath\20-29 UF Health\21 Infrastructure Documentation\21.01 Architecture Diagrams"
    New-JDFolder "$BasePath\20-29 UF Health\21 Infrastructure Documentation\21.02 Network Documentation"
    New-JDFolder "$BasePath\20-29 UF Health\21 Infrastructure Documentation\21.03 Storage Configuration"
    New-JDFolder "$BasePath\20-29 UF Health\21 Infrastructure Documentation\21.04 Cluster Documentation"
    New-JDFolder "$BasePath\20-29 UF Health\21 Infrastructure Documentation\21.05 Host Configurations"
    New-JDFolder "$BasePath\20-29 UF Health\21 Infrastructure Documentation\21.06 Inventory Reports"
    
    # 22 PowerCLI Scripts and Tools
    New-JDFolder "$BasePath\20-29 UF Health\22 PowerCLI Scripts"
    New-JDFolder "$BasePath\20-29 UF Health\22 PowerCLI Scripts\22.01 Production Scripts"
    New-JDFolder "$BasePath\20-29 UF Health\22 PowerCLI Scripts\22.02 Utility Scripts"
    New-JDFolder "$BasePath\20-29 UF Health\22 PowerCLI Scripts\22.03 Reporting Scripts"
    New-JDFolder "$BasePath\20-29 UF Health\22 PowerCLI Scripts\22.04 Automation Scripts"
    New-JDFolder "$BasePath\20-29 UF Health\22 PowerCLI Scripts\22.05 Script Documentation"
    New-JDFolder "$BasePath\20-29 UF Health\22 PowerCLI Scripts\22.06 Module Development"
    
    # 23 Backup Projects
    New-JDFolder "$BasePath\20-29 UF Health\23 Backup Projects"
    New-JDFolder "$BasePath\20-29 UF Health\23 Backup Projects\23.01 Current Initiatives"
    New-JDFolder "$BasePath\20-29 UF Health\23 Backup Projects\23.02 December Deadline Items"
    New-JDFolder "$BasePath\20-29 UF Health\23 Backup Projects\23.03 Backup Policies"
    New-JDFolder "$BasePath\20-29 UF Health\23 Backup Projects\23.04 Recovery Procedures"
    New-JDFolder "$BasePath\20-29 UF Health\23 Backup Projects\23.05 Vendor Solutions"
    New-JDFolder "$BasePath\20-29 UF Health\23 Backup Projects\23.06 Testing Documentation"
    
    # 24 VM Management
    New-JDFolder "$BasePath\20-29 UF Health\24 VM Management"
    New-JDFolder "$BasePath\20-29 UF Health\24 VM Management\24.01 Provisioning Templates"
    New-JDFolder "$BasePath\20-29 UF Health\24 VM Management\24.02 Lifecycle Management"
    New-JDFolder "$BasePath\20-29 UF Health\24 VM Management\24.03 Resource Allocation"
    New-JDFolder "$BasePath\20-29 UF Health\24 VM Management\24.04 Performance Reports"
    New-JDFolder "$BasePath\20-29 UF Health\24 VM Management\24.05 Migration Projects"
    
    # 25 Procedures and Runbooks
    New-JDFolder "$BasePath\20-29 UF Health\25 Procedures Runbooks"
    New-JDFolder "$BasePath\20-29 UF Health\25 Procedures Runbooks\25.01 Standard Operating Procedures"
    New-JDFolder "$BasePath\20-29 UF Health\25 Procedures Runbooks\25.02 Emergency Procedures"
    New-JDFolder "$BasePath\20-29 UF Health\25 Procedures Runbooks\25.03 Change Management"
    New-JDFolder "$BasePath\20-29 UF Health\25 Procedures Runbooks\25.04 Troubleshooting Guides"
    New-JDFolder "$BasePath\20-29 UF Health\25 Procedures Runbooks\25.05 Maintenance Windows"
    
    # 26 Vendor and Licensing
    New-JDFolder "$BasePath\20-29 UF Health\26 Vendor Licensing"
    New-JDFolder "$BasePath\20-29 UF Health\26 Vendor Licensing\26.01 VMware Licensing"
    New-JDFolder "$BasePath\20-29 UF Health\26 Vendor Licensing\26.02 Vendor Contacts"
    New-JDFolder "$BasePath\20-29 UF Health\26 Vendor Licensing\26.03 Support Contracts"
    New-JDFolder "$BasePath\20-29 UF Health\26 Vendor Licensing\26.04 Renewal Tracking"
    New-JDFolder "$BasePath\20-29 UF Health\26 Vendor Licensing\26.05 Product Evaluations"
    
    # 27 Training Materials (Received)
    New-JDFolder "$BasePath\20-29 UF Health\27 Training Materials"
    New-JDFolder "$BasePath\20-29 UF Health\27 Training Materials\27.01 VMware Training"
    New-JDFolder "$BasePath\20-29 UF Health\27 Training Materials\27.02 Certifications"
    New-JDFolder "$BasePath\20-29 UF Health\27 Training Materials\27.03 Conference Materials"
    New-JDFolder "$BasePath\20-29 UF Health\27 Training Materials\27.04 Webinar Notes"
}

# Function to create sync backup structure on Personal OneDrive
function New-PersonalBackupStructure {
    param([string]$BasePath)
    
    Write-Host ""
    Write-Host "Creating Backup Sync Structure on Personal OneDrive" -ForegroundColor Magenta
    Write-Host "Location: $BasePath" -ForegroundColor Gray
    Write-Host ""
    
    # Create mirror of iCloud structure for backup sync
    # Note: This creates the folder structure only - actual sync handled separately
    
    New-JDFolder "$BasePath\_SyncBackup"
    
    # Create README explaining this is a backup mirror
    $readme = @"
# Johnny Decimal Backup Sync Folder

This folder serves as a synchronized backup of your iCloud Drive JohnnyDecimal structure.

## Sync Configuration
Primary Location: iCloud Drive
Backup Location: This folder (Personal OneDrive)

## Areas Synced Here:
- 00-09 System
- 10-19 Personal (non-sensitive only)
- 30-39 As The Geek Learns
- 40-49 Development
- 60-69 Learning
- 90-99 Archive

## NOT Synced Here (Security):
- 20-29 UF Health (Work OneDrive only)
- 50-59 Resistance (ProtonDrive only)

## Sync Schedule
Configure using a sync tool like:
- FreeFileSync
- Syncthing
- rclone

Recommended: Daily incremental sync via scheduled task
"@
    
    if (-not $WhatIf) {
        $readme | Out-File "$BasePath\_SyncBackup\README.md" -Encoding UTF8
        Write-Success "Created README.md"
    }
    
    # Create placeholder folders
    New-JDFolder "$BasePath\_SyncBackup\00-09 System"
    New-JDFolder "$BasePath\_SyncBackup\10-19 Personal"
    New-JDFolder "$BasePath\_SyncBackup\30-39 As The Geek Learns"
    New-JDFolder "$BasePath\_SyncBackup\40-49 Development"
    New-JDFolder "$BasePath\_SyncBackup\60-69 Learning"
    New-JDFolder "$BasePath\_SyncBackup\90-99 Archive"
}

# Main execution
Clear-Host
Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     Johnny Decimal Folder Structure Creator for Windows           ║" -ForegroundColor Cyan
Write-Host "║                    Work & Backup Setup                            ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Verify paths exist (check parent directories)
$workParent = "C:\Users\JMEG8R\OneDrive - UF Health"
$personalParent = "C:\Users\JMEG8R\OneDrive\OneDrivePersonal\OneDrive"

Write-Host "Checking OneDrive locations..." -ForegroundColor Yellow
Write-Host ""

# Check Work OneDrive
if (Test-Path $workParent) {
    Write-Success "Work OneDrive found: $workParent"
} else {
    Write-Warn "Work OneDrive NOT found at: $workParent"
    Write-Info "The JohnnyDecimal folder will be created when the path becomes available"
}

# Check Personal OneDrive
if (Test-Path $personalParent) {
    Write-Success "Personal OneDrive found: $personalParent"
} else {
    Write-Warn "Personal OneDrive NOT found at: $personalParent"
    Write-Info "The JohnnyDecimal folder will be created when the path becomes available"
}

Write-Host ""
Write-Host "Configuration:" -ForegroundColor Yellow
Write-Host "  Work OneDrive:     $WorkOneDrivePath" -ForegroundColor Gray
Write-Host "  Personal OneDrive: $PersonalOneDrivePath" -ForegroundColor Gray
Write-Host ""

if ($WhatIf) {
    Write-Warn "Running in WhatIf mode - no folders will be created"
    Write-Host ""
}

$confirm = Read-Host "Proceed with folder creation? (y/n)"
if ($confirm -ne 'y' -and $confirm -ne 'Y') {
    Write-Host "Aborted." -ForegroundColor Red
    exit
}

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "Creating Work OneDrive Structure (UF Health VMware)" -ForegroundColor White
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray

New-UFHealthStructure -BasePath $WorkOneDrivePath

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "Creating Personal OneDrive Backup Structure" -ForegroundColor White
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray

New-PersonalBackupStructure -BasePath $PersonalOneDrivePath

Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host "COMPLETE!" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
Write-Host ""
Write-Success "Johnny Decimal folder structure created successfully!"
Write-Host ""
Write-Host "Folders Created:" -ForegroundColor Yellow
Write-Host "  💼 Work:     $WorkOneDrivePath" -ForegroundColor Cyan
Write-Host "  🏠 Personal: $PersonalOneDrivePath" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Run the Mac script on your MacBook Pro for iCloud & ProtonDrive"
Write-Host "  2. Set up email folders in Work Outlook for 20-29 categories"
Write-Host "  3. Configure sync between iCloud and Personal OneDrive backup"
Write-Host "  4. Launch the JDex app to manage your master index"
Write-Host ""
Write-Host "Work Email (Outlook) Folder Structure to Create:" -ForegroundColor Yellow
Write-Host "  📧 JD-21 Infrastructure"
Write-Host "  📧 JD-22 PowerCLI"
Write-Host "  📧 JD-23 Backup Projects"
Write-Host "  📧 JD-24 VM Management"
Write-Host "  📧 JD-25 Procedures"
Write-Host "  📧 JD-26 Vendor"
Write-Host "  📧 JD-27 Training"
Write-Host ""
