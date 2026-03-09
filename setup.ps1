# setup.ps1 — Download all local assets for offline use
# Run once: powershell -ExecutionPolicy Bypass -File setup.ps1

# MediaPipe face mesh
$base = "https://cdn.jsdelivr.net/npm/@mediapipe/face_mesh@0.4.1633559619"
$dest = "mediapipe\face_mesh"
$files = @(
    "face_mesh.js",
    "face_mesh_solution_packed_assets_loader.js",
    "face_mesh_solution_packed_assets.data",
    "face_mesh_solution_simd_wasm_bin.js",
    "face_mesh_solution_simd_wasm_bin.wasm",
    "face_mesh_solution_wasm_bin.js",
    "face_mesh_solution_wasm_bin.wasm",
    "face_mesh.binarypb"
)
New-Item -ItemType Directory -Force -Path $dest | Out-Null
foreach ($f in $files) {
    Write-Host "Downloading $f ..."
    Invoke-WebRequest "$base/$f" -OutFile "$dest\$f"
}

# Vendor JS libraries
New-Item -ItemType Directory -Force -Path "vendor" | Out-Null
$vendors = @(
    @{url="https://webgazer.cs.brown.edu/webgazer.js"; out="vendor\webgazer.js"},
    @{url="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"; out="vendor\chart.umd.min.js"},
    @{url="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"; out="vendor\html2canvas.min.js"}
)
foreach ($v in $vendors) {
    Write-Host "Downloading $($v.out) ..."
    Invoke-WebRequest $v.url -OutFile $v.out
}

Write-Host "Done. Run: python -m http.server 8000"
