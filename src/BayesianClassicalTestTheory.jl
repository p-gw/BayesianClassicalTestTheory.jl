module BayesianClassicalTestTheory

using Distributions
using MCMCChains
using Makie
using Reexport
using ReverseDiff
using Turing

@reexport using Turing: NUTS
@reexport import StatsAPI: fit

export Priors
export BayesianCTTModel
export getdata, getpriors, getposterior
export true_scores
export reliability, composite_reliability

function __init__()
    Turing.setadbackend(:reversediff)
    Turing.setrdcache(true)
    return nothing
end

include("priors.jl")
include("types.jl")
include("model.jl")
include("fit.jl")

# include("plot.jl")
# include("precompile.jl")

end
