# Copyright © 2022 Alexander L. Hayes

module CVHayesall

using ImageInTerminal, Images, OffsetArrays

export Image2D, Image1D, main, show, getindex, convolve1D, mean_kernel, make_kernel

struct Image1D
    pixels::Matrix{UInt8}

    Image1D(pixels::Matrix{UInt8}) = new(pixels)
end

function Base.getindex(image::Image1D, i::Integer)::UInt8
    # Return 0 where pixels are undefined, otherwise return image.pixels[i]
    return i < 1 ? 0 : (i > length(image.pixels) ? 0 : image.pixels[i])
end

function Base.getindex(image::Image1D, i::CartesianIndex)::UInt8
    # Return 0 where pixels are undefined, otherwise return image.pixels[i]
    return i.I[2] < 1 ? 0 : (i.I[2] > length(image.pixels) ? 0 : image.pixels[i])
end

mean_kernel = OffsetArray([0.2 0.2 0.2 0.2 0.2], 0:0, -2:2)

function make_kernel(odd_array::Matrix{Float64})
    # This only works with 1x5 kernels
    return OffsetArray(odd_array, 0:0, -2:2)
end

function convolve1D(image::Image1D, H = mean_kernel)
    output = similar(image.pixels, UInt8)
    for i ∈ CartesianIndices(image.pixels)
        value = 0.0
        for j ∈ CartesianIndices(H)
            value += H[j] * image[i + j]
        end
        # Round the value and clamp between 0-255 to prevent overflow
        output[i] = clamp(round(value), 0, 255)
    end
    return Image1D(output)
end

struct Image2D
    pixels::Matrix{UInt8}
    n::Int64
    m::Int64

    function Image2D(pixels::Matrix{UInt8})
        n, m = size(pixels)
        return new(pixels, n, m)
    end
end

function Base.getindex(image::Image2D, i::Int64)
    return image.pixels[i]
end

function Base.getindex(image::Image2D, i::Int64, j::Int64)
    return image.pixels[i, j]
end

function Base.getindex(image::Image2D, urange::UnitRange)
    return image.pixels[urange]
end

function Base.show(io::IO, ::MIME"text/plain", image::Image2D)
    display(Gray.(image.pixels / 255))
end

function Base.show(io::IO, ::MIME"text/plain", image::Image1D)
    display(Gray.(image.pixels / 255))
end


function main()

    data = UInt8[
        148 123 52 107 123 162 172 123 64 89;
        147 130 92 95 98 130 171 155 169 163;
        141 118 121 148 117 107 144 137 136 134;
        82 106 93 172 149 131 138 114 113 129;
        57 101 72 54 109 111 104 135 106 125;
        138 135 114 82 121 110 34 76 101 111;
        138 102 128 159 168 147 116 129 124 117;
        113 89 89 109 106 126 114 150 164 145;
        120 121 123 87 85 70 119 64 79 127;
        145 141 143 134 111 124 117 113 64 112
    ]
    return Image2D(data)
end

end # module
