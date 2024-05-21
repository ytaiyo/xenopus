# enter temperature here:
temp = 23

# enter hours here:
time = 53.5

import numpy as np
from scipy.optimize import root_scalar

f1 = lambda nfstage: -137.4 * np.exp(-0.1460 * temp) + (21.54 * np.exp(-0.1192 * temp)) * nfstage - time

stage = round((root_scalar(f1, bracket=[0, 120], method='brentq')).root, 1)

if stage <= 40:
    print(stage)
else:
    f1 = lambda nfstage: -2481.0 * np.exp(-0.09332 * temp) + (81.97 * np.exp(-0.09745 * temp)) * nfstage - time

    stage = round((root_scalar(f1, bracket=[0, 50], method='brentq')).root, 1)
    print(f"NF Stage {stage}")
