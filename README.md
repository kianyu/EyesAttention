# EyesAttention — WebGazer + MediaPipe Eye Tracking Demo

A browser-based eye tracking demo using **WebGazer.js** and **MediaPipe Face Mesh**.
No API key, no quota, no data sent to any server — everything runs on-device.

## Features

| Feature | Description |
|---|---|
| **Gaze tracking** | Real-time blue dot following your eye gaze on screen |
| **Calibration** | 9-point click calibration overlay (5 clicks per point) |
| **Gaze heatmap** | Accumulates where your gaze has been on the page |
| **Iris diameter** | Estimates iris/pupil size in mm using MediaPipe iris landmarks 468–477 |
| **Eye Aspect Ratio (EAR)** | Measures eyelid openness for squint and blink detection |
| **Blink counter** | Counts blinks in real time |
| **Gaze targets** | Interactive emoji circles that react when you look at them |

---

## Setup

### Step 1 — Clone the repository

```bash
git clone https://github.com/kianyu/EyesAttention.git
cd EyesAttention
```

### Step 2 — Download MediaPipe assets

The MediaPipe WASM/model files (~17 MB) are not included in the repo.
Download them once using the provided script:

**Windows (PowerShell):**
```powershell
powershell -ExecutionPolicy Bypass -File setup.ps1
```

**macOS / Linux (bash):**
```bash
bash setup.sh
```

This creates a `mediapipe/face_mesh/` folder with all required files.

### Step 3 — Start a local server

```bash
python -m http.server 8000
```

> **Note:** A local server is required. Opening `index.html` directly via `file://` will not work due to browser security restrictions on camera access and WASM loading.

### Step 4 — Open in browser

```
http://localhost:8000
```

Use **Chrome** for best compatibility.

---

## How to use

1. Click **Start Tracking** — allow camera access when prompted
2. Complete the **9-point calibration** — look at each yellow dot and click it 5 times
3. Look around — the blue dot follows your gaze
4. Watch the **Iris Diameter**, **EAR**, and **Blink Counter** update in real time
5. Click **Recalibrate** anytime to improve accuracy
6. Calibration data is saved locally (IndexedDB) and reused on the next visit

---

## How it works

```
Webcam
  │
  ├─► WebGazer.js
  │     ├─ MediaPipe Face Mesh  →  detects face landmarks
  │     └─ Ridge Regression     →  maps eye appearance to screen X, Y
  │
  └─► MediaPipe Face Mesh (our instance, refined landmarks)
        ├─ Iris landmarks 468–477  →  iris diameter in mm
        └─ Eyelid landmarks        →  EAR, blink detection
```

---

## Tech stack

- [WebGazer.js](https://webgazer.cs.brown.edu/) — gaze estimation
- [MediaPipe Face Mesh](https://google.github.io/mediapipe/solutions/face_mesh) — face & iris landmarks
- Vanilla HTML / CSS / JavaScript — no build tools required
