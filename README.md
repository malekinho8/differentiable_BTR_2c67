# Differentiable blind tip reconstruction

This repository contains Jupyter notebooks for differentiable blind tip reconstruction (BTR) used in Matsunaga et al. (2022). 

All notebooks are written in Julia programming language. You need to install julia before using the notebooks. 
Also, the notebooks depend on several packages. The packages can be installed as follows:

```julia
$ julia
julia> 
# enter the package mode by pressing ]
pkg> add IJulia, Flux, Plots, Statistics, BSON, Revise, HTTP
pkg> add https://github.com/matsunagalab/MDToolbox.jl.git
# return to the REPL mode by pressing BACKSPACE or DELETE
julia> using IJulia
julia> exit()
```

## Descriptions on files

The files are organied as follows:

- `single_tip/` contains the twin experiment notebooks for single tip shape

  - `blindtip_original.ipynb` notebook performs the original BTR under noise-free condition
 
  - `blindtip_opening.ipynb` notebook performs the differentiable BTR under noise-free condition

  - `blindtip_original_randn.ipynb` notebook performs the original BTR under noisy condition
 
  - `blindtip_opening_randn.ipynb` notebook performs the differentiable BTR under noisy condition

- `double_tip/` contains the twin experiment notebooks for double tip shape

  - `blindtip_original_randn.ipynb` notebook performs the original BTR under noisy condition
 
  - `blindtip_opening_randn.ipynb` notebook performs the differentiable BTR under noisy condition

- `myosin/` contains the notebooks for the BTR of high-speed AFM data of Myosin V walking

  - `blindtip_myosin_original_863-892.ipynb` notebook performs the original BTR
 
  - `blindtip_myosin_opening_863-892.ipynb` notebook performs the differentiable BTR
  
## License

This repository is licensed under the under the terms of GNU General Public License v3.0. 

Quaternion data contained in `quaternion/` directory were taken from the repository of the BioEM program written by Cossio et al. https://github.com/bio-phys/BioEM. These are separately licensed under the terms of the GNU General Public License. Please check the license file `quaternion/LICENSE`. 
 
## Contact

Yasuhiro Matsunaga

ymatsunaga@mail.saitama-u.ac.jp

