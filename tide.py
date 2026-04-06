import numpy as np
import matplotlib.pyplot as plt 

obs = np.loadtxt('obs_data.txt')
cal = np.loadtxt('cal_data.txt')

ad, ls, ios = cal[:, 1], cal[:, 2], cal[:, 3] 

''''
ad = admiralty method       [calculated in excel]
ls = least squares method   [calculated in ls app from US Army Engineer 
                                Waterways Experiment Station Coastal 
                                Engineering Research Center]
ios = IOS method            [calculated in Mike zero]

'''

# Sea surface elevation calculation

def MSL(Z0):
    MSL = Z0
    
    return MSL

def p(Z0, M2, S2, K1, O1):
    HHWL = Z0 + (M2 + S2 +K1 +O1)
    LLWL = Z0 - (M2 + S2 +K1 +O1)
    
    return HHWL, LLWL

def q(Z0, M2, K1, O1):
    MHWL = Z0 + (M2 +K1 +O1)
    MLWL = Z0 - (M2 +K1 +O1)
    
    return MHWL, MLWL


# Residu & elevation data

df = np.loadtxt('tide_constanta.txt')

MSL_ad, MSL_ls, MSL_ios = MSL(df[0, 0]), MSL(df[1, 0]), MSL(df[2, 0])

HHWL_ad, LLWL_ad = p(df[0, 0], df[0, 1], df[0, 2], df[0, 4], df[0, 6])
HHWL_ls, LLWL_ls = p(df[1, 0], df[1, 1], df[1, 2], df[1, 4], df[1, 6])
HHWL_ios, LLWL_ios = p(df[2, 0], df[2, 1], df[2, 2], df[2, 4], df[2, 6])

MHWL_ad, MLWL_ad = q(df[0, 0], df[0, 1], df[0, 4], df[0, 6])
MHWL_ls, MLWL_ls = q(df[1, 0], df[1, 1], df[1, 4], df[1, 6])
MHWL_ios, MLWL_ios = q(df[2, 0], df[2, 1], df[2, 4], df[2, 6])

# Residu calculation

r_ad = (ad - obs) + MSL_ad
r_ls = (ls - obs) + MSL_ls
r_ios = (ios - obs) + MSL_ios

# Plotting 

def tide_plot(obs, cal, residue, MSL, HHWL, MHWL, LLWL, MLWL, title, line_width):
    plt.plot(obs, 'tomato', linewidth=line_width)
    plt.plot(cal, 'skyblue', linewidth=line_width)
    plt.plot(residue, 'dimgrey', linewidth=line_width)
    plt.plot(MSL, 'peru', linewidth=line_width)
    plt.plot(HHWL, 'palevioletred', linewidth=line_width)
    plt.plot(MHWL, 'mediumturquoise', linewidth=line_width)
    plt.plot(LLWL, 'limegreen', linewidth=line_width)
    plt.plot(MLWL, 'grey', linewidth=line_width)
    
    plt.title(title, fontsize=14)
    plt.xlabel('Time (hour)', fontsize=10)
    plt.ylabel('Elevation (m)', fontsize=10)
    plt.legend(['Obs', 'Cal', 'Residue', 'MSL', 'HHWL', 'MHWL', 'LLWL', 'MLWL'], fontsize=7, loc='lower right')
    
    plt.tight_layout()
    plt.show()
 

plt.figure(1)
tide_plot(obs, ad, r_ad, MSL_ad, HHWL_ad, MHWL_ad, LLWL_ad, MLWL_ad, 'Admiralty Method', 1)

plt.figure(2)
tide_plot(obs, ls, r_ls, MSL_ls, HHWL_ls, MHWL_ls, LLWL_ls, MLWL_ls, 'Least Squares Method', 1)

plt.figure(3)
tide_plot(obs, ios, r_ios, MSL_ios, HHWL_ios, MHWL_ios, LLWL_ios, MLWL_ios, 'IOS Method', 1)
