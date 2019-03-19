//#include "system.h"

// Note since this CPU is pure harvard architecture, pointers must be defined in each function
// Global variables also cannot be used

void __main()
{
    //unsigned char name[12] = "Jack McEllin";
    //unsigned char* VGAdata = (unsigned char *)0xAAAA0000;
    //unsigned char* VGAcolour = (unsigned char *)0xAAAA12c0;

    // Declare pointers
    unsigned int* LEDaddress = (unsigned int *)0xFFFF0000;
    unsigned int* LEDvalue = (unsigned int *)0x00000004;
    unsigned int* counter = (unsigned int *)0x00000000;

    // Initialise Pointers
    *LEDaddress = 0;
    *LEDvalue = 0;
    *counter = 0;

    //for(int i = 0; i < 12; i++){
    //    *(VGAdata + i) = name[i];
    //    *(VGAdata + 80 + i) = name[i];
    //}

    //for(int i = 0; i < 80; i++){
    //    for(int j = 0; j < 60; j++){
    //        *(VGAcolour + i + (j*80)) = (j % 16) << 4;
    //    }
    //}

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
