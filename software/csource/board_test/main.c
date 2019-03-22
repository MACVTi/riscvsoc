//#include "system.h"

// Note since this CPU is pure harvard architecture, pointers must be defined in each function
// Global variables also cannot be used

void __main()
{
    // Declared shared variables with interrupt handler
    unsigned int* LEDvalue = (unsigned int *)0x00000000;
    unsigned int* counter = (unsigned int *)0x00000004;
    unsigned char* current_colour = (unsigned char *)0x00000008;

    // Create the pointers to our strings. Max 12 bytes long to prevent memcpy
    unsigned char name[12] = "Jack McEllin";
    unsigned char id[12] = "ID: 15170144";

    // Declare pointers
    unsigned int* LEDaddress = (unsigned int *)0xFFFF0000;
    unsigned int* SEGaddress = (unsigned int *)0xEEEE0000;
    unsigned char* VGAdata = (unsigned char *)0xAAAA0000;
    unsigned char* VGAcolour = (unsigned char *)0xAAAA12c0;

    // VGA interrupt pointers
    unsigned char* VGAEnableInterrupt = (unsigned char *)0xAAAA2580;
    //unsigned char* VGADisableInterrupt = (unsigned char *)0xAAAA2581;
    unsigned char* VGAClearInterrupt = (unsigned char *)0xAAAA2582;
    
    // Set shared variable initial values
    *counter = 0;
    *LEDvalue = 0;

    // Set initial values for LED and Seven Segment display
    *LEDaddress = 0xAAAA;
    *SEGaddress = 0x15170144;
    
    // Print Name
    for(unsigned int i = 0; i < 12; i++){
        *(VGAdata + 4640 + i) = name[i];
    }

    // Print ID
    for(unsigned int i = 0; i < 12; i++){
        *(VGAdata + 4720 + i) = id[i];
    }

    // Enable VGA Vblank interrupt
    *VGAEnableInterrupt = 1;

    // Wait for interrupt
    while(1){
        // Do nothing
    }
}

void __interrupt_handler(){
    // Declare Pointers
    unsigned int* LEDvalue = (unsigned int *)0x00000000;
    unsigned int* counter = (unsigned int *)0x00000004;
    unsigned char* current_colour = (unsigned char *)0x00000008;

    // Device pointers
    unsigned int* LEDaddress = (unsigned int *)0xFFFF0000;
    unsigned char* VGAcolour = (unsigned char *)0xAAAA12c0;

    // VGA interrupt pointers
    unsigned char* VGAEnableInterrupt = (unsigned char *)0xAAAA2580;
    //unsigned char* VGADisableInterrupt = (unsigned char *)0xAAAA2581;
    unsigned char* VGAClearInterrupt = (unsigned char *)0xAAAA2582;

    // Clear VGA interrupt
    *VGAClearInterrupt = 1;

    // Increment counter
    *counter += 1;

    // Increment LED value every second
    if(*counter == 60) {    
        *counter = 0;
        *current_colour += 0x10;
        *LEDvalue += 1;
        *LEDaddress = *LEDvalue;
    }

    // Change text colour depending on current colour
    if(*current_colour >= 0x80){
        *current_colour = *current_colour & 0xF0;
    }
    else{
        *current_colour = *current_colour | 0x0F;
    }

    // Get offset by multiplying counter by 80 -> 1010000
    unsigned int line = (*counter << 6) + (*counter << 4);

    // Change colour of current line
    for(unsigned char i = 0; i < 80; i++){
        *(VGAcolour + line + i) = *current_colour;
    }

    // Enable VGA interrupt
    *VGAEnableInterrupt = 1;
}
