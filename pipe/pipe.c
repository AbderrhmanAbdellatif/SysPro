#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{

    int forkdurum = 0;
    int pipe_p[2];
    int pipe_p2[2];
    int input = 0;
    int send_input_number[5];
    int re_input_number[5];
    for (int i = 0; i < 5; i++)
    {   
        printf(" %d .number :",i);
        scanf("%d", &send_input_number[i]);
    }
   if(pipe(pipe_p2)<0){
                printf("can not create  a pipe");
   }
    if (pipe(pipe_p) < 0)
        printf("can not create  a pipe");

    if ((forkdurum = fork()) < 0)
    {
        printf("cant create  a fork ");
    }
    else if (forkdurum > 0)
    {
        close(pipe_p[0]);
        for (size_t i = 0; i < 5; i++)
        {

            if (write(pipe_p[1], send_input_number,sizeof(send_input_number)) < 0)
            {
                printf("cant wr  ");
            }
            printf("write %d\n", send_input_number[i]);
        }
        sleep(1);
        close(pipe_p2[1]);
        int sum=0;
         read(pipe_p2[0],&sum,sizeof(sum));
         printf("avg is : %d \n ", (sum/5));
        wait(NULL);
    }
    else
    {
        sleep(1);
        close(pipe_p[1]);
        int sum = 0 ;
        for (size_t i = 0; i < 5; i++)
        {
            if (read(pipe_p[0], re_input_number,sizeof(re_input_number)) < 0)
            {
                printf("C: Can't read ");
            }
            printf(" read numbers is %d\n", re_input_number[i]);
            sum =sum +re_input_number[i];
            sleep(1);
        }
        close(pipe_p2[0]);
        write(pipe_p2[1],&sum,sizeof(sum));
        printf("sum toplam : %d\n",sum);
    }

    return 0;
}