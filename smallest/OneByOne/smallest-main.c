#include <stdio.h>

int smallest(int n1, int n2, int n3, int n4);

int main(void)
{
    int x1, x2, x3, x4, y;

    printf("No1: ");
    scanf("%d", &x1);

    printf("No2: ");
    scanf("%d", &x2);

    printf("No3: ");
    scanf("%d", &x3);


    printf("No4: ");
    scanf("%d", &x4);

    y = smallest(x1,x2,x3,x4);
    printf("Smallest is %d\n", y);
    return 0;
}
