/*
 * File:        csim.c
 * Description: A cache simulator that can replay traces from Valgrind and
 *              output statistics such as number of hits, misses, and evictions
 *              The replacement policy is Most-Recently Used (MRU).
 *
 * The function printSummary() is given to print output. You MUST use this to
 *     print the number of hits, misses, and evictions incurred by your
 *     simulator. This is crucial for the driver to evaluate your work.
 */
#include <getopt.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <assert.h>
#include <math.h>
#include <limits.h>
#include <string.h>
#include <errno.h>
//#include "cachelab.h"

//#define DEBUG_ON
#define ADDRESS_LENGTH 64

/* Type: Memory address */
typedef unsigned long long int mem_addr_t;

/* Type: Cache line
   Member mru is a counter used to implement MRU replacement policy */
typedef struct cache_line {
    char valid;
    mem_addr_t tag;
    unsigned long long int mru;
} cache_line_t;

typedef cache_line_t* cache_set_t;
typedef cache_set_t* cache_t;

/* Globals set by command line args */
int verbosity = 0; /* print trace if set */
int s = 0; /* set index bits */
int b = 0; /* block offset bits */
int E = 0; /* associativity */
char* trace_file = NULL;

/* Derived from command line args */
int S; /* number of sets */
int B; /* block size (bytes) */


/* Counters used to record cache statistics */
int miss_count = 0;
int hit_count = 0;
int eviction_count = 0;
unsigned long long int mru_counter = 1;

/* The cache we are simulating */
cache_t cache;
mem_addr_t set_index_mask;

/*
 * initCache - Allocate memory, write 0's for valid, tag, and MRU. Also computes
 *             the set_index_mask.
 */
void initCache()
{
	int i;
	int j;
	cache = (cache_set_t *) malloc (S * sizeof(cache_set_t));
	for( i = 0; i < S; i++)
	{
		for(j = 0; j < S; j++)
		{
			cache[i][j].tag = 3;
		}
	}
	

    
    
}

void accessData(mem_addr_t addr)
{
    int addr_B = addr%B;
}

int main()
{
	S = 10;
	B = 10;

	initCache();
	printf("%i\n", cache[0][1].tag);
	printf("%i", 7%5);
	return 0;
}
