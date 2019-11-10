#include <stdio.h>
#include <stdlib.h>


int smallest(int count, int *array);

int main(void)
{
    int cnt, *arr, y;
    int i;

    printf("Count: ");
    scanf("%d", &cnt);

    arr= (int *) malloc (cnt*sizeof(int));

    for(i=0; i<cnt; i++) {
        printf("No %d:",i);
        scanf("%d", &arr[i]);
    }

    y = smallest(cnt, arr);
    printf("Smallest is %d\n", y);
    return 0;
}
