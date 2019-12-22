#include <stdio.h>

int main()
{
    FILE* pFile;
    char buffer[10]="1453";
    int res;
    pFile = fopen("/dev/memo1", "rw");
    fwrite(buffer, 4*sizeof(char), 9, pFile);
//    res = fread(buffer, 1, 9, pFile);
//    printf("Err: %d\n", res);
//    printf("%s\n", buffer);
fclose(pFile);
    return 0;
}
