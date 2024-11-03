import os
import shutil
import random as rd

path_1 = "api\\images\\helopaltis\\"
path_2 = "api\\images\\normal\\"
path_3 = "api\\images\\red spider\\"
new_path = "api\\images\\section 1\\"

t = []

for i in range(15):
    for j in range(14):
        t.append((i+1, j+1))

print(len(t))

# a = os.listdir(new_path)
# b = os.listdir(path_1)
# c = os.listdir(path_2)
# d = os.listdir(path_3)
# print(len(b+c+d))

a = os.listdir(path_1)
for i, x in enumerate(a):
    c = rd.choice(t)
    shutil.copyfile(path_1+x, new_path+f"section_1_{c[0]}_{c[1]}.jpg")
    t.remove(c)

a = os.listdir(path_2)
for i, x in enumerate(a):
    c = rd.choice(t)
    shutil.copyfile(path_2+x, new_path+f"section_1_{c[0]}_{c[1]}.jpg")
    t.remove(c)

a = os.listdir(path_3)
for i, x in enumerate(a):
    c = rd.choice(t)
    shutil.copyfile(path_3+x, new_path+f"section_1_{c[0]}_{c[1]}.jpg")
    t.remove(c)

print(t)