import pandas as pd
import numpy as np
import os
actuary = pd.DataFrame({
    "x":[i for i in range(1,9)],
    "name": ["Embryo Luo", "", "Peter Smith", np.nan, "Angela Peterson", "Emily Johnston", "Barbara Scott", "Benjamin Eng"],
    "gender": ["M","F","M","F","F","F","?","M"],
    "age": [-1, 25, 22, 50, 30, 42, 29, 36],
    "exams": [10, 3, 0, 4, 6, 7, 5, 9],
    "Q1": [10, np.nan, 4, 7, 8, 9, 8, 7],
    "Q2": [9, 9, 5, 7, 8, 10, 9, 8],
    "Q3": [9, 7, 5, 8, 10, 10, 7, 8],
    "salary": [300000, np.nan, 80000, np.nan, np.nan, np.nan, np.nan, np.nan]
})


actuary.drop(columns=["x","salary"],axis = 1,inplace=True)
actuary["gender"] = pd.Categorical(actuary["gender"])
actuary["gender"] = actuary["gender"].cat.set_categories(["M","F","?",])

#drop NA
#actuary.n = actuary[~(actuary["Q1"].isna() | actuary["name"].isna())]
actuary_n = actuary.dropna(axis = 0,how= "any", subset = ["Q1","name"])

#apply to all and shift the column S after age column
actuary_n["S"] = actuary_n[["Q1","Q2","Q3"]].apply(lambda x : x.mean(),axis = 1)
index_of_age = actuary_n.columns.get_loc("age")
actuary_n.insert(index_of_age,"S",actuary_n.pop("S"))
print(actuary_n)

#apply mean to columns
mean_of_Q1to3 = actuary_n[["Q1","Q2","Q3"]].apply(lambda x : x.mean(),axis = 0)
print(mean_of_Q1to3)

#get best and worst actuary
best_actuary = actuary_n["S"].max()
worst_actuary = actuary_n["S"].min()
actuary_n.sort_values(by = ["gender","S"],ascending=False,inplace=True)

#ex 1.3.2
actuary_FSA = actuary_n[actuary_n["exams"]==10]
actuary_reduced = actuary_n[(actuary_n["gender"]=="M") | ((actuary_n["exams"]>=7) & (actuary_n["exams"]<=9))]
actuary_reduced = actuary_reduced.sort_values(by = "exams",ascending=False)
print(actuary_reduced)

#Task 4(b)
def get_title(data):
    if data == 10:
        return "FSA"
    elif (data >=7) & (data <=9):
        return "ASA"
    else:
        return "student"
        
actuary_n["title"] = actuary_n["exams"].apply(lambda x : get_title(x))
print(actuary_n)

#Task 5
actuary_n = actuary_n.sort_index(ascending= True)
new = pd.DataFrame({"smoke" : ["N", "N", "Y", "Y","N","N","N","Y"],
                     "weight" : [70, 65, 60, 90, 60, 55, 50, 75]})

new = new.iloc[actuary_n.index.tolist()]

actuary_n = pd.concat([actuary_n,new],axis=1)
print(actuary_n)

# 8A
import os
import pandas as pd
os.chdir("/workspaces/codespaces-jupyter/Projects/ExamPA/ExamPA_code/Python_Code")
print(os.getcwd())
college = pd.read_csv("College.csv")
