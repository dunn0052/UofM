#include <stdio.h>
#include <string.h>

typedef union foo
{
	short *x;
	long long y;
	char z;
} foo_t;

typedef struct bar
{
	foo_t foo_stuffs[3];
	char msg[64];
} bar_t;

void do_something1(bar_t *a_bar)
{
	strcpy((*a_bar).msg, "do_something1 did something!");
}

bar_t *do_something2(void)
{
	bar_t *bar  = (bar_t *)malloc (1 * sizeof(bar_t));;
	strcpy((*bar).msg, "do_something2 did something!");
	return bar;
}

void main(int argc, char* argv[])
{
	printf("%d\n", sizeof(bar_t));
	bar_t *fun = (bar_t *)malloc (1 * sizeof(bar_t));
	strcpy(fun->msg, "If only something would happen. . .");
	
	// do_somethin1
	do_something1(fun);
	strcpy(fun->msg, "do_something1 did something!");
	printf("do_something1 result: %s\n", fun->msg);
	
	// do_something2
	fun = do_something2();
	printf("do_something2 result: %s\n", fun->msg);
	
	
}
