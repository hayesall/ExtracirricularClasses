using Random, ImageInTerminal, Images

struct Image1D
    pixels::Matrix{UInt8}

    Image1D(pixels::Matrix{UInt8}) = new(pixels)
end

function Base.getindex(image::Image1D, i::Integer)::UInt8
    # Return 0 where pixels are undefined, otherwise return image.pixels[i]
    return i < 1 ? 0 : (i > length(image.pixels) ? 0 : image.pixels[i])
end

function convolve1D(image::Image1D, H = [0.2, 0.2, 0.2, 0.2, 0.2])
    output = similar(image.pixels, UInt8)
    for i ∈ eachindex(image.pixels)
        value = 0.0
        for j ∈ -2:2
            value += H[j + 3] * image[i + j]
        end
        # Round the value and clamp between 0-255 to avoid over/underflow
        output[i] = clamp(round(value), 0, 255)
    end
    return Image1D(output)
end

function Base.show(io::IO, ::MIME"text/plain", image::Image1D)
    display(Gray.(image.pixels / 255))
end

function main()
    # Sample a random 1x10 image with unsigned 8-bit integers
    image = Image1D(rand(UInt8, 1, 10))

    # Convolve with a mean filter and a Gaussian filter
    m_image = convolve1D(image, [0.2, 0.2, 0.2, 0.2, 0.2])
    g_image = convolve1D(image, [0.0544887, 0.244201, 0.40262, 0.244201, 0.0544887])

    return image, m_image, g_image
end
main()
