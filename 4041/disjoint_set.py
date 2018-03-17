class make_set:
    rank = 0
    
    def __init__(self, x):
        self.x = x
        self.p = self
        self.c = [self]



def union(x,y):
        link(find_set(x), find_set(y))

def link(x, y):
    if(x.rank > y.rank):
        y.p = x
        x.c.extend(y.c)
    else:
        x.p = y
        y.c.extend(x.c)
        if(x.rank == y.rank):
            y.rank = y.rank + 1

def find_set(x):
    if(x != x.p):
        x.p = find_set(x.p)
    return x.p

def print_set(x):
    x = find_set(x)
    for c in x.c:
        if c != None:
            print(c.x)

def find_set_i(node):
    common = node.p
    while(node != node.p):
        common = node.p
        node = node.p
    return node.p
