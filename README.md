## X-Ray Diffraction Simulation of Interfaces in Hexagonal Close-Packed Crystals

MATLAB XRD simulations of hcp bulk crystals. MSc project (2017-2019).

This repository consists of all scripts developed in MATLAB to simulate XRD line profiles of hexagonal close-packed bulk crystals with grain interfaces. The scripts are separated into two folders: `hcp3d/fulltilt` lists all scripts dedicated to the simulation routines performed, and `hcp3d/extras` lists all scripts developed to extract images and perform pertinent calculations to extract further information on the data obtained.

Disclaimer:  
_MATLAB® is a registered trademark of The MathWorks, Inc. Further information can be found at http://www.mathworks.com._

---

A full list of the scripts contained in this repository follows:

* _`hcp3d_lattice.m`_ - Defines lattice parameters and matrix size, sets up spherical matrix.
* _`hcp3d_projections.m`_ - Generates and saves specified projections of the matrix created by `hcp3d_lattice`.
* _`hcp3d_progcut`_ - Collection of functions that performs progressive rotations and cutting of the projected matrices.
  * _`_alpha.m`_ -
  * _`_beta.m`_ -
  * _`_gammaZ.m`_ -
  * _`_gammaX.m`_ -
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

* _`hcp3d_pov`_ - 
  * _`_bulk.m`_ - 
  * _`_alpha.m`_ - 
  * _`_beta.m`_ - 
  * _`_gamma.m`_ - 

* _`angulos.m`_ - 
* _`reverseangulos.m`_ - 
* _`Lcalc.m`_ - 
* _`strain.m`_ - 

[add descriptions]
