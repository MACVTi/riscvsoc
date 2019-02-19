int sum(int n);

void _start()
{
        int *output = (int*) 0x00000000;

        *output = sum(3);
}

int sum(int n){
    int f = 0;
    for(int i = 1; i <= n; ++i) {
        f = f + n;               // factorial = factorial*i;
    }
    return f;
}
