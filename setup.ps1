# setup.ps1 — Download MediaPipe face mesh assets for local serving
# Run once: powershell -ExecutionPolicy Bypass -File setup.ps1

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
Write-Host "Done. Run: python -m http.server 8000"
