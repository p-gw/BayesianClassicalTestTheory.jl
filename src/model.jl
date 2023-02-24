@model function ctt(y::AbstractMatrix; priors::Priors)
    npersons, ncomponents = size(y)

    mu_true ~ priors.mu_true
    sigma_true ~ priors.sigma_true
    sigma_observed ~ priors.sigma_observed

    T ~ filldist(Normal(mu_true, sigma_true), npersons)

    for j in 1:ncomponents
        y[:, j] ~ arraydist(Normal.(T, sigma_observed))
    end

    reliability = sigma_true^2 / (sigma_true^2 + sigma_observed^2)
    Turing.@addlogprob! logpdf(priors.reliability, reliability)

    composite_reliability = ncomponents * reliability / ((ncomponents - 1) * reliability + 1)

    return (; reliability, composite_reliability)
end
