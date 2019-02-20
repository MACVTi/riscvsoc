unsigned int factorial(unsigned int n);
unsigned int multiply(unsigned int input, unsigned int n);

// Initialise Stack Pointer
asm("addi sp,zero,0x00000400");

void __main()
{
    unsigned int* result = 0x00000000;
    *result = factorial(6);
    asm("EBREAK"); // This will cause the cpu to halt
}

unsigned int factorial(unsigned int n){
    unsigned int result = 1;
    for(int i = 1; i <= n; i++){
        result = multiply(result, i);
    }
    return result;
}

unsigned int multiply(unsigned input, unsigned n){
    unsigned int result = 0;
    for(int i = 1; i <= n; i++){
        result += input;
    }
    return result;
}

