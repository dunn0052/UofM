#include <stdio.h>
int main(){

int a, b;
a = scanf("%d" , a);
b = scanf("%d", b);
int x;

//A.

 //~a | ~b
//B.
 x = ~(~*a | (*b ˆ (0)));
//C.
 //((a ˆ b) & ~b) | (~(a ˆ b) & b)
//D.
 //1 + (a << 3) + ~a
//E.
 //(a << 4) + (a << 2) + (a << 1)
//F.
 //((a < 0) ? (a + 3) : a) >> 2
//G.
 //a ˆ (MIN_INT + MAX_INT)
//H.
 //~((a | (~a + 1)) >> W) & 1
//I.
 //~((a >> W) << 1)
//J.
 //a >> 2
//K.
//(a >> 4) + (a >> 2) + (a >> 1)

printf("%d\n", x);
return 0;
}
