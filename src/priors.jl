Base.@kwdef struct Priors
    mu_true::ContinuousUnivariateDistribution
    sigma_true::ContinuousUnivariateDistribution
    sigma_observed::ContinuousUnivariateDistribution
    reliability::ContinuousUnivariateDistribution = Beta(1, 1)
end
