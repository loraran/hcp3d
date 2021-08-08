# 📉 XRD Simulation of Interfaces in HCP Crystals

MATLAB XRD simulations of hcp bulk crystals. MSc project (2017-2019).

**_NOTE:_ Upload is still ongowing as of 2021.**

This repository consists of all scripts developed in MATLAB to simulate X-ray diffraction line profiles of hexagonal close-packed bulk crystals with grain interfaces. The scripts are separated into two folders: `hcp3d/sim` lists all scripts dedicated to the simulation routines performed, and `hcp3d/extras` lists all scripts developed to extract images and perform pertinent calculations to extract further information on the XRD data obtained. A full description of the scripts contained in the repository can be found below.

A research paper was published using results obtained from these scripts. You can find it here:

[_Retrieving the configuration of grain boundary structure in polycrystalline materials by extraordinary X-ray reflection analysis_](https://doi.org/10.1107/S1600576720007803)
<br>**L. Aarão-Rodrigues, A. Isaac, R. B. Figueiredo and A. Malachias**
 
>_MATLAB® is a registered trademark of The MathWorks, Inc. Further information can be found at http://www.mathworks.com._

---

## _hcp3d/sim_
### Simulation Routines

* `hcp3d_fulltilt.m` - HCP3D main script. Executes all relevant scripts, calling functions in the correct order.
* `hcp3d_lattice.m` - Crystal lattice assembly. Defines lattice parameters and matrix size, sets up a spherical matrix.
* `hcp3d_projections.m` - Generates specified projections of the matrix created by `hcp3d_lattice`: (100), (110).
* Collection of functions that perform progressive rotation and cutting of the projected matrices:
  * `hcp3d_progcut_alpha.m` - Progressive rotation, cutting and assembly of _out-of-plane_ α-type interfaces.
  * `hcp3d_progcut_beta.m` - Progressive rotation, cutting and assembly of _out-of-plane_ β-type interfaces.
  * `hcp3d_progcut_gammaZ.m` - Progressive rotation, cutting and assembly of _out-of-plane_ γ-type interfaces.
  * `hcp3d_progcut_gammaX.m` - Progressive rotation, cutting and assembly of _in-plane_ γ-type interfaces. **_[ADD]_**
* `hcp3d_fft.m` - Fast-Fourier Transform of assembled out-of-plane lattices α, β and γ. Varies l with 0.006 steps.
* Collection of functions that perform Fast-Fourier Transform of assembled lattices γ (in-plane):
  * `hcp3d_fftX_fftXh.m` - Varies h with 0.006 steps.
  * `hcp3d_fftX_fftXk.m` - Varies k with 0.006 steps.
  * `hcp3d_fftX_fftXhk.m` - Varies h and k with 0.006 steps.
* `hcp3d_stackingfault.m` - **_[ADD description]_**
* `hcp3d_stack` - **_[ADD description]_**
  * `_abb.m` - **_[ADD description]_**
  * `_abc.m` - **_[ADD description]_**
  
## _hcp3d/extras_
### Extraction of Atom Matrix Figures for POV-Ray™
>The [_Persistence of Vision Raytracer™_](http://www.povray.org/) (_POV-Ray™_) is a tool for producing high-quality computer graphics. POV-Ray is a free and open-source software >with source code available under the AGPLv3.

* Collection of scripts to assist the creation on images to better illustrate relevant assembled lattices (all atom positions are preserved). They create _.pov_ files to be visualized in POV-Ray.
  * `_bulk.m` - Creates _.pov_ files to generate images for the bulk matrix.
  * `_alpha.m` - Creates _.pov_ files to generate images for _out-of-plane_ α-type interfaces.
  * `_beta.m` - Creates _.pov_ files to generate images for _out-of-plane_ β-type interfaces.
  * `_gamma.m` - Creates _.pov_ files to generate images for _out-of-plane_ γ-type interfaces.

### Data Retrieval

* `angulos.m` - Convertion of atom coordinates into rotation angles.
* `Lcalc.m` - Estimates Miller indexes (_l_ only).
* `strain.m` - Calculates maximum estimated strain (1D distortion).
* `reverseangulos.m` - Convertion of rotation angles into atom coordinates. _[not used, unfinished]_
