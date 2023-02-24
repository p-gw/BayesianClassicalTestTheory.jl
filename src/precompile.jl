using SnoopPrecompile

# data = [
#     80 77 80 73 73
#     83 79 78 78 77
#     85 77 88 81 80
#     76 76 76 78 67
#     70 69 73 71 77
#     87 89 92 91 87
#     76 75 79 80 75
#     86 75 80 80 82
#     84 79 79 77 82
#     96 85 91 87 90
# ]

# priors = Priors(
#     mu_true = Normal(80, 10),
#     sigma_true = InverseGamma(1, 6),
#     sigma_observed = InverseGamma(1, 4),
# )

# TODO: make SnoopPrecompile work with Turing
@precompile_setup begin
    test_data = [
        80 77 80 73 73
        83 79 78 78 77
        85 77 88 81 80
        76 76 76 78 67
        70 69 73 71 77
        87 89 92 91 87
        76 75 79 80 75
        86 75 80 80 82
        84 79 79 77 82
        96 85 91 87 90
    ]

    @precompile_all_calls begin
        using Turing

        model_priors = Priors(
            mu_true = Normal(80, 10),
            sigma_true = InverseGamma(1, 6),
            sigma_observed = InverseGamma(1, 4),
        )

        fitted = fit(
            BayesianCTTModel,
            test_data,
            NUTS(),
            100;
            priors = model_priors,
            progress = false,
        )

        getdata(fitted)
        getpriors(fitted)
        getposterior(fitted)
        true_scores(fitted)
        reliability(fitted)
        composite_reliability(fitted)
    end
end
