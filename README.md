# Hydrodynamics-Study-Tide-and-Wind-Wave-Hindcasting
This study compared several methods in tide calculation and wave hindcasting. The data used are secondary data obtained from OGIMET in Badung Regency, Bali, for wave data, and Bitung Regency, North Sulawesi, for tidal data. 

# Tide calculation method
admiralty method       [calculated in excel]
least squares method   [calculated in ls app from US Army Engineer Waterways 
                        Experiment Station Coastal Engineering Research Center]
IOS method             [calculated in Mike zero]

# Wave hindcasting using inversion polynomial
Using high-degree polynomial inversion (orders 6, 8, 10) on wind/wave data produced beautifully smooth fits within the training range in MATLAB. However, the model completely breaks when extended beyond the training data — forecasting just 10 hours ahead produced physically implausible results, confirming that the polynomial inversion has no predictive power. The fit is purely interpolative and fails catastrophically outside the fitted range.

Conclusion: Polynomial inversion fails here due to numerical instability and cannot generalize beyond the observed data. Regularization or physically-based models are required for meaningful results.
