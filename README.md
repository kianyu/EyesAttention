# EyesAttention

Browser-based eye tracking and pupil-response experiments using WebGazer and MediaPipe Face Mesh. All processing runs on-device in the browser.

## Quick Start

1. Clone and enter the repository:
```bash
git clone https://github.com/kianyu/EyesAttention.git
cd EyesAttention
```
2. Download MediaPipe assets:
```powershell
powershell -ExecutionPolicy Bypass -File setup.ps1
```
or:
```bash
bash setup.sh
```
3. Start a local server from this folder:
```bash
python -m http.server 8000
```
4. Open:
```
http://localhost:8000/experiment.html
```

## Project Overview

`experiment.html` provides five experiments:

1. Fixation dot accuracy (error in px vs known dot target).
2. Word-reading gaze tracking (error per highlighted word).
3. Off-screen robustness (predicted gaze leakage while looking away).
4. Cognitive load response using PIR (pupil-to-iris ratio) across easy/rest/hard phases.
5. Luminance response using PIR across bright/recovery/dark phases.

Results include live plots, per-phase summaries, run history, JSON/CSV export, and screenshot export.

## Pupil Detection Methods (Exp 4 & 5)

For each frame, iris radius is computed from MediaPipe iris landmarks, then pupil radius is estimated on the same eye crop by:

1. SET-style threshold region (`T = 30` from Javadi et al., 2015).
2. Otsu adaptive threshold + region grow (Otsu, 1979).

The reported metrics for Exp 4/5 phase summaries are method-specific:

- `PIR_SET = pupil_radius_SET_px / iris_radius_px`
- `PIR_Otsu = pupil_radius_Otsu_px / iris_radius_px`
- `pupil_mm = PIR * iris_mm` (reported separately for SET and Otsu)

Parameter provenance:

- `SET threshold T = 30` and segment-area filtering follow SET (Javadi et al., 2015).
- `Otsu threshold` is computed per frame by maximizing between-class variance (Otsu, 1979).
- `mm_per_px = user_IPD_mm / landmark_IPD_px` uses MediaPipe iris center landmarks (468, 473).

The UI still shows method-wise values for transparency:

- Live readout (Exp 4/5)
- Time-series chart
- Phase summary cards/tables
- CSV export

## Scale Calibration

Absolute pupil size in millimeters is estimated from a user IPD calibration:

- `mm_per_px = IPD_mm / IPD_px`
- `pupil_mm = pupil_px * mm_per_px`
- `iris_mm = iris_px * mm_per_px`

Default IPD is `63.0 mm` and can be overridden per user in Exp 4/5 ready screen. Relative changes across phases are still more reliable than absolute values.

## Method Limitations

- Webcam auto-exposure and lighting adaptation can affect pixel brightness and PIR.
- Pupil segmentation is sensitive to reflections, eyelid occlusion, and motion blur.
- Fixed iris-size conversion gives approximate pupil mm, not a clinical measurement.
- Off-axis gaze/head pose can bias both gaze prediction and pupil segmentation.

## References

- MediaPipe Iris (landmarks + depth/iris-size context):  
  https://research.google/blog/mediapipe-iris-real-time-iris-tracking-depth-estimation/
- Daugman, J. (1993). High confidence visual recognition of persons by a test of statistical independence. IEEE TPAMI.  
  https://ieeexplore.ieee.org/document/244676/
- Li, D., Winfield, D., & Parkhurst, D. J. (2005). Starburst: A hybrid algorithm for video-based eye tracking combining feature-based and model-based approaches. CVPR Workshops.  
  https://ieeexplore.ieee.org/document/1565386/
- Javadi, A.-H., et al. (2015). SET: A pupil detection method using sinusoidal approximation. Frontiers in Neuroengineering. DOI: 10.3389/fneng.2015.00004  
  https://www.frontiersin.org/articles/10.3389/fneng.2015.00004/full
- Wang, K., et al. (2015). Pupil and glint detection using wearable camera sensor and near-infrared LED array. Sensors. DOI: 10.3390/s151229792  
  https://www.mdpi.com/1424-8220/15/12/29792
- Papoutsaki, A., et al. (2016). WebGazer: Scalable webcam eye tracking using user interactions. IJCAI.  
  https://dl.acm.org/doi/10.5555/3060832.3061055
