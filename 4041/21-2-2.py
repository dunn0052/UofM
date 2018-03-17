import disjoint_set

def p21():
    ds = []
    ds.append(None)
    for i in range(1, 17):
        ds.append(disjoint_set.make_set(i))
    print(ds)
    for i in range(1,16, 2):
        disjoint_set.union(ds[i], ds[i+1])
    print(ds)
    for i in range(1, 14, 4):
        disjoint_set.union(ds[i], ds[i+2])
    disjoint_set.union(ds[1], ds[5])
    disjoint_set.union(ds[1], ds[10])
    print(disjoint_set.find_set(ds[2]).x)
    print(disjoint_set.find_set(ds[9]).x)
    return ds
