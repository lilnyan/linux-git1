import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from sklearn.preprocessing import PolynomialFeatures
from sklearn.pipeline import make_pipeline
from sklearn.linear_model import LinearRegression


def find_csv_filenames( path_to_dir, suffix=".csv" ):
    filenames = os.listdir(path_to_dir)
    return [ filename for filename in filenames if filename.endswith( suffix ) ]

dirname = os.getcwd()
filenames = find_csv_filenames(dirname+'/EEG_Dataset')
n = 200 #число окон
degree=2 #степень полинома
stats2 = pd.DataFrame([],columns=['Subject','Status','max','min','mean','std'])

for index,file in enumerate(filenames):
    df = pd.read_csv('EEG_Dataset/'+file)
    w = np.array_split(df['RAW'],n)
    proc_values = [None]*200
    polyreg=make_pipeline(PolynomialFeatures(degree),LinearRegression())
    for i,values in enumerate(w):
        polyreg.fit(np.array(values.index).reshape(-1,1), np.array(values))
        proc_values[i] = polyreg.predict(np.array(values.index).reshape(-1,1))
    proc_values = np.concatenate(proc_values)
    stats2.loc[index] = [index+1, file[10], np.max(proc_values), 
                          np.min(proc_values), np.mean(proc_values), np.std(proc_values)]

print(stats2)
