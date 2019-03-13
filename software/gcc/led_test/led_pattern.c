// LED C Program Test
// Written by Jack McEllin

// Initialise Stack Pointer
asm("li sp, 0x00000040");

// Main Program Entry
void main(void){
    unsigned int* led = (int *)0xFFFF0000;
    unsigned int value = 1;

    while(1){
        *led = value;
        value = value + 1;
    }
}

