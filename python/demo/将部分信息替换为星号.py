# -*- coding: utf-8 -*-
"""
Created on Mon Jun  9 11:16:01 2025

@author: Jerrylzysss
"""
import pandas as pd
series =pd.Series(['123456199001011234','789012198502027890'])
print(series.str.replace(r'^(\d{6})(\d{8})(\d{4})',
                r'\1******\3',
                regex=True))
    
