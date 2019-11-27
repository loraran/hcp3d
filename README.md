## 📉 X-Ray Diffraction Simulation of Interfaces in Hexagonal Close-Packed Crystals

MATLAB XRD simulations of hcp bulk crystals. MSc project (2017-2019).

This repository consists of all scripts developed in MATLAB to simulate XRD line profiles of hexagonal close-packed bulk crystals with grain interfaces. The scripts are separated into two folders: `hcp3d/fulltilt` lists all scripts dedicated to the simulation routines performed, and `hcp3d/extras` lists all scripts developed to extract images and perform pertinent calculations to extract further information on the XRD data obtained. A full description of the scripts contained in the repository can be found below.

Disclaimer:  
_MATLAB® is a registered trademark of The MathWorks, Inc. Further information can be found at http://www.mathworks.com._

---

<h3> Simulation Routines </h3>

* _`hcp3d_lattice.m`_ - Crystal lattice assembly. Defines lattice parameters and matrix size, sets up a spherical matrix.
* _`hcp3d_projections.m`_ - Generates and saves specified projections of the matrix created by `hcp3d_lattice`: (100), (110).
* _`hcp3d_progcut`_ - Collection of functions that perform progressive rotation and cutting of the projected matrices.
  * _`_alpha.m`_ - Progressive rotation and cutting of alpha-like interfaces (out-of-plane).
  * _`_beta.m`_ - Progressive rotation and cutting of beta-like interfaces (out-of-plane).
  * _`_gammaZ.m`_ - Progressive rotation and cutting of gamma-like interfaces (out-of-plane).
  * _`_gammaX.m`_ - Progressive rotation and cutting of gamma-like interfaces (in-plane).
* _`hcp3d_fft.m`_ - 
* _`hcp3d_fftX`_ - 
  * _`_fftXh.m`_ -
  * _`_fftXk.m`_ -
  * _`_fftXhk.m`_ -
* _`hcp3d_fulltilt.m`_ - HCP3D executable.

* _`hcp3d_stackingfault.m`_ - 
* _`hcp3d_stack`_ - 
  * _`_abb.m`_ - 
  * _`_abc.m`_ - 
  
<h3> Extraction of Atom Matrices Figures for POV-Ray™ </h3>

The [_Persistence of Vision Raytracer™_](http://www.povray.org/) (_POV-Ray™_) is a tool for producing high-quality computer graphics. POV-Ray is a free and open-source software with source code available under the AGPLv3.

* _`hcp3d_pov`_ - 
  * _`_bulk.m`_ - 
  * _`_alpha.m`_ - 
  * _`_beta.m`_ - 
  * _`_gamma.m`_ - 

<h3> Data Retrieval </h3>

* _`angulos.m`_ - Convertion of atom coordinates into rotation angles
* _`reverseangulos.m`_ - Convertion of rotation angles into atom coordinates **_[TO-DO]_**
* _`Lcalc.m`_ - Estimates Miller indexes (_l_ only)
* _`strain.m`_ - Calculates maximum estimated strain (1D distortion)

[add descriptions]
