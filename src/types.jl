struct BayesianCTTModel{DT<:AbstractMatrix{<:Real},MT}
    data::DT
    model::MT
    priors::Priors
    posterior::Chains
end

getdata(model::BayesianCTTModel) = model.data

getpriors(model::BayesianCTTModel) = model.priors
getpriors(model::BayesianCTTModel, name) = getfield(model.priors, name)

getposterior(model::BayesianCTTModel) = model.posterior
getposterior(model::BayesianCTTModel, name) = get(model.posterior, name)

function true_scores(model::BayesianCTTModel)
    chains = getposterior(model)
    scores = chains[namesingroup(chains, :T)]
    return Array(scores)
end

function reliability(model::BayesianCTTModel)
    ρ = _get_generated_quantity(model, :reliability)
    return vec(ρ)
end

function composite_reliability(model::BayesianCTTModel)
    ρ = _get_generated_quantity(model, :composite_reliability)
    return vec(ρ)
end

function _get_generated_quantity(model::BayesianCTTModel, quantity::Symbol)
    # reconstructing chains is required to avoid warning messages from Turing
    chains = Chains(getposterior(model), :parameters)
    gq = generated_quantities(model.model, chains)
    return getfield.(gq, quantity)
end
