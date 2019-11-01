

// Counting sort in C programming
//https://www.thecrazyprogrammer.com/2015/04/counting-sort-program-in-c.html
#include <stdio.h>
#include <stdlib.h>


/*
void countingsort(int *a,int n)
{
      
    // find a max 
      int max = a[0], i; 
    // Traverse array elements from second and 
    // compare every element with current max   
    for (i = 1; i < n; i++) 
        if (a[i] > max) 
            max = a[i]; 

     int count[50]={0},j;
     
     for(i=0;i<n;++i)
      count[a[i]]=count[a[i]]+1;
      
     printf("\nSorted elements are: \n");
     
     for(i=0;i<=max;++i)
      for(j=1;j<=count[i];++j)
       printf("%d ",i);
}
*/
int countingsort(int *array, int n);
void main()
{
    int *array, n, i;
    printf("Enter number of elements:");
    scanf("%d", &n);
    array = (int *)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++)
    {
        printf("%d . sayiyi giriniz : ", i);
        scanf("%d", &array[i]);
    }

    printf("max %d",countingsort(array, n));
     exit(0);
}
