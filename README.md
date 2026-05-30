# Wavelet Based Watermarking of Color Images

A secure, imperceptible digital signal processing solution that embeds copyright watermarks into color images using Discrete Wavelet Transform (DWT) multi-resolution decomposition.

## System Framework & Methodology
- **Color Space Selection:** Evaluates optimal luminance/chrominance channels to host watermark information while maintaining visual imperceptibility.
- **DWT Decomposition:** Splits image channels into sub-bands (LL, LH, HL, HH) to selectively inject spread-spectrum watermark signals into resilient coefficients.
- **Robustness Attacks Evaluated:** The system assesses security by subjecting watermarked images to heavy degradation and measuring recovery performance:
  - Salt & Pepper and Gaussian Noise Additions
  - Spatial Operations: Cropping, Blurring (Averaging Filters), and Sharpening
  - Image Modifications: Intensity Adjustment, Histogram Equalization, and lossy JPEG Compression.

## Analytical Metrics
- **Peak Signal-to-Noise Ratio (PSNR)** for strict visual fidelity check.
- **Correlation Coefficients** to quantitatively measure extracted watermark fidelity.

## References
- I. J. Cox, J. Kilian, F. T. Leighton, and T. Shamoon, "Secure spread spectrum watermarking for multimedia," *IEEE Trans. Image Process.*
- W. Bender, D. Gruhl, and N. Morimoto, "Techniques for data hiding," *Proc. SPIE*.

## Authors (Section A1, Group 02)
- **Rejoun Rahi Rad** (2106003) - *Winding Analysis & Signal Blurring Impacts*
- **Abrar Fahim** (2106005) - *Embedding Architecture, Code Optimization, & Noise Robustness*
- **Md. Yeasir Alif** (2106011) - *Correlation Calculation & Cropping/Blurring Degradation*
- **Al Muktadir Khan** (2106012) - *Extraction Pipelines, Histogram Normalization, & JPEG Compression*

**Course:** Digital Signal Processing I Laboratory (EEE 312), Bangladesh University of Engineering and Technology (BUET).
