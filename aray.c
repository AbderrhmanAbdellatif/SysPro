

// Counting sort in C programming
//https://www.thecrazyprogrammer.com/2015/04/counting-sort-program-in-c.html
#include <stdio.h>
#include <stdlib.h>

int arrayc(int *array,int n)
{
    
   
    for (int i = 0; i < n; i++)
    {
        array[i] = array[i]+1;
   
    }
    
    return *array;
}
