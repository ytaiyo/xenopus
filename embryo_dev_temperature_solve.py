# enter desired final NF-stage here:
nfStage = 34

# enter hours until that stage should be reached:
time = 48+8

import numpy as np
from scipy.optimize import root_scalar

if nfStage <= 40:
    f1 = lambda temp: -137.4*np.exp(-0.1460*temp) + (21.54*np.exp(-0.1192*temp))*nfStage-time
else:
    f1 = lambda temp: -2481.0*np.exp(-0.09332*temp) + (81.97*np.exp(-0.09745*temp))*nfStage-time

temperature = round((root_scalar(f1, bracket=[0, 35], method='brentq')).root, 1)

print(f"Incubate at {temperature}°C")
