//#include "system.h"

// Note since this CPU is pure harvard architecture, pointers must be defined in each function
// Global variables also cannot be used

void __main()
{
    // Declared shared variables with interrupt handler
    //unsigned int* LEDvalue = (unsigned int *)0x00000004;
    //unsigned int* counter = (unsigned int *)0x00000000;

    // Create the pointers to our strings. Our strings are initialise with ram
    //unsigned char* name = (unsigned char *)0x00000000;
    //unsigned char* id = (unsigned char *)0x00000013;
    unsigned char name[12] = "Jack McEllin";
    unsigned char id[12] = "ID: 15170144";
    //unsigned char course[49] = "Course: LM118 Electronic and Computer Engineering";

    // Declare pointers
    unsigned int* LEDaddress = (unsigned int *)0xFFFF0000;
    unsigned char* VGAdata = (unsigned char *)0xAAAA0000;
    unsigned char* VGAcolour = (unsigned char *)0xAAAA12c0;
    

    // Initialise Pointers
    *LEDaddress = 0xAAAA;

    // Print details in bottom left
    //unsigned int offset = 80*58;
    for(unsigned int i = 0; i < 12; i++){
        *(VGAdata + 4640 + i) = name[i];
        *(VGAcolour + 4640 + i) = 0x04;
    }

    for(int i = 0; i < 12; i++){
        *(VGAdata + 4720 + i) = id[i];
        *(VGAcolour + 4720 + i) = 0x02;
    }

    // Wait for interrupt
    while(1){
        // Do nothing
    }
}

void __interrupt_handler(){
    // Declare Pointers
    unsigned int* LEDaddress = (unsigned int *)0xFFFF0000;
    unsigned int* LEDvalue = (unsigned int *)0x00000004;
    unsigned int* counter = (unsigned int *)0x00000000;

    *counter += 1;
    // Increment counter

    if(*counter == 60) {    
        *counter = 0;
        *LEDvalue += 1;
        *LEDaddress = *LEDvalue;
    }
}
