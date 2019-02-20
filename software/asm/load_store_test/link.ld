/* Define top stack address*/
_estack = 0x00000400;

MEMORY
{
    rom (rwx) : ORIGIN = 0, LENGTH = 0x00001000
}

SECTIONS
{
    . = 0x00000100;

    .text :
    {
        . = ALIGN(4);
        *(.text) 
    }

    .data :
    {
        . = ALIGN(4);
        *(.data) 
    }

    .bss :
    {
        . = ALIGN(4);
        *(.bss) 
    }
    
    .fill : 
    {
        FILL(0xDEADBEEF);   
    } > rom

}
