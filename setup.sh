#!/bin/bash
# setup.sh — Download MediaPipe face mesh assets for local serving
# Run once: bash setup.sh

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

echo "Done. Run: python -m http.server 8000"
