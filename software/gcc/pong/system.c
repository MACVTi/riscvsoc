#include "system.h"

void enable_interrupt(void){
    asm("csrrw t1, 0xFC0, zero");
    asm("ori t1, t1, 1");
    asm("csrrw zero, 0x7C0, t1");
}

void wait_for_interrupt(void){
    while(true){
        // Do nothing while waiting for interrupt
    }
}
