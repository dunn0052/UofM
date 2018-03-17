import disjoint_set
import random

def test(n):
    ds = []
    for i in range(n):
        ds.append(disjoint_set.make_set(i))
    for i in range(0, n-1, 2):
        disjoint_set.union(ds[i], ds[i+1])
    return ds
    
        
    
def print_test(ds):
    for d_set in ds:
        print(disjoint_set.find_set_i(d_set).x)

def print_set(ds):
    for ele in disjoint_set.find_set_i(ds).c:
        print(ele.x)

def rand_union(n, ds):
    MAX = len(ds) -1
    for i in range(n):
        f = random.randint(0, MAX)
        s = random.randint(0, MAX)
        disjoint_set.union(ds[f], ds[s])
    
