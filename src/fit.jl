function fit(
    ::Type{BayesianCTTModel},
    data::AbstractVecOrMat,
    args...;
    priors::Priors,
    kwargs...,
)
    scores = reshape(data, :, size(data, 2))
    ctt_model = ctt(scores; priors)
    chains = sample(ctt_model, args...; kwargs...)
    return BayesianCTTModel(scores, ctt_model, priors, chains)
end

function fit(
    T::Type{BayesianCTTModel},
    data::PsychometricTest,
    args...;
    priors::Priors,
    kwargs...,
)
    scores = personscores(data)
    return fit(T, scores, args...; priors, kwargs...)
end

function fit(
    T::Type{BayesianCTTModel},
    data::AbstractVector{<:PsychometricTest},
    args...;
    priors::Priors,
    kwargs...,
)
    scores = [personscores(test) for test in data]
    return fit(T, hcat(scores...), args...; priors, kwargs...)
end
