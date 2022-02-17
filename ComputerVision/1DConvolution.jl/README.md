## Simple 1D Convolution

```julia
include("src/simple_convolution.jl")

using Random

im1 = Image1D(rand(UInt8, 1, 10))

gaussian_kernel = [0.0544887, 0.244201, 0.40262, 0.244201, 0.0544887]

convolve1D(im1, [0.2, 0.2, 0.2, 0.2, 0.2])
convolve1D(im1, gaussian_kernel)
```
