# 安装pandas
# Anaconda 自带有pandas库
# 验证方式
# Anaconda Prompt(控制台)
# python -c "import pandas; print(pandas._version__)"

# pip安装
# pip install pandas

import pandas as pd
mydataset = {
    'sites':['Google','Noob','Baidu'],
    'number':['1','2','3']
}
myvar=pd.DataFrame(mydataset)
print(myvar)