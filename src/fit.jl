function fit(
    ::Type{BayesianCTTModel},
    data::AbstractVecOrMat,
    args...;
    priors::Priors,
    kwargs...,
)
    ymat = reshape(data, :, size(data, 2))

    ctt_model = ctt(ymat; priors)
    chains = sample(ctt_model, args...; kwargs...)
    return BayesianCTTModel(ymat, ctt_model, priors, chains)
end
