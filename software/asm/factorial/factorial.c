int factorial(int n);

void __entry__()
{
        int *output = (int*) 0x00000000;

        *output = factorial(10);
}

int factorial(int n){
    int f = 1;
    for(int i = 1; i <= n; ++i) {
        f *= i;              // factorial = factorial*i;
    }
    return f;
}
