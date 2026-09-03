# Maximizing Power Efficiency of PV Modules Under Partial Shaded Conditions

## Overview

Partial shading causes non-linear, multi-peaked I-V curves in PV arrays, which makes conventional MPPT methods lose significant power. This thesis benchmarks four metaheuristic MPPT algorithms — Particle Swarm Optimization (PSO), Grey Wolf Optimization (GWO), Flying Squirrel Search Optimization (FSSO), and Drone Squadron Optimization (DSO) — against conventional Perturb & Observe (P&O), on a 3×3 Total-Cross-Tied PV array built from Adani Eternal Shine 540 Wp monofacial PERC modules.

Each algorithm was simulated in MATLAB R2024a across six shading patterns (row, column, narrow, wide, middle, random) — 30 configurations in total — tracking both maximum power point achieved and convergence time.

## Key findings

- **DSO ranked first overall** by TOPSIS analysis (weighting 70% power output, 30% convergence time), with a relative closeness of 0.84456, ahead of PSO (0.79685), GWO (0.69043), FSSO (0.43402), and P&O (0.34802).
- Under narrow shading, DSO reached 3410 W against P&O's 2176 W — a 56.7% power gain, the widest margin observed across the six scenarios.
- P&O converged fastest in every scenario (5–7 s) but consistently landed on the lowest power output. DSO paired near-best power output with the best convergence time among the metaheuristic algorithms (10.8–22.8 s across scenarios).


## Future scope 

- Hybrid MPPT combining DSO's tracking accuracy with P&O's convergence speed
- Adaptive/real-time tuning of DSO parameters
- Field validation on a physical PV array
- Smart-grid integration and predictive/forecasting control
---
ME dissertation (Electrical Engineering, Automatic Control & Robotics), submitted to The Maharaja Sayajirao University of Baroda, Faculty of Technology and Engineering, July 2024.

**Author:** Nair Rahuldev Muraleedharan

**Guide:** Dr. Jagrut Gadit — **Co-guide:** Ms. Kinjal Patel
---
