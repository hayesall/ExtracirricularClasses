# Copyright © 2021 Alexander L. Hayes

"""
ccall functions for calling C-like functions from Julia
"""

using Base.Filesystem

export mean_c
export mean_rust


pwd = Filesystem.pwd()
c_lib = joinpath(pwd, "libmean.so")
r_lib = joinpath(pwd, "target/release/librustmeanffi.so")


function mean_c(a::Number, b::Number)
    return ccall((:mean, c_lib),
                   Float64,
                   (Float64, Float64),
                   a, b)
end

function mean_rust(a::Number, b::Number)
    return ccall((:mean, r_lib),
               Float64,
               (Float64, Float64),
               a, b)
end


function main()
    for (i, j) in [(10.0, 20.0), (1.0, 2.0), (10, 20), (1, 2.9)]
        println("MyCLib: ", mean_c(i, j), ", MyRustLib: ", mean_rust(i, j))
    end
end

main()
