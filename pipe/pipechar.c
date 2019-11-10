#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>




int main( int argc, const char* argv[] )
{
    int c,p[2],p1[2],i;
    char rec[5];
    char snd[]="test";
    int number;
 
    if(pipe(p)< 0) printf("Pipe did not open");
      if(pipe(p1)< 0) printf("Pipe did not open");
   
    if((c=fork())< 0) printf("Fork did not open");
    else if(c > 0){
        close(p[0]);
        for(int i = 0; i < 5; i++)
        {
            printf("Write the ineger to be passed ");
          scanf("%d", &number);
          write(p[1], &number, sizeof(number));
        }

        sleep(1);
        close(p1[1]);
        int hello=0;
        read(p1[0], &hello, sizeof(hello));
        printf("\nsum = %d",hello);
        wait(NULL);
    }
    else {
         sleep(1);
         close(p[1]);
         int avg=0;
         int test=0;
         for(int i = 0; i < 5; i++)
        {read(p[0], &test, sizeof(number));
          avg += test;
        }

        printf("avg chid %d",avg/5);
        close(p1[0]);
         //printf("\n results = %d",avg);
        write(p1[1], &avg, sizeof(avg));
    }

}