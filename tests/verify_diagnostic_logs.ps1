$ErrorActionPreference = 'Stop'

$source = Get-Content -Raw -Encoding utf8 (Join-Path $PSScriptRoot '..\src\pmw3610.c')
$required = @(
    'PMW3610 self-test passed',
    'PMW3610 Product ID:',
    'MOTION IRQ received',
    'MOTION burst SPI read failed',
    'Failed to re-enable MOTION IRQ'
)

$missing = $required | Where-Object { -not $source.Contains($_) }
if ($missing) {
    throw "Missing PMW3610 diagnostic logs: $($missing -join ', ')"
}

Write-Output 'PMW3610 diagnostic log contract: PASS'
