using ArgParse
using DelimitedFiles
using Plots

# define commandline options
function parse_commandline()
    s = ArgParseSettings("Create PNG image of given AFM data files. PNG files are created in the same direcoty of the AFM data files.")

    @add_arg_table! s begin
        "--cmin"
            arg_type = Float64
            default = nothing
            help = "Minimum of colorbar range. If nothing is given, determined from input data."
        "--cmax"
            arg_type = Float64
            default = nothing
            help = "Maximum of colorbar range. If nothing is given, determined from input data."
        "--resx"
            arg_type = Float64
            default = 1.0
            help = "Spatial resolution of each pixel in the X axis."
        "--resy"
            arg_type = Float64
            default = 1.0
            help = "Spatial resolution of each pixel in the Y axis."
        "--ext"
            arg_type = String
            default = "csv"
            help = "Extension of input AFM csv filenames that should be recognized as inputs. E.g., --ext csv_erosion recognizes 1.csv_erosion."
        "--fps"
            arg_type = Float64
            default = 5.0
            help = "Frames per second for the GIF movie."
        "--output"
            arg_type = String
            default = "afm.gif"
            help = "Output GIF file name."
        "arg1"
            arg_type = String
            default = "./"
            help = "Input directory which contains the CSV files of AFM images. By default, read only filenames ending with \".csv\". Recognized extension can be specified with --ext option. Each CSV contains the heights of pixels. Columns correspond to the x-axis (width). Rows are the y-axis (height)."
    end

    s.epilog = """
        examples:\n
        \n
        \ua0\ua0julia $(basename(Base.source_path())) --output afm.gif data/
        \n
        \ua0\ua0julia $(basename(Base.source_path())) --output inlier.gif --ext csv_inlier --cmin 0.0 data/
        \n
        """

    return parse_args(s)
end


function main(args)
    parsed_args = parse_commandline()

    cmin = parsed_args["cmin"]
    cmax = parsed_args["cmax"]
    resx = parsed_args["resx"]
    resy = parsed_args["resy"]
    ext = parsed_args["ext"]
    fps = parsed_args["fps"]
    output = parsed_args["output"]
    input_dir = parsed_args["arg1"]

    # input and output
    fnames = readdir(input_dir)
    println("# Files in $(input_dir) are read in the following order:")
    images = []
    for fname in fnames
        if !isnothing(match(Regex(".+\\.$(ext)" * "\$"), fname))
            println(joinpath(input_dir, fname))
            image = readdlm(joinpath(input_dir, fname), ',')
            push!(images, image)
        end
    end
    if cmin == nothing
        cmin2 = minimum(minimum.(images))
    else
        cmin2 = cmin
    end
    if cmax == nothing
        cmax2 = maximum(maximum.(images))
    else
        cmax2 = cmax
    end

    anim = @animate for i = 1:length(images)
        nx = size(images[i], 2)
        ny = size(images[i], 1)
        heatmap(collect(1:nx) .* resx, collect(1:ny) .* resy, images[i], clim=(cmin2, cmax2), dpi=150, fmt=:png, 
                aspect_ratio=:equal) #xtickfontsize=12, ytickfontsize=12, legendfontsize=12, colorbar_tickfontsize=12)
        xlabel!("X-axis")
        ylabel!("Y-axis")
        xlims!(0, nx * resx)
        ylims!(0, ny * resy)
    end
    
    println("# Writing GIF movie in $(output):")
    gif(anim, output, fps=fps)

    return 0
end

main(ARGS)
