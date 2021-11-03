import matplotlib.pyplot as plt
import numpy as np

a = np.array([1,2,5,3,2,8,3,1])
plt.plot(a)
plt.legend('EEG using VR')
plt.xlabel('Time, sec')
plt.ylabel('Value')
plt.show()
