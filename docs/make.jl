using BayesianClassicalTestTheory
using Documenter

DocMeta.setdocmeta!(BayesianClassicalTestTheory, :DocTestSetup, :(using BayesianClassicalTestTheory); recursive=true)

makedocs(;
    modules=[BayesianClassicalTestTheory],
    authors="Philipp Gewessler",
    repo="https://github.com/p-gw/BayesianClassicalTestTheory.jl/blob/{commit}{path}#{line}",
    sitename="BayesianClassicalTestTheory.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://p-gw.github.io/BayesianClassicalTestTheory.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/p-gw/BayesianClassicalTestTheory.jl",
    devbranch="main",
)
