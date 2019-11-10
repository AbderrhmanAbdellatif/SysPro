    #include <stdio.h>
    int gcd(int n1,int n2);
    int main()
    {
        /*
        int n1, n2;
        
        printf("Enter two positive integers: ");
        scanf("%d %d",&n1,&n2);
        while(n1!=n2)
        {
            if(n1 > n2)
                n1 -= n2;
            else
                n2 -= n1;
        }
        */
       int n1, n2;
        
        printf("Enter two positive integers: ");
        scanf("%d %d",&n1,&n2);
        printf("GCD = %d",gcd(n1,n2));
        return 0;
    }