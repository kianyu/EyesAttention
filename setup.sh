#!/bin/bash
# setup.sh — Download all local assets for offline use
# Run once: bash setup.sh

# MediaPipe face mesh
BASE="https://cdn.jsdelivr.net/npm/@mediapipe/face_mesh@0.4.1633559619"
DEST="mediapipe/face_mesh"
mkdir -p "$DEST"

for f in \
  face_mesh.js \
  face_mesh_solution_packed_assets_loader.js \
  face_mesh_solution_packed_assets.data \
  face_mesh_solution_simd_wasm_bin.js \
  face_mesh_solution_simd_wasm_bin.wasm \
  face_mesh_solution_wasm_bin.js \
  face_mesh_solution_wasm_bin.wasm \
  face_mesh.binarypb; do
    echo "Downloading $f ..."
    curl -sL "$BASE/$f" -o "$DEST/$f"
done

# Vendor JS libraries
mkdir -p vendor
echo "Downloading vendor/webgazer.js ..."
curl -sL "https://webgazer.cs.brown.edu/webgazer.js" -o "vendor/webgazer.js"
echo "Downloading vendor/chart.umd.min.js ..."
curl -sL "https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js" -o "vendor/chart.umd.min.js"
echo "Downloading vendor/html2canvas.min.js ..."
curl -sL "https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js" -o "vendor/html2canvas.min.js"

echo "Done. Run: python -m http.server 8000"
