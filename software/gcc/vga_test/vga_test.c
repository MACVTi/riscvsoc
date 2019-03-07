void main(void){
    asm("li sp,0x100");
    unsigned int* vga = (int *)0xEEEE0000;
    
    for(int i = 0; i < 256; i++){
        *(vga+i) = i;
    }
    
    while(1){
    }
}
