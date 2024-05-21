# enter desired final NF-stage here:
nfStage = 20

# enter temperature:
temp = 9

import numpy as np
from scipy.optimize import root_scalar

if nfStage <= 40:
    f1 = lambda time: -137.4*np.exp(-0.1460*temp) + (21.54*np.exp(-0.1192*temp))*nfStage-time
else:
    f1 = lambda time: -2481.0*np.exp(-0.09332*temp) + (81.97*np.exp(-0.09745*temp))*nfStage-time

time = round((root_scalar(f1, bracket=[0, 300], method='brentq')).root, 2)

print(time)

print(-137.4*np.exp(-0.1460*temp))

timeperstage = (time - (-137.4*np.exp(-0.1460*temp)))/nfStage
print(round(timeperstage, 3))
