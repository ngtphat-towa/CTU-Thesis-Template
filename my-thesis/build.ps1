# CTU Thesis Build Script for PowerShell

param(
    [Parameter()]
    [ValidateSet("build", "watch", "clean")]
    [string]$Action = "build"
)

switch ($Action) {
    "build" {
        Write-Host "🔨 Compiling thesis..." -ForegroundColor Cyan
        typst compile main.typ thesis.pdf
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Compilation successful! Output: thesis.pdf" -ForegroundColor Green
        } else {
            Write-Host "❌ Compilation failed!" -ForegroundColor Red
        }
    }
    "watch" {
        Write-Host "👀 Watching for changes..." -ForegroundColor Cyan
        Write-Host "Press Ctrl+C to stop" -ForegroundColor Yellow
        typst watch main.typ thesis.pdf
    }
    "clean" {
        if (Test-Path "thesis.pdf") {
            Remove-Item "thesis.pdf"
            Write-Host "✅ Cleaned: thesis.pdf removed" -ForegroundColor Green
        } else {
            Write-Host "ℹ️  Nothing to clean" -ForegroundColor Gray
        }
    }
}
