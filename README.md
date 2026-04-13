# Hydrodynamics-Study
This study compared several methods in tide calculation and wave hindcasting. The data used are secondary data obtained from NASA, the Copernicus Climate Change Service (C3S), the Sea Level Station Monitoring Facility (UNESCO/IOC), and OGIMET.

## Tide calculation
1. admiralty method       [calculated in excel]
2. least squares method   [calculated in ls app from US Army Engineer Waterways 
                        Experiment Station Coastal Engineering Research Center]
3. IOS method             [calculated in Mike zero]

### Results 
The highest water level elevation recorded in Bitung Regency, North Sulawesi from October 1 2022 to October 31 2022 was 2.584 m, and the lowest was 0.944 m. The results indicate that although the Formzahl values obtained from the three tidal analysis methods differ, they all fall within the range of 0.25–1.5. Therefore, it can be concluded that the tidal type in Bitung Regency is a mixed, predominantly semidiurnal tide.

Plots included:
#####
<img height="100" alt="Admiralty" src="https://github.com/user-attachments/assets/8cb70236-c06e-4d33-8c9e-2cc9d0ed9b6d" />
<img height="100" alt="LS" src="https://github.com/user-attachments/assets/8f478738-8a23-44a3-b75d-e054ed3d075e" />
<img height="100" alt="IOS" src="https://github.com/user-attachments/assets/fbe3e93c-abcd-4988-b17b-d89a0ca720ea" />


## Wave hindcasting using inversion polynomial
Using polynomial inversion on wind data to calculate wave height and period.

### Results
Polynomial inversion (orders 6, 8, 10) produced beautifully smooth fits within the training range in MATLAB. However, the model completely breaks when extended beyond the training data — forecasting just 10 hours ahead produced physically implausible results, confirming that the polynomial inversion has no predictive power. The fit is purely interpolative and fails catastrophically outside the fitted range.

Conclusion: Polynomial inversion fails here due to numerical instability and cannot generalize beyond the observed data. Regularization or physically-based models are required for meaningful results.

Plots included:
#####
<img height="100" alt="obs_bener" src="https://github.com/user-attachments/assets/c008adbf-c7f6-44d4-b3c8-2c64762cdf8f" />
<img height="100" alt="cal" src="https://github.com/user-attachments/assets/dac61f60-283b-45a8-bf67-8548e46dcac8" />


#####
#####
See [Hydrodynamics Study-Result.pdf](https://github.com/user-attachments/files/26528704/Hydrodynamics.Study-Result.pdf) for the full report.

