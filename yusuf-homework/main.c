#include <stdio.h>
#include <stdlib.h>


int countingSort(int count, int *array);
int main()
{

    FILE *f;
    f = fopen("nums.txt", "r");


    int cnt=0;


    char ch;
    f=fopen("nums.txt" , "r");
    while(feof(f)==NULL) {
        ch=getc(f);
        if(ch=='\n'){ cnt++; }
    }

    FILE *myFile;
myFile= fopen("nums.txt", "r");
    //read file into array
    int arr[200];
    int i,*y;



    for (i = 0; i < cnt; i++)
    {
        fscanf(myFile, "%d", &arr[i]);
    }

    for (i = 0; i < cnt; i++)
    {
        printf("no %d is: %d\n\n",i+1, arr[i]);
    }

    y = countingSort(cnt, arr);


     for (i = 0; i < cnt; i++)
    {
        printf("no %d is %d\n", i+1,y[i]);
    }

    

}
