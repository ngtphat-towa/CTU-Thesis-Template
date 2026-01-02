# Quick Start Guide - CTU Thesis

## Step 1: Install Typst
Download and install from: https://github.com/typst/typst/releases

## Step 2: Edit Your Info
Open `info.typ` and replace placeholder data with your information.

## Step 3: Compile
```powershell
# Option 1: Using PowerShell script
.\build.ps1

# Option 2: Using Typst directly
typst compile main.typ

# Option 3: Watch mode (auto-compile)
.\build.ps1 watch
```

## Step 4: Start Writing
Navigate to `chapters/part1/01-context.typ` and begin writing.

## Tips
- Compile frequently to catch errors early
- Use comments (`//`) for notes
- Keep sentences under 80 characters for better version control
- Add images to `images/` folders
- Update `backmatter/bibliography.bib` as you research

Happy writing! 🎓
